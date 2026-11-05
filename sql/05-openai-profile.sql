-- Run as YANTRAS_AGENTIC_USER only if credential/profile do not yet exist.
-- Enter your OpenAI API key only in a private local copy.
SET DEFINE OFF
WHENEVER SQLERROR EXIT SQL.SQLCODE
DECLARE
  l_api_key VARCHAR2(4000) := '*****';
BEGIN
  IF l_api_key = '*****' THEN
    RAISE_APPLICATION_ERROR(-20001, 'Set your API key locally; never publish it.');
  END IF;
  DBMS_CLOUD.CREATE_CREDENTIAL(
    credential_name => 'OPENAI_CREDENTIAL',
    username => 'apikey', password => l_api_key);
END;
/
BEGIN
  DBMS_CLOUD_AI.CREATE_PROFILE(
    profile_name => 'OPENAI_PROFILE',
    attributes => '{"provider":"openai","credential_name":"OPENAI_CREDENTIAL","model":"gpt-4o-mini"}');
END;
/
EXEC DBMS_CLOUD_AI.SET_PROFILE('OPENAI_PROFILE');
SELECT DBMS_CLOUD_AI.GENERATE(
  prompt => 'Verify connection: respond with the word "Success" if you can read this.',
  profile_name => 'OPENAI_PROFILE', action => 'chat') AS response
FROM dual;
