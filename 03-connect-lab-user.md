# 03. Connect the lab user

1. Create a second SQL Developer Desktop connection. Enter `yantras_agentic_user` and the database password you set in step 02.
2. Choose **Cloud Wallet**, select the same wallet ZIP, and select the desired service. Use **Test → Connect**.
3. Confirm the worksheet session with `SELECT USER FROM dual;`. The result should be `YANTRAS_AGENTIC_USER`.
4. Run [04-verify-storage.sql](sql/04-verify-storage.sql) after filling the URI fields. Continue when the result includes your PDFs. If access fails, check the dynamic group match, policy scope, bucket URI, and principal enablement. IAM changes may take time to propagate.
