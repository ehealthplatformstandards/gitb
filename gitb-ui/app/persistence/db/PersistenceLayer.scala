/*
 * Copyright (C) 2025 European Union
 *
 * Licensed under the EUPL, Version 1.2 or - as soon they will be approved by the European Commission - subsequent
 * versions of the EUPL (the "Licence"); You may not use this work except in compliance with the Licence.
 *
 * You may obtain a copy of the Licence at:
 *
 * https://interoperable-europe.ec.europa.eu/collection/eupl/eupl-text-eupl-12
 *
 * Unless required by applicable law or agreed to in writing, software distributed under the Licence is distributed on an
 * "AS IS" basis, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the Licence for
 * the specific language governing permissions and limitations under the Licence.
 */

package persistence.db

import config.Configurations
import org.apache.commons.lang3.StringUtils
import org.slf4j.LoggerFactory

import java.nio.charset.StandardCharsets
import java.sql._
import scala.collection.mutable.ListBuffer
import scala.util.Using
import slick.jdbc.PostgresProfile.api._
import scala.concurrent.Await
import scala.concurrent.duration._
import scala.concurrent.ExecutionContext.Implicits.global

object PersistenceLayer {

  private def logger = LoggerFactory.getLogger("PersistenceLayer")

  /**
   * Creates database if not exists. This must be called before applications starts,
   * since creation method uses mysql-java-connector rather than Play!'s DB API
   * which expects an already created database.
   *
   * Methods that use direct SQL commands should be called here, as well.
   */
  def preInitialize(): Unit = {
    createDatabaseIfNotExists()
  }

  /**
   * Creates a database with a given name by using SQL commands.
   */
  private def createDatabaseIfNotExists(): Unit = {
    try {
      // Create database if not exists (connection using root URL)
      Using.resource(DriverManager.getConnection(Configurations.DB_ROOT_URL, Configurations.DB_USER, Configurations.DB_PASSWORD)) { connection =>
        var exists = false
        Using.resource(connection.prepareStatement("SELECT 1 FROM pg_database WHERE datname = ?")) { statement =>
          statement.setString(1, Configurations.DB_NAME)
          Using.resource(statement.executeQuery()) { rs =>
            exists = rs.next()
          }
        }

        if (!exists) {
          val createDbSQL = s"CREATE DATABASE ${Configurations.DB_NAME} ENCODING 'UTF8'"
          Using.resource(connection.createStatement()) { stmt =>
            stmt.executeUpdate(createDbSQL)
          }
        }
      }

      // Initialize the DB if Baseline-Script available
      if (Configurations.DB_LATEST_DB_BASELINE_SCRIPT.isDefined) {
        Using.resource(DriverManager.getConnection(Configurations.DB_JDBC_URL, Configurations.DB_USER, Configurations.DB_PASSWORD)) { connection =>
          connection.setAutoCommit(true)
          var count = 0
          Using.resource(connection.prepareStatement(
            s"SELECT COUNT(*) FROM information_schema.tables WHERE table_schema = 'public' AND table_name = LOWER(?)"
          )) { statement =>
            statement.setString(1, Configurations.DB_MIGRATION_TABLE)
            Using.resource(statement.executeQuery()) { resultSet =>
              if (resultSet.next()) count = resultSet.getInt(1)
            }
          }
          if (count == 0) {
            logger.info("Create database tables from Slick table definitions.")
            val db = Database.forConfig("slick.dbs.default.db")
            val setup = PersistenceSchema.allSchemas.createIfNotExists
            val schemaFuture = db.run(setup)
            Await.result(schemaFuture, 30.seconds)

            logger.info("Finish initialising database using baseline script {}...", Configurations.DB_LATEST_DB_BASELINE_SCRIPT.get)
            getBaseLineScriptStatements().foreach { statementContent =>
              Using.resource(connection.createStatement()) { statement =>
                statement.execute(statementContent)
              }
            }
          } else {
            logger.info("Database already initialised.")
          }
        }
      }
    } catch {
      case e: Exception =>
        logger.error("DB initialisation error", e)
        throw new IllegalStateException(e)
    }
  }

  private def getBaseLineScriptStatements(): List[String] = {
    val statements = new ListBuffer[String]()
    Using.resource(Thread.currentThread().getContextClassLoader.getResourceAsStream("db/baseline/"+Configurations.DB_LATEST_DB_BASELINE_SCRIPT.get)) { stream =>
      val statementBuffer = new StringBuilder();
      StringUtils.split(new String(stream.readAllBytes(), StandardCharsets.UTF_8), "\n").map(_.trim).foreach { line =>
        if (!line.isBlank && !line.startsWith("--")) {
          statementBuffer.append(line)
          if (line.endsWith(";")) {
            statements += StringUtils.normalizeSpace(statementBuffer.toString())
            statementBuffer.delete(0, statementBuffer.length())
          }
        }
      }
    }
    statements.toList
  }

}
