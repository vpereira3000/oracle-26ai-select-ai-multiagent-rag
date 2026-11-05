-- Run as YANTRAS_AGENTIC_USER.
-- Replace the entire masked URI using this format:
-- https://objectstorage.<region>.oraclecloud.com/n/<namespace>/b/<bucket-name>/o/
SET DEFINE OFF
SELECT object_name, bytes
FROM DBMS_CLOUD.LIST_OBJECTS(
  credential_name => 'OCI$RESOURCE_PRINCIPAL',
  location_uri => '*****');
