/*
 Navicat Premium Data Transfer

 Source Server         : 本机
 Source Server Type    : MySQL
 Source Server Version : 50723
 Source Host           : localhost:3306
 Source Schema         : security

 Target Server Type    : MySQL
 Target Server Version : 50723
 File Encoding         : 65001

 Date: 17/08/2018 13:42:34
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
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of ss_app
-- ----------------------------
BEGIN;
INSERT INTO `ss_app` VALUES (1, '授权管理系统', '645ba616-370a-43a8-a8e0-993e7a590cf0', 'bb74abb6-bae0-47dd-a7b1-9571ea3a0f33', '', 1);
INSERT INTO `ss_app` VALUES (2, 'shiro客户端demo', '23ee982d-b562-40a9-ad49-fbc96a81fa16', '772df1d0-824a-4b9a-97ff-4191a9480bd7', '', 0);
COMMIT;

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
) ENGINE=InnoDB AUTO_INCREMENT=33 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of ss_resource
-- ----------------------------
BEGIN;
INSERT INTO `ss_resource` VALUES (1, '资源', 0, '', 0, '/0/', '', 1, '2017-12-22 09:49:36');
INSERT INTO `ss_resource` VALUES (2, '权限管理系统', 0, '', 1, '/0/1/', '', 1, '2017-12-28 11:27:16');
INSERT INTO `ss_resource` VALUES (3, '应用管理', 0, '', 2, '/0/1/2/', 'app:menu', 1, '2017-12-28 11:27:16');
INSERT INTO `ss_resource` VALUES (4, '应用视图', 1, 'http://127.0.0.1:8080/app', 3, '/0/1/2/3/', 'app:view', 1, '2017-12-28 11:27:16');
INSERT INTO `ss_resource` VALUES (5, '应用添加', 2, '', 3, '/0/1/2/3/', 'app:create', 1, '2017-12-28 11:27:16');
INSERT INTO `ss_resource` VALUES (6, '应用修改', 2, '', 3, '/0/1/2/3/', 'app:update', 1, '2017-12-28 11:27:16');
INSERT INTO `ss_resource` VALUES (7, '应用删除', 2, '', 3, '/0/1/2/3/', 'app:delete', 1, '2017-12-28 11:27:16');
INSERT INTO `ss_resource` VALUES (8, '区域管理', 0, '', 2, '/0/1/2/', 'area:menu', 1, '2017-12-28 11:27:16');
INSERT INTO `ss_resource` VALUES (9, '区域列表', 1, 'http://127.0.0.1:8080/area', 8, '/0/1/2/8/', 'area:view', 1, '2017-12-28 11:27:16');
INSERT INTO `ss_resource` VALUES (10, '区域添加', 2, '', 8, '/0/1/2/8/', 'area:add', 1, '2017-12-28 11:27:16');
INSERT INTO `ss_resource` VALUES (11, '区域编辑', 2, '', 8, '/0/1/2/8/', 'area:edit', 1, '2017-12-28 11:27:16');
INSERT INTO `ss_resource` VALUES (12, '授权管理', 0, '', 2, '/0/1/2/', 'authorization:menu', 1, '2017-12-28 11:27:16');
INSERT INTO `ss_resource` VALUES (13, '授权列表', 1, 'http://127.0.0.1:8080/authorization', 12, '/0/1/2/12/', 'authorization:view', 1, '2017-12-28 11:27:16');
INSERT INTO `ss_resource` VALUES (14, '授权添加', 2, '', 12, '/0/1/2/12/', 'authorization:create', 1, '2017-12-28 11:27:16');
INSERT INTO `ss_resource` VALUES (15, '授权修改', 2, '', 12, '/0/1/2/12/', 'authorization:update', 1, '2017-12-28 11:27:16');
INSERT INTO `ss_resource` VALUES (16, '授权删除', 2, '', 12, '/0/1/2/12/', 'authorization:delete', 1, '2017-12-28 11:27:16');
INSERT INTO `ss_resource` VALUES (17, '组织机构', 0, '', 2, '/0/1/2/', 'organization:menu', 1, '2017-12-28 11:27:16');
INSERT INTO `ss_resource` VALUES (18, '组织机构列表', 1, 'http://127.0.0.1:8080/organization', 17, '/0/1/2/17/', 'organization:view', 1, '2017-12-28 11:27:16');
INSERT INTO `ss_resource` VALUES (19, '组织机构添加', 2, '', 17, '/0/1/2/17/', 'organization:create', 1, '2017-12-28 11:27:16');
INSERT INTO `ss_resource` VALUES (20, '组织机构编辑', 2, '', 17, '/0/1/2/17/', 'organization:update', 1, '2017-12-28 11:27:16');
INSERT INTO `ss_resource` VALUES (21, '组织机构删除', 2, '', 17, '/0/1/2/17/', 'organization:delete', 1, '2017-12-27 18:11:20');
INSERT INTO `ss_resource` VALUES (22, '用户管理', 0, '', 2, '/0/1/2/', 'user:menu', 1, '2017-12-28 11:27:16');
INSERT INTO `ss_resource` VALUES (23, '用户列表', 1, 'http://127.0.0.1:8080/user', 22, '/0/1/2/22/', 'user:view', 1, '2018-07-05 23:25:28');
INSERT INTO `ss_resource` VALUES (24, '用户添加', 2, '', 22, '/0/1/2/22/', 'user:create', 1, '2017-12-28 11:27:16');
INSERT INTO `ss_resource` VALUES (25, '用户编辑', 2, '', 22, '/0/1/2/22/', 'user:update', 1, '2017-12-28 11:27:16');
INSERT INTO `ss_resource` VALUES (26, '用户删除', 2, '', 22, '/0/1/2/22/', 'user:delete', 1, '2017-12-28 11:27:16');
INSERT INTO `ss_resource` VALUES (27, '角色管理', 0, '', 2, '/0/1/2/', 'role:menu', 1, '2017-12-28 11:27:16');
INSERT INTO `ss_resource` VALUES (28, '角色列表', 1, 'http://127.0.0.1:8080/role/search', 27, '/0/1/2/27/', 'role:view', 1, '2017-12-26 16:23:26');
INSERT INTO `ss_resource` VALUES (29, '角色编辑', 2, '', 27, '/0/1/2/27/', 'role:update', 1, '2017-12-26 23:24:58');
INSERT INTO `ss_resource` VALUES (30, '角色添加', 2, '', 27, '/0/1/2/27/', 'role:create', 1, '2017-12-26 23:25:50');
INSERT INTO `ss_resource` VALUES (31, '资源管理', 0, '', 2, '/0/1/2/', 'resource:menu', 1, '2017-12-26 23:37:22');
INSERT INTO `ss_resource` VALUES (32, '资源列表', 1, 'http://127.0.0.1:8080/resource', 31, '/0/1/2/31', 'resource:view', 1, '2017-12-26 23:39:43');
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
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of ss_role
-- ----------------------------
BEGIN;
INSERT INTO `ss_role` VALUES (1, 'super-admin', '超级管理员', '3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32', 1, '2017-12-26 15:59:31');
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
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4;

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
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of ss_user_app_roles
-- ----------------------------
BEGIN;
INSERT INTO `ss_user_app_roles` VALUES (1, 1, 1, '1');
COMMIT;

SET FOREIGN_KEY_CHECKS = 1;
