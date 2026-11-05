# 01. Create the OCI environment

1. In **Identity & Security → Compartments**, create `agentic_engineering_compartment` under the tenancy root.
2. In **Oracle AI Database → Autonomous AI Database**, create an Autonomous AI Database Serverless in that compartment. Choose **26ai**, use **Lakehouse** for the lab, and set the ADMIN password. Review the available tier and network options. Wait for the database to become available.
3. In **Identity & Security → Domains → Default → Dynamic Groups**, create `yantras_agentic-dg`. Use the following rule with your database resource OCID.

   ```text
   ALL {resource.type='autonomousdatabase', resource.id='*****'}
   ```

4. In **Identity & Security → Policies**, create a policy at the tenancy root. These statements scope storage access to the lab compartment. For a non-default identity domain, qualify the dynamic group name with its domain.

   ```text
   Allow dynamic-group yantras_agentic-dg to read buckets in compartment agentic_engineering_compartment
   Allow dynamic-group yantras_agentic-dg to read objects in compartment agentic_engineering_compartment
   ```

5. In **Storage → Buckets**, select the lab compartment. Create a private Standard bucket and upload a few text-based literature PDFs you are authorized to send to the AI provider. Use ASCII filenames. Include a copy of *The Picture of Dorian Gray* for the example retrieval prompt, or adapt the prompt to your documents. The human uploader needs separate Object Storage write access.
6. Record the bucket's region, namespace, and name locally. On the database details page, select **Database connection → Instance wallet → Download wallet** and store the ZIP securely.
7. In SQL Developer Desktop, create an **ADMIN** connection using **Cloud Wallet**. Set **Configuration File** to the wallet ZIP, select a service from the wallet, enter the ADMIN database password, then select **Test → Connect**. Continue with [02-admin-setup.sql](sql/02-admin-setup.sql).

[Oracle compartment creation](https://docs.oracle.com/en-us/iaas/Content/Identity/compartments/To_create_a_compartment.htm) · [Provision Autonomous AI Database](https://docs.oracle.com/en-us/iaas/autonomous-database-serverless/doc/autonomous-provision.html) · [Connect with a wallet](https://docs.oracle.com/en/cloud/paas/autonomous-database/serverless/adbsb/connect-sql-dev182.html)
