CREATE TABLE schema_version (
                                installed_rank int NOT NULL,
                                version varchar(50) DEFAULT NULL,
                                description varchar(200) NOT NULL,
                                type varchar(20) NOT NULL,
                                script varchar(1000) NOT NULL,
                                checksum int DEFAULT NULL,
                                installed_by varchar(100) NOT NULL,
                                installed_on timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP,
                                execution_time int NOT NULL,
                                success smallint NOT NULL,
                                PRIMARY KEY (installed_rank)
) ;

CREATE INDEX dom_idx_api_key ON domains (api_key);
CREATE INDEX spec_idx_domain ON specificationgroups (domain);
CREATE INDEX sgroup_idx_api_key ON specificationgroups (api_key);
CREATE INDEX spe_fk_dom ON specifications (domain);
CREATE INDEX spe_idx_api_key ON specifications (api_key);
CREATE INDEX spec_idx_spec_group ON specifications (spec_group);
CREATE INDEX ac_fk_dom ON actors (domain);
CREATE INDEX act_idx_api_key ON actors (api_key);
CREATE INDEX end_fk_act ON endpoints (actor);
CREATE INDEX com_fk_dom ON communities (domain);
CREATE INDEX com_idx_api_key ON communities (api_key);
CREATE INDEX conf_snap_idx_api_key ON conformancesnapshots (api_key);
CREATE INDEX cokey_fk_com ON communitykeystores (community);
CREATE INDEX cr_fk_com ON communityresources (community);
CREATE INDEX cocertmsg_fk_dom ON conformanceoverviewcertificatemessages (domain_id);
CREATE INDEX cocertmsg_fk_spg ON conformanceoverviewcertificatemessages (group_id);
CREATE INDEX cocertmsg_fk_spe ON conformanceoverviewcertificatemessages (specification_id);
CREATE INDEX cocertmsg_fk_act ON conformanceoverviewcertificatemessages (actor_id);
CREATE INDEX cocertmsg_fk_com ON conformanceoverviewcertificatemessages (community_id);
CREATE INDEX cs_ac_id ON conformancesnapshotactors  (id);
CREATE INDEX cs_ac_fk_cs ON conformancesnapshotactors  (snapshot_id);
CREATE INDEX cs_dom_param_cs_domain_idx ON conformancesnapshotdomainparams (domain_id);
CREATE INDEX cs_dom_param_cs_snapshot_idx ON conformancesnapshotdomainparams (snapshot_id);
CREATE INDEX cs_dom_id ON conformancesnapshotdomains  (id);
CREATE INDEX cs_dom_fk_cs ON conformancesnapshotdomains  (snapshot_id);
CREATE INDEX cs_org_id ON conformancesnapshotorganisations (id);
CREATE INDEX cs_org_fk_cs ON conformancesnapshotorganisations (snapshot_id);
CREATE INDEX cs_org_param_cs_org_idx ON conformancesnapshotorgparams (org_id);
CREATE INDEX cs_org_param_cs_snapshot_idx ON conformancesnapshotorgparams (snapshot_id);
CREATE INDEX cs_cert_over_msg_cs_idx ON conformancesnapshotoverviewcertificatemessages (snapshot_id);
CREATE INDEX cs_spg_id ON conformancesnapshotspecificationgroups (id);
CREATE INDEX cs_spg_fk_cs ON conformancesnapshotspecificationgroups (snapshot_id);
CREATE INDEX cs_sp_id ON conformancesnapshotspecifications  (id);
CREATE INDEX cs_sp_fk_cs ON conformancesnapshotspecifications  (snapshot_id);
CREATE INDEX cs_sys_param_cs_sys_idx ON conformancesnapshotsysparams (sys_id);
CREATE INDEX cs_sys_param_cs_snapshot_idx ON conformancesnapshotsysparams (snapshot_id);
CREATE INDEX cs_sys_id ON conformancesnapshotsystems (id);
CREATE INDEX cs_sys_fk_cs ON conformancesnapshotsystems (snapshot_id);
CREATE INDEX cs_tc_id ON conformancesnapshottestcases (id);
CREATE INDEX cs_tc_fk_cs ON conformancesnapshottestcases (snapshot_id);
CREATE INDEX cs_ts_id ON conformancesnapshottestsuites (id);
CREATE INDEX cs_ts_fk_cs ON conformancesnapshottestsuites (snapshot_id);
CREATE INDEX dp_idx_domain ON domainparameters (domain);
CREATE INDEX errtem_fk_com ON errortemplates (community);
CREATE INDEX lanpag_fk_com ON landingpages (community);
CREATE INDEX legnot_fk_com ON legalnotices (community);
CREATE INDEX opt_fk_act ON options (actor);
CREATE INDEX op_idx_com ON organisationparameters (community);
CREATE INDEX org_fk_com ON organizations (community);
CREATE INDEX org_fk_lanpag ON organizations (landing_page);
CREATE INDEX org_fk_legnot ON organizations (legal_notice);
CREATE INDEX org_fk_errtem ON organizations (error_template);
CREATE INDEX org_idx_api_key ON organizations (api_key);
CREATE INDEX opv_idx_par ON organisationparametervalues (parameter);
CREATE INDEX pa_fk_end ON parameters (endpoint);
CREATE INDEX spehact_fk_act ON specificationhasactors (actor_id);
CREATE INDEX ts_idx_domain ON testsuites (domain);
CREATE INDEX shts_spec_idx ON specificationhastestsuites (spec);
CREATE INDEX shts_ts_idx ON specificationhastestsuites (testsuite);--
CREATE INDEX sys_idx_api_key ON systems (api_key);
CREATE INDEX sys_idx_badge_key ON systems (badge_key);
CREATE INDEX users_idx_sso_uid ON users (sso_uid);
CREATE INDEX use_fk_org ON users (organization);
CREATE INDEX sutiact_fk_act ON systemimplementsactors (actor_id);
CREATE INDEX sutiopt_fk_opt ON systemimplementsoptions (option_id);
CREATE INDEX sy_idx_com ON systemparameters (community);
CREATE INDEX spv_idx_sys ON systemparametervalues (system);
CREATE INDEX spv_idx_par ON systemparametervalues (parameter);
CREATE INDEX tcg_ts_idx ON testcasegroups (testsuite);
CREATE INDEX tc_tcg_idx ON testcases (testcase_group);
CREATE INDEX tescovopt_fk_opt ON testcasecoversoptions (option);
CREATE INDEX teshact_fk_spe ON testcasehasactors (specification);
CREATE INDEX teshact_fk_act ON testcasehasactors (actor);
CREATE INDEX tr_idx_sut ON testresults (sut_id);
CREATE INDEX tr_idx_organization ON testresults (organization_id);
CREATE INDEX tr_idx_community ON testresults (community_id);
CREATE INDEX tr_idx_testcase ON testresults (testcase_id);
CREATE INDEX tr_idx_testsuite ON testresults (testsuite_id);
CREATE INDEX tr_idx_actor ON testresults (actor_id);
CREATE INDEX tr_idx_specification ON testresults (specification_id);
CREATE INDEX tr_idx_domain ON testresults (domain_id);
CREATE INDEX tessuihact_fk_act ON testsuitehasactors (actor);
CREATE INDEX tessuihtescas_fk_tescas ON testsuitehastestcases (testcase);
CREATE INDEX tra_fk_dom ON transactions (domain);
CREATE INDEX trigger_community_idx ON triggers (community);
CREATE INDEX trigger_data_idx ON triggerdata (trigger);
CREATE INDEX trigger_data_id_idx ON triggerdata (data_id);
CREATE INDEX trigger_data_id_type_idx ON triggerdata (data_id,data_type);
CREATE INDEX co_fk_sys ON configurations (system);
CREATE INDEX co_fk_par ON configurations (parameter);
CREATE INDEX co_fk_end ON configurations (endpoint);
CREATE INDEX cr_idx_sut ON conformanceresults (sut_id);
CREATE INDEX cr_idx_spec ON conformanceresults (spec_id);
CREATE INDEX cr_idx_actor ON conformanceresults (actor_id);
CREATE INDEX cr_idx_testsuite ON conformanceresults (test_suite_id);
CREATE INDEX cr_idx_testcase ON conformanceresults (test_case_id);
CREATE INDEX cr_idx_testsession ON conformanceresults (test_session_id);
CREATE INDEX csr_idx_org ON conformancesnapshotresults (organization_id);
CREATE INDEX csr_idx_sut ON conformancesnapshotresults (sut_id);
CREATE INDEX csr_idx_domain ON conformancesnapshotresults (domain_id);
CREATE INDEX csr_idx_spec ON conformancesnapshotresults (spec_id);
CREATE INDEX csr_idx_actor ON conformancesnapshotresults (actor_id);
CREATE INDEX csr_idx_testsuite ON conformancesnapshotresults (test_suite_id);
CREATE INDEX csr_idx_testcase ON conformancesnapshotresults (test_case_id);
CREATE INDEX csr_idx_testsession ON conformancesnapshotresults (test_session_id);
CREATE INDEX csr_idx_snapshot ON conformancesnapshotresults (snapshot_id);
CREATE INDEX crs_fk_com ON communityreportsettings (community);
CREATE INDEX tfe_trigger_idx ON triggerfireexpressions (trigger);
CREATE INDEX cs_tcg_id ON conformancesnapshottestcasegroups (id);
CREATE INDEX cs_tcg_fk_cs_idx ON conformancesnapshottestcasegroups (snapshot_id);
CREATE INDEX schema_version_s_idx ON "schema_version" (success);
CREATE INDEX suthadm_fk_use ON systemhasadmins (user_id);
CREATE INDEX sutiact_fk_spe ON systemimplementsactors (spec_id);
CREATE INDEX sut_fk_org ON systems (owner);
CREATE INDEX opv_idx_org ON organisationparametervalues (organisation);
CREATE INDEX conf_snap_idx_community ON conformancesnapshots (community);

