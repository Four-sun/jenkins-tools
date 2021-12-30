ALTER TABLE `da_api`
ADD COLUMN `api_version_code` VARCHAR(45) NULL DEFAULT 'API_WITH_TOKEN' AFTER `body_desc_json`;
