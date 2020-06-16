DROP SCHEMA IF EXISTS subs;

CREATE SCHEMA subs;

USE subs;

CREATE TABLE `icons` (
  `icon_id` varchar(255) NOT NULL PRIMARY KEY,
  `icon_uri` text NOT NULL,
  `is_original` tinyint(1) DEFAULT 0 NOT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

CREATE TABLE `subscriptions`(
  `subscription_id` varchar(255) PRIMARY KEY,
  `icon_id` varchar(255) NOT NULL,
  `service_name` varchar(255) NOT NULL,
  `service_type` int DEFAULT 1 NOT NULL,
  `price` int DEFAULT 0 NOT NULL,
  `cycle` int DEFAULT 1 NOT NULL,
  `is_original` tinyint(1) DEFAULT 0 NOT NULL,
  `free_trial` int DEFAULT 0 NOT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  FOREIGN KEY (`icon_id`) REFERENCES icons(`icon_id`),
  INDEX index_icon_id (`icon_id`)
);

CREATE TABLE `user_subscriptions`(
  `user_subscription_id` varchar(255) PRIMARY KEY,
  `subscription_id` varchar(255) NOT NULL,
  `user_id` varchar(255) NOT NULL,
  `cycle` int DEFAULT 1 NOT NULL,
  `price` int DEFAULT 0 NOT NULL,
  `started_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  FOREIGN KEY (`subscription_id`) REFERENCES subscriptions(`subscription_id`),
  INDEX index_subscription_id (`subscription_id`)
);
