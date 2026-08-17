-- Run this ONCE, as a database superuser or the database owner (NOT as the
-- application's own DB role) — a role cannot revoke privileges from itself.
--
-- On Railway: open the Postgres plugin's connected psql (or use the
-- connection string Railway shows for the "postgres" superuser, not your
-- app's own DATABASE_URL) and run this file.
--
-- Locally: `psql -U postgres -d <your_db> -f prisma/migrations/02_app_role_grants.sql`
--          (replace svp_app below with your actual application DB role name
--          if different from the .env.example default)

REVOKE UPDATE, DELETE ON audit_logs FROM svp_app;
GRANT INSERT, SELECT ON audit_logs TO svp_app;

-- Verify it worked:
-- SELECT privilege_type FROM information_schema.role_table_grants
-- WHERE table_name = 'audit_logs' AND grantee = 'svp_app';
-- Should show INSERT and SELECT only — never UPDATE or DELETE.
