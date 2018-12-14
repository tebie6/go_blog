# ************************************************************
# Sequel Pro SQL dump
# Version 4541
#
# http://www.sequelpro.com/
# https://github.com/sequelpro/sequelpro
#
# Host: 127.0.0.1 (MySQL 5.7.19)
# Database: go_test
# Generation Time: 2018-12-14 04:47:55 +0000
# ************************************************************


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


# Dump of table tb_auth_permission
# ------------------------------------------------------------

DROP TABLE IF EXISTS `tb_auth_permission`;

CREATE TABLE `tb_auth_permission` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '资源控制表',
  `title` varchar(20) NOT NULL DEFAULT '' COMMENT '节点名称',
  `pid` int(11) NOT NULL DEFAULT '0' COMMENT '节点父级id',
  `status` tinyint(1) NOT NULL DEFAULT '0' COMMENT '状态 1正常 0禁用',
  `level` tinyint(1) NOT NULL COMMENT '节点类型：1:表示应用；2:模块 3:表示控制器\\方法',
  `is_show` tinyint(1) NOT NULL COMMENT '是否展示 1展示 0不展示',
  `route` varchar(50) NOT NULL DEFAULT '' COMMENT '路由',
  `url` varchar(50) DEFAULT NULL COMMENT 'url',
  `is_del` tinyint(1) DEFAULT NULL COMMENT '是否删除 0否 1是',
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `tb_auth_permission` WRITE;
/*!40000 ALTER TABLE `tb_auth_permission` DISABLE KEYS */;

INSERT INTO `tb_auth_permission` (`id`, `title`, `pid`, `status`, `level`, `is_show`, `route`, `url`, `is_del`, `created_at`, `updated_at`)
VALUES
	(41,'后台应用',0,1,1,0,'backend',NULL,0,'2018-12-10 14:04:14','2018-12-14 12:44:29'),
	(42,'用户',41,1,2,1,'user',NULL,0,'2018-12-10 14:12:27','2018-12-10 14:12:27'),
	(43,'角色管理',42,1,3,1,'/auth/rolelist',NULL,0,'2018-12-10 14:13:18','2018-12-10 14:28:35'),
	(44,'编辑角色【页面】',42,1,3,0,'/auth/role',NULL,0,'2018-12-10 14:27:32','2018-12-10 14:27:32'),
	(45,'编辑角色【保存】',42,1,3,0,'/auth/rolesave',NULL,0,'2018-12-10 15:14:19','2018-12-10 15:14:19'),
	(46,'删除角色',42,1,3,0,'/auth/roledelete',NULL,0,'2018-12-10 15:14:44','2018-12-10 15:14:44'),
	(47,'权限管理',42,1,3,1,'/auth/permissionlist',NULL,0,'2018-12-12 16:10:29','2018-12-12 16:10:29'),
	(48,'添加/编辑权限',42,1,3,0,'/auth/permissionsave',NULL,0,'2018-12-12 16:11:22','2018-12-12 16:11:22'),
	(49,'删除权限',42,1,3,0,'/auth/permissiondel',NULL,0,'2018-12-12 16:12:47','2018-12-12 16:12:47');

/*!40000 ALTER TABLE `tb_auth_permission` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table tb_auth_permission_copy
# ------------------------------------------------------------

DROP TABLE IF EXISTS `tb_auth_permission_copy`;

CREATE TABLE `tb_auth_permission_copy` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '资源控制表',
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `status` tinyint(1) NOT NULL DEFAULT '0' COMMENT '状态 0正常 1删除',
  `title` varchar(20) NOT NULL DEFAULT '' COMMENT '节点名称',
  `pid` int(11) NOT NULL DEFAULT '0' COMMENT '节点父级id',
  `level` tinyint(1) NOT NULL COMMENT '节点类型：1:表示应用（模块）；2:表示控制器；3：表示方法',
  `is_show` tinyint(1) NOT NULL COMMENT '是否展示 0展示 1不展示',
  `route` varchar(50) NOT NULL DEFAULT '' COMMENT '路由',
  `url` varchar(50) DEFAULT NULL COMMENT 'url',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table tb_auth_role
# ------------------------------------------------------------

DROP TABLE IF EXISTS `tb_auth_role`;

CREATE TABLE `tb_auth_role` (
  `id` tinyint(3) unsigned NOT NULL AUTO_INCREMENT COMMENT '角色id',
  `role_name` varchar(30) NOT NULL DEFAULT '' COMMENT '角色名称',
  `role_alias_name` varchar(30) NOT NULL DEFAULT '' COMMENT '角色别名',
  `descr` varchar(50) DEFAULT '' COMMENT '具体描述',
  `status` tinyint(1) NOT NULL DEFAULT '0' COMMENT '状态 0正常 1已删除',
  `created_at` datetime NOT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `tb_auth_role` WRITE;
/*!40000 ALTER TABLE `tb_auth_role` DISABLE KEYS */;

