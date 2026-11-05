# Oracle Database 26ai Select AI lab

Build a sequential literature team with Oracle Autonomous AI Database 26ai. A Reader agent retrieves passages from PDFs in OCI Object Storage and an Editor agent uses the Reader's output to synthesize findings. The lab uses an OCI resource principal for storage and an OpenAI API credential for chat and embeddings.

You need an OCI account with permission to provision a database and configure IAM, SQL Developer Desktop, and an OpenAI API project with model access and billing. Choose an Autonomous AI Database Serverless 26ai instance that supports Select AI Agent and RAG. OpenAI usage is billed separately from OCI.

| Step | File | Run or configure as |
| --- | --- | --- |
| 01 | [Create the OCI environment](01-cloud-setup.md) | OCI administrator and bucket uploader |
| 02 | [Create the schema and grant access](sql/02-admin-setup.sql) | Database ADMIN |
| 03 | [Connect the lab user](03-connect-lab-user.md) | YANTRAS_AGENTIC_USER |
| 04 | [Verify Object Storage access](sql/04-verify-storage.sql) | YANTRAS_AGENTIC_USER |
| 05 | [Create and test the OpenAI profile](sql/05-openai-profile.sql) | YANTRAS_AGENTIC_USER |
| 06 | [Index PDFs and test retrieval](sql/06-index-and-test-rag.sql) | YANTRAS_AGENTIC_USER |
| 07 | [Create the RAG tool, agents, tasks and team](sql/07-create-team.sql) | YANTRAS_AGENTIC_USER |
| 08 | [Run the team](sql/08-run-team.sql) | YANTRAS_AGENTIC_USER |

Download the folder and follow the steps in order. In SQL Developer, open each SQL file in the indicated connection and use **Run Script (F5)**. For files with `*****` placeholders, make a private copy ending in `.local.sql` and substitute the values there. Keep local copies, keys, passwords, and wallet ZIPs out of commits. Run creation steps once and inspect existing objects if a script stops partway.

The lab run confirmed profile chat, PDF retrieval, team registration, and successful team execution. The final run returned a clarification question. Treat this as a check that the team runs. Review citations and coverage separately when a literary report is returned.

[Oracle resource principals](https://docs.oracle.com/en/cloud/paas/autonomous-database/serverless/adbsb/resource-principal.html) · [Select AI providers](https://docs.oracle.com/en/database/oracle/oracle-database/26/selai/use-select-ai-ai-providers.html) · [Select AI RAG](https://docs.oracle.com/en/cloud/paas/autonomous-database/serverless/adbsb/select-ai-retrieval-augmented-generation.html) · [Agent package](https://docs.oracle.com/en/cloud/paas/autonomous-database/serverless/adbsb/dbms-cloud-ai-agent-package.html)
