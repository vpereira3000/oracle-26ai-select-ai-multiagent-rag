-- Run as ADMIN in a fresh lab database.
-- In a private copy, replace the password mask with your own strong password.
SET DEFINE OFF
WHENEVER SQLERROR EXIT SQL.SQLCODE
BEGIN
  DBMS_CLOUD_ADMIN.ENABLE_RESOURCE_PRINCIPAL();
END;
/

CREATE USER yantras_agentic_user IDENTIFIED BY "*****";
GRANT CONNECT, DWROLE, RESOURCE TO yantras_agentic_user;
ALTER USER yantras_agentic_user QUOTA UNLIMITED ON DATA;
GRANT EXECUTE ON DBMS_CLOUD TO yantras_agentic_user;
GRANT EXECUTE ON DBMS_CLOUD_AI TO yantras_agentic_user;
GRANT EXECUTE ON DBMS_CLOUD_AI_AGENT TO yantras_agentic_user;
GRANT EXECUTE ON DBMS_CLOUD_PIPELINE TO yantras_agentic_user;

BEGIN
  DBMS_CLOUD_ADMIN.ENABLE_PRINCIPAL_AUTH(
    username => 'YANTRAS_AGENTIC_USER', provider => 'OCI');

  DBMS_NETWORK_ACL_ADMIN.APPEND_HOST_ACE(
    host => 'api.openai.com',
    ace => xs$ace_type(
      privilege_list => xs$name_list('http'),
      principal_name => 'YANTRAS_AGENTIC_USER',
      principal_type => xs_acl.ptype_db));
END;
/
