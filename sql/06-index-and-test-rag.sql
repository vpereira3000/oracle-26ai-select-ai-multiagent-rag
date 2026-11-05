-- Run as YANTRAS_AGENTIC_USER after the OpenAI chat test succeeds.
-- Replace the entire masked URI using this format:
-- https://objectstorage.<region>.oraclecloud.com/n/<namespace>/b/<bucket-name>/o/
-- Ingestion and model requests can incur charges. Do not proceed on an error.
SET DEFINE OFF
WHENEVER SQLERROR EXIT SQL.SQLCODE
DECLARE
  l_bucket_uri VARCHAR2(4000) := '*****';
  l_attributes CLOB;
BEGIN
  IF l_bucket_uri = '*****' THEN
    RAISE_APPLICATION_ERROR(-20002, 'Set the full Object Storage URI first.');
  END IF;
  DBMS_CLOUD_AI.SET_ATTRIBUTE(
    profile_name => 'OPENAI_PROFILE',
    attribute_name => 'embedding_model',
    attribute_value => 'text-embedding-ada-002');
  DBMS_CLOUD_AI.SET_ATTRIBUTE(
    profile_name => 'OPENAI_PROFILE',
    attribute_name => 'vector_index_name',
    attribute_value => 'LITERATURE_INDEX');
  SELECT JSON_OBJECT(
    'vector_db_provider' VALUE 'oracle',
    'location' VALUE l_bucket_uri,
    'object_storage_credential_name' VALUE 'OCI$RESOURCE_PRINCIPAL',
    'profile_name' VALUE 'OPENAI_PROFILE',
    'chunk_size' VALUE 1024,
    'chunk_overlap' VALUE 128
    RETURNING CLOB) INTO l_attributes FROM dual;
  DBMS_CLOUD_AI.CREATE_VECTOR_INDEX(
    index_name => 'LITERATURE_INDEX', attributes => l_attributes, wait_for_completion => TRUE);
END;
/
-- Do not register/run the team until ingestion completes and retrieval works.
SELECT DBMS_CLOUD_AI.GENERATE(
  prompt => 'What do the uploaded documents say about Dorian Gray? Cite sources. If unavailable, say so.',
  profile_name => 'OPENAI_PROFILE', action => 'narrate') AS response
FROM dual;
