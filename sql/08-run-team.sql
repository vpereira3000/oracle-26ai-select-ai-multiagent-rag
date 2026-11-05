-- Run as YANTRAS_AGENTIC_USER after step 07. Review Script Output.
-- SET_TEAM initializes the session before RUN_TEAM.
SET DEFINE OFF
SET SERVEROUTPUT ON SIZE UNLIMITED
WHENEVER SQLERROR EXIT SQL.SQLCODE
EXEC DBMS_CLOUD_AI_AGENT.SET_TEAM(team_name => 'literature_processing_team');
DECLARE
  l_response CLOB;
  l_offset PLS_INTEGER := 1;
BEGIN
  l_response := DBMS_CLOUD_AI_AGENT.RUN_TEAM(
    team_name => 'literature_processing_team',
    user_prompt => 'Compare how identity and freedom are portrayed in the uploaded works. Use retrieved evidence, identify each source, and disclose missing coverage.');
  WHILE l_offset <= DBMS_LOB.GETLENGTH(l_response) LOOP
    DBMS_OUTPUT.PUT_LINE(DBMS_LOB.SUBSTR(l_response, 4000, l_offset));
    l_offset := l_offset + 4000;
  END LOOP;
END;
/
