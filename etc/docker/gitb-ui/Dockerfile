FROM eclipse-temurin:21-jre-jammy

ENV PATH=/usr/local/gitb-ui/bin:$PATH
ENV TESTBED_SERVICE_URL=http://gitb-srv:8080/itbsrv/TestbedService
ENV TESTBED_CLIENT_URL_INTERNAL=http://0.0.0.0:9090/TestbedClient
ENV TESTBED_CLIENT_URL=http://gitb-ui:9090/TestbedClient
ENV DB_DEFAULT_URL=jdbc:postgresql://gitb-postgresql/gitb?ssl=false
ENV DB_DEFAULT_ROOTURL=jdbc:postgresql://gitb-postgresql/
ENV REDIS_HOST=gitb-redis

COPY gitb-ui /usr/local/gitb-ui
RUN chmod +x /usr/local/gitb-ui/bin/gitb
RUN chmod +x /usr/local/gitb-ui/bin/gitb.bat
COPY gitb-entrypoint.sh /usr/local/gitb-ui/bin
RUN chmod +x /usr/local/gitb-ui/bin/gitb-entrypoint.sh

EXPOSE 9000
EXPOSE 9090
WORKDIR /usr/local/gitb-ui

ENTRYPOINT ["/usr/local/gitb-ui/bin/gitb-entrypoint.sh"]