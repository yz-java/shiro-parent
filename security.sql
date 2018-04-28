/*
 Navicat Premium Data Transfer

 Source Server         : 测试库
 Source Server Type    : MySQL
 Source Server Version : 50721
 Source Host           : 192.168.1.160:3306
 Source Schema         : security

 Target Server Type    : MySQL
 Target Server Version : 50721
 File Encoding         : 65001

 Date: 28/04/2018 17:01:00
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for ss_app
-- ----------------------------
DROP TABLE IF EXISTS `ss_app`;
CREATE TABLE `ss_app` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) DEFAULT NULL,
  `app_key` varchar(100) DEFAULT NULL,
  `app_secret` varchar(100) DEFAULT NULL,
  `url` varchar(100) DEFAULT '',
  `available` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_sys_app_app_key` (`app_key`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Table structure for ss_area
-- ----------------------------
DROP TABLE IF EXISTS `ss_area`;
CREATE TABLE `ss_area` (
  `id` bigint(64) NOT NULL AUTO_INCREMENT COMMENT '编号',
  `parent_id` bigint(64) NOT NULL COMMENT '父级编号',
  `parent_ids` varchar(2000) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT '所有父级编号',
  `a_name` varchar(100) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT '名称',
  `a_sort` int(10) DEFAULT '0' COMMENT '排序',
  `code` varchar(100) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT '区域编码',
  `a_type` int(4) DEFAULT NULL COMMENT '区域类型',
  `create_by` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT '创建者',
  `create_date` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT '更新者',
  `update_date` datetime DEFAULT NULL COMMENT '更新时间',
  `remarks` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT '备注信息',
  `a_status` tinyint(1) DEFAULT '1' COMMENT '删除标记',
  PRIMARY KEY (`id`),
  KEY `sys_area_parent_id` (`parent_id`),
  KEY `sys_area_del_flag` (`a_status`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8 COMMENT='区域表';

-- ----------------------------
-- Records of ss_area
-- ----------------------------
BEGIN;
INSERT INTO `ss_area` VALUES (1, 0, '/0/', '中国', 0, 'CHINA', NULL, NULL, '2017-12-18 11:36:42', NULL, NULL, NULL, 1);
INSERT INTO `ss_area` VALUES (2, 1, '/0/1/', '山东', 0, 'SD', NULL, NULL, '2017-12-18 11:37:15', NULL, NULL, NULL, 1);
INSERT INTO `ss_area` VALUES (3, 1, '/0/1/', '北京', 0, 'BJ', NULL, NULL, '2017-12-18 12:02:24', NULL, NULL, NULL, 1);
INSERT INTO `ss_area` VALUES (4, 1, '/0/1/', '浙江', 0, 'ZJ', NULL, NULL, '2017-12-18 14:08:14', NULL, NULL, NULL, 1);
INSERT INTO `ss_area` VALUES (5, 1, '/0/1/', '江苏', 0, 'JS', NULL, NULL, '2017-12-18 14:08:27', NULL, NULL, NULL, 1);
INSERT INTO `ss_area` VALUES (6, 5, '/0/1/5/', '昆山', 0, 'JS-KS', NULL, NULL, '2017-12-18 14:08:54', NULL, NULL, NULL, 1);
INSERT INTO `ss_area` VALUES (7, 2, '/0/1/2/', '山东-烟台', 0, 'SD-YT', NULL, NULL, '2017-12-18 15:49:04', NULL, NULL, NULL, 1);
INSERT INTO `ss_area` VALUES (8, 3, '/0/1/3/', '北京-朝阳区', 0, 'BJ-CY', NULL, NULL, '2017-12-18 15:49:35', NULL, NULL, NULL, 1);
INSERT INTO `ss_area` VALUES (9, 4, '/0/1/4/', '浙江-杭州', 0, 'ZJ-HZ', NULL, NULL, '2017-12-18 15:52:54', NULL, NULL, NULL, 1);
INSERT INTO `ss_area` VALUES (10, 5, '/0/1/5/', '常州', 0, 'JS-CZ', NULL, NULL, '2017-12-26 16:12:19', NULL, NULL, NULL, 1);
INSERT INTO `ss_area` VALUES (11, 6, '/0/1/5/6/', '昆山市第一人民医院', 0, 'JS-KS-H', NULL, NULL, '2017-12-26 16:13:39', NULL, NULL, NULL, 1);
COMMIT;

-- ----------------------------
-- Table structure for ss_area_type_dic
-- ----------------------------
DROP TABLE IF EXISTS `ss_area_type_dic`;
CREATE TABLE `ss_area_type_dic` (
  `id` int(11) NOT NULL,
  `at_name` varchar(20) NOT NULL,
  `create_time` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='区域类型字典';

-- ----------------------------
-- Table structure for ss_organization
-- ----------------------------
DROP TABLE IF EXISTS `ss_organization`;
CREATE TABLE `ss_organization` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '机构ID',
  `org_name` varchar(255) DEFAULT NULL COMMENT '机构名称',
  `org_code` varchar(32) DEFAULT NULL COMMENT '机构编码',
  `org_type` tinyint(4) DEFAULT NULL COMMENT '机构类型',
  `org_level` tinyint(4) DEFAULT NULL COMMENT '机构级别',
  `area` varchar(100) DEFAULT NULL COMMENT '所属区域',
  `parent_id` bigint(20) DEFAULT NULL COMMENT '父ID',
  `parent_ids` varchar(100) DEFAULT NULL COMMENT '所有父id',
  `createtime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '新建时间',
  `updatetime` timestamp NULL DEFAULT NULL COMMENT '更新时间',
  `org_status` tinyint(1) DEFAULT '1' COMMENT '状态：0=禁用 1=启用',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8mb4 COMMENT='组织结构';

-- ----------------------------
-- Records of ss_organization
-- ----------------------------
BEGIN;
INSERT INTO `ss_organization` VALUES (2, '总部', NULL, NULL, NULL, NULL, 0, '/0/', '2017-12-18 15:48:08', '2017-12-18 15:48:08', 1);
INSERT INTO `ss_organization` VALUES (5, '销售部', 'SALE', NULL, NULL, NULL, 2, '/0/2/', '2017-12-18 15:48:08', '2017-12-18 15:48:08', 1);
INSERT INTO `ss_organization` VALUES (6, '北京', 'BJ', NULL, NULL, NULL, 2, '/0/2/', '2017-12-18 15:48:08', '2017-12-18 15:48:08', 1);
INSERT INTO `ss_organization` VALUES (7, '北京-销售部', 'BJ-SALE', NULL, NULL, NULL, 6, '/0/2/6/', '2017-12-18 15:48:08', '2017-12-18 15:48:08', 1);
INSERT INTO `ss_organization` VALUES (8, '杭州', 'HZ', NULL, NULL, NULL, 2, '/0/2/', '2017-12-18 15:48:08', '2017-12-18 15:48:08', 1);
INSERT INTO `ss_organization` VALUES (9, '杭州-销售部', 'HZ-SALE', NULL, NULL, NULL, 8, '/0/2/8/', '2017-12-18 15:48:08', '2017-12-18 15:48:08', 1);
INSERT INTO `ss_organization` VALUES (10, '南昌', 'NC', NULL, NULL, NULL, 2, '/0/2/', '2017-12-18 15:48:08', '2017-12-18 15:48:08', 1);
INSERT INTO `ss_organization` VALUES (11, '南昌-销售部', 'NC-SALE', NULL, NULL, NULL, 10, '/0/2/10/', '2017-12-18 15:48:08', '2017-12-18 15:48:08', 1);
INSERT INTO `ss_organization` VALUES (12, '开发部', 'DEVELOP', NULL, NULL, NULL, 2, '/0/2/', '2017-12-18 15:48:08', '2017-12-18 15:48:08', 1);
INSERT INTO `ss_organization` VALUES (13, '河南', 'HN', NULL, NULL, NULL, 2, '/0/2/', '2017-12-18 15:48:08', '2017-12-18 15:48:08', 1);
INSERT INTO `ss_organization` VALUES (14, '河南-销售部', 'HN-SALE', NULL, NULL, NULL, 13, '/0/2/13/', '2017-12-18 15:48:08', '2017-12-18 15:48:08', 1);
INSERT INTO `ss_organization` VALUES (15, '杭州-研发部', 'HZ-DEVELOP', NULL, NULL, NULL, 8, '/0/2/8/', '2017-12-18 15:48:08', '2017-12-18 15:48:08', 1);
INSERT INTO `ss_organization` VALUES (16, '技术中心', 'T-C', NULL, NULL, NULL, 2, '/0/2/', '2017-12-18 15:48:08', '2017-12-18 15:48:08', 1);
INSERT INTO `ss_organization` VALUES (17, '江苏', 'JS', NULL, NULL, NULL, 2, '/0/2/', '2017-12-26 14:38:41', NULL, 1);
INSERT INTO `ss_organization` VALUES (19, '研发部', 'DEVELEPOR', NULL, NULL, NULL, 2, '/0/2/', '2017-12-27 15:01:14', NULL, 1);
COMMIT;

-- ----------------------------
-- Table structure for ss_resource
-- ----------------------------
DROP TABLE IF EXISTS `ss_resource`;
CREATE TABLE `ss_resource` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `r_name` varchar(100) DEFAULT NULL,
  `r_type` int(4) DEFAULT '0' COMMENT '1=菜单 2=按钮',
  `url` varchar(200) DEFAULT NULL,
  `parent_id` bigint(20) DEFAULT NULL,
  `parent_ids` varchar(200) DEFAULT '',
  `permission` varchar(100) DEFAULT '',
  `r_status` tinyint(1) DEFAULT '1',
  `create_time` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_sys_resource_parent_id` (`parent_id`),
  KEY `idx_sys_resource_parent_ids` (`parent_ids`),
  KEY `idx_permission` (`permission`)
) ENGINE=InnoDB AUTO_INCREMENT=335 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of ss_resource
-- ----------------------------
BEGIN;
INSERT INTO `ss_resource` VALUES (1, '资源', 0, '', 0, '/0/', '', 1, '2017-12-22 09:49:36');
COMMIT;

-- ----------------------------
-- Table structure for ss_role
-- ----------------------------
DROP TABLE IF EXISTS `ss_role`;
CREATE TABLE `ss_role` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `r_code` varchar(100) DEFAULT NULL,
  `r_desc` varchar(100) DEFAULT NULL,
  `resource_ids` varchar(600) DEFAULT NULL,
  `r_status` tinyint(1) DEFAULT '0',
  `create_time` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_sys_role_resource_ids` (`resource_ids`),
  KEY `idx_r_code` (`r_code`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of ss_role
-- ----------------------------
BEGIN;
INSERT INTO `ss_role` VALUES (1, 'super-admin', '超级管理员', '78,82,86,92,91,221,237,77,79,80,81,83,84,85,87,88,89,208,209,210,243,93,94,95,198,224,235,236,238,240', 1, '2017-12-26 15:59:31');
INSERT INTO `ss_role` VALUES (16, 'sbt-bms-admin', '汇百通后台管理系统超级管理员', '248,251,252,253,254,255,256,257,258,259,260,261,262,263,264,265,266,267,268,269,270,271,272,289,290,291,292,293,294,295,296,306,307,308,309,310,311,312,313,314,315,316,317,318,319,320,321,323,322,324,325,326,249,304,250,297,298,299,300,301,302,303,327,328,329,330,331,332,333,334', 1, '2017-12-28 14:45:25');
INSERT INTO `ss_role` VALUES (18, 'hbt-goods-bms-admin', '商城后台管理员', '212,101,102,103,213,108,109,110,112,113,114,219,115,116,117,118,120,119,246,214,121,122,123,215,96,97,98,99,100,216,104,105,106,107,220', 1, '2018-04-10 14:34:30');
COMMIT;

-- ----------------------------
-- Table structure for ss_user
-- ----------------------------
DROP TABLE IF EXISTS `ss_user`;
CREATE TABLE `ss_user` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `organization_id` bigint(20) DEFAULT NULL,
  `username` varchar(100) DEFAULT '',
  `password` varchar(100) DEFAULT '',
  `phone` varchar(11) DEFAULT '',
  `salt` varchar(100) DEFAULT '',
  `locked` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_sys_user_username` (`username`),
  KEY `idx_sys_user_organization_id` (`organization_id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of ss_user
-- ----------------------------
BEGIN;
INSERT INTO `ss_user` VALUES (1, 2, 'admin', '58bb542ce71f918ca6fb680d38c21a8f', '17777870844', '1a3ab0ff9e544c0781a09bac693b9f51', 0);
INSERT INTO `ss_user` VALUES (3, 5, 'test', '719ca57b3b52b747c186735407a1b682', '17777870844', 'd3dd182bab77a5677e86d57dd7242326', 0);
COMMIT;

-- ----------------------------
-- Table structure for ss_user_app_roles
-- ----------------------------
DROP TABLE IF EXISTS `ss_user_app_roles`;
CREATE TABLE `ss_user_app_roles` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) DEFAULT NULL,
  `app_id` bigint(20) DEFAULT NULL,
  `role_ids` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `sys_user_app_roles_user_id_app_id` (`user_id`,`app_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

SET FOREIGN_KEY_CHECKS = 1;
