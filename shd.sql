-- Adminer 4.2.2 MySQL dump

SET NAMES utf8;
SET time_zone = '+00:00';
SET foreign_key_checks = 0;
SET sql_mode = 'NO_AUTO_VALUE_ON_ZERO';

DROP TABLE IF EXISTS `apns_devices`;
CREATE TABLE `apns_devices` (
  `pid` int(9) unsigned NOT NULL AUTO_INCREMENT,
  `clientid` varchar(64) NOT NULL,
  `appname` varchar(255) NOT NULL,
  `appversion` varchar(25) DEFAULT NULL,
  `deviceuid` char(40) NOT NULL,
  `devicetoken` char(164) NOT NULL,
  `devicename` varchar(255) NOT NULL,
  `devicemodel` varchar(100) NOT NULL,
  `deviceversion` varchar(25) NOT NULL,
  `pushbadge` enum('disabled','enabled') DEFAULT 'disabled',
  `pushalert` enum('disabled','enabled') DEFAULT 'disabled',
  `pushsound` enum('disabled','enabled') DEFAULT 'disabled',
  `development` enum('production','sandbox') CHARACTER SET latin1 NOT NULL DEFAULT 'production',
  `status` enum('active','uninstalled') NOT NULL DEFAULT 'active',
  `created` datetime NOT NULL,
  `modified` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`pid`),
  UNIQUE KEY `appname` (`appname`,`appversion`,`deviceuid`),
  KEY `clientid` (`clientid`),
  KEY `devicetoken` (`devicetoken`),
  KEY `devicename` (`devicename`),
  KEY `devicemodel` (`devicemodel`),
  KEY `deviceversion` (`deviceversion`),
  KEY `pushbadge` (`pushbadge`),
  KEY `pushalert` (`pushalert`),
  KEY `pushsound` (`pushsound`),
  KEY `development` (`development`),
  KEY `status` (`status`),
  KEY `created` (`created`),
  KEY `modified` (`modified`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='Store unique devices';


DROP TABLE IF EXISTS `apns_messages`;
CREATE TABLE `apns_messages` (
  `pid` int(9) unsigned NOT NULL AUTO_INCREMENT,
  `clientid` varchar(64) NOT NULL,
  `fk_device` int(9) unsigned NOT NULL,
  `message` varchar(255) NOT NULL,
  `delivery` datetime NOT NULL,
  `status` enum('queued','delivered','failed') CHARACTER SET latin1 NOT NULL DEFAULT 'queued',
  `created` datetime NOT NULL,
  `modified` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`pid`),
  KEY `clientid` (`clientid`),
  KEY `fk_device` (`fk_device`),
  KEY `status` (`status`),
  KEY `created` (`created`),
  KEY `modified` (`modified`),
  KEY `message` (`message`),
  KEY `delivery` (`delivery`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='Messages to push to APNS';


DROP TABLE IF EXISTS `c2dm_devices`;
CREATE TABLE `c2dm_devices` (
  `clientid` varchar(64) NOT NULL,
  `appname` varchar(128) NOT NULL,
  `deviceid` varchar(255) CHARACTER SET latin1 COLLATE latin1_bin NOT NULL,
  `imei` varchar(50) NOT NULL,
  `status` enum('active','uninstalled') NOT NULL DEFAULT 'active',
  `created` datetime NOT NULL,
  `modified` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' ON UPDATE CURRENT_TIMESTAMP,
  `pid` int(11) NOT NULL,
  PRIMARY KEY (`appname`,`imei`),
  UNIQUE KEY `appname` (`appname`,`deviceid`),
  KEY `clientid` (`clientid`),
  KEY `imei` (`imei`),
  KEY `status` (`status`),
  KEY `created` (`created`),
  KEY `modified` (`modified`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='Store unique devices';


DROP TABLE IF EXISTS `c2dm_messages`;
CREATE TABLE `c2dm_messages` (
  `pid` int(9) unsigned NOT NULL AUTO_INCREMENT,
  `clientid` varchar(64) NOT NULL,
  `fk_device` varchar(50) NOT NULL,
  `message` varchar(255) NOT NULL,
  `delivery` datetime NOT NULL,
  `status` enum('queued','delivered','failed') CHARACTER SET latin1 NOT NULL DEFAULT 'queued',
  `created` datetime NOT NULL,
  `modified` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`pid`),
  KEY `clientid` (`clientid`),
  KEY `fk_device` (`fk_device`),
  KEY `status` (`status`),
  KEY `created` (`created`),
  KEY `modified` (`modified`),
  KEY `message` (`message`),
  KEY `delivery` (`delivery`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='Messages to push to C2DM';


DROP TABLE IF EXISTS `engine4_activity_actions`;
CREATE TABLE `engine4_activity_actions` (
  `action_id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `type` varchar(32) COLLATE utf8_unicode_ci NOT NULL,
  `subject_type` varchar(24) CHARACTER SET latin1 COLLATE latin1_general_ci NOT NULL,
  `subject_id` int(11) unsigned NOT NULL,
  `object_type` varchar(24) CHARACTER SET latin1 COLLATE latin1_general_ci NOT NULL,
  `object_id` int(11) unsigned NOT NULL,
  `body` text COLLATE utf8_unicode_ci,
  `params` text COLLATE utf8_unicode_ci,
  `date` datetime NOT NULL,
  `attachment_count` smallint(3) unsigned NOT NULL DEFAULT '0',
  `comment_count` mediumint(5) unsigned NOT NULL DEFAULT '0',
  `like_count` mediumint(5) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`action_id`),
  KEY `SUBJECT` (`subject_type`,`subject_id`),
  KEY `OBJECT` (`object_type`,`object_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


DROP TABLE IF EXISTS `engine4_activity_actionsettings`;
CREATE TABLE `engine4_activity_actionsettings` (
  `user_id` int(11) unsigned NOT NULL,
  `type` varchar(64) CHARACTER SET latin1 COLLATE latin1_general_ci NOT NULL,
  `publish` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`user_id`,`type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


DROP TABLE IF EXISTS `engine4_activity_actiontypes`;
CREATE TABLE `engine4_activity_actiontypes` (
  `type` varchar(64) CHARACTER SET latin1 COLLATE latin1_general_ci NOT NULL,
  `module` varchar(32) CHARACTER SET latin1 COLLATE latin1_general_ci NOT NULL,
  `body` text COLLATE utf8_unicode_ci NOT NULL,
  `enabled` tinyint(1) NOT NULL DEFAULT '1',
  `displayable` tinyint(1) NOT NULL DEFAULT '3',
  `attachable` tinyint(1) NOT NULL DEFAULT '1',
  `commentable` tinyint(1) NOT NULL DEFAULT '1',
  `shareable` tinyint(1) NOT NULL DEFAULT '1',
  `is_generated` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


DROP TABLE IF EXISTS `engine4_activity_attachments`;
CREATE TABLE `engine4_activity_attachments` (
  `attachment_id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `action_id` int(11) unsigned NOT NULL,
  `type` varchar(64) CHARACTER SET latin1 COLLATE latin1_general_ci NOT NULL,
  `id` int(11) unsigned NOT NULL,
  `mode` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`attachment_id`),
  KEY `action_id` (`action_id`),
  KEY `type_id` (`type`,`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


DROP TABLE IF EXISTS `engine4_activity_comments`;
CREATE TABLE `engine4_activity_comments` (
  `comment_id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `resource_id` int(11) unsigned NOT NULL,
  `poster_type` varchar(24) CHARACTER SET latin1 COLLATE latin1_general_ci NOT NULL,
  `poster_id` int(11) unsigned NOT NULL,
  `body` text COLLATE utf8_unicode_ci NOT NULL,
  `creation_date` datetime NOT NULL,
  `like_count` int(11) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`comment_id`),
  KEY `resource_type` (`resource_id`),
  KEY `poster_type` (`poster_type`,`poster_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


DROP TABLE IF EXISTS `engine4_activity_likes`;
CREATE TABLE `engine4_activity_likes` (
  `like_id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `resource_id` int(11) unsigned NOT NULL,
  `poster_type` varchar(16) CHARACTER SET latin1 COLLATE latin1_general_ci NOT NULL,
  `poster_id` int(11) unsigned NOT NULL,
  PRIMARY KEY (`like_id`),
  KEY `resource_id` (`resource_id`),
  KEY `poster_type` (`poster_type`,`poster_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


DROP TABLE IF EXISTS `engine4_activity_notifications`;
CREATE TABLE `engine4_activity_notifications` (
  `notification_id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(11) unsigned NOT NULL,
  `subject_type` varchar(64) CHARACTER SET latin1 COLLATE latin1_general_ci NOT NULL,
  `subject_id` int(11) unsigned NOT NULL,
  `object_type` varchar(64) CHARACTER SET latin1 COLLATE latin1_general_ci NOT NULL,
  `object_id` int(11) unsigned NOT NULL,
  `type` varchar(64) CHARACTER SET latin1 COLLATE latin1_general_ci NOT NULL,
  `params` text COLLATE utf8_unicode_ci,
  `read` tinyint(1) NOT NULL DEFAULT '0',
  `mitigated` tinyint(1) NOT NULL DEFAULT '0',
  `date` datetime NOT NULL,
  PRIMARY KEY (`notification_id`),
  KEY `LOOKUP` (`user_id`,`date`),
  KEY `subject` (`subject_type`,`subject_id`),
  KEY `object` (`object_type`,`object_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


DROP TABLE IF EXISTS `engine4_activity_notificationsettings`;
CREATE TABLE `engine4_activity_notificationsettings` (
  `user_id` int(11) unsigned NOT NULL,
  `type` varchar(128) CHARACTER SET latin1 COLLATE latin1_general_ci NOT NULL,
  `email` tinyint(4) NOT NULL DEFAULT '1',
  PRIMARY KEY (`user_id`,`type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


DROP TABLE IF EXISTS `engine4_activity_notificationtypes`;
CREATE TABLE `engine4_activity_notificationtypes` (
  `type` varchar(128) CHARACTER SET latin1 COLLATE latin1_general_ci NOT NULL,
  `module` varchar(32) CHARACTER SET latin1 COLLATE latin1_general_ci NOT NULL,
  `body` text COLLATE utf8_unicode_ci NOT NULL,
  `is_request` tinyint(1) NOT NULL DEFAULT '0',
  `handler` varchar(64) CHARACTER SET latin1 COLLATE latin1_general_ci NOT NULL,
  `default` tinyint(4) NOT NULL DEFAULT '1',
  PRIMARY KEY (`type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


DROP TABLE IF EXISTS `engine4_activity_stream`;
CREATE TABLE `engine4_activity_stream` (
  `target_type` varchar(16) CHARACTER SET latin1 COLLATE latin1_general_ci NOT NULL,
  `target_id` int(11) unsigned NOT NULL,
  `subject_type` varchar(24) CHARACTER SET latin1 COLLATE latin1_general_ci NOT NULL,
  `subject_id` int(11) unsigned NOT NULL,
  `object_type` varchar(24) CHARACTER SET latin1 COLLATE latin1_general_ci NOT NULL,
  `object_id` int(11) unsigned NOT NULL,
  `type` varchar(32) CHARACTER SET latin1 COLLATE latin1_general_ci NOT NULL,
  `action_id` int(11) unsigned NOT NULL,
  PRIMARY KEY (`target_type`,`target_id`,`action_id`),
  KEY `SUBJECT` (`subject_type`,`subject_id`,`action_id`),
  KEY `OBJECT` (`object_type`,`object_id`,`action_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


DROP TABLE IF EXISTS `engine4_album_albums`;
CREATE TABLE `engine4_album_albums` (
  `album_id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(128) COLLATE utf8_unicode_ci NOT NULL,
  `description` mediumtext COLLATE utf8_unicode_ci NOT NULL,
  `owner_type` varchar(64) CHARACTER SET latin1 COLLATE latin1_general_ci NOT NULL,
  `owner_id` int(11) unsigned NOT NULL,
  `category_id` int(11) unsigned NOT NULL DEFAULT '0',
  `creation_date` datetime NOT NULL,
  `modified_date` datetime NOT NULL,
  `photo_id` int(11) unsigned NOT NULL DEFAULT '0',
  `view_count` int(11) unsigned NOT NULL DEFAULT '0',
  `comment_count` int(11) unsigned NOT NULL DEFAULT '0',
  `search` tinyint(1) NOT NULL DEFAULT '1',
  `type` enum('wall','profile','message','blog') COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`album_id`),
  KEY `owner_type` (`owner_type`,`owner_id`),
  KEY `category_id` (`category_id`),
  KEY `search` (`search`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


DROP TABLE IF EXISTS `engine4_album_categories`;
CREATE TABLE `engine4_album_categories` (
  `category_id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) unsigned NOT NULL,
  `category_name` varchar(128) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`category_id`),
  KEY `user_id` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


DROP TABLE IF EXISTS `engine4_album_photos`;
CREATE TABLE `engine4_album_photos` (
  `photo_id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `album_id` int(11) unsigned NOT NULL,
  `title` varchar(128) COLLATE utf8_unicode_ci NOT NULL,
  `description` mediumtext COLLATE utf8_unicode_ci NOT NULL,
  `creation_date` datetime NOT NULL,
  `modified_date` datetime NOT NULL,
  `order` int(11) unsigned NOT NULL DEFAULT '0',
  `owner_type` varchar(64) CHARACTER SET latin1 COLLATE latin1_general_ci NOT NULL,
  `owner_id` int(11) unsigned NOT NULL,
  `file_id` int(11) unsigned NOT NULL,
  `view_count` int(11) unsigned NOT NULL DEFAULT '0',
  `comment_count` int(11) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`photo_id`),
  KEY `album_id` (`album_id`),
  KEY `owner_type` (`owner_type`,`owner_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


DROP TABLE IF EXISTS `engine4_announcement_announcements`;
CREATE TABLE `engine4_announcement_announcements` (
  `announcement_id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(11) unsigned NOT NULL,
  `title` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `body` text COLLATE utf8_unicode_ci NOT NULL,
  `creation_date` datetime NOT NULL,
  `modified_date` datetime DEFAULT NULL,
  `networks` text COLLATE utf8_unicode_ci,
  `member_levels` text COLLATE utf8_unicode_ci,
  `profile_types` text COLLATE utf8_unicode_ci,
  PRIMARY KEY (`announcement_id`),
  KEY `user_id` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


DROP TABLE IF EXISTS `engine4_authorization_allow`;
CREATE TABLE `engine4_authorization_allow` (
  `resource_type` varchar(64) CHARACTER SET latin1 COLLATE latin1_general_ci NOT NULL,
  `resource_id` int(11) unsigned NOT NULL,
  `action` varchar(16) CHARACTER SET latin1 COLLATE latin1_general_ci NOT NULL,
  `role` varchar(24) CHARACTER SET latin1 COLLATE latin1_general_ci NOT NULL,
  `role_id` int(11) unsigned NOT NULL DEFAULT '0',
  `value` tinyint(1) NOT NULL DEFAULT '0',
  `params` text COLLATE utf8_unicode_ci,
  PRIMARY KEY (`resource_type`,`resource_id`,`action`,`role`,`role_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


DROP TABLE IF EXISTS `engine4_authorization_levels`;
CREATE TABLE `engine4_authorization_levels` (
  `level_id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `description` text COLLATE utf8_unicode_ci NOT NULL,
  `type` enum('public','user','moderator','admin') COLLATE utf8_unicode_ci NOT NULL DEFAULT 'user',
  `flag` enum('default','superadmin','public') COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`level_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


DROP TABLE IF EXISTS `engine4_authorization_permissions`;
CREATE TABLE `engine4_authorization_permissions` (
  `level_id` int(11) unsigned NOT NULL,
  `type` varchar(64) CHARACTER SET latin1 COLLATE latin1_general_ci NOT NULL,
  `name` varchar(64) CHARACTER SET latin1 COLLATE latin1_general_ci NOT NULL,
  `value` tinyint(3) NOT NULL DEFAULT '0',
  `params` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`level_id`,`type`,`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


DROP TABLE IF EXISTS `engine4_blog_blogs`;
CREATE TABLE `engine4_blog_blogs` (
  `blog_id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(128) COLLATE utf8_unicode_ci NOT NULL,
  `body` longtext COLLATE utf8_unicode_ci NOT NULL,
  `owner_type` varchar(64) CHARACTER SET latin1 COLLATE latin1_general_ci NOT NULL,
  `owner_id` int(11) unsigned NOT NULL,
  `category_id` int(11) unsigned NOT NULL DEFAULT '0',
  `creation_date` datetime NOT NULL,
  `modified_date` datetime NOT NULL,
  `view_count` int(11) unsigned NOT NULL DEFAULT '0',
  `comment_count` int(11) unsigned NOT NULL DEFAULT '0',
  `search` tinyint(1) NOT NULL DEFAULT '1',
  `draft` tinyint(1) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`blog_id`),
  KEY `owner_type` (`owner_type`,`owner_id`),
  KEY `search` (`search`,`creation_date`),
  KEY `owner_id` (`owner_id`,`draft`),
  KEY `draft` (`draft`,`search`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


DROP TABLE IF EXISTS `engine4_blog_categories`;
CREATE TABLE `engine4_blog_categories` (
  `category_id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) unsigned NOT NULL,
  `category_name` varchar(128) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`category_id`),
  KEY `user_id` (`user_id`),
  KEY `category_id` (`category_id`,`category_name`),
  KEY `category_name` (`category_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


DROP TABLE IF EXISTS `engine4_blog_subscriptions`;
CREATE TABLE `engine4_blog_subscriptions` (
  `subscription_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(10) unsigned NOT NULL,
  `subscriber_user_id` int(10) unsigned NOT NULL,
  PRIMARY KEY (`subscription_id`),
  UNIQUE KEY `user_id` (`user_id`,`subscriber_user_id`),
  KEY `subscriber_user_id` (`subscriber_user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


DROP TABLE IF EXISTS `engine4_chat_bans`;
CREATE TABLE `engine4_chat_bans` (
  `ban_id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `room_id` int(11) DEFAULT NULL,
  `description` varchar(255) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `expires` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`ban_id`),
  KEY `user_id` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


DROP TABLE IF EXISTS `engine4_chat_events`;
CREATE TABLE `engine4_chat_events` (
  `event_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `date` datetime NOT NULL,
  `type` varchar(64) COLLATE utf8_unicode_ci NOT NULL,
  `body` text COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`event_id`),
  KEY `user_id` (`user_id`,`date`),
  KEY `date` (`date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


DROP TABLE IF EXISTS `engine4_chat_messages`;
CREATE TABLE `engine4_chat_messages` (
  `message_id` int(11) NOT NULL AUTO_INCREMENT,
  `room_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `system` tinyint(1) NOT NULL DEFAULT '0',
  `body` text COLLATE utf8_unicode_ci NOT NULL,
  `date` datetime NOT NULL,
  PRIMARY KEY (`message_id`),
  KEY `room_id` (`room_id`,`date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


DROP TABLE IF EXISTS `engine4_chat_rooms`;
CREATE TABLE `engine4_chat_rooms` (
  `room_id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(64) COLLATE utf8_unicode_ci DEFAULT NULL,
  `user_count` smallint(6) NOT NULL,
  `modified_date` datetime NOT NULL,
  `public` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`room_id`),
  KEY `public` (`public`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


DROP TABLE IF EXISTS `engine4_chat_roomusers`;
CREATE TABLE `engine4_chat_roomusers` (
  `room_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `state` tinyint(1) NOT NULL DEFAULT '1',
  `date` datetime NOT NULL,
  PRIMARY KEY (`room_id`,`user_id`),
  KEY `user_id` (`user_id`),
  KEY `date` (`date`)
) ENGINE=MEMORY DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


DROP TABLE IF EXISTS `engine4_chat_users`;
CREATE TABLE `engine4_chat_users` (
  `user_id` int(11) NOT NULL,
  `state` tinyint(1) NOT NULL DEFAULT '1',
  `date` datetime NOT NULL,
  `event_count` smallint(6) NOT NULL DEFAULT '0',
  PRIMARY KEY (`user_id`),
  KEY `date` (`date`)
) ENGINE=MEMORY DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


DROP TABLE IF EXISTS `engine4_chat_whispers`;
CREATE TABLE `engine4_chat_whispers` (
  `whisper_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `recipient_id` int(11) NOT NULL,
  `sender_id` int(11) NOT NULL,
  `body` text COLLATE utf8_unicode_ci NOT NULL,
  `date` datetime NOT NULL,
  `recipient_deleted` tinyint(1) NOT NULL DEFAULT '0',
  `sender_deleted` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`whisper_id`),
  KEY `recipient_id` (`recipient_id`),
  KEY `sender_id` (`sender_id`),
  KEY `recipient_deleted` (`recipient_deleted`,`sender_deleted`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


DROP TABLE IF EXISTS `engine4_classified_albums`;
CREATE TABLE `engine4_classified_albums` (
  `album_id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `classified_id` int(11) unsigned NOT NULL,
  `title` varchar(128) COLLATE utf8_unicode_ci NOT NULL,
  `description` mediumtext COLLATE utf8_unicode_ci NOT NULL,
  `creation_date` datetime NOT NULL,
  `modified_date` datetime NOT NULL,
  `search` tinyint(1) NOT NULL DEFAULT '1',
  `photo_id` int(11) unsigned NOT NULL DEFAULT '0',
  `view_count` int(11) unsigned NOT NULL DEFAULT '0',
  `comment_count` int(11) unsigned NOT NULL DEFAULT '0',
  `collectible_count` int(11) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`album_id`),
  KEY `classified_id` (`classified_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


DROP TABLE IF EXISTS `engine4_classified_categories`;
CREATE TABLE `engine4_classified_categories` (
  `category_id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(11) unsigned NOT NULL,
  `category_name` varchar(128) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`category_id`),
  KEY `user_id` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


DROP TABLE IF EXISTS `engine4_classified_classifieds`;
CREATE TABLE `engine4_classified_classifieds` (
  `classified_id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(128) COLLATE utf8_unicode_ci NOT NULL,
  `body` longtext COLLATE utf8_unicode_ci NOT NULL,
  `owner_id` int(11) unsigned NOT NULL,
  `category_id` int(11) unsigned NOT NULL,
  `photo_id` int(10) unsigned NOT NULL DEFAULT '0',
  `creation_date` datetime NOT NULL,
  `modified_date` datetime NOT NULL,
  `view_count` int(11) unsigned NOT NULL DEFAULT '0',
  `comment_count` int(11) unsigned NOT NULL DEFAULT '0',
  `search` tinyint(1) NOT NULL DEFAULT '1',
  `closed` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`classified_id`),
  KEY `owner_id` (`owner_id`),
  KEY `search` (`search`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


DROP TABLE IF EXISTS `engine4_classified_fields_maps`;
CREATE TABLE `engine4_classified_fields_maps` (
  `field_id` int(11) NOT NULL,
  `option_id` int(11) NOT NULL,
  `child_id` int(11) NOT NULL,
  `order` smallint(6) NOT NULL,
  PRIMARY KEY (`field_id`,`option_id`,`child_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


DROP TABLE IF EXISTS `engine4_classified_fields_meta`;
CREATE TABLE `engine4_classified_fields_meta` (
  `field_id` int(11) NOT NULL AUTO_INCREMENT,
  `type` varchar(24) CHARACTER SET latin1 COLLATE latin1_general_ci NOT NULL,
  `label` varchar(64) COLLATE utf8_unicode_ci NOT NULL,
  `description` varchar(255) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `alias` varchar(32) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `required` tinyint(1) NOT NULL DEFAULT '0',
  `display` tinyint(1) unsigned NOT NULL,
  `search` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `show` tinyint(1) unsigned NOT NULL DEFAULT '1',
  `order` smallint(3) unsigned NOT NULL DEFAULT '999',
  `config` text COLLATE utf8_unicode_ci NOT NULL,
  `validators` text COLLATE utf8_unicode_ci,
  `filters` text COLLATE utf8_unicode_ci,
  `style` text COLLATE utf8_unicode_ci,
  `error` text COLLATE utf8_unicode_ci,
  PRIMARY KEY (`field_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


DROP TABLE IF EXISTS `engine4_classified_fields_options`;
CREATE TABLE `engine4_classified_fields_options` (
  `option_id` int(11) NOT NULL AUTO_INCREMENT,
  `field_id` int(11) NOT NULL,
  `label` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `order` smallint(6) NOT NULL DEFAULT '999',
  PRIMARY KEY (`option_id`),
  KEY `field_id` (`field_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


DROP TABLE IF EXISTS `engine4_classified_fields_search`;
CREATE TABLE `engine4_classified_fields_search` (
  `item_id` int(11) NOT NULL,
  `price` double DEFAULT NULL,
  `location` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`item_id`),
  KEY `price` (`price`),
  KEY `location` (`location`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


DROP TABLE IF EXISTS `engine4_classified_fields_values`;
CREATE TABLE `engine4_classified_fields_values` (
  `item_id` int(11) NOT NULL,
  `field_id` int(11) NOT NULL,
  `index` smallint(3) NOT NULL DEFAULT '0',
  `value` text COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`item_id`,`field_id`,`index`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


DROP TABLE IF EXISTS `engine4_classified_photos`;
CREATE TABLE `engine4_classified_photos` (
  `photo_id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `album_id` int(11) unsigned NOT NULL,
  `classified_id` int(11) unsigned NOT NULL,
  `user_id` int(11) unsigned NOT NULL,
  `title` varchar(128) COLLATE utf8_unicode_ci NOT NULL,
  `description` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `collection_id` int(11) unsigned NOT NULL,
  `file_id` int(11) unsigned NOT NULL,
  `creation_date` datetime NOT NULL,
  `modified_date` datetime NOT NULL,
  PRIMARY KEY (`photo_id`),
  KEY `album_id` (`album_id`),
  KEY `classified_id` (`classified_id`),
  KEY `user_id` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


DROP TABLE IF EXISTS `engine4_core_adcampaigns`;
CREATE TABLE `engine4_core_adcampaigns` (
  `adcampaign_id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `end_settings` tinyint(4) NOT NULL,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `start_time` datetime NOT NULL,
  `end_time` datetime NOT NULL,
  `limit_view` int(11) unsigned NOT NULL DEFAULT '0',
  `limit_click` int(11) unsigned NOT NULL DEFAULT '0',
  `limit_ctr` varchar(11) COLLATE utf8_unicode_ci NOT NULL DEFAULT '0',
  `network` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `level` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `views` int(11) unsigned NOT NULL DEFAULT '0',
  `clicks` int(11) unsigned NOT NULL DEFAULT '0',
  `status` tinyint(4) NOT NULL DEFAULT '0',
  PRIMARY KEY (`adcampaign_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


DROP TABLE IF EXISTS `engine4_core_adphotos`;
CREATE TABLE `engine4_core_adphotos` (
  `adphoto_id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `ad_id` int(11) unsigned NOT NULL,
  `title` varchar(128) COLLATE utf8_unicode_ci NOT NULL,
  `description` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `file_id` int(11) unsigned NOT NULL,
  `creation_date` datetime NOT NULL,
  `modified_date` datetime NOT NULL,
  PRIMARY KEY (`adphoto_id`),
  KEY `ad_id` (`ad_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


DROP TABLE IF EXISTS `engine4_core_ads`;
CREATE TABLE `engine4_core_ads` (
  `ad_id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(16) COLLATE utf8_unicode_ci NOT NULL,
  `ad_campaign` int(11) unsigned NOT NULL,
  `views` int(11) unsigned NOT NULL DEFAULT '0',
  `clicks` int(11) unsigned NOT NULL DEFAULT '0',
  `media_type` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `html_code` text COLLATE utf8_unicode_ci NOT NULL,
  `photo_id` int(11) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`ad_id`),
  KEY `ad_campaign` (`ad_campaign`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


DROP TABLE IF EXISTS `engine4_core_auth`;
CREATE TABLE `engine4_core_auth` (
  `id` varchar(40) CHARACTER SET latin1 COLLATE latin1_general_ci NOT NULL,
  `user_id` int(11) unsigned NOT NULL,
  `type` varchar(32) CHARACTER SET latin1 COLLATE latin1_general_ci DEFAULT NULL,
  `expires` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`,`user_id`),
  KEY `expires` (`expires`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


DROP TABLE IF EXISTS `engine4_core_bannedemails`;
CREATE TABLE `engine4_core_bannedemails` (
  `bannedemail_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `email` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`bannedemail_id`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


DROP TABLE IF EXISTS `engine4_core_bannedips`;
CREATE TABLE `engine4_core_bannedips` (
  `bannedip_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `start` varbinary(16) NOT NULL,
  `stop` varbinary(16) NOT NULL,
  PRIMARY KEY (`bannedip_id`),
  UNIQUE KEY `start` (`start`,`stop`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


DROP TABLE IF EXISTS `engine4_core_bannedusernames`;
CREATE TABLE `engine4_core_bannedusernames` (
  `bannedusername_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `username` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`bannedusername_id`),
  KEY `username` (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


DROP TABLE IF EXISTS `engine4_core_bannedwords`;
CREATE TABLE `engine4_core_bannedwords` (
  `bannedword_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `word` text COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`bannedword_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


DROP TABLE IF EXISTS `engine4_core_comments`;
CREATE TABLE `engine4_core_comments` (
  `comment_id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `resource_type` varchar(32) CHARACTER SET latin1 COLLATE latin1_general_ci NOT NULL,
  `resource_id` int(11) unsigned NOT NULL,
  `poster_type` varchar(32) CHARACTER SET latin1 COLLATE latin1_general_ci NOT NULL,
  `poster_id` int(11) unsigned NOT NULL,
  `body` text COLLATE utf8_unicode_ci NOT NULL,
  `creation_date` datetime NOT NULL,
  `like_count` int(11) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`comment_id`),
  KEY `resource_type` (`resource_type`,`resource_id`),
  KEY `poster_type` (`poster_type`,`poster_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


DROP TABLE IF EXISTS `engine4_core_content`;
CREATE TABLE `engine4_core_content` (
  `content_id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `page_id` int(11) unsigned NOT NULL,
  `type` varchar(32) CHARACTER SET latin1 COLLATE latin1_general_ci NOT NULL DEFAULT 'widget',
  `name` varchar(64) CHARACTER SET latin1 COLLATE latin1_general_ci NOT NULL,
  `parent_content_id` int(11) unsigned DEFAULT NULL,
  `order` int(11) NOT NULL DEFAULT '1',
  `params` text COLLATE utf8_unicode_ci,
  `attribs` text COLLATE utf8_unicode_ci,
  PRIMARY KEY (`content_id`),
  KEY `page_id` (`page_id`,`order`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


DROP TABLE IF EXISTS `engine4_core_geotags`;
CREATE TABLE `engine4_core_geotags` (
  `geotag_id` int(11) unsigned NOT NULL,
  `latitude` float NOT NULL,
  `longitude` float NOT NULL,
  PRIMARY KEY (`geotag_id`),
  KEY `latitude` (`latitude`,`longitude`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


DROP TABLE IF EXISTS `engine4_core_jobs`;
CREATE TABLE `engine4_core_jobs` (
  `job_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `jobtype_id` int(10) unsigned NOT NULL,
  `state` enum('pending','active','sleeping','failed','cancelled','completed','timeout') COLLATE utf8_unicode_ci NOT NULL DEFAULT 'pending',
  `is_complete` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `progress` decimal(5,4) unsigned NOT NULL DEFAULT '0.0000',
  `creation_date` datetime NOT NULL,
  `modified_date` datetime DEFAULT NULL,
  `started_date` datetime DEFAULT NULL,
  `completion_date` datetime DEFAULT NULL,
  `priority` mediumint(9) NOT NULL DEFAULT '100',
  `data` text COLLATE utf8_unicode_ci,
  `messages` text COLLATE utf8_unicode_ci,
  PRIMARY KEY (`job_id`),
  KEY `jobtype_id` (`jobtype_id`),
  KEY `state` (`state`),
  KEY `is_complete` (`is_complete`,`priority`,`job_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


DROP TABLE IF EXISTS `engine4_core_jobtypes`;
CREATE TABLE `engine4_core_jobtypes` (
  `jobtype_id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(128) COLLATE utf8_unicode_ci NOT NULL,
  `type` varchar(64) CHARACTER SET latin1 COLLATE latin1_general_ci NOT NULL,
  `module` varchar(64) CHARACTER SET latin1 COLLATE latin1_general_ci NOT NULL,
  `plugin` varchar(128) CHARACTER SET latin1 COLLATE latin1_general_ci NOT NULL,
  `form` varchar(128) CHARACTER SET latin1 COLLATE latin1_general_ci DEFAULT NULL,
  `enabled` tinyint(1) unsigned NOT NULL DEFAULT '1',
  `priority` mediumint(9) NOT NULL DEFAULT '100',
  `multi` tinyint(3) unsigned DEFAULT '1',
  PRIMARY KEY (`jobtype_id`),
  UNIQUE KEY `type` (`type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


DROP TABLE IF EXISTS `engine4_core_languages`;
CREATE TABLE `engine4_core_languages` (
  `language_id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `code` varchar(8) CHARACTER SET latin1 COLLATE latin1_general_ci NOT NULL,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `fallback` varchar(8) CHARACTER SET latin1 COLLATE latin1_general_ci DEFAULT NULL,
  `order` smallint(6) NOT NULL DEFAULT '1',
  PRIMARY KEY (`language_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


DROP TABLE IF EXISTS `engine4_core_likes`;
CREATE TABLE `engine4_core_likes` (
  `like_id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `resource_type` varchar(32) CHARACTER SET latin1 COLLATE latin1_general_ci NOT NULL,
  `resource_id` int(11) unsigned NOT NULL,
  `poster_type` varchar(32) CHARACTER SET latin1 COLLATE latin1_general_ci NOT NULL,
  `poster_id` int(11) unsigned NOT NULL,
  PRIMARY KEY (`like_id`),
  KEY `resource_type` (`resource_type`,`resource_id`),
  KEY `poster_type` (`poster_type`,`poster_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


DROP TABLE IF EXISTS `engine4_core_links`;
CREATE TABLE `engine4_core_links` (
  `link_id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `uri` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `title` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `description` text COLLATE utf8_unicode_ci NOT NULL,
  `photo_id` int(11) unsigned NOT NULL DEFAULT '0',
  `parent_type` varchar(24) CHARACTER SET latin1 COLLATE latin1_general_ci NOT NULL,
  `parent_id` int(11) unsigned NOT NULL,
  `owner_type` varchar(24) CHARACTER SET latin1 COLLATE latin1_general_ci NOT NULL,
  `owner_id` int(11) unsigned NOT NULL,
  `view_count` mediumint(6) unsigned NOT NULL DEFAULT '0',
  `creation_date` datetime NOT NULL,
  `search` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`link_id`),
  KEY `owner` (`owner_type`,`owner_id`),
  KEY `parent` (`parent_type`,`parent_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


DROP TABLE IF EXISTS `engine4_core_listitems`;
CREATE TABLE `engine4_core_listitems` (
  `listitem_id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `list_id` int(11) unsigned NOT NULL,
  `child_id` int(11) unsigned NOT NULL,
  PRIMARY KEY (`listitem_id`),
  KEY `list_id` (`list_id`),
  KEY `child_id` (`child_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


DROP TABLE IF EXISTS `engine4_core_lists`;
CREATE TABLE `engine4_core_lists` (
  `list_id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(64) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `owner_type` varchar(24) CHARACTER SET latin1 COLLATE latin1_general_ci NOT NULL,
  `owner_id` int(11) unsigned NOT NULL,
  `child_type` varchar(24) CHARACTER SET latin1 COLLATE latin1_general_ci NOT NULL,
  `child_count` int(11) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`list_id`),
  KEY `owner_type` (`owner_type`,`owner_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


DROP TABLE IF EXISTS `engine4_core_log`;
CREATE TABLE `engine4_core_log` (
  `message_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `domain` varchar(32) CHARACTER SET latin1 COLLATE latin1_general_ci NOT NULL,
  `user_id` int(10) unsigned DEFAULT NULL,
  `plugin` varchar(128) COLLATE utf8_unicode_ci DEFAULT NULL,
  `timestamp` datetime NOT NULL,
  `message` longtext COLLATE utf8_unicode_ci NOT NULL,
  `priority` smallint(2) NOT NULL DEFAULT '6',
  `priorityName` varchar(16) COLLATE utf8_unicode_ci NOT NULL DEFAULT 'INFO',
  PRIMARY KEY (`message_id`),
  KEY `domain` (`domain`,`timestamp`),
  KEY `user_id` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


DROP TABLE IF EXISTS `engine4_core_mail`;
CREATE TABLE `engine4_core_mail` (
  `mail_id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `type` enum('system','zend') CHARACTER SET latin1 COLLATE latin1_general_ci NOT NULL,
  `body` longtext COLLATE utf8_unicode_ci NOT NULL,
  `priority` smallint(3) DEFAULT '100',
  `recipient_count` int(11) unsigned DEFAULT '0',
  `recipient_total` int(10) NOT NULL DEFAULT '0',
  `creation_time` datetime NOT NULL,
  PRIMARY KEY (`mail_id`),
  KEY `priority` (`priority`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


DROP TABLE IF EXISTS `engine4_core_mailrecipients`;
CREATE TABLE `engine4_core_mailrecipients` (
  `recipient_id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `mail_id` int(11) unsigned NOT NULL,
  `user_id` int(11) unsigned DEFAULT NULL,
  `email` varchar(128) CHARACTER SET latin1 COLLATE latin1_general_ci DEFAULT NULL,
  PRIMARY KEY (`recipient_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


DROP TABLE IF EXISTS `engine4_core_mailtemplates`;
CREATE TABLE `engine4_core_mailtemplates` (
  `mailtemplate_id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `type` varchar(255) CHARACTER SET latin1 COLLATE latin1_general_ci NOT NULL,
  `module` varchar(64) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `vars` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`mailtemplate_id`),
  UNIQUE KEY `type` (`type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


DROP TABLE IF EXISTS `engine4_core_menuitems`;
CREATE TABLE `engine4_core_menuitems` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(64) CHARACTER SET latin1 COLLATE latin1_general_ci NOT NULL,
  `module` varchar(32) CHARACTER SET latin1 COLLATE latin1_general_ci NOT NULL,
  `label` varchar(128) CHARACTER SET latin1 COLLATE latin1_general_ci DEFAULT NULL,
  `plugin` varchar(128) CHARACTER SET latin1 COLLATE latin1_general_ci DEFAULT NULL,
  `params` text COLLATE utf8_unicode_ci NOT NULL,
  `menu` varchar(64) CHARACTER SET latin1 COLLATE latin1_general_ci DEFAULT NULL,
  `submenu` varchar(32) CHARACTER SET latin1 COLLATE latin1_general_ci DEFAULT NULL,
  `enabled` tinyint(1) NOT NULL DEFAULT '1',
  `custom` tinyint(1) NOT NULL DEFAULT '0',
  `order` smallint(6) NOT NULL DEFAULT '999',
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`),
  KEY `LOOKUP` (`name`,`order`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


DROP TABLE IF EXISTS `engine4_core_menus`;
CREATE TABLE `engine4_core_menus` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(32) CHARACTER SET latin1 COLLATE latin1_general_ci NOT NULL,
  `type` enum('standard','hidden','custom') CHARACTER SET latin1 COLLATE latin1_general_ci NOT NULL DEFAULT 'standard',
  `title` varchar(64) COLLATE utf8_unicode_ci NOT NULL,
  `order` smallint(3) NOT NULL DEFAULT '999',
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`),
  KEY `order` (`order`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


DROP TABLE IF EXISTS `engine4_core_migrations`;
CREATE TABLE `engine4_core_migrations` (
  `package` varchar(128) CHARACTER SET latin1 COLLATE latin1_general_ci NOT NULL,
  `current` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`package`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


DROP TABLE IF EXISTS `engine4_core_modules`;
CREATE TABLE `engine4_core_modules` (
  `name` varchar(64) CHARACTER SET latin1 COLLATE latin1_general_ci NOT NULL,
  `title` varchar(128) CHARACTER SET latin1 COLLATE latin1_general_ci NOT NULL,
  `description` text COLLATE utf8_unicode_ci,
  `version` varchar(32) CHARACTER SET latin1 COLLATE latin1_general_ci NOT NULL,
  `enabled` tinyint(1) NOT NULL DEFAULT '0',
  `type` enum('core','standard','extra') CHARACTER SET latin1 COLLATE latin1_general_ci NOT NULL DEFAULT 'extra',
  PRIMARY KEY (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


DROP TABLE IF EXISTS `engine4_core_nodes`;
CREATE TABLE `engine4_core_nodes` (
  `node_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `signature` char(40) COLLATE utf8_unicode_ci NOT NULL,
  `host` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `ip` varbinary(16) NOT NULL,
  `first_seen` datetime NOT NULL,
  `last_seen` datetime NOT NULL,
  PRIMARY KEY (`node_id`),
  UNIQUE KEY `signature` (`signature`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


DROP TABLE IF EXISTS `engine4_core_pages`;
CREATE TABLE `engine4_core_pages` (
  `page_id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(128) CHARACTER SET latin1 COLLATE latin1_general_ci DEFAULT NULL,
  `displayname` varchar(128) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `url` varchar(128) COLLATE utf8_unicode_ci DEFAULT NULL,
  `title` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `description` text COLLATE utf8_unicode_ci NOT NULL,
  `keywords` text COLLATE utf8_unicode_ci NOT NULL,
  `custom` tinyint(1) NOT NULL DEFAULT '1',
  `fragment` tinyint(1) NOT NULL DEFAULT '0',
  `layout` varchar(32) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `levels` text COLLATE utf8_unicode_ci,
  `provides` text COLLATE utf8_unicode_ci,
  `view_count` int(11) unsigned NOT NULL DEFAULT '0',
  `search` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`page_id`),
  UNIQUE KEY `name` (`name`),
  UNIQUE KEY `url` (`url`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


DROP TABLE IF EXISTS `engine4_core_processes`;
CREATE TABLE `engine4_core_processes` (
  `pid` int(10) unsigned NOT NULL,
  `parent_pid` int(10) unsigned NOT NULL DEFAULT '0',
  `system_pid` int(10) unsigned NOT NULL DEFAULT '0',
  `started` int(10) unsigned NOT NULL,
  `timeout` mediumint(10) unsigned NOT NULL DEFAULT '0',
  `name` varchar(128) CHARACTER SET latin1 COLLATE latin1_general_ci NOT NULL,
  PRIMARY KEY (`pid`),
  KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


DROP TABLE IF EXISTS `engine4_core_referrers`;
CREATE TABLE `engine4_core_referrers` (
  `host` varchar(64) COLLATE utf8_unicode_ci NOT NULL,
  `path` varchar(64) COLLATE utf8_unicode_ci NOT NULL,
  `query` varchar(128) COLLATE utf8_unicode_ci NOT NULL,
  `value` int(11) unsigned NOT NULL,
  PRIMARY KEY (`host`,`path`,`query`),
  KEY `value` (`value`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


DROP TABLE IF EXISTS `engine4_core_reports`;
CREATE TABLE `engine4_core_reports` (
  `report_id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `category` varchar(16) COLLATE utf8_unicode_ci NOT NULL,
  `description` text COLLATE utf8_unicode_ci NOT NULL,
  `subject_type` varchar(32) CHARACTER SET latin1 COLLATE latin1_general_ci NOT NULL,
  `subject_id` int(11) NOT NULL,
  `creation_date` datetime NOT NULL,
  `read` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`report_id`),
  KEY `category` (`category`),
  KEY `user_id` (`user_id`),
  KEY `read` (`read`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


DROP TABLE IF EXISTS `engine4_core_routes`;
CREATE TABLE `engine4_core_routes` (
  `name` varchar(32) CHARACTER SET latin1 COLLATE latin1_general_ci NOT NULL,
  `config` text COLLATE utf8_unicode_ci NOT NULL,
  `order` smallint(6) NOT NULL DEFAULT '1',
  PRIMARY KEY (`name`),
  KEY `order` (`order`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


DROP TABLE IF EXISTS `engine4_core_search`;
CREATE TABLE `engine4_core_search` (
  `type` varchar(32) CHARACTER SET latin1 COLLATE latin1_general_ci NOT NULL,
  `id` int(11) unsigned NOT NULL,
  `title` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `description` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `keywords` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `hidden` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`type`,`id`),
  FULLTEXT KEY `LOOKUP` (`title`,`description`,`keywords`,`hidden`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


DROP TABLE IF EXISTS `engine4_core_serviceproviders`;
CREATE TABLE `engine4_core_serviceproviders` (
  `serviceprovider_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(128) COLLATE utf8_unicode_ci NOT NULL,
  `type` varchar(128) CHARACTER SET latin1 COLLATE latin1_general_ci NOT NULL,
  `name` varchar(128) CHARACTER SET latin1 COLLATE latin1_general_ci NOT NULL,
  `class` varchar(128) CHARACTER SET latin1 COLLATE latin1_general_ci NOT NULL,
  `enabled` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`serviceprovider_id`),
  UNIQUE KEY `type` (`type`,`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


DROP TABLE IF EXISTS `engine4_core_services`;
CREATE TABLE `engine4_core_services` (
  `service_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `type` varchar(128) CHARACTER SET latin1 COLLATE latin1_general_ci NOT NULL,
  `name` varchar(128) CHARACTER SET latin1 COLLATE latin1_general_ci NOT NULL,
  `profile` varchar(128) CHARACTER SET latin1 COLLATE latin1_general_ci NOT NULL DEFAULT 'default',
  `config` text COLLATE utf8_unicode_ci NOT NULL,
  `enabled` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`service_id`),
  UNIQUE KEY `type` (`type`,`profile`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


DROP TABLE IF EXISTS `engine4_core_servicetypes`;
CREATE TABLE `engine4_core_servicetypes` (
  `servicetype_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(128) COLLATE utf8_unicode_ci NOT NULL,
  `type` varchar(128) CHARACTER SET latin1 COLLATE latin1_general_ci NOT NULL,
  `interface` varchar(128) CHARACTER SET latin1 COLLATE latin1_general_ci DEFAULT NULL,
  `enabled` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`servicetype_id`),
  UNIQUE KEY `type` (`type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


DROP TABLE IF EXISTS `engine4_core_session`;
CREATE TABLE `engine4_core_session` (
  `id` char(32) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `modified` int(11) DEFAULT NULL,
  `lifetime` int(11) DEFAULT NULL,
  `data` text COLLATE utf8_unicode_ci,
  `user_id` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


DROP TABLE IF EXISTS `engine4_core_settings`;
CREATE TABLE `engine4_core_settings` (
  `name` varchar(255) CHARACTER SET latin1 COLLATE latin1_general_ci NOT NULL,
  `value` longtext COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


DROP TABLE IF EXISTS `engine4_core_statistics`;
CREATE TABLE `engine4_core_statistics` (
  `type` varchar(64) CHARACTER SET latin1 COLLATE latin1_general_ci NOT NULL,
  `date` datetime NOT NULL,
  `value` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`type`,`date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


DROP TABLE IF EXISTS `engine4_core_status`;
CREATE TABLE `engine4_core_status` (
  `status_id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `resource_type` varchar(32) CHARACTER SET latin1 COLLATE latin1_general_ci NOT NULL,
  `resource_id` int(11) unsigned NOT NULL,
  `body` text COLLATE utf8_unicode_ci NOT NULL,
  `creation_date` datetime NOT NULL,
  PRIMARY KEY (`status_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


DROP TABLE IF EXISTS `engine4_core_styles`;
CREATE TABLE `engine4_core_styles` (
  `type` varchar(32) CHARACTER SET latin1 COLLATE latin1_general_ci NOT NULL,
  `id` int(11) unsigned NOT NULL,
  `style` text COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`type`,`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


DROP TABLE IF EXISTS `engine4_core_tagmaps`;
CREATE TABLE `engine4_core_tagmaps` (
  `tagmap_id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `resource_type` varchar(24) CHARACTER SET latin1 COLLATE latin1_general_ci NOT NULL,
  `resource_id` int(11) unsigned NOT NULL,
  `tagger_type` varchar(24) CHARACTER SET latin1 COLLATE latin1_general_ci NOT NULL,
  `tagger_id` int(11) unsigned NOT NULL,
  `tag_type` varchar(24) CHARACTER SET latin1 COLLATE latin1_general_ci NOT NULL,
  `tag_id` int(11) unsigned NOT NULL,
  `creation_date` datetime DEFAULT NULL,
  `extra` text COLLATE utf8_unicode_ci,
  PRIMARY KEY (`tagmap_id`),
  KEY `resource_type` (`resource_type`,`resource_id`),
  KEY `tagger_type` (`tagger_type`,`tagger_id`),
  KEY `tag_type` (`tag_type`,`tag_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


DROP TABLE IF EXISTS `engine4_core_tags`;
CREATE TABLE `engine4_core_tags` (
  `tag_id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `text` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`tag_id`),
  UNIQUE KEY `text` (`text`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


DROP TABLE IF EXISTS `engine4_core_tasks`;
CREATE TABLE `engine4_core_tasks` (
  `task_id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `module` varchar(128) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `plugin` varchar(128) CHARACTER SET latin1 COLLATE latin1_general_ci NOT NULL,
  `timeout` int(11) unsigned NOT NULL DEFAULT '60',
  `processes` smallint(3) unsigned NOT NULL DEFAULT '1',
  `semaphore` smallint(3) NOT NULL DEFAULT '0',
  `started_last` int(11) NOT NULL DEFAULT '0',
  `started_count` int(11) unsigned NOT NULL DEFAULT '0',
  `completed_last` int(11) NOT NULL DEFAULT '0',
  `completed_count` int(11) unsigned NOT NULL DEFAULT '0',
  `failure_last` int(11) NOT NULL DEFAULT '0',
  `failure_count` int(11) unsigned NOT NULL DEFAULT '0',
  `success_last` int(11) NOT NULL DEFAULT '0',
  `success_count` int(11) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`task_id`),
  UNIQUE KEY `plugin` (`plugin`),
  KEY `module` (`module`),
  KEY `started_last` (`started_last`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


DROP TABLE IF EXISTS `engine4_core_themes`;
CREATE TABLE `engine4_core_themes` (
  `theme_id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(64) CHARACTER SET latin1 COLLATE latin1_general_ci NOT NULL,
  `title` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `description` text COLLATE utf8_unicode_ci NOT NULL,
  `active` tinyint(4) NOT NULL DEFAULT '0',
  PRIMARY KEY (`theme_id`),
  UNIQUE KEY `name` (`name`),
  KEY `active` (`active`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


DROP TABLE IF EXISTS `engine4_event_albums`;
CREATE TABLE `engine4_event_albums` (
  `album_id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `event_id` int(11) unsigned NOT NULL,
  `title` varchar(128) COLLATE utf8_unicode_ci NOT NULL,
  `description` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `creation_date` datetime NOT NULL,
  `modified_date` datetime NOT NULL,
  `search` tinyint(1) NOT NULL DEFAULT '1',
  `photo_id` int(11) unsigned NOT NULL DEFAULT '0',
  `view_count` int(11) unsigned NOT NULL DEFAULT '0',
  `comment_count` int(11) unsigned NOT NULL DEFAULT '0',
  `collectible_count` int(11) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`album_id`),
  KEY `event_id` (`event_id`),
  KEY `search` (`search`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


DROP TABLE IF EXISTS `engine4_event_categories`;
CREATE TABLE `engine4_event_categories` (
  `category_id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(64) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`category_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


DROP TABLE IF EXISTS `engine4_event_events`;
CREATE TABLE `engine4_event_events` (
  `event_id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(128) COLLATE utf8_unicode_ci NOT NULL,
  `description` text COLLATE utf8_unicode_ci NOT NULL,
  `user_id` int(11) unsigned NOT NULL,
  `parent_type` varchar(64) COLLATE utf8_unicode_ci NOT NULL,
  `parent_id` int(11) unsigned NOT NULL,
  `search` tinyint(1) NOT NULL DEFAULT '1',
  `creation_date` datetime NOT NULL,
  `modified_date` datetime NOT NULL,
  `starttime` datetime NOT NULL,
  `endtime` datetime NOT NULL,
  `host` varchar(115) COLLATE utf8_unicode_ci NOT NULL,
  `location` varchar(115) COLLATE utf8_unicode_ci NOT NULL,
  `view_count` int(11) unsigned NOT NULL DEFAULT '0',
  `member_count` int(11) unsigned NOT NULL DEFAULT '0',
  `approval` tinyint(1) NOT NULL DEFAULT '0',
  `invite` tinyint(1) NOT NULL DEFAULT '0',
  `photo_id` int(11) unsigned NOT NULL,
  `category_id` int(11) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`event_id`),
  KEY `user_id` (`user_id`),
  KEY `parent_type` (`parent_type`,`parent_id`),
  KEY `starttime` (`starttime`),
  KEY `search` (`search`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


DROP TABLE IF EXISTS `engine4_event_membership`;
CREATE TABLE `engine4_event_membership` (
  `resource_id` int(11) unsigned NOT NULL,
  `user_id` int(11) unsigned NOT NULL,
  `active` tinyint(1) NOT NULL DEFAULT '0',
  `resource_approved` tinyint(1) NOT NULL DEFAULT '0',
  `user_approved` tinyint(1) NOT NULL DEFAULT '0',
  `message` text COLLATE utf8_unicode_ci,
  `rsvp` tinyint(3) NOT NULL DEFAULT '3',
  `title` text COLLATE utf8_unicode_ci,
  PRIMARY KEY (`resource_id`,`user_id`),
  KEY `REVERSE` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


DROP TABLE IF EXISTS `engine4_event_photos`;
CREATE TABLE `engine4_event_photos` (
  `photo_id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `album_id` int(11) unsigned NOT NULL,
  `event_id` int(11) unsigned NOT NULL,
  `user_id` int(11) unsigned NOT NULL,
  `title` varchar(128) COLLATE utf8_unicode_ci NOT NULL,
  `description` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `collection_id` int(11) unsigned NOT NULL,
  `file_id` int(11) unsigned NOT NULL,
  `creation_date` datetime NOT NULL,
  `modified_date` datetime NOT NULL,
  `view_count` int(11) unsigned NOT NULL DEFAULT '0',
  `comment_count` int(11) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`photo_id`),
  KEY `album_id` (`album_id`),
  KEY `event_id` (`event_id`),
  KEY `collection_id` (`collection_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


DROP TABLE IF EXISTS `engine4_event_posts`;
CREATE TABLE `engine4_event_posts` (
  `post_id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `topic_id` int(11) unsigned NOT NULL,
  `event_id` int(11) unsigned NOT NULL,
  `user_id` int(11) unsigned NOT NULL,
  `body` text COLLATE utf8_unicode_ci NOT NULL,
  `creation_date` datetime NOT NULL,
  `modified_date` datetime NOT NULL,
  PRIMARY KEY (`post_id`),
  KEY `topic_id` (`topic_id`),
  KEY `event_id` (`event_id`),
  KEY `user_id` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


DROP TABLE IF EXISTS `engine4_event_topics`;
CREATE TABLE `engine4_event_topics` (
  `topic_id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `event_id` int(11) unsigned NOT NULL,
  `user_id` int(11) unsigned NOT NULL,
  `title` varchar(64) COLLATE utf8_unicode_ci NOT NULL,
  `creation_date` datetime NOT NULL,
  `modified_date` datetime NOT NULL,
  `sticky` tinyint(1) NOT NULL DEFAULT '0',
  `closed` tinyint(1) NOT NULL DEFAULT '0',
  `view_count` int(11) unsigned NOT NULL DEFAULT '0',
  `post_count` int(11) unsigned NOT NULL DEFAULT '0',
  `lastpost_id` int(11) unsigned NOT NULL,
  `lastposter_id` int(11) unsigned NOT NULL,
  PRIMARY KEY (`topic_id`),
  KEY `event_id` (`event_id`),
  KEY `user_id` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


DROP TABLE IF EXISTS `engine4_event_topicwatches`;
CREATE TABLE `engine4_event_topicwatches` (
  `resource_id` int(10) unsigned NOT NULL,
  `topic_id` int(10) unsigned NOT NULL,
  `user_id` int(10) unsigned NOT NULL,
  `watch` tinyint(1) unsigned NOT NULL DEFAULT '1',
  PRIMARY KEY (`resource_id`,`topic_id`,`user_id`),
  KEY `user_id` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


DROP TABLE IF EXISTS `engine4_forum_categories`;
CREATE TABLE `engine4_forum_categories` (
  `category_id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(64) COLLATE utf8_unicode_ci NOT NULL,
  `description` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `creation_date` datetime NOT NULL,
  `modified_date` datetime NOT NULL,
  `order` smallint(6) NOT NULL DEFAULT '0',
  `forum_count` int(11) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`category_id`),
  KEY `order` (`order`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


DROP TABLE IF EXISTS `engine4_forum_forums`;
CREATE TABLE `engine4_forum_forums` (
  `forum_id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `category_id` int(11) unsigned NOT NULL,
  `title` varchar(64) COLLATE utf8_unicode_ci NOT NULL,
  `description` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `creation_date` datetime NOT NULL,
  `modified_date` datetime NOT NULL,
  `order` smallint(6) NOT NULL DEFAULT '999',
  `file_id` int(11) unsigned NOT NULL DEFAULT '0',
  `view_count` int(11) unsigned NOT NULL DEFAULT '0',
  `topic_count` int(11) unsigned NOT NULL DEFAULT '0',
  `post_count` int(11) unsigned NOT NULL DEFAULT '0',
  `lastpost_id` int(11) unsigned NOT NULL DEFAULT '0',
  `lastposter_id` int(11) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`forum_id`),
  KEY `category_id` (`category_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


DROP TABLE IF EXISTS `engine4_forum_listitems`;
CREATE TABLE `engine4_forum_listitems` (
  `listitem_id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `list_id` int(11) unsigned NOT NULL,
  `child_id` int(11) unsigned NOT NULL,
  PRIMARY KEY (`listitem_id`),
  KEY `list_id` (`list_id`),
  KEY `child_id` (`child_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


DROP TABLE IF EXISTS `engine4_forum_lists`;
CREATE TABLE `engine4_forum_lists` (
  `list_id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `owner_id` int(11) unsigned NOT NULL,
  `child_count` int(11) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`list_id`),
  KEY `owner_id` (`owner_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


DROP TABLE IF EXISTS `engine4_forum_membership`;
CREATE TABLE `engine4_forum_membership` (
  `resource_id` int(11) unsigned NOT NULL,
  `user_id` int(11) unsigned NOT NULL,
  `active` tinyint(1) NOT NULL DEFAULT '0',
  `resource_approved` tinyint(1) NOT NULL DEFAULT '0',
  `moderator` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`resource_id`,`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


DROP TABLE IF EXISTS `engine4_forum_posts`;
CREATE TABLE `engine4_forum_posts` (
  `post_id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `topic_id` int(11) unsigned NOT NULL,
  `forum_id` int(11) unsigned NOT NULL,
  `user_id` int(11) unsigned NOT NULL,
  `body` text COLLATE utf8_unicode_ci NOT NULL,
  `creation_date` datetime NOT NULL,
  `modified_date` datetime NOT NULL,
  `file_id` int(11) unsigned NOT NULL DEFAULT '0',
  `edit_id` int(11) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`post_id`),
  KEY `topic_id` (`topic_id`),
  KEY `user_id` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


DROP TABLE IF EXISTS `engine4_forum_signatures`;
CREATE TABLE `engine4_forum_signatures` (
  `signature_id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(11) unsigned NOT NULL,
  `body` text COLLATE utf8_unicode_ci NOT NULL,
  `creation_date` datetime NOT NULL,
  `modified_date` datetime NOT NULL,
  `post_count` int(11) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`signature_id`),
  UNIQUE KEY `user_id` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


DROP TABLE IF EXISTS `engine4_forum_topics`;
CREATE TABLE `engine4_forum_topics` (
  `topic_id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `forum_id` int(11) unsigned NOT NULL,
  `user_id` int(11) unsigned NOT NULL,
  `title` varchar(64) COLLATE utf8_unicode_ci NOT NULL,
  `description` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `creation_date` datetime NOT NULL,
  `modified_date` datetime NOT NULL,
  `sticky` tinyint(4) NOT NULL DEFAULT '0',
  `closed` tinyint(4) NOT NULL DEFAULT '0',
  `post_count` int(11) unsigned NOT NULL DEFAULT '0',
  `view_count` int(11) unsigned NOT NULL DEFAULT '0',
  `lastpost_id` int(11) unsigned NOT NULL DEFAULT '0',
  `lastposter_id` int(11) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`topic_id`),
  KEY `forum_id` (`forum_id`),
  KEY `user_id` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


DROP TABLE IF EXISTS `engine4_forum_topicviews`;
CREATE TABLE `engine4_forum_topicviews` (
  `user_id` int(11) unsigned NOT NULL,
  `topic_id` int(11) unsigned NOT NULL,
  `last_view_date` datetime NOT NULL,
  PRIMARY KEY (`user_id`,`topic_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


DROP TABLE IF EXISTS `engine4_forum_topicwatches`;
CREATE TABLE `engine4_forum_topicwatches` (
  `resource_id` int(10) unsigned NOT NULL,
  `topic_id` int(10) unsigned NOT NULL,
  `user_id` int(10) unsigned NOT NULL,
  `watch` tinyint(1) unsigned NOT NULL DEFAULT '1',
  PRIMARY KEY (`resource_id`,`topic_id`,`user_id`),
  KEY `user_id` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


DROP TABLE IF EXISTS `engine4_group_albums`;
CREATE TABLE `engine4_group_albums` (
  `album_id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `group_id` int(11) unsigned NOT NULL,
  `title` varchar(128) COLLATE utf8_unicode_ci NOT NULL,
  `description` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `creation_date` datetime NOT NULL,
  `modified_date` datetime NOT NULL,
  `search` tinyint(1) NOT NULL DEFAULT '1',
  `photo_id` int(11) unsigned NOT NULL DEFAULT '0',
  `view_count` int(11) unsigned NOT NULL DEFAULT '0',
  `comment_count` int(11) unsigned NOT NULL DEFAULT '0',
  `collectible_count` int(11) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`album_id`),
  KEY `group_id` (`group_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


DROP TABLE IF EXISTS `engine4_group_categories`;
CREATE TABLE `engine4_group_categories` (
  `category_id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(64) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`category_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


DROP TABLE IF EXISTS `engine4_group_groups`;
CREATE TABLE `engine4_group_groups` (
  `group_id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(11) unsigned NOT NULL,
  `title` varchar(64) COLLATE utf8_unicode_ci NOT NULL,
  `description` text COLLATE utf8_unicode_ci NOT NULL,
  `category_id` int(11) unsigned NOT NULL DEFAULT '0',
  `search` tinyint(1) NOT NULL DEFAULT '1',
  `invite` tinyint(1) NOT NULL DEFAULT '1',
  `approval` tinyint(1) NOT NULL DEFAULT '0',
  `photo_id` int(11) unsigned NOT NULL DEFAULT '0',
  `creation_date` datetime NOT NULL,
  `modified_date` datetime NOT NULL,
  `member_count` smallint(6) unsigned NOT NULL,
  `view_count` int(11) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`group_id`),
  KEY `user_id` (`user_id`),
  KEY `search` (`search`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


DROP TABLE IF EXISTS `engine4_group_listitems`;
CREATE TABLE `engine4_group_listitems` (
  `listitem_id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `list_id` int(11) unsigned NOT NULL,
  `child_id` int(11) unsigned NOT NULL,
  PRIMARY KEY (`listitem_id`),
  KEY `list_id` (`list_id`),
  KEY `child_id` (`child_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


DROP TABLE IF EXISTS `engine4_group_lists`;
CREATE TABLE `engine4_group_lists` (
  `list_id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(64) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `owner_id` int(11) unsigned NOT NULL,
  `child_count` int(11) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`list_id`),
  KEY `owner_id` (`owner_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


DROP TABLE IF EXISTS `engine4_group_membership`;
CREATE TABLE `engine4_group_membership` (
  `resource_id` int(11) unsigned NOT NULL,
  `user_id` int(11) unsigned NOT NULL,
  `active` tinyint(1) NOT NULL DEFAULT '0',
  `resource_approved` tinyint(1) NOT NULL DEFAULT '0',
  `user_approved` tinyint(1) NOT NULL DEFAULT '0',
  `message` text COLLATE utf8_unicode_ci,
  `title` text COLLATE utf8_unicode_ci,
  PRIMARY KEY (`resource_id`,`user_id`),
  KEY `REVERSE` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


DROP TABLE IF EXISTS `engine4_group_photos`;
CREATE TABLE `engine4_group_photos` (
  `photo_id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `album_id` int(11) unsigned NOT NULL,
  `group_id` int(11) unsigned NOT NULL,
  `user_id` int(11) unsigned NOT NULL,
  `title` varchar(128) COLLATE utf8_unicode_ci NOT NULL,
  `description` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `collection_id` int(11) unsigned NOT NULL,
  `file_id` int(11) unsigned NOT NULL,
  `creation_date` datetime NOT NULL,
  `modified_date` datetime NOT NULL,
  `view_count` int(11) unsigned NOT NULL DEFAULT '0',
  `comment_count` int(11) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`photo_id`),
  KEY `album_id` (`album_id`),
  KEY `group_id` (`group_id`),
  KEY `user_id` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


DROP TABLE IF EXISTS `engine4_group_posts`;
CREATE TABLE `engine4_group_posts` (
  `post_id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `topic_id` int(11) unsigned NOT NULL,
  `group_id` int(11) unsigned NOT NULL,
  `user_id` int(11) unsigned NOT NULL,
  `body` text COLLATE utf8_unicode_ci NOT NULL,
  `creation_date` datetime NOT NULL,
  `modified_date` datetime NOT NULL,
  PRIMARY KEY (`post_id`),
  KEY `topic_id` (`topic_id`),
  KEY `group_id` (`group_id`),
  KEY `user_id` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


DROP TABLE IF EXISTS `engine4_group_topics`;
CREATE TABLE `engine4_group_topics` (
  `topic_id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `group_id` int(11) unsigned NOT NULL,
  `user_id` int(11) unsigned NOT NULL,
  `title` varchar(64) COLLATE utf8_unicode_ci NOT NULL,
  `creation_date` datetime NOT NULL,
  `modified_date` datetime NOT NULL,
  `sticky` tinyint(1) NOT NULL DEFAULT '0',
  `closed` tinyint(1) NOT NULL DEFAULT '0',
  `post_count` int(11) unsigned NOT NULL DEFAULT '0',
  `view_count` int(11) unsigned NOT NULL DEFAULT '0',
  `lastpost_id` int(11) unsigned NOT NULL DEFAULT '0',
  `lastposter_id` int(11) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`topic_id`),
  KEY `group_id` (`group_id`),
  KEY `user_id` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


DROP TABLE IF EXISTS `engine4_group_topicwatches`;
CREATE TABLE `engine4_group_topicwatches` (
  `resource_id` int(10) unsigned NOT NULL,
  `topic_id` int(10) unsigned NOT NULL,
  `user_id` int(10) unsigned NOT NULL,
  `watch` tinyint(1) unsigned NOT NULL DEFAULT '1',
  PRIMARY KEY (`resource_id`,`topic_id`,`user_id`),
  KEY `user_id` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


DROP TABLE IF EXISTS `engine4_invites`;
CREATE TABLE `engine4_invites` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(11) unsigned NOT NULL,
  `recipient` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `code` varchar(255) CHARACTER SET latin1 COLLATE latin1_general_ci NOT NULL,
  `send_request` int(11) NOT NULL,
  `timestamp` datetime NOT NULL,
  `message` text COLLATE utf8_unicode_ci NOT NULL,
  `new_user_id` int(11) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `code` (`code`),
  KEY `user_id` (`user_id`),
  KEY `recipient` (`recipient`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


DROP TABLE IF EXISTS `engine4_messages_conversations`;
CREATE TABLE `engine4_messages_conversations` (
  `conversation_id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(255) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `user_id` int(11) unsigned NOT NULL,
  `recipients` int(11) unsigned NOT NULL,
  `modified` datetime NOT NULL,
  `locked` tinyint(1) NOT NULL DEFAULT '0',
  `resource_type` varchar(64) CHARACTER SET latin1 COLLATE latin1_general_ci DEFAULT '',
  `resource_id` int(11) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`conversation_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


DROP TABLE IF EXISTS `engine4_messages_messages`;
CREATE TABLE `engine4_messages_messages` (
  `message_id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `conversation_id` int(11) unsigned NOT NULL,
  `user_id` int(11) unsigned NOT NULL,
  `title` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `body` text COLLATE utf8_unicode_ci NOT NULL,
  `date` datetime NOT NULL,
  `attachment_type` varchar(24) CHARACTER SET latin1 COLLATE latin1_general_ci DEFAULT '',
  `attachment_id` int(11) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`message_id`),
  UNIQUE KEY `CONVERSATIONS` (`conversation_id`,`message_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


DROP TABLE IF EXISTS `engine4_messages_recipients`;
CREATE TABLE `engine4_messages_recipients` (
  `user_id` int(11) unsigned NOT NULL,
  `conversation_id` int(11) unsigned NOT NULL,
  `inbox_message_id` int(11) unsigned DEFAULT NULL,
  `inbox_updated` datetime DEFAULT NULL,
  `inbox_read` tinyint(1) DEFAULT NULL,
  `inbox_deleted` tinyint(1) DEFAULT NULL,
  `outbox_message_id` int(11) unsigned DEFAULT NULL,
  `outbox_updated` datetime DEFAULT NULL,
  `outbox_deleted` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`user_id`,`conversation_id`),
  KEY `INBOX_UPDATED` (`user_id`,`conversation_id`,`inbox_updated`),
  KEY `OUTBOX_UPDATED` (`user_id`,`conversation_id`,`outbox_updated`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


DROP TABLE IF EXISTS `engine4_music_playlists`;
CREATE TABLE `engine4_music_playlists` (
  `playlist_id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(63) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `description` text COLLATE utf8_unicode_ci NOT NULL,
  `photo_id` int(11) unsigned NOT NULL DEFAULT '0',
  `owner_type` varchar(24) CHARACTER SET latin1 COLLATE latin1_general_ci NOT NULL,
  `owner_id` int(11) unsigned NOT NULL,
  `search` tinyint(1) NOT NULL DEFAULT '1',
  `profile` tinyint(1) NOT NULL DEFAULT '0',
  `special` enum('wall','message') COLLATE utf8_unicode_ci DEFAULT NULL,
  `creation_date` datetime NOT NULL,
  `modified_date` datetime NOT NULL,
  `view_count` int(11) unsigned NOT NULL DEFAULT '0',
  `comment_count` int(11) unsigned NOT NULL DEFAULT '0',
  `play_count` int(11) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`playlist_id`),
  KEY `creation_date` (`creation_date`),
  KEY `play_count` (`play_count`),
  KEY `owner_id` (`owner_type`,`owner_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


DROP TABLE IF EXISTS `engine4_music_playlist_songs`;
CREATE TABLE `engine4_music_playlist_songs` (
  `song_id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `playlist_id` int(11) unsigned NOT NULL,
  `file_id` int(11) unsigned NOT NULL,
  `title` varchar(60) COLLATE utf8_unicode_ci NOT NULL,
  `play_count` int(11) unsigned NOT NULL DEFAULT '0',
  `order` smallint(6) NOT NULL DEFAULT '0',
  PRIMARY KEY (`song_id`),
  KEY `playlist_id` (`playlist_id`,`file_id`),
  KEY `play_count` (`play_count`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


DROP TABLE IF EXISTS `engine4_network_membership`;
CREATE TABLE `engine4_network_membership` (
  `resource_id` int(11) unsigned NOT NULL,
  `user_id` int(11) unsigned NOT NULL,
  `active` tinyint(1) NOT NULL DEFAULT '0',
  `resource_approved` tinyint(1) NOT NULL DEFAULT '0',
  `user_approved` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`resource_id`,`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


DROP TABLE IF EXISTS `engine4_network_networks`;
CREATE TABLE `engine4_network_networks` (
  `network_id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `description` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `field_id` int(11) unsigned NOT NULL DEFAULT '0',
  `pattern` text COLLATE utf8_unicode_ci,
  `member_count` int(11) unsigned NOT NULL DEFAULT '0',
  `hide` tinyint(1) NOT NULL DEFAULT '0',
  `assignment` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`network_id`),
  KEY `assignment` (`assignment`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


DROP TABLE IF EXISTS `engine4_payment_gateways`;
CREATE TABLE `engine4_payment_gateways` (
  `gateway_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(128) COLLATE utf8_unicode_ci NOT NULL,
  `description` text COLLATE utf8_unicode_ci,
  `enabled` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `plugin` varchar(128) CHARACTER SET latin1 COLLATE latin1_general_ci NOT NULL,
  `config` mediumblob,
  `test_mode` tinyint(1) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`gateway_id`),
  KEY `enabled` (`enabled`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


DROP TABLE IF EXISTS `engine4_payment_orders`;
CREATE TABLE `engine4_payment_orders` (
  `order_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(10) unsigned NOT NULL,
  `gateway_id` int(10) unsigned NOT NULL,
  `gateway_order_id` varchar(128) CHARACTER SET latin1 COLLATE latin1_general_ci DEFAULT NULL,
  `gateway_transaction_id` varchar(128) CHARACTER SET latin1 COLLATE latin1_general_ci DEFAULT NULL,
  `state` enum('pending','cancelled','failed','incomplete','complete') CHARACTER SET latin1 COLLATE latin1_general_ci NOT NULL DEFAULT 'pending',
  `creation_date` datetime NOT NULL,
  `source_type` varchar(128) CHARACTER SET latin1 COLLATE latin1_general_ci DEFAULT NULL,
  `source_id` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`order_id`),
  KEY `user_id` (`user_id`),
  KEY `gateway_id` (`gateway_id`,`gateway_order_id`),
  KEY `state` (`state`),
  KEY `source_type` (`source_type`,`source_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


DROP TABLE IF EXISTS `engine4_payment_packages`;
CREATE TABLE `engine4_payment_packages` (
  `package_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(128) COLLATE utf8_unicode_ci NOT NULL,
  `description` text COLLATE utf8_unicode_ci NOT NULL,
  `level_id` int(10) unsigned NOT NULL,
  `downgrade_level_id` int(10) unsigned NOT NULL DEFAULT '0',
  `price` decimal(16,2) unsigned NOT NULL,
  `recurrence` int(11) unsigned NOT NULL,
  `recurrence_type` enum('day','week','month','year','forever') COLLATE utf8_unicode_ci NOT NULL,
  `duration` int(11) unsigned NOT NULL,
  `duration_type` enum('day','week','month','year','forever') COLLATE utf8_unicode_ci NOT NULL,
  `trial_duration` int(11) unsigned NOT NULL DEFAULT '0',
  `trial_duration_type` enum('day','week','month','year','forever') COLLATE utf8_unicode_ci DEFAULT NULL,
  `enabled` tinyint(1) unsigned NOT NULL DEFAULT '1',
  `signup` tinyint(1) unsigned NOT NULL DEFAULT '1',
  `after_signup` tinyint(1) unsigned NOT NULL DEFAULT '1',
  `default` tinyint(1) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`package_id`),
  KEY `level_id` (`level_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


DROP TABLE IF EXISTS `engine4_payment_products`;
CREATE TABLE `engine4_payment_products` (
  `product_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `extension_type` varchar(64) CHARACTER SET latin1 COLLATE latin1_general_ci DEFAULT NULL,
  `extension_id` int(10) unsigned DEFAULT NULL,
  `sku` bigint(20) unsigned NOT NULL,
  `title` varchar(128) COLLATE utf8_unicode_ci NOT NULL,
  `description` text COLLATE utf8_unicode_ci NOT NULL,
  `price` decimal(16,2) unsigned NOT NULL,
  PRIMARY KEY (`product_id`),
  UNIQUE KEY `sku` (`sku`),
  KEY `extension_type` (`extension_type`,`extension_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


DROP TABLE IF EXISTS `engine4_payment_subscriptions`;
CREATE TABLE `engine4_payment_subscriptions` (
  `subscription_id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(11) unsigned NOT NULL,
  `package_id` int(11) unsigned NOT NULL,
  `status` enum('initial','trial','pending','active','cancelled','expired','overdue','refunded') COLLATE utf8_unicode_ci NOT NULL DEFAULT 'initial',
  `active` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `creation_date` datetime NOT NULL,
  `modified_date` datetime DEFAULT NULL,
  `payment_date` datetime DEFAULT NULL,
  `expiration_date` datetime DEFAULT NULL,
  `notes` text COLLATE utf8_unicode_ci,
  `gateway_id` int(10) unsigned DEFAULT NULL,
  `gateway_profile_id` varchar(128) CHARACTER SET latin1 COLLATE latin1_general_ci DEFAULT NULL,
  PRIMARY KEY (`subscription_id`),
  UNIQUE KEY `gateway_id` (`gateway_id`,`gateway_profile_id`),
  KEY `user_id` (`user_id`),
  KEY `package_id` (`package_id`),
  KEY `status` (`status`),
  KEY `active` (`active`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


DROP TABLE IF EXISTS `engine4_payment_transactions`;
CREATE TABLE `engine4_payment_transactions` (
  `transaction_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(10) unsigned NOT NULL DEFAULT '0',
  `gateway_id` int(10) unsigned NOT NULL,
  `timestamp` datetime NOT NULL,
  `order_id` int(10) unsigned NOT NULL DEFAULT '0',
  `type` varchar(64) CHARACTER SET latin1 COLLATE latin1_general_ci DEFAULT NULL,
  `state` varchar(64) CHARACTER SET latin1 COLLATE latin1_general_ci DEFAULT NULL,
  `gateway_transaction_id` varchar(128) CHARACTER SET latin1 COLLATE latin1_general_ci NOT NULL,
  `gateway_parent_transaction_id` varchar(128) CHARACTER SET latin1 COLLATE latin1_general_ci DEFAULT NULL,
  `gateway_order_id` varchar(128) CHARACTER SET latin1 COLLATE latin1_general_ci DEFAULT NULL,
  `amount` decimal(16,2) NOT NULL,
  `currency` char(3) CHARACTER SET latin1 COLLATE latin1_general_ci NOT NULL DEFAULT '',
  PRIMARY KEY (`transaction_id`),
  KEY `user_id` (`user_id`),
  KEY `gateway_id` (`gateway_id`),
  KEY `type` (`type`),
  KEY `state` (`state`),
  KEY `gateway_transaction_id` (`gateway_transaction_id`),
  KEY `gateway_parent_transaction_id` (`gateway_parent_transaction_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


DROP TABLE IF EXISTS `engine4_poll_options`;
CREATE TABLE `engine4_poll_options` (
  `poll_option_id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `poll_id` int(11) unsigned NOT NULL,
  `poll_option` text COLLATE utf8_unicode_ci NOT NULL,
  `votes` smallint(4) unsigned NOT NULL,
  PRIMARY KEY (`poll_option_id`),
  KEY `poll_id` (`poll_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


DROP TABLE IF EXISTS `engine4_poll_polls`;
CREATE TABLE `engine4_poll_polls` (
  `poll_id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(11) unsigned NOT NULL,
  `is_closed` tinyint(1) NOT NULL DEFAULT '0',
  `title` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `description` text COLLATE utf8_unicode_ci NOT NULL,
  `creation_date` datetime NOT NULL,
  `view_count` int(11) unsigned NOT NULL DEFAULT '0',
  `comment_count` int(11) unsigned NOT NULL DEFAULT '0',
  `vote_count` int(11) unsigned NOT NULL DEFAULT '0',
  `search` tinyint(1) NOT NULL DEFAULT '1',
  `closed` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`poll_id`),
  KEY `user_id` (`user_id`),
  KEY `is_closed` (`is_closed`),
  KEY `creation_date` (`creation_date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


DROP TABLE IF EXISTS `engine4_poll_votes`;
CREATE TABLE `engine4_poll_votes` (
  `poll_id` int(11) unsigned NOT NULL,
  `user_id` int(11) unsigned NOT NULL,
  `poll_option_id` int(11) unsigned NOT NULL,
  `creation_date` datetime NOT NULL,
  `modified_date` datetime NOT NULL,
  PRIMARY KEY (`poll_id`,`user_id`),
  KEY `poll_option_id` (`poll_option_id`),
  KEY `user_id` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


DROP TABLE IF EXISTS `engine4_push_log`;
CREATE TABLE `engine4_push_log` (
  `log_id` int(11) NOT NULL AUTO_INCREMENT,
  `conversation_id` int(11) NOT NULL,
  `message_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `sender_id` int(11) NOT NULL DEFAULT '0',
  `status` int(11) NOT NULL DEFAULT '1',
  PRIMARY KEY (`log_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


DROP TABLE IF EXISTS `engine4_push_notices`;
CREATE TABLE `engine4_push_notices` (
  `id_push` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `push_number` int(11) unsigned NOT NULL,
  `user_id` int(11) unsigned NOT NULL,
  `title` varchar(34) NOT NULL,
  `body` varchar(256) NOT NULL,
  `button_link` varchar(104) DEFAULT NULL,
  `button_title` varchar(34) DEFAULT NULL,
  `second_button_link` varchar(104) DEFAULT NULL,
  `second_button_title` varchar(34) DEFAULT NULL,
  `is_sent` tinyint(1) NOT NULL,
  `creation_date` datetime NOT NULL,
  PRIMARY KEY (`id_push`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;


DROP TABLE IF EXISTS `engine4_seaocores`;
CREATE TABLE `engine4_seaocores` (
  `seaocores_id` int(11) NOT NULL AUTO_INCREMENT,
  `module_name` varchar(64) COLLATE utf8_unicode_ci NOT NULL,
  `title` varchar(64) COLLATE utf8_unicode_ci NOT NULL,
  `description` text COLLATE utf8_unicode_ci NOT NULL,
  `version` varchar(32) COLLATE utf8_unicode_ci NOT NULL,
  `is_installed` tinyint(1) NOT NULL,
  `category` varchar(64) COLLATE utf8_unicode_ci NOT NULL,
  `ptype` varchar(20) COLLATE utf8_unicode_ci NOT NULL,
  `is_activate` int(11) NOT NULL DEFAULT '0',
  `enviroment` varchar(50) COLLATE utf8_unicode_ci NOT NULL DEFAULT 'development',
  PRIMARY KEY (`seaocores_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


DROP TABLE IF EXISTS `engine4_seaocore_bannedpageurls`;
CREATE TABLE `engine4_seaocore_bannedpageurls` (
  `bannedpageurl_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `word` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`bannedpageurl_id`),
  UNIQUE KEY `word` (`word`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


DROP TABLE IF EXISTS `engine4_seaocore_invites`;
CREATE TABLE `engine4_seaocore_invites` (
  `invite_id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `resource_type` varchar(64) COLLATE utf8_unicode_ci NOT NULL,
  `resource_id` int(11) NOT NULL,
  `creation_time` datetime NOT NULL,
  `recipient_id` int(11) unsigned NOT NULL,
  `params` longtext COLLATE utf8_unicode_ci,
  `inviter_id` int(11) NOT NULL,
  PRIMARY KEY (`invite_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


DROP TABLE IF EXISTS `engine4_seaocore_locationcontents`;
CREATE TABLE `engine4_seaocore_locationcontents` (
  `locationcontent_id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `location` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `latitude` double NOT NULL,
  `longitude` double NOT NULL,
  `status` tinyint(1) NOT NULL DEFAULT '1',
  `formatted_address` text COLLATE utf8_unicode_ci,
  `country` varchar(128) COLLATE utf8_unicode_ci DEFAULT NULL,
  `state` varchar(128) COLLATE utf8_unicode_ci DEFAULT NULL,
  `zipcode` varchar(32) COLLATE utf8_unicode_ci DEFAULT NULL,
  `city` varchar(128) COLLATE utf8_unicode_ci DEFAULT NULL,
  `address` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`locationcontent_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


DROP TABLE IF EXISTS `engine4_seaocore_locationitems`;
CREATE TABLE `engine4_seaocore_locationitems` (
  `locationitem_id` int(11) NOT NULL AUTO_INCREMENT,
  `resource_type` varchar(64) COLLATE utf8_unicode_ci NOT NULL,
  `resource_id` int(11) NOT NULL,
  `location` text COLLATE utf8_unicode_ci,
  `latitude` double NOT NULL,
  `longitude` double NOT NULL,
  `formatted_address` text COLLATE utf8_unicode_ci,
  `country` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `state` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `zipcode` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `city` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `address` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `zoom` int(11) NOT NULL,
  PRIMARY KEY (`locationitem_id`),
  UNIQUE KEY `resource_id` (`resource_id`,`resource_type`),
  KEY `resource_type` (`resource_type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


DROP TABLE IF EXISTS `engine4_seaocore_locations`;
CREATE TABLE `engine4_seaocore_locations` (
  `location_id` int(11) NOT NULL AUTO_INCREMENT,
  `location` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `latitude` double NOT NULL,
  `longitude` double NOT NULL,
  `formatted_address` text COLLATE utf8_unicode_ci,
  `country` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `state` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `zipcode` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `city` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `address` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `zoom` int(11) NOT NULL,
  PRIMARY KEY (`location_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


DROP TABLE IF EXISTS `engine4_seaocore_searchformsetting`;
CREATE TABLE `engine4_seaocore_searchformsetting` (
  `searchformsetting_id` int(11) NOT NULL AUTO_INCREMENT,
  `module` varchar(64) COLLATE utf8_unicode_ci NOT NULL,
  `name` varchar(64) COLLATE utf8_unicode_ci NOT NULL,
  `display` tinyint(1) NOT NULL DEFAULT '1',
  `order` int(11) NOT NULL DEFAULT '0',
  `label` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`searchformsetting_id`),
  UNIQUE KEY `PLUGIN_NAME` (`module`,`name`),
  KEY `module` (`module`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


DROP TABLE IF EXISTS `engine4_seaocore_tabs`;
CREATE TABLE `engine4_seaocore_tabs` (
  `tab_id` int(11) NOT NULL AUTO_INCREMENT,
  `module` varchar(64) COLLATE utf8_unicode_ci NOT NULL,
  `type` varchar(64) COLLATE utf8_unicode_ci NOT NULL,
  `name` varchar(64) COLLATE utf8_unicode_ci NOT NULL,
  `title` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `enabled` tinyint(1) NOT NULL DEFAULT '1',
  `order` int(3) NOT NULL DEFAULT '0',
  `limit` int(3) NOT NULL,
  `show` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`tab_id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


DROP TABLE IF EXISTS `engine4_seaocore_userinfo`;
CREATE TABLE `engine4_seaocore_userinfo` (
  `userinfo_id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(32) NOT NULL,
  `rating_avg` float NOT NULL,
  `rating_users` float NOT NULL,
  `review_count` int(11) NOT NULL,
  PRIMARY KEY (`userinfo_id`),
  UNIQUE KEY `user_id` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


DROP TABLE IF EXISTS `engine4_shoespage_categories`;
CREATE TABLE `engine4_shoespage_categories` (
  `category_id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) unsigned NOT NULL,
  `category_name` varchar(128) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`category_id`),
  KEY `user_id` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


DROP TABLE IF EXISTS `engine4_shoespage_contests`;
CREATE TABLE `engine4_shoespage_contests` (
  `contest_id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `category_id` tinyint(1) unsigned NOT NULL,
  `owner_id` int(11) unsigned NOT NULL,
  `photo_id` int(11) unsigned NOT NULL,
  `image_url` varchar(255) NOT NULL,
  `likes` int(11) unsigned NOT NULL,
  `place` smallint(2) unsigned NOT NULL,
  `start_date` date NOT NULL,
  `extended` tinyint(1) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`contest_id`),
  UNIQUE KEY `category_id_photo_id_finish_date` (`category_id`,`photo_id`,`start_date`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;


DROP TABLE IF EXISTS `engine4_shoespage_photos`;
CREATE TABLE `engine4_shoespage_photos` (
  `photo_id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `shoespage_id` int(11) unsigned NOT NULL,
  `title` varchar(128) COLLATE utf8_unicode_ci NOT NULL,
  `description` mediumtext COLLATE utf8_unicode_ci NOT NULL,
  `creation_date` datetime NOT NULL,
  `modified_date` datetime NOT NULL,
  `order` int(11) unsigned NOT NULL DEFAULT '0',
  `owner_type` varchar(64) CHARACTER SET latin1 COLLATE latin1_general_ci NOT NULL,
  `owner_id` int(11) unsigned NOT NULL,
  `file_id` int(11) unsigned NOT NULL,
  `view_count` int(11) unsigned NOT NULL DEFAULT '0',
  `comment_count` int(11) unsigned NOT NULL DEFAULT '0',
  `like_count` int(11) unsigned NOT NULL DEFAULT '0',
  `extended` int(11) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`photo_id`),
  KEY `shoespage_id` (`shoespage_id`),
  KEY `owner_type` (`owner_type`,`owner_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


DROP TABLE IF EXISTS `engine4_shoespage_shoespages`;
CREATE TABLE `engine4_shoespage_shoespages` (
  `shoespage_id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(128) COLLATE utf8_unicode_ci NOT NULL,
  `description` mediumtext COLLATE utf8_unicode_ci NOT NULL,
  `owner_type` varchar(64) CHARACTER SET latin1 COLLATE latin1_general_ci NOT NULL,
  `owner_id` int(11) unsigned NOT NULL,
  `category_id` int(11) unsigned NOT NULL DEFAULT '0',
  `creation_date` datetime NOT NULL,
  `modified_date` datetime NOT NULL,
  `photo_id` int(11) unsigned NOT NULL DEFAULT '0',
  `view_count` int(11) unsigned NOT NULL DEFAULT '0',
  `comment_count` int(11) unsigned NOT NULL DEFAULT '0',
  `search` tinyint(1) NOT NULL DEFAULT '0',
  `type` enum('wall','profile','message','blog') COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`shoespage_id`),
  KEY `owner_type` (`owner_type`,`owner_id`),
  KEY `category_id` (`category_id`),
  KEY `search` (`search`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


DROP TABLE IF EXISTS `engine4_storage_chunks`;
CREATE TABLE `engine4_storage_chunks` (
  `chunk_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `file_id` int(11) unsigned NOT NULL,
  `data` blob NOT NULL,
  PRIMARY KEY (`chunk_id`),
  KEY `file_id` (`file_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


DROP TABLE IF EXISTS `engine4_storage_files`;
CREATE TABLE `engine4_storage_files` (
  `file_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `parent_file_id` int(10) unsigned DEFAULT NULL,
  `type` varchar(16) CHARACTER SET latin1 COLLATE latin1_general_ci DEFAULT NULL,
  `parent_type` varchar(32) CHARACTER SET latin1 COLLATE latin1_general_ci DEFAULT NULL,
  `parent_id` int(10) unsigned DEFAULT NULL,
  `user_id` int(10) unsigned DEFAULT NULL,
  `creation_date` datetime NOT NULL,
  `modified_date` datetime NOT NULL,
  `service_id` int(10) unsigned NOT NULL DEFAULT '1',
  `storage_path` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `extension` varchar(8) COLLATE utf8_unicode_ci NOT NULL,
  `name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `mime_major` varchar(64) COLLATE utf8_unicode_ci NOT NULL,
  `mime_minor` varchar(64) COLLATE utf8_unicode_ci NOT NULL,
  `size` bigint(20) unsigned NOT NULL,
  `hash` varchar(64) CHARACTER SET latin1 COLLATE latin1_general_ci NOT NULL,
  PRIMARY KEY (`file_id`),
  UNIQUE KEY `parent_file_id` (`parent_file_id`,`type`),
  KEY `PARENT` (`parent_type`,`parent_id`),
  KEY `user_id` (`user_id`),
  KEY `service_id` (`service_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


DROP TABLE IF EXISTS `engine4_storage_mirrors`;
CREATE TABLE `engine4_storage_mirrors` (
  `file_id` bigint(20) unsigned NOT NULL,
  `service_id` int(10) unsigned NOT NULL,
  PRIMARY KEY (`file_id`,`service_id`),
  KEY `service_id` (`service_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


DROP TABLE IF EXISTS `engine4_storage_services`;
CREATE TABLE `engine4_storage_services` (
  `service_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `servicetype_id` int(10) unsigned NOT NULL,
  `config` text CHARACTER SET latin1 COLLATE latin1_general_ci,
  `enabled` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `default` tinyint(1) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`service_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


DROP TABLE IF EXISTS `engine4_storage_servicetypes`;
CREATE TABLE `engine4_storage_servicetypes` (
  `servicetype_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(128) COLLATE utf8_unicode_ci NOT NULL,
  `plugin` varchar(128) CHARACTER SET latin1 COLLATE latin1_general_ci NOT NULL,
  `form` varchar(128) CHARACTER SET latin1 COLLATE latin1_general_ci DEFAULT NULL,
  `enabled` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`servicetype_id`),
  UNIQUE KEY `plugin` (`plugin`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


DROP TABLE IF EXISTS `engine4_users`;
CREATE TABLE `engine4_users` (
  `user_id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `email` varchar(128) COLLATE utf8_unicode_ci NOT NULL,
  `username` varchar(128) COLLATE utf8_unicode_ci DEFAULT NULL,
  `displayname` varchar(128) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `photo_id` int(11) unsigned NOT NULL DEFAULT '0',
  `status` text COLLATE utf8_unicode_ci,
  `status_date` datetime DEFAULT NULL,
  `password` char(32) COLLATE utf8_unicode_ci NOT NULL,
  `salt` char(64) COLLATE utf8_unicode_ci NOT NULL,
  `locale` varchar(16) CHARACTER SET latin1 COLLATE latin1_general_ci NOT NULL DEFAULT 'auto',
  `language` varchar(8) CHARACTER SET latin1 COLLATE latin1_general_ci NOT NULL DEFAULT 'en_US',
  `timezone` varchar(64) CHARACTER SET latin1 COLLATE latin1_general_ci NOT NULL DEFAULT 'America/Los_Angeles',
  `search` tinyint(1) NOT NULL DEFAULT '1',
  `show_profileviewers` tinyint(1) NOT NULL DEFAULT '1',
  `level_id` int(11) unsigned NOT NULL,
  `invites_used` int(11) unsigned NOT NULL DEFAULT '0',
  `extra_invites` int(11) unsigned NOT NULL DEFAULT '0',
  `enabled` tinyint(1) NOT NULL DEFAULT '1',
  `verified` tinyint(1) NOT NULL DEFAULT '0',
  `approved` tinyint(1) NOT NULL DEFAULT '1',
  `creation_date` datetime NOT NULL,
  `creation_ip` varbinary(16) NOT NULL,
  `modified_date` datetime NOT NULL,
  `lastlogin_date` datetime DEFAULT NULL,
  `lastlogin_ip` varbinary(16) DEFAULT NULL,
  `update_date` int(11) DEFAULT NULL,
  `member_count` smallint(5) unsigned NOT NULL DEFAULT '0',
  `view_count` int(11) unsigned NOT NULL DEFAULT '0',
  `maleshoes_likes` tinyint(2) unsigned NOT NULL DEFAULT '0',
  `femaleshoes_likes` tinyint(2) unsigned NOT NULL DEFAULT '0',
  `sneakers_likes` tinyint(2) unsigned NOT NULL DEFAULT '0',
  `maleshoes_photos` tinyint(2) unsigned NOT NULL DEFAULT '0',
  `femaleshoes_photos` tinyint(2) unsigned NOT NULL DEFAULT '0',
  `sneakers_photos` tinyint(2) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`user_id`),
  UNIQUE KEY `EMAIL` (`email`),
  UNIQUE KEY `USERNAME` (`username`),
  KEY `MEMBER_COUNT` (`member_count`),
  KEY `CREATION_DATE` (`creation_date`),
  KEY `search` (`search`),
  KEY `enabled` (`enabled`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


DROP TABLE IF EXISTS `engine4_user_block`;
CREATE TABLE `engine4_user_block` (
  `user_id` int(11) unsigned NOT NULL,
  `blocked_user_id` int(11) unsigned NOT NULL,
  PRIMARY KEY (`user_id`,`blocked_user_id`),
  KEY `REVERSE` (`blocked_user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


DROP TABLE IF EXISTS `engine4_user_facebook`;
CREATE TABLE `engine4_user_facebook` (
  `user_id` int(11) unsigned NOT NULL,
  `facebook_uid` bigint(20) unsigned NOT NULL,
  `access_token` varchar(255) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `code` varchar(255) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `expires` bigint(20) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`user_id`),
  UNIQUE KEY `facebook_uid` (`facebook_uid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


DROP TABLE IF EXISTS `engine4_user_fields_maps`;
CREATE TABLE `engine4_user_fields_maps` (
  `field_id` int(11) unsigned NOT NULL,
  `option_id` int(11) unsigned NOT NULL,
  `child_id` int(11) unsigned NOT NULL,
  `order` smallint(6) NOT NULL,
  PRIMARY KEY (`field_id`,`option_id`,`child_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


DROP TABLE IF EXISTS `engine4_user_fields_meta`;
CREATE TABLE `engine4_user_fields_meta` (
  `field_id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `type` varchar(24) CHARACTER SET latin1 COLLATE latin1_general_ci NOT NULL,
  `label` varchar(64) COLLATE utf8_unicode_ci NOT NULL,
  `description` varchar(255) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `alias` varchar(32) CHARACTER SET latin1 COLLATE latin1_general_ci NOT NULL DEFAULT '',
  `required` tinyint(1) NOT NULL DEFAULT '0',
  `display` tinyint(1) unsigned NOT NULL,
  `publish` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `search` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `show` tinyint(1) unsigned NOT NULL DEFAULT '1',
  `order` smallint(3) unsigned NOT NULL DEFAULT '999',
  `config` text COLLATE utf8_unicode_ci,
  `validators` text COLLATE utf8_unicode_ci,
  `filters` text COLLATE utf8_unicode_ci,
  `style` text COLLATE utf8_unicode_ci,
  `error` text COLLATE utf8_unicode_ci,
  PRIMARY KEY (`field_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


DROP TABLE IF EXISTS `engine4_user_fields_options`;
CREATE TABLE `engine4_user_fields_options` (
  `option_id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `field_id` int(11) unsigned NOT NULL,
  `label` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `order` smallint(6) NOT NULL DEFAULT '999',
  PRIMARY KEY (`option_id`),
  KEY `field_id` (`field_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


DROP TABLE IF EXISTS `engine4_user_fields_search`;
CREATE TABLE `engine4_user_fields_search` (
  `item_id` int(11) unsigned NOT NULL,
  `profile_type` smallint(11) unsigned DEFAULT NULL,
  `first_name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `last_name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `gender` smallint(6) unsigned DEFAULT NULL,
  `birthdate` date DEFAULT NULL,
  PRIMARY KEY (`item_id`),
  KEY `profile_type` (`profile_type`),
  KEY `first_name` (`first_name`),
  KEY `last_name` (`last_name`),
  KEY `gender` (`gender`),
  KEY `birthdate` (`birthdate`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


DROP TABLE IF EXISTS `engine4_user_fields_values`;
CREATE TABLE `engine4_user_fields_values` (
  `item_id` int(11) unsigned NOT NULL,
  `field_id` int(11) unsigned NOT NULL,
  `index` smallint(3) unsigned NOT NULL DEFAULT '0',
  `value` text COLLATE utf8_unicode_ci NOT NULL,
  `privacy` varchar(64) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`item_id`,`field_id`,`index`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


DROP TABLE IF EXISTS `engine4_user_forgot`;
CREATE TABLE `engine4_user_forgot` (
  `user_id` int(11) unsigned NOT NULL,
  `code` varchar(64) CHARACTER SET latin1 COLLATE latin1_general_ci NOT NULL,
  `creation_date` datetime NOT NULL,
  PRIMARY KEY (`user_id`),
  KEY `code` (`code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


DROP TABLE IF EXISTS `engine4_user_janrain`;
CREATE TABLE `engine4_user_janrain` (
  `user_id` int(11) unsigned NOT NULL,
  `identifier` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `provider` varchar(255) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `token` varchar(255) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  PRIMARY KEY (`user_id`),
  UNIQUE KEY `identifier` (`identifier`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


DROP TABLE IF EXISTS `engine4_user_listitems`;
CREATE TABLE `engine4_user_listitems` (
  `listitem_id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `list_id` int(11) unsigned NOT NULL,
  `child_id` int(11) unsigned NOT NULL,
  PRIMARY KEY (`listitem_id`),
  KEY `list_id` (`list_id`),
  KEY `child_id` (`child_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


DROP TABLE IF EXISTS `engine4_user_lists`;
CREATE TABLE `engine4_user_lists` (
  `list_id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(64) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `owner_id` int(11) unsigned NOT NULL,
  `child_count` int(11) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`list_id`),
  KEY `owner_id` (`owner_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


DROP TABLE IF EXISTS `engine4_user_logins`;
CREATE TABLE `engine4_user_logins` (
  `login_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(10) unsigned DEFAULT NULL,
  `email` varchar(128) COLLATE utf8_unicode_ci DEFAULT NULL,
  `ip` varbinary(16) NOT NULL,
  `timestamp` datetime NOT NULL,
  `state` enum('success','no-member','bad-password','disabled','unpaid','third-party','v3-migration','unknown') CHARACTER SET latin1 COLLATE latin1_general_ci NOT NULL DEFAULT 'unknown',
  `source` varchar(64) COLLATE utf8_unicode_ci DEFAULT NULL,
  `active` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`login_id`),
  KEY `user_id` (`user_id`),
  KEY `email` (`email`),
  KEY `ip` (`ip`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


DROP TABLE IF EXISTS `engine4_user_membership`;
CREATE TABLE `engine4_user_membership` (
  `resource_id` int(11) unsigned NOT NULL,
  `user_id` int(11) unsigned NOT NULL,
  `active` tinyint(1) NOT NULL DEFAULT '0',
  `resource_approved` tinyint(1) NOT NULL DEFAULT '0',
  `user_approved` tinyint(1) NOT NULL DEFAULT '0',
  `message` text COLLATE utf8_unicode_ci,
  `description` text COLLATE utf8_unicode_ci,
  PRIMARY KEY (`resource_id`,`user_id`),
  KEY `REVERSE` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


DROP TABLE IF EXISTS `engine4_user_online`;
CREATE TABLE `engine4_user_online` (
  `ip` varbinary(16) NOT NULL,
  `user_id` int(11) unsigned NOT NULL DEFAULT '0',
  `active` datetime NOT NULL,
  PRIMARY KEY (`ip`,`user_id`),
  KEY `LOOKUP` (`active`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


DROP TABLE IF EXISTS `engine4_user_settings`;
CREATE TABLE `engine4_user_settings` (
  `user_id` int(10) unsigned NOT NULL,
  `name` varchar(64) CHARACTER SET latin1 COLLATE latin1_general_ci NOT NULL,
  `value` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`user_id`,`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


DROP TABLE IF EXISTS `engine4_user_signup`;
CREATE TABLE `engine4_user_signup` (
  `signup_id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `class` varchar(128) CHARACTER SET latin1 COLLATE latin1_general_ci NOT NULL,
  `order` smallint(6) NOT NULL DEFAULT '999',
  `enable` smallint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`signup_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


DROP TABLE IF EXISTS `engine4_user_twitter`;
CREATE TABLE `engine4_user_twitter` (
  `user_id` int(10) unsigned NOT NULL,
  `twitter_uid` bigint(20) unsigned NOT NULL,
  `twitter_token` varchar(255) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `twitter_secret` varchar(255) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  PRIMARY KEY (`user_id`),
  UNIQUE KEY `twitter_uid` (`twitter_uid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


DROP TABLE IF EXISTS `engine4_user_verify`;
CREATE TABLE `engine4_user_verify` (
  `user_id` int(11) unsigned NOT NULL,
  `code` varchar(64) CHARACTER SET latin1 COLLATE latin1_general_ci NOT NULL,
  `date` datetime NOT NULL,
  PRIMARY KEY (`user_id`),
  KEY `code` (`code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


DROP TABLE IF EXISTS `engine4_video_categories`;
CREATE TABLE `engine4_video_categories` (
  `category_id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(11) unsigned NOT NULL,
  `category_name` varchar(128) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`category_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


DROP TABLE IF EXISTS `engine4_video_ratings`;
CREATE TABLE `engine4_video_ratings` (
  `video_id` int(10) unsigned NOT NULL,
  `user_id` int(9) unsigned NOT NULL,
  `rating` tinyint(1) unsigned DEFAULT NULL,
  PRIMARY KEY (`video_id`,`user_id`),
  KEY `INDEX` (`video_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


DROP TABLE IF EXISTS `engine4_video_videos`;
CREATE TABLE `engine4_video_videos` (
  `video_id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `description` text COLLATE utf8_unicode_ci NOT NULL,
  `search` tinyint(1) NOT NULL DEFAULT '1',
  `owner_type` varchar(128) CHARACTER SET latin1 COLLATE latin1_general_ci NOT NULL,
  `owner_id` int(11) NOT NULL,
  `parent_type` varchar(128) CHARACTER SET latin1 COLLATE latin1_general_ci DEFAULT NULL,
  `parent_id` int(11) unsigned DEFAULT NULL,
  `creation_date` datetime NOT NULL,
  `modified_date` datetime NOT NULL,
  `view_count` int(11) unsigned NOT NULL DEFAULT '0',
  `comment_count` int(11) unsigned NOT NULL DEFAULT '0',
  `type` tinyint(1) NOT NULL,
  `code` varchar(150) COLLATE utf8_unicode_ci NOT NULL,
  `photo_id` int(11) unsigned DEFAULT NULL,
  `rating` float NOT NULL,
  `category_id` int(11) unsigned NOT NULL DEFAULT '0',
  `status` tinyint(1) NOT NULL,
  `file_id` int(11) unsigned NOT NULL,
  `duration` int(9) unsigned NOT NULL,
  `rotation` smallint(5) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`video_id`),
  KEY `owner_id` (`owner_id`,`owner_type`),
  KEY `search` (`search`),
  KEY `creation_date` (`creation_date`),
  KEY `view_count` (`view_count`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


-- 2017-04-04 11:26:45