INSERT INTO `tb_auth_role` (`id`, `role_name`, `role_alias_name`, `descr`, `status`, `created_at`, `updated_at`)
VALUES
	(1,'超级管理员','Super Admin','拥有所有权限',0,'2018-12-12 16:14:54','2018-12-12 16:14:54');

/*!40000 ALTER TABLE `tb_auth_role` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table tb_auth_role_node
# ------------------------------------------------------------

DROP TABLE IF EXISTS `tb_auth_role_node`;

CREATE TABLE `tb_auth_role_node` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '角色节点关联表',
  `node_id` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '节点id',
  `role_id` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '角色id',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `tb_auth_role_node` WRITE;
/*!40000 ALTER TABLE `tb_auth_role_node` DISABLE KEYS */;

INSERT INTO `tb_auth_role_node` (`id`, `node_id`, `role_id`)
VALUES
	(77,46,1),
	(78,42,1),
	(79,43,1),
	(80,47,1),
	(81,49,1),
	(82,45,1),
	(83,44,1),
	(84,48,1),
	(85,41,1);

/*!40000 ALTER TABLE `tb_auth_role_node` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table tb_category
# ------------------------------------------------------------

DROP TABLE IF EXISTS `tb_category`;

CREATE TABLE `tb_category` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

LOCK TABLES `tb_category` WRITE;
/*!40000 ALTER TABLE `tb_category` DISABLE KEYS */;

INSERT INTO `tb_category` (`id`, `name`, `created`, `updated`)
VALUES
	(2,'the first category','2018-11-30 14:52:41','2018-11-30 14:52:41'),
	(4,'the second category','2018-11-29 15:46:16','2018-11-29 15:46:16'),
	(6,'the third category','2018-11-29 15:48:16','2018-11-29 15:48:16');

/*!40000 ALTER TABLE `tb_category` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table tb_comment
# ------------------------------------------------------------

DROP TABLE IF EXISTS `tb_comment`;

CREATE TABLE `tb_comment` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(200) DEFAULT NULL,
  `content` varchar(500) DEFAULT NULL,
  `created` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `ip` varchar(100) DEFAULT NULL,
  `post_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `tb_comment` WRITE;
/*!40000 ALTER TABLE `tb_comment` DISABLE KEYS */;

INSERT INTO `tb_comment` (`id`, `username`, `content`, `created`, `ip`, `post_id`)
VALUES
	(4,'dsdfsfdsfds','fsdfdsfds','2017-08-16 15:34:09','[',0),
	(5,'dsfds','fdsfds','2017-08-09 15:41:12','111',1),
	(7,'fsdfdsfdsfds','sdfdsfdsf',NULL,'[',8),
	(8,'sdfdsfds','fsdfdsfdsfds',NULL,'[',8),
	(9,'fdsfdsfdsfds','<p style=\"text-align: left;\"><b>fdsfdsfdsffdsfdsfdsfdsfdsdsfdsfds</b></p><p style=\"text-align: left;\"><b><br></b></p><p style=\"text-align: left;\"><b>a. fsdfdsf</b></p>','2017-08-09 15:42:54','[',8);

/*!40000 ALTER TABLE `tb_comment` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table tb_config
# ------------------------------------------------------------

DROP TABLE IF EXISTS `tb_config`;

CREATE TABLE `tb_config` (
  `id` mediumint(8) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(30) NOT NULL DEFAULT '',
  `value` text NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `tb_config` WRITE;
/*!40000 ALTER TABLE `tb_config` DISABLE KEYS */;

INSERT INTO `tb_config` (`id`, `name`, `value`)
VALUES
	(1,'title','fdsfdsfdsfdsfds'),
	(2,'url','http://www.ptapp.cnsdfdsfds'),
	(5,'keywords','dsfds'),
	(6,'description','fdsfdsfdsfdsfdsfds'),
	(7,'email','lisijie86@gmail.com'),
	(9,'timezone','8'),
	(11,'start','1'),
	(12,'qq','1212121');

