/*
 Navicat Premium Data Transfer

 Source Server         : 肾百通APP阿里云数据库
 Source Server Type    : MySQL
 Source Server Version : 50716
 Source Host           : 123.56.107.180:3306
 Source Schema         : security

 Target Server Type    : MySQL
 Target Server Version : 50716
 File Encoding         : 65001

 Date: 22/12/2017 19:52:21
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
  `available` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_sys_app_app_key` (`app_key`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of ss_app
-- ----------------------------
BEGIN;
INSERT INTO `ss_app` VALUES (1, '授权管理系统', '645ba616-370a-43a8-a8e0-993e7a590cf0', 'bb74abb6-bae0-47dd-a7b1-9571ea3a0f33', 1);
INSERT INTO `ss_app` VALUES (6, '宣教后台管理', 'b3fc6e42-6eac-4c0c-bfee-63a2ffcb8049', '4be50608-11a8-4357-8050-1ad248ce32c9', 0);
INSERT INTO `ss_app` VALUES (7, '电子商城后台管理', '0df337c8-14ad-4bfa-8861-1846120a6fec', 'a3781fde-e64b-43d2-b113-992a0ec2e215', 0);
INSERT INTO `ss_app` VALUES (8, 'APP后台管理系统', '370f5b78-c1ed-44b8-ab9f-f616e3183872', 'aecb886f-5563-40c2-84a6-0d9813f49a13', 0);
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
  `a_type` tinyint(1) DEFAULT NULL COMMENT '区域类型',
  `create_by` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT '创建者',
  `create_date` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT '更新者',
  `update_date` datetime DEFAULT NULL COMMENT '更新时间',
  `remarks` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT '备注信息',
  `a_status` tinyint(1) DEFAULT '1' COMMENT '删除标记',
  PRIMARY KEY (`id`),
  KEY `sys_area_parent_id` (`parent_id`),
  KEY `sys_area_del_flag` (`a_status`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8 COMMENT='区域表';

-- ----------------------------
-- Records of ss_area
-- ----------------------------
BEGIN;
INSERT INTO `ss_area` VALUES (1, 0, '/0/', '中国', 0, 'CHINA', NULL, NULL, '2017-12-18 11:36:42', NULL, NULL, NULL, 1);
INSERT INTO `ss_area` VALUES (2, 1, '/0/1/', '山东', 0, 'SD', NULL, NULL, '2017-12-18 11:37:15', NULL, NULL, NULL, 1);
INSERT INTO `ss_area` VALUES (3, 1, '/0/1/', '北京', 0, 'BJ', NULL, NULL, '2017-12-18 12:02:24', NULL, NULL, NULL, 1);
INSERT INTO `ss_area` VALUES (4, 1, '/0/1/', '浙江', 0, 'ZJ', NULL, NULL, '2017-12-18 14:08:14', NULL, NULL, NULL, 1);
INSERT INTO `ss_area` VALUES (5, 1, '/0/1/', '江苏', 0, 'JS', NULL, NULL, '2017-12-18 14:08:27', NULL, NULL, NULL, 1);
INSERT INTO `ss_area` VALUES (6, 5, '/0/1/5/6/5/', '昆山', 0, 'JS-KS', NULL, NULL, '2017-12-18 14:08:54', NULL, NULL, NULL, 1);
INSERT INTO `ss_area` VALUES (7, 2, '/0/1/2/', '山东-烟台', 0, 'SD-YT', NULL, NULL, '2017-12-18 15:49:04', NULL, NULL, NULL, 1);
INSERT INTO `ss_area` VALUES (8, 3, '/0/1/3/', '北京-朝阳区', 0, 'BJ-CY', NULL, NULL, '2017-12-18 15:49:35', NULL, NULL, NULL, 1);
INSERT INTO `ss_area` VALUES (9, 4, '/0/1/4/', '浙江-杭州', 0, 'ZJ-HZ', NULL, NULL, '2017-12-18 15:52:54', NULL, NULL, NULL, 1);
COMMIT;

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
  `parent_id` bigint(20) DEFAULT NULL COMMENT '父ID',
  `parent_ids` varchar(100) DEFAULT NULL COMMENT '所有父id',
  `createtime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '新建时间',
  `updatetime` timestamp NULL DEFAULT NULL COMMENT '更新时间',
  `org_status` tinyint(1) DEFAULT '0' COMMENT '状态：0=禁用 1=启用',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8mb4 COMMENT='组织结构';

-- ----------------------------
-- Records of ss_organization
-- ----------------------------
BEGIN;
INSERT INTO `ss_organization` VALUES (2, '总部', NULL, NULL, NULL, 0, '/0/', '2017-12-18 15:48:08', '2017-12-18 15:48:08', 1);
INSERT INTO `ss_organization` VALUES (5, '销售部', 'SALE', NULL, NULL, 2, '/0/2/', '2017-12-18 15:48:08', '2017-12-18 15:48:08', 1);
INSERT INTO `ss_organization` VALUES (6, '北京', 'BJ', NULL, NULL, 2, '/0/2/', '2017-12-18 15:48:08', '2017-12-18 15:48:08', 1);
INSERT INTO `ss_organization` VALUES (7, '北京-销售部', 'BJ-SALE', NULL, NULL, 6, '/0/2/6/', '2017-12-18 15:48:08', '2017-12-18 15:48:08', 1);
INSERT INTO `ss_organization` VALUES (8, '杭州', 'HZ', NULL, NULL, 2, '/0/2/', '2017-12-18 15:48:08', '2017-12-18 15:48:08', 1);
INSERT INTO `ss_organization` VALUES (9, '杭州-销售部', 'HZ-SALE', NULL, NULL, 8, '/0/2/8/', '2017-12-18 15:48:08', '2017-12-18 15:48:08', 1);
INSERT INTO `ss_organization` VALUES (10, '南昌', 'NC', NULL, NULL, 2, '/0/2/', '2017-12-18 15:48:08', '2017-12-18 15:48:08', 1);
INSERT INTO `ss_organization` VALUES (11, '南昌-销售部', 'NC-SALE', NULL, NULL, 10, '/0/2/10/', '2017-12-18 15:48:08', '2017-12-18 15:48:08', 1);
INSERT INTO `ss_organization` VALUES (12, '开发部', 'DEVELOP', NULL, NULL, 2, '/0/2/', '2017-12-18 15:48:08', '2017-12-18 15:48:08', 1);
INSERT INTO `ss_organization` VALUES (13, '河南', 'HN', NULL, NULL, 2, '/0/2/', '2017-12-18 15:48:08', '2017-12-18 15:48:08', 1);
INSERT INTO `ss_organization` VALUES (14, '河南-销售部', 'HN-SALE', NULL, NULL, 13, '/0/2/13/', '2017-12-18 15:48:08', '2017-12-18 15:48:08', 1);
INSERT INTO `ss_organization` VALUES (15, '杭州-研发部', 'HZ-DEVELOP', NULL, NULL, 8, '/0/2/8/', '2017-12-18 15:48:08', '2017-12-18 15:48:08', 1);
INSERT INTO `ss_organization` VALUES (16, '技术中心', 'T-C', NULL, NULL, 2, '/0/2/', '2017-12-18 15:48:08', '2017-12-18 15:48:08', 1);
COMMIT;

-- ----------------------------
-- Table structure for ss_resource
-- ----------------------------
DROP TABLE IF EXISTS `ss_resource`;
CREATE TABLE `ss_resource` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `r_name` varchar(100) DEFAULT NULL,
  `r_type` int(4) DEFAULT '0',
  `url` varchar(200) DEFAULT NULL,
  `parent_id` bigint(20) DEFAULT NULL,
  `parent_ids` varchar(100) DEFAULT '',
  `permission` varchar(100) DEFAULT '',
  `r_status` tinyint(1) DEFAULT '1',
  `create_time` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_sys_resource_parent_id` (`parent_id`),
  KEY `idx_sys_resource_parent_ids` (`parent_ids`)
) ENGINE=InnoDB AUTO_INCREMENT=96 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of ss_resource
-- ----------------------------
BEGIN;
INSERT INTO `ss_resource` VALUES (1, '资源', 0, NULL, 0, '/0/', '', 1, '2017-12-22 09:49:36');
INSERT INTO `ss_resource` VALUES (41, '宣教', 0, NULL, 1, '/0/1/', '', 1, '2017-12-22 10:07:01');
INSERT INTO `ss_resource` VALUES (42, '商城', 0, NULL, 1, '/0/1/', '', 1, '2017-12-22 10:07:13');
INSERT INTO `ss_resource` VALUES (43, '韦睿后台管理系统', 0, 'index.do', 1, '/0/1/', 'weirui_bms', 1, '2017-12-22 11:15:25');
INSERT INTO `ss_resource` VALUES (44, '血压参考', 1, 'selectAllBloodPressures.do', 43, '/0/1/43/', 'blood_list', 1, '2017-12-22 11:15:27');
INSERT INTO `ss_resource` VALUES (45, '修改血压参考内容回显', 2, 'showBloodPressure.do', 44, '/0/1/43/44/', 'blood_info', 1, '2017-12-22 11:15:29');
INSERT INTO `ss_resource` VALUES (46, '修改血压参考', 2, 'updateBloodPressure.do', 44, '/0/1/43/44/', 'blood_update', 1, '2017-12-22 11:15:34');
INSERT INTO `ss_resource` VALUES (47, '新增', 2, 'insertBloodPressure', 44, '/0/1/43/44/', 'blood_insert', 1, '2017-12-22 11:15:36');
INSERT INTO `ss_resource` VALUES (48, '删除', 2, 'delBloodPressures.do', 44, '/0/1/43/44/', 'blood_delete', 1, '2017-12-22 11:15:38');
INSERT INTO `ss_resource` VALUES (49, '删除', 2, 'deleteBloodPressure.do', 44, '/0/1/43/44/', 'blood_batch_delete', 1, '2017-12-22 11:15:40');
INSERT INTO `ss_resource` VALUES (50, '事件字典', 1, 'selectAllEventDic.do', 43, '/0/1/43/50/', 'event_dic_list', 1, '2017-12-22 11:15:43');
INSERT INTO `ss_resource` VALUES (51, '添加', 2, 'insertEventDic.do', 50, '/0/1/43/50/', 'event_dic_insert', 1, '2017-12-22 11:15:47');
INSERT INTO `ss_resource` VALUES (52, '获取字典修改信息', 2, 'getUpdateInfo.do', 50, '/0/1/43/50/', 'event_dic_info', 1, '2017-12-22 11:15:45');
INSERT INTO `ss_resource` VALUES (53, '修改', 2, 'updateEventDic.do', 50, '/0/1/43/50/', 'event_dic_edit', 1, '2017-12-22 11:15:51');
INSERT INTO `ss_resource` VALUES (54, '删除', 2, 'deleteEventDicById', 50, '/0/1/43/50/', 'event_dic_delete', 1, '2017-12-22 11:15:53');
INSERT INTO `ss_resource` VALUES (55, '导出', 2, 'excelExport.do', 43, '/0/1/43/50/', 'export', 1, '2017-12-22 11:15:55');
INSERT INTO `ss_resource` VALUES (56, '血压记录', 1, 'selectAllBloodPressuresRecord.do', 43, '/0/1/43/', 'blood_record_list', 1, '2017-12-22 11:15:59');
INSERT INTO `ss_resource` VALUES (57, '体重记录', 1, 'selectAllWeightRecord.do', 43, '/0/1/43/', 'weight_record_list', 1, '2017-12-22 11:16:02');
INSERT INTO `ss_resource` VALUES (58, '体温记录', 1, 'selectAllTemperatureRecord.do', 43, '/0/1/43/', 'temperature_record_list', 1, '2017-12-22 11:16:03');
INSERT INTO `ss_resource` VALUES (59, '饮水记录', 1, 'selectAllDrinkPissRecord.do?type=1', 43, '/0/1/43/', 'drink_record_list', 1, '2017-12-22 11:16:04');
INSERT INTO `ss_resource` VALUES (60, '用药记录', 1, 'selectAllMedicationRecord.do', 43, '/0/1/43/', 'medication_record_list', 1, '2017-12-22 11:16:06');
INSERT INTO `ss_resource` VALUES (61, '医院列表', 1, 'selectAllHospital.do', 43, '/0/1/43/', 'hospital_list', 1, '2017-12-22 11:16:07');
INSERT INTO `ss_resource` VALUES (62, '获取添加医院的信息', 2, 'getAddHospitalInfo.do', 61, '/0/1/43/61/', 'hospital_info', 1, '2017-12-22 11:16:09');
INSERT INTO `ss_resource` VALUES (63, '添加医院', 2, 'insertHospital.do', 61, '/0/1/43/61/', 'hospital_insert', 1, '2017-12-22 11:16:12');
INSERT INTO `ss_resource` VALUES (64, '获取修改信息', 2, 'updateHospitalInfo.do', 61, '/0/1/43/61/', 'hospital_update_info', 1, '2017-12-22 11:16:13');
INSERT INTO `ss_resource` VALUES (65, '修改', 2, 'updateHospital.do', 61, '/0/1/43/61/', 'hospital_update', 1, '2017-12-22 11:16:15');
INSERT INTO `ss_resource` VALUES (66, '删除', 2, 'deleteHospital.do', 61, '/0/1/43/61/', 'hospital_delete', 1, '2017-12-22 11:16:16');
INSERT INTO `ss_resource` VALUES (67, '出口记录', 1, 'selectAllExportAssessRecord.do', 43, '/0/1/43/', 'export_assess_record_list', 1, '2017-12-22 11:16:18');
INSERT INTO `ss_resource` VALUES (68, '处方信息', 1, 'selectAllPrescriptionInfo.do', 43, '/0/1/43/', 'prescription_info_list', 1, '2017-12-22 11:16:19');
INSERT INTO `ss_resource` VALUES (69, '治疗结果记录', 1, 'selectAllTreatmentResultRecord.do', 43, '/0/1/43/', 'treatment_result_list', 1, '2017-12-22 11:16:21');
INSERT INTO `ss_resource` VALUES (70, '事件记录', 1, 'selectAllEventRecord.do', 43, '/0/1/43/', 'event_list', 1, '2017-12-22 11:16:22');
INSERT INTO `ss_resource` VALUES (71, '医生注册', 1, 'registerDoctor.do', 43, '/0/1/43/', 'register_doctor', 1, '2017-12-22 11:16:23');
INSERT INTO `ss_resource` VALUES (72, '患者注册', 1, 'registerPatient.do', 43, '/0/1/43/', 'register_patient', 1, '2017-12-22 11:16:23');
INSERT INTO `ss_resource` VALUES (73, '体温参考', 1, 'selectAllTemperatureStandards.do', 43, '/0/1/43/', 'temperature_standard_list', 1, '2017-12-22 11:16:25');
INSERT INTO `ss_resource` VALUES (74, '排尿记录', 1, 'selectAllDrinkPissRecord.do?type=2', 43, '/0/1/43/', 'piss_record_list', 1, '2017-12-22 11:10:36');
INSERT INTO `ss_resource` VALUES (76, '权限管理', 0, '', 1, '/0/1/', '', 1, NULL);
INSERT INTO `ss_resource` VALUES (77, '应用视图', 1, '/app', 78, '/0/1/76/78/', 'app:view', 1, NULL);
INSERT INTO `ss_resource` VALUES (78, '应用', 0, '', 76, '/0/1/76/', '', 1, NULL);
INSERT INTO `ss_resource` VALUES (79, '应用添加', 2, '', 78, '/0/1/76/78/', 'app:create', 1, NULL);
INSERT INTO `ss_resource` VALUES (80, '应用修改', 2, '', 78, '/0/1/76/78/', 'app:update', 1, NULL);
INSERT INTO `ss_resource` VALUES (81, '应用删除', 2, '', 78, '/0/1/76/78/', 'app:delete', 1, NULL);
INSERT INTO `ss_resource` VALUES (82, '区域', 0, '', 76, '/0/1/76/', '', 1, NULL);
INSERT INTO `ss_resource` VALUES (83, '区域列表', 1, '/area/search', 82, '/0/1/76/82/', 'area:view', 1, NULL);
INSERT INTO `ss_resource` VALUES (84, '区域添加', 2, '', 82, '/0/1/76/82/', 'area:add', 1, NULL);
INSERT INTO `ss_resource` VALUES (85, '区域编辑', 0, '', 82, '/0/1/76/82/', 'area:edit', 1, NULL);
INSERT INTO `ss_resource` VALUES (86, '授权', 0, '', 76, '/0/1/76/', '', 1, NULL);
INSERT INTO `ss_resource` VALUES (87, '授权列表', 1, '/authorization', 86, '/0/1/76/86/', 'authorization:view', 1, NULL);
INSERT INTO `ss_resource` VALUES (88, '授权添加', 2, '', 86, '/0/1/76/86/', 'authorization:create', 1, NULL);
INSERT INTO `ss_resource` VALUES (89, '授权修改', 2, '', 86, '/0/1/76/86/', 'authorization:update', 1, NULL);
INSERT INTO `ss_resource` VALUES (90, '授权删除', 2, '', 86, '/0/1/76/86/', 'authorization:delete', 1, NULL);
INSERT INTO `ss_resource` VALUES (91, '组织机构', 0, '', 76, '/0/1/', '', 1, NULL);
INSERT INTO `ss_resource` VALUES (92, '用户', 0, '', 76, '/0/1/76/', '', 1, NULL);
INSERT INTO `ss_resource` VALUES (93, '用户添加', 2, '', 92, '/0/1/76/92/', 'user:create', 1, NULL);
INSERT INTO `ss_resource` VALUES (94, '用户编辑', 2, '', 92, '/0/1/76/92/', 'user:update', 1, NULL);
INSERT INTO `ss_resource` VALUES (95, '用户删除', 2, '', 92, '/0/1/76/92/', 'user:delete', 1, NULL);
COMMIT;

-- ----------------------------
-- Table structure for ss_role
-- ----------------------------
DROP TABLE IF EXISTS `ss_role`;
CREATE TABLE `ss_role` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `r_code` varchar(100) DEFAULT NULL,
  `r_desc` varchar(100) DEFAULT NULL,
  `resource_ids` varchar(100) DEFAULT NULL,
  `r_status` tinyint(1) DEFAULT '0',
  `create_time` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_sys_role_resource_ids` (`resource_ids`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of ss_role
-- ----------------------------
BEGIN;
INSERT INTO `ss_role` VALUES (1, 'super-admin', '超级管理员', '77,79,80,81,82,83,84,85,87,88,89,90,93,94,95', 1, NULL);
INSERT INTO `ss_role` VALUES (6, 'shoppingOrgAdmin', '百货集团管理员', '150,151,160', 1, NULL);
INSERT INTO `ss_role` VALUES (7, 'shoppingMallAdmin', '百货门店管理员', '129,130,146,150,151,158,159,162,163,164,166,167,168', 1, NULL);
INSERT INTO `ss_role` VALUES (8, 'hospitalOrgAdmin', '医疗集团管理员', '124,125,126,127,128,129,130,131,135', 1, NULL);
INSERT INTO `ss_role` VALUES (9, 'hospitalMallAdmin', '医疗门店管理员', '127,135,136,148,149', 1, NULL);
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
INSERT INTO `ss_user` VALUES (1, 2, 'yangzhao', '2c690853a45aaab64f729b3e3dbca82d', '17777870844', '2da00eb5bdad96189600ea29a3335ea4', 0);
INSERT INTO `ss_user` VALUES (3, 5, 'test', '719ca57b3b52b747c186735407a1b682', '17777870844', 'd3dd182bab77a5677e86d57dd7242326', NULL);
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
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of ss_user_app_roles
-- ----------------------------
BEGIN;
INSERT INTO `ss_user_app_roles` VALUES (1, 1, 1, '1');
COMMIT;

SET FOREIGN_KEY_CHECKS = 1;