INSERT INTO themes VALUES (1,'ec','European Commission theme.',false,false,'#337ab7','#337ab7','#337ab7','#337ab7','#FFFFFF','#337ab7','#337ab7','#FFFFFF','#0065a2','#074a8b','#FFFFFF','/assets/images/ec.png','#0065a2','#074a8b','/assets/images/gitb.png','inherit','/assets/images/favicon-ec.gif', '#337ab7', '#FFFFFF', '#2b689c', '#296292', '#6c757d', '#FFFFFF' , '#5c636a' , '#565e64'),(2,'gitb','Default GITB theme.',false,false,'#337ab7','#337ab7','#337ab7','#337ab7','#FFFFFF','#337ab7','#337ab7','#FFFFFF','#171717','#CCCCCC','#FFFFFF','/assets/images/gitb.png','#121214','#CCCCCC','/assets/images/gitb.png','none','/assets/images/favicon.png', '#337ab7', '#FFFFFF', '#2b689c', '#296292', '#6c757d', '#FFFFFF' , '#5c636a' , '#565e64');
ALTER SEQUENCE public.themes_id_seq RESTART WITH 3;
INSERT INTO conformancecertificates (id, title, include_title, include_message, include_test_status, include_test_cases, include_details, include_signature, include_page_numbers, message, community) VALUES (1, 'Conformance Certificate', true, false, true, true, true, false, true, NULL, 0);
INSERT INTO systemconfigurations VALUES ('session_alive_time', '3600', 'session_alive_time');
INSERT INTO users VALUES (1, 'Administrator', 'admin@itb', '$2a$10$uMPniYxO/NJIQiJA/q8kseF5N3KRxXM3bHPnRC0ZyIzvBZ.u6Edha', true, 4, 0, NULL, NULL, 1);
ALTER SEQUENCE public.users_id_seq RESTART WITH 3;
INSERT INTO communities (id, sname, fname, support_email, selfreg_type, selfreg_token, selfreg_token_help_text, selfreg_notification, interaction_notification, description, selfreg_restriction, selfreg_force_template, selfreg_force_properties, allow_certificate_download, allow_statement_management, allow_system_management, allow_post_test_org_updates, allow_post_test_sys_updates, allow_post_test_stm_updates, allow_automation_api, allow_community_view, api_key, latest_status_label, domain) VALUES (0, 'Default community', 'Default community', NULL, 1, NULL, NULL, false, false, NULL, 1, false, false, false, true, true, true, true, true, false, false, '225D4900X6DA6X4479X9BBFX32B50FB1B916', NULL, NULL);
INSERT INTO organizations (id, sname, fname, type, admin_organization, landing_page, legal_notice, error_template, template, template_name, api_key, community) VALUES (0, 'Admin organisation', 'Admin organisation', 1, true, NULL, NULL, NULL, false, NULL, NULL, 0);
INSERT INTO schema_version (installed_rank, version, description, type, script, checksum, installed_by, installed_on, execution_time, success) VALUES (121, '121', 'Base DB for GITB v1.26.0', 'SQL', 'V1__Base_DB_for_GITB_v1.26.0.sql', -73768430, 'gitb', CURRENT_TIMESTAMP, 1, 1);
UPDATE "organizations" SET id = 0;
UPDATE "communities" SET id = 0;