/*!40000 ALTER TABLE `tb_config` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table tb_post
# ------------------------------------------------------------

DROP TABLE IF EXISTS `tb_post`;

CREATE TABLE `tb_post` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `title` varchar(255) NOT NULL,
  `url` varchar(255) CHARACTER SET utf8 NOT NULL COMMENT '下载地址',
  `content` mediumtext,
  `tags` varchar(100) NOT NULL,
  `views` mediumint(9) NOT NULL,
  `status` tinyint(4) NOT NULL,
  `is_top` tinyint(4) NOT NULL DEFAULT '0',
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `category_id` int(11) NOT NULL,
  `types` tinyint(4) DEFAULT NULL COMMENT '1. 文章 0 下载',
  `info` varchar(500) CHARACTER SET utf8 DEFAULT NULL COMMENT '简介',
  `image` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

LOCK TABLES `tb_post` WRITE;
/*!40000 ALTER TABLE `tb_post` DISABLE KEYS */;

INSERT INTO `tb_post` (`id`, `user_id`, `title`, `url`, `content`, `tags`, `views`, `status`, `is_top`, `created`, `updated`, `category_id`, `types`, `info`, `image`)
VALUES
	(13,1,'this is second article','http://www.tebie6.com','<p>123大法师地方</p>','php,tebie6',0,0,1,'2018-11-30 23:35:33','2018-11-30 23:35:33',4,1,'哈哈哈',''),
	(14,1,'this is first article','http://www.tebie6.com','<p>123大法师地方</p>','php,tebie6',0,0,1,'2018-11-30 23:33:41','2018-11-30 23:33:41',2,1,'哈哈哈','');

/*!40000 ALTER TABLE `tb_post` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table tb_tag
# ------------------------------------------------------------

DROP TABLE IF EXISTS `tb_tag`;

CREATE TABLE `tb_tag` (
  `id` mediumint(8) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(20) NOT NULL DEFAULT '' COMMENT '标签名',
  `count` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT '使用次数',
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `tb_tag` WRITE;
/*!40000 ALTER TABLE `tb_tag` DISABLE KEYS */;

INSERT INTO `tb_tag` (`id`, `name`, `count`, `created`, `updated`)
VALUES
	(1,'iPhone',3,'2017-08-08 10:58:39','2017-08-08 10:58:39'),
	(2,'越狱',3,'2017-08-08 10:58:39','2017-08-08 10:58:39');

/*!40000 ALTER TABLE `tb_tag` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table tb_tag_post
# ------------------------------------------------------------

DROP TABLE IF EXISTS `tb_tag_post`;

CREATE TABLE `tb_tag_post` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `tag_id` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT '标签id',
  `post_id` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT '内容id',
  PRIMARY KEY (`id`),
  KEY `tagid` (`tag_id`),
  KEY `postid` (`post_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `tb_tag_post` WRITE;
/*!40000 ALTER TABLE `tb_tag_post` DISABLE KEYS */;

INSERT INTO `tb_tag_post` (`id`, `tag_id`, `post_id`)
VALUES
	(1,1,22),
	(2,2,22),
	(3,1,21),
	(4,2,21),
	(5,1,20),
	(6,2,20);

/*!40000 ALTER TABLE `tb_tag_post` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table tb_user
# ------------------------------------------------------------

DROP TABLE IF EXISTS `tb_user`;

CREATE TABLE `tb_user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(255) DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL,
  `email` varchar(200) DEFAULT NULL,
  `login_count` int(11) DEFAULT NULL,
  `last_time` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  `last_ip` varchar(200) DEFAULT 'current_timestamp()',
  `state` tinyint(4) DEFAULT NULL,
  `created` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

LOCK TABLES `tb_user` WRITE;
/*!40000 ALTER TABLE `tb_user` DISABLE KEYS */;

INSERT INTO `tb_user` (`id`, `username`, `password`, `email`, `login_count`, `last_time`, `last_ip`, `state`, `created`, `updated`)
VALUES
	(1,'admin',' e10adc3949ba59abbe56e057f20f883e','',35,NULL,'127.0.0.1',0,NULL,'2017-08-08 19:48:05');

/*!40000 ALTER TABLE `tb_user` ENABLE KEYS */;
UNLOCK TABLES;



/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
