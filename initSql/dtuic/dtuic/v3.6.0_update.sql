/*
 Navicat Premium Data Transfer

 Source Server         : 61
 Source Server Type    : MySQL
 Source Server Version : 50624
 Source Host           : 172.16.10.61:3306
 Source Schema         : dtuic

 Target Server Type    : MySQL
 Target Server Version : 50624
 File Encoding         : 65001

 Date: 25/04/2019 16:02:45
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for uic_info
-- ----------------------------
CREATE TABLE `uic_info` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(16) DEFAULT NULL,
  `value` text,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uni_name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8

SET FOREIGN_KEY_CHECKS = 1;
