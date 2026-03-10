BEGIN;

--
-- Function: gen_random_uuid_v7()
-- Source: https://gist.github.com/kjmph/5bd772b2c2df145aa645b837da7eca74
-- License: MIT (copyright notice included on the generator source code).
--
create or replace function gen_random_uuid_v7()
returns uuid
as $$
begin
  -- use random v4 uuid as starting point (which has the same variant we need)
  -- then overlay timestamp
  -- then set version 7 by flipping the 2 and 1 bit in the version 4 string
  return encode(
    set_bit(
      set_bit(
        overlay(uuid_send(gen_random_uuid())
                placing substring(int8send(floor(extract(epoch from clock_timestamp()) * 1000)::bigint) from 3)
                from 1 for 6
        ),
        52, 1
      ),
      53, 1
    ),
    'hex')::uuid;
end
$$
language plpgsql
volatile;

--
-- ACTION DROP TABLE
--
DROP TABLE "evals_runs" CASCADE;

--
-- ACTION CREATE TABLE
--
CREATE TABLE "evals_runs" (
    "id" uuid PRIMARY KEY DEFAULT gen_random_uuid_v7(),
    "inspectId" text NOT NULL,
    "status" text NOT NULL,
    "variants" json NOT NULL,
    "mcpServerVersion" text NOT NULL,
    "batchRuntimeSeconds" bigint NOT NULL,
    "createdAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- Indexes
CREATE INDEX "runs_status_idx" ON "evals_runs" USING btree ("status");
CREATE INDEX "runs_inspect_id_idx" ON "evals_runs" USING btree ("inspectId");
CREATE INDEX "runs_created_at_idx" ON "evals_runs" USING btree ("createdAt");

--
-- ACTION CREATE TABLE
--
CREATE TABLE "evals_samples_tags_xref" (
    "id" bigserial PRIMARY KEY,
    "sampleId" uuid NOT NULL,
    "tagId" uuid NOT NULL
);

-- Indexes
CREATE UNIQUE INDEX "sample_tag_index_idx" ON "evals_samples_tags_xref" USING btree ("sampleId", "tagId");

--
-- ACTION ALTER TABLE
--
ALTER TABLE "evals_tags" DROP CONSTRAINT "evals_tags_fk_0";
ALTER TABLE "evals_tags" DROP COLUMN "_evalsSamplesTagsEvalsSamplesId";
--
-- ACTION DROP TABLE
--
DROP TABLE "evals_tasks" CASCADE;

--
-- ACTION CREATE TABLE
--
CREATE TABLE "evals_tasks" (
    "id" uuid PRIMARY KEY DEFAULT gen_random_uuid_v7(),
    "inspectId" text NOT NULL,
    "modelId" uuid NOT NULL,
    "datasetId" uuid NOT NULL,
    "runId" uuid NOT NULL,
    "createdAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "_evalsRunsTasksEvalsRunsId" uuid
);

-- Indexes
CREATE INDEX "evals_task_run_id_idx" ON "evals_tasks" USING btree ("runId");
CREATE INDEX "evals_task_inspect_id_idx" ON "evals_tasks" USING btree ("inspectId");
CREATE INDEX "evals_task_model_id_idx" ON "evals_tasks" USING btree ("modelId");
CREATE INDEX "evals_task_dataset_id_idx" ON "evals_tasks" USING btree ("datasetId");
CREATE INDEX "evals_task_created_at_idx" ON "evals_tasks" USING btree ("createdAt");

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "evals_samples_tags_xref"
    ADD CONSTRAINT "evals_samples_tags_xref_fk_0"
    FOREIGN KEY("sampleId")
    REFERENCES "evals_samples"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "evals_samples_tags_xref"
    ADD CONSTRAINT "evals_samples_tags_xref_fk_1"
    FOREIGN KEY("tagId")
    REFERENCES "evals_tags"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "evals_tasks"
    ADD CONSTRAINT "evals_tasks_fk_0"
    FOREIGN KEY("modelId")
    REFERENCES "evals_models"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "evals_tasks"
    ADD CONSTRAINT "evals_tasks_fk_1"
    FOREIGN KEY("datasetId")
    REFERENCES "evals_datasets"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "evals_tasks"
    ADD CONSTRAINT "evals_tasks_fk_2"
    FOREIGN KEY("runId")
    REFERENCES "evals_runs"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "evals_tasks"
    ADD CONSTRAINT "evals_tasks_fk_3"
    FOREIGN KEY("_evalsRunsTasksEvalsRunsId")
    REFERENCES "evals_runs"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;


--
-- MIGRATION VERSION FOR eval_explorer
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('eval_explorer', '20260116133701488', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260116133701488', "timestamp" = now();

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
