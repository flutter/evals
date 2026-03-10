BEGIN;

--
-- ACTION ALTER TABLE
--
ALTER TABLE "evals_datasets" ADD COLUMN "isActive" boolean NOT NULL DEFAULT true;
--
-- ACTION ALTER TABLE
--
ALTER TABLE "evals_samples" ADD COLUMN "isActive" boolean NOT NULL DEFAULT true;

--
-- MIGRATION VERSION FOR eval_explorer
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('eval_explorer', '20260115201713782', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260115201713782', "timestamp" = now();

--
-- MIGRATION VERSION FOR serverpod
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('serverpod', '20251208110333922-v3-0-0', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20251208110333922-v3-0-0', "timestamp" = now();

--
-- MIGRATION VERSION FOR serverpod_auth_idp
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('serverpod_auth_idp', '20260109031533194', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260109031533194', "timestamp" = now();

--
-- MIGRATION VERSION FOR serverpod_auth_core
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('serverpod_auth_core', '20251208110412389-v3-0-0', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20251208110412389-v3-0-0', "timestamp" = now();


COMMIT;
