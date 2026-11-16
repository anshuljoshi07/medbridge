BEGIN;

--
-- ACTION CREATE TABLE
--
CREATE TABLE "alert" (
    "id" bigserial PRIMARY KEY,
    "patientId" bigint NOT NULL,
    "type" text NOT NULL,
    "sev" text NOT NULL,
    "dedupeKey" text NOT NULL,
    "recipientsJson" text NOT NULL,
    "sentAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "ackAt" timestamp without time zone
);

-- Indexes
CREATE UNIQUE INDEX "alert_dedupe_idx" ON "alert" USING btree ("dedupeKey");

--
-- ACTION CREATE TABLE
--
CREATE TABLE "audit_log" (
    "id" bigserial PRIMARY KEY,
    "actorUserId" uuid,
    "action" text NOT NULL,
    "entity" text NOT NULL,
    "entityId" text NOT NULL,
    "at" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- Indexes
CREATE INDEX "audit_entity_idx" ON "audit_log" USING btree ("entity", "entityId");

--
-- ACTION CREATE TABLE
--
CREATE TABLE "bottle_scan" (
    "id" bigserial PRIMARY KEY,
    "patientId" bigint NOT NULL,
    "ndc11" text,
    "rxcui" text,
    "name" text NOT NULL,
    "ingsJson" text NOT NULL,
    "strength" text NOT NULL,
    "form" text NOT NULL,
    "sigRaw" text NOT NULL,
    "sigJson" text,
    "ocrText" text NOT NULL,
    "conf" double precision NOT NULL,
    "confirmed" boolean NOT NULL,
    "classIdsJson" text NOT NULL DEFAULT '[]'::text,
    "setAside" boolean NOT NULL DEFAULT false,
    "scannedAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- Indexes
CREATE INDEX "bottle_scan_patient_idx" ON "bottle_scan" USING btree ("patientId");

--
-- ACTION CREATE TABLE
--
CREATE TABLE "care_link" (
    "id" bigserial PRIMARY KEY,
    "patientId" bigint NOT NULL,
    "userId" uuid,
    "role" text NOT NULL,
    "status" text NOT NULL DEFAULT 'pending'::text,
    "inviteCode" text NOT NULL,
    "createdAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- Indexes
CREATE UNIQUE INDEX "care_link_code_idx" ON "care_link" USING btree ("inviteCode");
CREATE INDEX "care_link_user_idx" ON "care_link" USING btree ("userId");

--
-- ACTION CREATE TABLE
--
CREATE TABLE "discharge_plan" (
    "id" bigserial PRIMARY KEY,
    "patientId" bigint NOT NULL,
    "source" text NOT NULL DEFAULT 'avs_scan'::text,
    "dischargeDate" timestamp without time zone,
    "status" text NOT NULL DEFAULT 'draft'::text,
    "allergiesJson" text NOT NULL DEFAULT '[]'::text,
    "unrecognizedJson" text NOT NULL DEFAULT '[]'::text,
    "verifiedBy" uuid,
    "verifiedAt" timestamp without time zone,
    "createdAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- Indexes
CREATE INDEX "discharge_plan_patient_idx" ON "discharge_plan" USING btree ("patientId");

--
-- ACTION CREATE TABLE
--
CREATE TABLE "dose_event" (
    "id" bigserial PRIMARY KEY,
    "scheduleId" bigint NOT NULL,
    "dueAt" timestamp without time zone NOT NULL,
    "state" text NOT NULL,
    "loggedAt" timestamp without time zone
);

-- Indexes
CREATE UNIQUE INDEX "dose_event_schedule_due_idx" ON "dose_event" USING btree ("scheduleId", "dueAt");

--
-- ACTION CREATE TABLE
--
CREATE TABLE "dose_schedule" (
    "id" bigserial PRIMARY KEY,
    "planItemId" bigint NOT NULL,
    "slotsJson" text NOT NULL,
    "prn" boolean NOT NULL,
    "active" boolean NOT NULL DEFAULT true,
    "suspendedUntil" timestamp without time zone
);

-- Indexes
CREATE INDEX "dose_schedule_item_idx" ON "dose_schedule" USING btree ("planItemId");

--
-- ACTION CREATE TABLE
--
CREATE TABLE "patient" (
    "id" bigserial PRIMARY KEY,
    "userId" uuid NOT NULL,
    "firstName" text NOT NULL DEFAULT 'Patient'::text,
    "lang" text NOT NULL DEFAULT 'en'::text,
    "birthYear" bigint,
    "utcOffsetMin" bigint NOT NULL DEFAULT 0,
    "allergiesJson" text NOT NULL DEFAULT '[]'::text,
    "createdAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- Indexes
CREATE UNIQUE INDEX "patient_user_idx" ON "patient" USING btree ("userId");

--
-- ACTION CREATE TABLE
--
CREATE TABLE "plan_item" (
    "id" bigserial PRIMARY KEY,
    "planId" bigint NOT NULL,
    "itemKey" text NOT NULL,
    "action" text NOT NULL,
    "name" text NOT NULL,
    "rxcui" text,
    "ingsJson" text NOT NULL,
    "scd" text,
    "strength" text NOT NULL,
    "form" text NOT NULL,
    "route" text,
    "sigRaw" text NOT NULL,
    "sigJson" text,
    "holdUntil" timestamp without time zone,
    "holdNote" text,
    "src" text NOT NULL,
    "conf" double precision NOT NULL,
    "classIdsJson" text NOT NULL DEFAULT '[]'::text
);

-- Indexes
CREATE INDEX "plan_item_plan_idx" ON "plan_item" USING btree ("planId");

--
-- ACTION CREATE TABLE
--
CREATE TABLE "question" (
    "id" bigserial PRIMARY KEY,
    "patientId" bigint NOT NULL,
    "text" text NOT NULL,
    "source" text NOT NULL,
    "linkedReconId" bigint,
    "askedBy" uuid,
    "status" text NOT NULL DEFAULT 'open'::text,
    "answer" text,
    "answeredBy" uuid,
    "answeredAt" timestamp without time zone,
    "createdAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- Indexes
CREATE INDEX "question_patient_idx" ON "question" USING btree ("patientId");

--
-- ACTION CREATE TABLE
--
CREATE TABLE "recon" (
    "id" bigserial PRIMARY KEY,
    "scanId" bigint NOT NULL,
    "planItemId" bigint,
    "itemKey" text,
    "status" text NOT NULL,
    "reason" text NOT NULL,
    "sev" text NOT NULL,
    "flagsJson" text NOT NULL DEFAULT '[]'::text,
    "paramsJson" text NOT NULL DEFAULT '{}'::text,
    "ruleVersion" text NOT NULL,
    "resolvedNote" text,
    "resolvedBy" uuid,
    "createdAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- Indexes
CREATE INDEX "recon_scan_idx" ON "recon" USING btree ("scanId");

--
-- ACTION CREATE TABLE
--
CREATE TABLE "rx_cache" (
    "id" bigserial PRIMARY KEY,
    "key" text NOT NULL,
    "kind" text NOT NULL,
    "json" text NOT NULL,
    "fetchedAt" timestamp without time zone NOT NULL
);

-- Indexes
CREATE UNIQUE INDEX "rx_cache_key_idx" ON "rx_cache" USING btree ("key");

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "alert"
    ADD CONSTRAINT "alert_fk_0"
    FOREIGN KEY("patientId")
    REFERENCES "patient"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "bottle_scan"
    ADD CONSTRAINT "bottle_scan_fk_0"
    FOREIGN KEY("patientId")
    REFERENCES "patient"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "care_link"
    ADD CONSTRAINT "care_link_fk_0"
    FOREIGN KEY("patientId")
    REFERENCES "patient"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "discharge_plan"
    ADD CONSTRAINT "discharge_plan_fk_0"
    FOREIGN KEY("patientId")
    REFERENCES "patient"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "dose_event"
    ADD CONSTRAINT "dose_event_fk_0"
    FOREIGN KEY("scheduleId")
    REFERENCES "dose_schedule"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "dose_schedule"
    ADD CONSTRAINT "dose_schedule_fk_0"
    FOREIGN KEY("planItemId")
    REFERENCES "plan_item"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "plan_item"
    ADD CONSTRAINT "plan_item_fk_0"
    FOREIGN KEY("planId")
    REFERENCES "discharge_plan"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "question"
    ADD CONSTRAINT "question_fk_0"
    FOREIGN KEY("patientId")
    REFERENCES "patient"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "recon"
    ADD CONSTRAINT "recon_fk_0"
    FOREIGN KEY("scanId")
    REFERENCES "bottle_scan"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;


--
-- MIGRATION VERSION FOR medbridge
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('medbridge', '20261116101426186', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20261116101426186', "timestamp" = now();

--
-- MIGRATION VERSION FOR serverpod
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('serverpod', '20260824182259319', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260824182259319', "timestamp" = now();

--
-- MIGRATION VERSION FOR serverpod_auth_idp
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('serverpod_auth_idp', '20261015164015382', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20261015164015382', "timestamp" = now();

--
-- MIGRATION VERSION FOR serverpod_auth_core
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('serverpod_auth_core', '20260924105232991', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260924105232991', "timestamp" = now();


COMMIT;
