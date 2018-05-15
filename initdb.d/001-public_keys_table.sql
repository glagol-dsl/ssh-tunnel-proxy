CREATE TABLE `glagol`.`public_keys` (
  `key_hash` CHAR(128) NOT NULL,
  `key` BLOB NULL,
  PRIMARY KEY (`key_hash`));
