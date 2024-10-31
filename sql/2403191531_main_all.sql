/*
 Navicat Premium Data Transfer

 Source Server         : wh-prod
 Source Server Type    : MySQL
 Source Server Version : 80030
 Source Host           : 183.253.10.76:3307
 Source Schema         : s002_whours

 Target Server Type    : MySQL
 Target Server Version : 80030
 File Encoding         : 65001

 Date: 26/03/2024 23:41:43
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for gen_table
-- ----------------------------
DROP TABLE IF EXISTS `gen_table`;
CREATE TABLE `gen_table`  (
  `table_id` bigint(0) NOT NULL AUTO_INCREMENT COMMENT '编号',
  `table_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '表名称',
  `table_comment` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '表描述',
  `sub_table_name` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '关联子表的表名',
  `sub_table_fk_name` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '子表关联的外键名',
  `class_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '实体类名称',
  `tpl_category` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT 'crud' COMMENT '使用的模板（crud单表操作 tree树表操作）',
  `package_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '生成包路径',
  `module_name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '生成模块名',
  `business_name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '生成业务名',
  `function_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '生成功能名',
  `function_author` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '生成功能作者',
  `gen_type` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '0' COMMENT '生成代码方式（0zip压缩包 1自定义路径）',
  `gen_path` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '/' COMMENT '生成路径（不填默认项目路径）',
  `options` varchar(1000) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '其它生成选项',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime(0) NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`table_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '代码生成业务表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for gen_table_column
-- ----------------------------
DROP TABLE IF EXISTS `gen_table_column`;
CREATE TABLE `gen_table_column`  (
  `column_id` bigint(0) NOT NULL AUTO_INCREMENT COMMENT '编号',
  `table_id` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '归属表编号',
  `column_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '列名称',
  `column_comment` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '列描述',
  `column_type` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '列类型',
  `java_type` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT 'JAVA类型',
  `java_field` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT 'JAVA字段名',
  `is_pk` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '是否主键（1是）',
  `is_increment` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '是否自增（1是）',
  `is_required` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '是否必填（1是）',
  `is_insert` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '是否为插入字段（1是）',
  `is_edit` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '是否编辑字段（1是）',
  `is_list` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '是否列表字段（1是）',
  `is_query` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '是否查询字段（1是）',
  `query_type` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT 'EQ' COMMENT '查询方式（等于、不等于、大于、小于、范围）',
  `html_type` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '显示类型（文本框、文本域、下拉框、复选框、单选框、日期控件）',
  `dict_type` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '字典类型',
  `sort` int(0) NULL DEFAULT NULL COMMENT '排序',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime(0) NULL DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`column_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '代码生成业务表字段' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for qrtz_blob_triggers
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_blob_triggers`;
CREATE TABLE `qrtz_blob_triggers`  (
  `sched_name` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '调度名称',
  `trigger_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT 'qrtz_triggers表trigger_name的外键',
  `trigger_group` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT 'qrtz_triggers表trigger_group的外键',
  `blob_data` blob NULL COMMENT '存放持久化Trigger对象',
  PRIMARY KEY (`sched_name`, `trigger_name`, `trigger_group`) USING BTREE,
  CONSTRAINT `qrtz_blob_triggers_ibfk_1` FOREIGN KEY (`sched_name`, `trigger_name`, `trigger_group`) REFERENCES `qrtz_triggers` (`sched_name`, `trigger_name`, `trigger_group`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = 'Blob类型的触发器表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for qrtz_calendars
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_calendars`;
CREATE TABLE `qrtz_calendars`  (
  `sched_name` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '调度名称',
  `calendar_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '日历名称',
  `calendar` blob NOT NULL COMMENT '存放持久化calendar对象',
  PRIMARY KEY (`sched_name`, `calendar_name`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '日历信息表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for qrtz_cron_triggers
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_cron_triggers`;
CREATE TABLE `qrtz_cron_triggers`  (
  `sched_name` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '调度名称',
  `trigger_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT 'qrtz_triggers表trigger_name的外键',
  `trigger_group` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT 'qrtz_triggers表trigger_group的外键',
  `cron_expression` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT 'cron表达式',
  `time_zone_id` varchar(80) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '时区',
  PRIMARY KEY (`sched_name`, `trigger_name`, `trigger_group`) USING BTREE,
  CONSTRAINT `qrtz_cron_triggers_ibfk_1` FOREIGN KEY (`sched_name`, `trigger_name`, `trigger_group`) REFERENCES `qrtz_triggers` (`sched_name`, `trigger_name`, `trigger_group`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = 'Cron类型的触发器表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for qrtz_fired_triggers
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_fired_triggers`;
CREATE TABLE `qrtz_fired_triggers`  (
  `sched_name` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '调度名称',
  `entry_id` varchar(95) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '调度器实例id',
  `trigger_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT 'qrtz_triggers表trigger_name的外键',
  `trigger_group` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT 'qrtz_triggers表trigger_group的外键',
  `instance_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '调度器实例名',
  `fired_time` bigint(0) NOT NULL COMMENT '触发的时间',
  `sched_time` bigint(0) NOT NULL COMMENT '定时器制定的时间',
  `priority` int(0) NOT NULL COMMENT '优先级',
  `state` varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '状态',
  `job_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '任务名称',
  `job_group` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '任务组名',
  `is_nonconcurrent` varchar(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '是否并发',
  `requests_recovery` varchar(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '是否接受恢复执行',
  PRIMARY KEY (`sched_name`, `entry_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '已触发的触发器表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for qrtz_job_details
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_job_details`;
CREATE TABLE `qrtz_job_details`  (
  `sched_name` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '调度名称',
  `job_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '任务名称',
  `job_group` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '任务组名',
  `description` varchar(250) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '相关介绍',
  `job_class_name` varchar(250) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '执行任务类名称',
  `is_durable` varchar(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '是否持久化',
  `is_nonconcurrent` varchar(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '是否并发',
  `is_update_data` varchar(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '是否更新数据',
  `requests_recovery` varchar(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '是否接受恢复执行',
  `job_data` blob NULL COMMENT '存放持久化job对象',
  PRIMARY KEY (`sched_name`, `job_name`, `job_group`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '任务详细信息表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for qrtz_locks
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_locks`;
CREATE TABLE `qrtz_locks`  (
  `sched_name` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '调度名称',
  `lock_name` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '悲观锁名称',
  PRIMARY KEY (`sched_name`, `lock_name`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '存储的悲观锁信息表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for qrtz_paused_trigger_grps
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_paused_trigger_grps`;
CREATE TABLE `qrtz_paused_trigger_grps`  (
  `sched_name` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '调度名称',
  `trigger_group` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT 'qrtz_triggers表trigger_group的外键',
  PRIMARY KEY (`sched_name`, `trigger_group`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '暂停的触发器表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for qrtz_scheduler_state
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_scheduler_state`;
CREATE TABLE `qrtz_scheduler_state`  (
  `sched_name` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '调度名称',
  `instance_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '实例名称',
  `last_checkin_time` bigint(0) NOT NULL COMMENT '上次检查时间',
  `checkin_interval` bigint(0) NOT NULL COMMENT '检查间隔时间',
  PRIMARY KEY (`sched_name`, `instance_name`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '调度器状态表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for qrtz_simple_triggers
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_simple_triggers`;
CREATE TABLE `qrtz_simple_triggers`  (
  `sched_name` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '调度名称',
  `trigger_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT 'qrtz_triggers表trigger_name的外键',
  `trigger_group` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT 'qrtz_triggers表trigger_group的外键',
  `repeat_count` bigint(0) NOT NULL COMMENT '重复的次数统计',
  `repeat_interval` bigint(0) NOT NULL COMMENT '重复的间隔时间',
  `times_triggered` bigint(0) NOT NULL COMMENT '已经触发的次数',
  PRIMARY KEY (`sched_name`, `trigger_name`, `trigger_group`) USING BTREE,
  CONSTRAINT `qrtz_simple_triggers_ibfk_1` FOREIGN KEY (`sched_name`, `trigger_name`, `trigger_group`) REFERENCES `qrtz_triggers` (`sched_name`, `trigger_name`, `trigger_group`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '简单触发器的信息表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for qrtz_simprop_triggers
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_simprop_triggers`;
CREATE TABLE `qrtz_simprop_triggers`  (
  `sched_name` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '调度名称',
  `trigger_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT 'qrtz_triggers表trigger_name的外键',
  `trigger_group` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT 'qrtz_triggers表trigger_group的外键',
  `str_prop_1` varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT 'String类型的trigger的第一个参数',
  `str_prop_2` varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT 'String类型的trigger的第二个参数',
  `str_prop_3` varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT 'String类型的trigger的第三个参数',
  `int_prop_1` int(0) NULL DEFAULT NULL COMMENT 'int类型的trigger的第一个参数',
  `int_prop_2` int(0) NULL DEFAULT NULL COMMENT 'int类型的trigger的第二个参数',
  `long_prop_1` bigint(0) NULL DEFAULT NULL COMMENT 'long类型的trigger的第一个参数',
  `long_prop_2` bigint(0) NULL DEFAULT NULL COMMENT 'long类型的trigger的第二个参数',
  `dec_prop_1` decimal(13, 4) NULL DEFAULT NULL COMMENT 'decimal类型的trigger的第一个参数',
  `dec_prop_2` decimal(13, 4) NULL DEFAULT NULL COMMENT 'decimal类型的trigger的第二个参数',
  `bool_prop_1` varchar(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT 'Boolean类型的trigger的第一个参数',
  `bool_prop_2` varchar(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT 'Boolean类型的trigger的第二个参数',
  PRIMARY KEY (`sched_name`, `trigger_name`, `trigger_group`) USING BTREE,
  CONSTRAINT `qrtz_simprop_triggers_ibfk_1` FOREIGN KEY (`sched_name`, `trigger_name`, `trigger_group`) REFERENCES `qrtz_triggers` (`sched_name`, `trigger_name`, `trigger_group`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '同步机制的行锁表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for qrtz_triggers
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_triggers`;
CREATE TABLE `qrtz_triggers`  (
  `sched_name` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '调度名称',
  `trigger_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '触发器的名字',
  `trigger_group` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '触发器所属组的名字',
  `job_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT 'qrtz_job_details表job_name的外键',
  `job_group` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT 'qrtz_job_details表job_group的外键',
  `description` varchar(250) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '相关介绍',
  `next_fire_time` bigint(0) NULL DEFAULT NULL COMMENT '上一次触发时间（毫秒）',
  `prev_fire_time` bigint(0) NULL DEFAULT NULL COMMENT '下一次触发时间（默认为-1表示不触发）',
  `priority` int(0) NULL DEFAULT NULL COMMENT '优先级',
  `trigger_state` varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '触发器状态',
  `trigger_type` varchar(8) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '触发器的类型',
  `start_time` bigint(0) NOT NULL COMMENT '开始时间',
  `end_time` bigint(0) NULL DEFAULT NULL COMMENT '结束时间',
  `calendar_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '日程表名称',
  `misfire_instr` smallint(0) NULL DEFAULT NULL COMMENT '补偿执行的策略',
  `job_data` blob NULL COMMENT '存放持久化job对象',
  PRIMARY KEY (`sched_name`, `trigger_name`, `trigger_group`) USING BTREE,
  INDEX `sched_name`(`sched_name`, `job_name`, `job_group`) USING BTREE,
  CONSTRAINT `qrtz_triggers_ibfk_1` FOREIGN KEY (`sched_name`, `job_name`, `job_group`) REFERENCES `qrtz_job_details` (`sched_name`, `job_name`, `job_group`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '触发器详细信息表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for sys_config
-- ----------------------------
DROP TABLE IF EXISTS `sys_config`;
CREATE TABLE `sys_config`  (
  `config_id` int(0) NOT NULL AUTO_INCREMENT COMMENT '参数主键',
  `config_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '参数名称',
  `config_key` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '参数键名',
  `config_value` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '参数键值',
  `config_type` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT 'N' COMMENT '系统内置（Y是 N否）',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime(0) NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`config_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 103 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '参数配置表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_config
-- ----------------------------
INSERT INTO `sys_config` VALUES (1, '主框架页-默认皮肤样式名称', 'sys.index.skinName', 'skin-blue', 'Y', 'admin', '2023-05-20 23:47:20', '', NULL, '蓝色 skin-blue、绿色 skin-green、紫色 skin-purple、红色 skin-red、黄色 skin-yellow');
INSERT INTO `sys_config` VALUES (2, '用户管理-账号初始密码', 'sys.user.initPassword', 'Dfyj@1964.0', 'Y', 'admin', '2023-05-20 23:47:20', '', NULL, NULL);
INSERT INTO `sys_config` VALUES (3, '主框架页-侧边栏主题', 'sys.index.sideTheme', 'theme-dark', 'Y', 'admin', '2023-05-20 23:47:20', '', NULL, '深色主题theme-dark，浅色主题theme-light');
INSERT INTO `sys_config` VALUES (4, '账号自助-验证码开关', 'sys.account.captchaEnabled', 'true', 'Y', 'admin', '2023-05-20 23:47:20', 'admin', '2023-06-18 22:13:31', '是否开启验证码功能（true开启，false关闭）');
INSERT INTO `sys_config` VALUES (5, '账号自助-是否开启用户注册功能', 'sys.account.registerUser', 'false', 'Y', 'admin', '2023-05-20 23:47:20', '', NULL, '是否开启注册用户功能（true开启，false关闭）');
INSERT INTO `sys_config` VALUES (6, '用户登录-黑名单列表', 'sys.login.blackIPList', '', 'Y', 'admin', '2023-05-20 23:47:20', '', NULL, '设置登录IP黑名单限制，多个匹配项以;分隔，支持匹配（*通配、网段）');
INSERT INTO `sys_config` VALUES (7, '测试地址', 'sys.test.url', NULL, 'Y', 'admin', '2023-06-24 00:39:48', 'admin', '2023-06-29 11:35:07', NULL);
INSERT INTO `sys_config` VALUES (8, '技术支持姓名', 'sys.support.name', NULL, 'Y', 'admin', '2023-06-24 00:40:42', 'admin', '2023-06-29 11:26:45', NULL);
INSERT INTO `sys_config` VALUES (9, '技术支持微信', 'sys.support.wechat', NULL, 'Y', 'admin', '2023-06-24 00:41:13', 'admin', '2023-06-29 11:28:24', NULL);
INSERT INTO `sys_config` VALUES (10, '技术支持联系方式', 'sys.support.phone', NULL, 'Y', 'admin', '2023-06-24 00:41:40', 'admin', '2023-06-29 11:30:47', NULL);
INSERT INTO `sys_config` VALUES (11, '系统管理员姓名', 'sys.admin.name', NULL, 'Y', 'admin', '2023-06-24 00:42:26', 'admin', '2023-06-29 11:32:12', NULL);
INSERT INTO `sys_config` VALUES (12, '系统管理员微信', 'sys.admin.wechat', NULL, 'Y', 'admin', '2023-06-24 00:43:05', 'admin', '2023-06-29 11:32:24', NULL);
INSERT INTO `sys_config` VALUES (13, '系统管理员联系方式', 'sys.admin.phone', NULL, 'Y', 'admin', '2023-06-24 00:43:35', 'admin', '2023-06-29 11:32:33', NULL);
INSERT INTO `sys_config` VALUES (14, '项目限定任务工时量', 'sys.workhours.threshold', '50', 'Y', 'admin', '2023-07-28 15:09:53', 'admin', '2023-07-29 00:32:31', NULL);
INSERT INTO `sys_config` VALUES (100, '发布版注意事项', 'sys.release.attention', '1、文件格式 2、文件大小', 'Y', 'admin', '2023-11-01 02:27:20', '', NULL, NULL);
INSERT INTO `sys_config` VALUES (101, '发布版模板', 'sys.release.template', NULL, 'Y', 'admin', '2023-11-01 10:00:08', '2023062507', '2023-11-01 11:38:07', NULL);
INSERT INTO `sys_config` VALUES (102, '虚拟桌面录制服务器IP地址或域名', 'sys.video.address', NULL, 'Y', 'admin', '2024-03-16 10:33:16', '2023070602', '2024-03-19 15:12:19', NULL);

-- ----------------------------
-- Table structure for sys_dept
-- ----------------------------
DROP TABLE IF EXISTS `sys_dept`;
CREATE TABLE `sys_dept`  (
  `dept_id` bigint(0) NOT NULL AUTO_INCREMENT COMMENT '部门id',
  `parent_id` bigint(0) NULL DEFAULT 0 COMMENT '父部门id',
  `ancestors` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '祖级列表',
  `dept_name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '部门名称',
  `order_num` int(0) NULL DEFAULT 0 COMMENT '显示顺序',
  `leader` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '负责人',
  `phone` varchar(11) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '联系电话',
  `email` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '邮箱',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '0' COMMENT '部门状态（0正常 1停用）',
  `del_flag` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '0' COMMENT '删除标志（0代表存在 2代表删除）',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime(0) NULL DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`dept_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 203 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '部门表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_dept
-- ----------------------------
INSERT INTO `sys_dept` VALUES (100, 0, '0', '/', 0, '/', '/', '/', '0', '0', 'admin', '2023-05-20 23:46:12', 'admin', '2023-05-31 11:12:32');

-- ----------------------------
-- Table structure for sys_dict_data
-- ----------------------------
DROP TABLE IF EXISTS `sys_dict_data`;
CREATE TABLE `sys_dict_data`  (
  `dict_code` bigint(0) NOT NULL AUTO_INCREMENT COMMENT '字典编码',
  `dict_sort` int(0) NULL DEFAULT 0 COMMENT '字典排序',
  `dict_label` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '字典标签',
  `dict_value` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '字典键值',
  `dict_type` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '字典类型',
  `css_class` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '样式属性（其他样式扩展）',
  `list_class` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '表格回显样式',
  `is_default` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT 'N' COMMENT '是否默认（Y是 N否）',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '0' COMMENT '状态（0正常 1停用）',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime(0) NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`dict_code`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 164 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '字典数据表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_dict_data
-- ----------------------------
INSERT INTO `sys_dict_data` VALUES (1, 1, '男', '0', 'sys_user_sex', '', '', 'Y', '0', 'admin', '2023-05-20 23:47:19', '', NULL, '性别男');
INSERT INTO `sys_dict_data` VALUES (2, 2, '女', '1', 'sys_user_sex', '', '', 'N', '0', 'admin', '2023-05-20 23:47:19', '', NULL, '性别女');
INSERT INTO `sys_dict_data` VALUES (3, 3, '未知', '2', 'sys_user_sex', '', '', 'N', '0', 'admin', '2023-05-20 23:47:19', '', NULL, '性别未知');
INSERT INTO `sys_dict_data` VALUES (4, 1, '显示', '0', 'sys_show_hide', '', 'primary', 'Y', '0', 'admin', '2023-05-20 23:47:19', '', NULL, '显示菜单');
INSERT INTO `sys_dict_data` VALUES (5, 2, '隐藏', '1', 'sys_show_hide', '', 'danger', 'N', '0', 'admin', '2023-05-20 23:47:19', '', NULL, '隐藏菜单');
INSERT INTO `sys_dict_data` VALUES (6, 1, '正常', '0', 'sys_normal_disable', '', 'primary', 'Y', '0', 'admin', '2023-05-20 23:47:19', '', NULL, '正常状态');
INSERT INTO `sys_dict_data` VALUES (7, 2, '停用', '1', 'sys_normal_disable', '', 'danger', 'N', '0', 'admin', '2023-05-20 23:47:19', '', NULL, '停用状态');
INSERT INTO `sys_dict_data` VALUES (8, 1, '正常', '0', 'sys_job_status', '', 'primary', 'Y', '0', 'admin', '2023-05-20 23:47:19', '', NULL, '正常状态');
INSERT INTO `sys_dict_data` VALUES (9, 2, '暂停', '1', 'sys_job_status', '', 'danger', 'N', '0', 'admin', '2023-05-20 23:47:19', '', NULL, '停用状态');
INSERT INTO `sys_dict_data` VALUES (10, 1, '默认', 'DEFAULT', 'sys_job_group', '', '', 'Y', '0', 'admin', '2023-05-20 23:47:19', '', NULL, '默认分组');
INSERT INTO `sys_dict_data` VALUES (11, 2, '系统', 'SYSTEM', 'sys_job_group', '', '', 'N', '0', 'admin', '2023-05-20 23:47:19', '', NULL, '系统分组');
INSERT INTO `sys_dict_data` VALUES (12, 1, '是', 'Y', 'sys_yes_no', '', 'primary', 'Y', '0', 'admin', '2023-05-20 23:47:19', '', NULL, '系统默认是');
INSERT INTO `sys_dict_data` VALUES (13, 2, '否', 'N', 'sys_yes_no', '', 'danger', 'N', '0', 'admin', '2023-05-20 23:47:19', '', NULL, '系统默认否');
INSERT INTO `sys_dict_data` VALUES (14, 1, '通知', '1', 'sys_notice_type', '', 'warning', 'Y', '0', 'admin', '2023-05-20 23:47:19', '', NULL, '通知');
INSERT INTO `sys_dict_data` VALUES (15, 2, '公告', '2', 'sys_notice_type', '', 'success', 'N', '0', 'admin', '2023-05-20 23:47:19', '', NULL, '公告');
INSERT INTO `sys_dict_data` VALUES (16, 1, '正常', '0', 'sys_notice_status', '', 'primary', 'Y', '0', 'admin', '2023-05-20 23:47:20', '', NULL, '正常状态');
INSERT INTO `sys_dict_data` VALUES (17, 2, '关闭', '1', 'sys_notice_status', '', 'danger', 'N', '0', 'admin', '2023-05-20 23:47:20', '', NULL, '关闭状态');
INSERT INTO `sys_dict_data` VALUES (18, 99, '其他', '0', 'sys_oper_type', '', 'info', 'N', '0', 'admin', '2023-05-20 23:47:20', '', NULL, '其他操作');
INSERT INTO `sys_dict_data` VALUES (19, 1, '新增', '1', 'sys_oper_type', '', 'info', 'N', '0', 'admin', '2023-05-20 23:47:20', '', NULL, '新增操作');
INSERT INTO `sys_dict_data` VALUES (20, 2, '修改', '2', 'sys_oper_type', '', 'info', 'N', '0', 'admin', '2023-05-20 23:47:20', '', NULL, '修改操作');
INSERT INTO `sys_dict_data` VALUES (21, 3, '删除', '3', 'sys_oper_type', '', 'danger', 'N', '0', 'admin', '2023-05-20 23:47:20', '', NULL, '删除操作');
INSERT INTO `sys_dict_data` VALUES (22, 4, '授权', '4', 'sys_oper_type', '', 'primary', 'N', '0', 'admin', '2023-05-20 23:47:20', '', NULL, '授权操作');
INSERT INTO `sys_dict_data` VALUES (23, 5, '导出', '5', 'sys_oper_type', '', 'warning', 'N', '0', 'admin', '2023-05-20 23:47:20', '', NULL, '导出操作');
INSERT INTO `sys_dict_data` VALUES (24, 6, '导入', '6', 'sys_oper_type', '', 'warning', 'N', '0', 'admin', '2023-05-20 23:47:20', '', NULL, '导入操作');
INSERT INTO `sys_dict_data` VALUES (25, 7, '强退', '7', 'sys_oper_type', '', 'danger', 'N', '0', 'admin', '2023-05-20 23:47:20', '', NULL, '强退操作');
INSERT INTO `sys_dict_data` VALUES (26, 8, '生成代码', '8', 'sys_oper_type', '', 'warning', 'N', '0', 'admin', '2023-05-20 23:47:20', '', NULL, '生成操作');
INSERT INTO `sys_dict_data` VALUES (27, 9, '清空数据', '9', 'sys_oper_type', '', 'danger', 'N', '0', 'admin', '2023-05-20 23:47:20', '', NULL, '清空操作');
INSERT INTO `sys_dict_data` VALUES (28, 1, '成功', '0', 'sys_common_status', '', 'primary', 'N', '0', 'admin', '2023-05-20 23:47:20', '', NULL, '正常状态');
INSERT INTO `sys_dict_data` VALUES (29, 2, '失败', '1', 'sys_common_status', '', 'danger', 'N', '0', 'admin', '2023-05-20 23:47:20', '', NULL, '停用状态');
INSERT INTO `sys_dict_data` VALUES (100, 1, '团队负责人', '1', 'wh_participation_methods', NULL, 'primary', 'N', '0', 'admin', '2023-05-16 22:29:59', 'admin', '2023-05-16 22:33:01', NULL);
INSERT INTO `sys_dict_data` VALUES (101, 2, '小组负责人', '2', 'wh_participation_methods', NULL, 'success', 'N', '0', 'admin', '2023-05-16 22:30:15', 'admin', '2023-05-16 22:33:09', NULL);
INSERT INTO `sys_dict_data` VALUES (102, 3, '开发人员', '3', 'wh_participation_methods', NULL, 'info', 'N', '0', 'admin', '2023-05-16 22:30:27', 'admin', '2023-05-16 22:33:15', NULL);
INSERT INTO `sys_dict_data` VALUES (103, 4, '领薪人员', '4', 'wh_participation_methods', NULL, 'warning', 'N', '0', 'admin', '2023-05-16 22:30:46', 'admin', '2023-05-16 22:33:20', NULL);
INSERT INTO `sys_dict_data` VALUES (104, 1, '创建', '1', 'wh_distribution_nature', NULL, 'primary', 'N', '0', 'admin', '2023-05-16 22:32:21', 'admin', '2023-05-16 22:34:23', NULL);
INSERT INTO `sys_dict_data` VALUES (105, 2, '优化', '2', 'wh_distribution_nature', NULL, 'success', 'N', '0', 'admin', '2023-05-16 22:32:33', 'admin', '2023-05-16 22:34:29', NULL);
INSERT INTO `sys_dict_data` VALUES (106, 1, '尚未申报', '0', 'wh_claim_status', NULL, 'danger', 'N', '0', 'admin', '2023-06-04 17:41:57', '2023061217', '2023-08-12 10:51:16', NULL);
INSERT INTO `sys_dict_data` VALUES (107, 2, '完成申报', '1', 'wh_claim_status', NULL, 'success', 'N', '0', 'admin', '2023-06-04 17:44:59', '2023061217', '2023-08-12 10:51:28', NULL);
INSERT INTO `sys_dict_data` VALUES (108, 1, '未发放', '0', 'wh_salary_status', NULL, 'danger', 'N', '0', 'admin', '2023-06-05 23:39:51', '', NULL, NULL);
INSERT INTO `sys_dict_data` VALUES (109, 2, '已发放', '1', 'wh_salary_status', NULL, 'success', 'N', '0', 'admin', '2023-06-05 23:40:07', '', NULL, NULL);
INSERT INTO `sys_dict_data` VALUES (110, 1, '团队统计', '1', 'wh_statistics_dimension', NULL, 'primary', 'N', '0', 'admin', '2023-06-06 11:10:17', 'admin', '2023-06-06 11:11:01', NULL);
INSERT INTO `sys_dict_data` VALUES (111, 2, '小组统计', '2', 'wh_statistics_dimension', NULL, 'success', 'N', '0', 'admin', '2023-06-06 11:10:37', 'admin', '2023-06-06 11:11:28', NULL);
INSERT INTO `sys_dict_data` VALUES (112, 3, '开发统计', '3', 'wh_statistics_dimension', NULL, 'danger', 'N', '0', 'admin', '2023-06-06 11:11:20', '', NULL, NULL);
INSERT INTO `sys_dict_data` VALUES (113, 1, '尚未完成', '0', 'wh_is_completed', NULL, 'danger', 'N', '0', 'admin', '2023-06-10 23:09:03', '2023061217', '2023-08-17 08:29:54', NULL);
INSERT INTO `sys_dict_data` VALUES (114, 2, '已经完成', '1', 'wh_is_completed', NULL, 'success', 'N', '0', 'admin', '2023-06-10 23:09:17', '2023061217', '2023-08-17 08:31:02', NULL);
INSERT INTO `sys_dict_data` VALUES (115, 1, '无需分配', '1', 'wh_distribution_stage', NULL, 'danger', 'N', '0', 'admin', '2023-06-13 21:36:34', 'admin', '2023-06-13 21:36:50', NULL);
INSERT INTO `sys_dict_data` VALUES (116, 2, '等待分配', '2', 'wh_distribution_stage', NULL, 'warning', 'N', '0', 'admin', '2023-06-13 21:37:03', '', NULL, NULL);
INSERT INTO `sys_dict_data` VALUES (117, 3, '正在分配', '3', 'wh_distribution_stage', NULL, 'primary', 'N', '0', 'admin', '2023-06-13 21:37:18', '', NULL, NULL);
INSERT INTO `sys_dict_data` VALUES (118, 4, '分配完成', '4', 'wh_distribution_stage', NULL, 'primary', 'N', '0', 'admin', '2023-06-13 21:37:28', 'admin', '2023-06-14 21:59:06', NULL);
INSERT INTO `sys_dict_data` VALUES (119, 1, '团队', 'A', 'wh_team_name', NULL, 'primary', 'N', '0', 'admin', '2023-06-17 13:23:47', 'admin', '2023-06-17 13:24:25', NULL);
INSERT INTO `sys_dict_data` VALUES (120, 2, '小组', 'B', 'wh_team_name', NULL, 'success', 'N', '0', 'admin', '2023-06-17 13:24:20', '', NULL, NULL);
INSERT INTO `sys_dict_data` VALUES (121, 3, '开发', 'C', 'wh_team_name', NULL, 'info', 'N', '0', 'admin', '2023-06-17 13:26:03', '', NULL, NULL);
INSERT INTO `sys_dict_data` VALUES (122, 4, '领薪', 'D', 'wh_team_name', NULL, 'warning', 'N', '0', 'admin', '2023-06-17 13:26:30', '', NULL, NULL);
INSERT INTO `sys_dict_data` VALUES (123, 1, '劳动关系', '1', 'sys_hc_relation', NULL, 'warning', 'N', '0', 'admin', '2023-06-26 00:42:56', '', NULL, NULL);
INSERT INTO `sys_dict_data` VALUES (124, 2, '外协服务', '2', 'sys_hc_relation', NULL, 'success', 'N', '0', 'admin', '2023-06-26 00:43:47', '2023061217', '2023-07-12 06:24:41', NULL);
INSERT INTO `sys_dict_data` VALUES (125, 1, 'https://gits.sinoaopt.com', '1', 'wh_deploy_url', NULL, 'primary', 'N', '0', 'admin', '2023-07-20 22:00:38', 'admin', '2023-07-20 22:01:00', NULL);
INSERT INTO `sys_dict_data` VALUES (126, 2, 'https://git.sinoaopt.com', '2', 'wh_deploy_url', NULL, 'success', 'N', '0', 'admin', '2023-07-20 22:07:20', '2023061217', '2023-07-26 13:51:53', NULL);
INSERT INTO `sys_dict_data` VALUES (128, 1, '单次任务', '1', 'wh_cycle_type', NULL, 'primary', 'N', '0', 'admin', '2023-07-26 22:05:20', '', NULL, NULL);
INSERT INTO `sys_dict_data` VALUES (129, 2, '每日任务', '2', 'wh_cycle_type', NULL, 'success', 'N', '0', 'admin', '2023-07-26 22:05:41', '', NULL, NULL);
INSERT INTO `sys_dict_data` VALUES (130, 3, '每月任务', '3', 'wh_cycle_type', NULL, 'danger', 'N', '0', 'admin', '2023-07-26 22:06:19', '', NULL, NULL);
INSERT INTO `sys_dict_data` VALUES (131, 1, '同步来源', '1', 'wh_pro_sou', NULL, 'primary', 'N', '0', 'admin', '2023-07-26 22:09:06', 'admin', '2023-07-26 22:11:57', NULL);
INSERT INTO `sys_dict_data` VALUES (132, 2, '创建新增', '2', 'wh_pro_sou', NULL, 'success', 'N', '0', 'admin', '2023-07-26 22:11:46', '', NULL, NULL);
INSERT INTO `sys_dict_data` VALUES (133, 9, '超时关闭', '9', 'wh_claim_status', '', 'primary', 'N', '0', '2023061217', '2023-08-12 10:52:26', '2023061217', '2023-08-12 10:52:50', NULL);
INSERT INTO `sys_dict_data` VALUES (134, 0, 'IT开发任务', '1', 'wh_pro_type', NULL, 'primary', 'N', '0', '2023061217', '2023-08-12 11:15:37', '', NULL, NULL);
INSERT INTO `sys_dict_data` VALUES (135, 2, 'IT设计任务', '2', 'wh_pro_type', NULL, 'success', 'N', '0', '2023061217', '2023-08-12 11:15:58', '2023061217', '2023-08-12 11:16:07', NULL);
INSERT INTO `sys_dict_data` VALUES (136, 9, '非IT类任务', '9', 'wh_pro_type', NULL, 'danger', 'N', '0', '2023061217', '2023-08-12 11:16:35', '2023061217', '2023-08-12 11:16:45', NULL);
INSERT INTO `sys_dict_data` VALUES (137, 1, '否', '0', 'wh_pro_status', NULL, 'danger', 'N', '0', 'admin', '2023-08-14 23:46:41', '', NULL, NULL);
INSERT INTO `sys_dict_data` VALUES (138, 2, '是', '1', 'wh_pro_status', NULL, 'success', 'N', '0', 'admin', '2023-08-14 23:46:52', '', NULL, NULL);
INSERT INTO `sys_dict_data` VALUES (139, 9, '超时关闭', '9', 'wh_is_completed', NULL, 'primary', 'N', '0', 'admin', '2023-08-14 23:50:27', '', NULL, NULL);
INSERT INTO `sys_dict_data` VALUES (140, 1, '正在组队', '0', 'wh_team_status', NULL, 'success', 'N', '0', 'admin', '2023-09-22 00:15:02', 'admin', '2023-09-22 00:15:33', NULL);
INSERT INTO `sys_dict_data` VALUES (141, 2, '解除组队', '1', 'wh_team_status', NULL, 'danger', 'N', '0', 'admin', '2023-09-22 00:15:17', '', NULL, NULL);
INSERT INTO `sys_dict_data` VALUES (142, 1, '主分支', 'main', 'wh_branch_type', NULL, 'default', 'N', '0', '2023062507', '2023-10-29 17:39:17', 'admin', '2023-11-01 11:03:35', NULL);
INSERT INTO `sys_dict_data` VALUES (144, 1, '增量发布', '0', 'wh_full_release', NULL, 'primary', 'N', '0', 'admin', '2023-11-01 13:38:49', '2023061217', '2023-11-01 21:39:09', NULL);
INSERT INTO `sys_dict_data` VALUES (145, 2, '全量发布', '1', 'wh_full_release', NULL, 'warning', 'N', '0', 'admin', '2023-11-01 13:39:07', '2023061217', '2023-11-03 05:25:13', NULL);
INSERT INTO `sys_dict_data` VALUES (146, 3, '全量失败', '2', 'wh_full_release', NULL, 'danger', 'N', '0', 'admin', '2023-11-01 13:39:26', '2023061217', '2023-11-01 21:39:40', NULL);
INSERT INTO `sys_dict_data` VALUES (147, 1, '厦门城职分支', '001', 'wh_branch_type', NULL, 'default', 'N', '0', '2023061217', '2023-11-01 21:36:43', '2023061217', '2023-11-01 21:40:50', NULL);
INSERT INTO `sys_dict_data` VALUES (148, 2, '厦门集大分支', '002', 'wh_branch_type', NULL, 'default', 'N', '0', '2023061217', '2023-11-01 21:37:26', '2023061217', '2023-11-01 21:41:00', NULL);
INSERT INTO `sys_dict_data` VALUES (149, 4, '全量成功', '3', 'wh_full_release', NULL, 'success', 'N', '0', '2023061217', '2023-11-03 05:24:49', '2023061217', '2023-11-03 05:25:30', NULL);
INSERT INTO `sys_dict_data` VALUES (150, 1, '暂存待发', '0', 'wh_distribute_status', NULL, 'danger', 'N', '0', 'admin', '2024-01-03 00:10:40', '', NULL, NULL);
INSERT INTO `sys_dict_data` VALUES (151, 2, '完成下发', '1', 'wh_distribute_status', NULL, 'success', 'N', '0', 'admin', '2024-01-03 00:11:00', '', NULL, NULL);
INSERT INTO `sys_dict_data` VALUES (152, 1, '否', '0', 'wh_is_parallel', NULL, 'danger', 'N', '0', 'admin', '2024-01-04 00:26:42', '', NULL, NULL);
INSERT INTO `sys_dict_data` VALUES (153, 2, '是', '1', 'wh_is_parallel', NULL, 'success', 'N', '0', 'admin', '2024-01-04 00:26:53', '', NULL, NULL);
INSERT INTO `sys_dict_data` VALUES (158, 1, '关闭', '0', 'wh_config_status', NULL, 'danger', 'N', '0', 'admin', '2024-03-01 16:45:15', '', NULL, NULL);
INSERT INTO `sys_dict_data` VALUES (159, 2, '打开', '1', 'wh_config_status', NULL, 'success', 'N', '0', 'admin', '2024-03-01 16:45:29', '', NULL, NULL);
INSERT INTO `sys_dict_data` VALUES (160, 1, '桌面作业', '1', 'wh_claim_type', NULL, 'primary', 'N', '0', 'admin', '2024-03-02 02:48:31', '', NULL, NULL);
INSERT INTO `sys_dict_data` VALUES (161, 2, '会议交流', '2', 'wh_claim_type', NULL, 'success', 'N', '0', 'admin', '2024-03-02 02:48:45', '', NULL, NULL);
INSERT INTO `sys_dict_data` VALUES (162, 3, '现场作业', '3', 'wh_claim_type', NULL, 'warning', 'N', '0', 'admin', '2024-03-02 02:49:00', 'admin', '2024-03-02 02:49:09', NULL);
INSERT INTO `sys_dict_data` VALUES (163, 4, '其他', '4', 'wh_claim_type', NULL, 'danger', 'N', '0', 'admin', '2024-03-02 02:49:27', 'admin', '2024-03-02 02:49:35', NULL);

-- ----------------------------
-- Table structure for sys_dict_type
-- ----------------------------
DROP TABLE IF EXISTS `sys_dict_type`;
CREATE TABLE `sys_dict_type`  (
  `dict_id` bigint(0) NOT NULL AUTO_INCREMENT COMMENT '字典主键',
  `dict_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '字典名称',
  `dict_type` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '字典类型',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '0' COMMENT '状态（0正常 1停用）',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime(0) NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`dict_id`) USING BTREE,
  UNIQUE INDEX `dict_type`(`dict_type`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 121 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '字典类型表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_dict_type
-- ----------------------------
INSERT INTO `sys_dict_type` VALUES (1, '用户性别', 'sys_user_sex', '0', 'admin', '2023-05-20 23:47:19', '', NULL, '用户性别列表');
INSERT INTO `sys_dict_type` VALUES (2, '菜单状态', 'sys_show_hide', '0', 'admin', '2023-05-20 23:47:19', '', NULL, '菜单状态列表');
INSERT INTO `sys_dict_type` VALUES (3, '系统开关', 'sys_normal_disable', '0', 'admin', '2023-05-20 23:47:19', '', NULL, '系统开关列表');
INSERT INTO `sys_dict_type` VALUES (4, '任务状态', 'sys_job_status', '0', 'admin', '2023-05-20 23:47:19', '', NULL, '任务状态列表');
INSERT INTO `sys_dict_type` VALUES (5, '任务分组', 'sys_job_group', '0', 'admin', '2023-05-20 23:47:19', '', NULL, '任务分组列表');
INSERT INTO `sys_dict_type` VALUES (6, '系统是否', 'sys_yes_no', '0', 'admin', '2023-05-20 23:47:19', '', NULL, '系统是否列表');
INSERT INTO `sys_dict_type` VALUES (7, '通知类型', 'sys_notice_type', '0', 'admin', '2023-05-20 23:47:19', '', NULL, '通知类型列表');
INSERT INTO `sys_dict_type` VALUES (8, '通知状态', 'sys_notice_status', '0', 'admin', '2023-05-20 23:47:19', '', NULL, '通知状态列表');
INSERT INTO `sys_dict_type` VALUES (9, '操作类型', 'sys_oper_type', '0', 'admin', '2023-05-20 23:47:19', '', NULL, '操作类型列表');
INSERT INTO `sys_dict_type` VALUES (10, '系统状态', 'sys_common_status', '0', 'admin', '2023-05-20 23:47:19', '', NULL, '登录状态列表');
INSERT INTO `sys_dict_type` VALUES (100, '参与方式', 'wh_participation_methods', '0', 'admin', '2023-05-16 22:28:36', '', NULL, '人员参与方式');
INSERT INTO `sys_dict_type` VALUES (101, '分配性质', 'wh_distribution_nature', '0', 'admin', '2023-05-16 22:32:00', '', NULL, NULL);
INSERT INTO `sys_dict_type` VALUES (102, '申报状态', 'wh_claim_status', '0', 'admin', '2023-06-04 17:41:20', 'admin', '2023-06-04 17:48:45', '任务分配状态');
INSERT INTO `sys_dict_type` VALUES (103, '发放状态', 'wh_salary_status', '0', 'admin', '2023-06-05 23:39:11', 'admin', '2023-06-05 23:39:30', '薪酬发放状态');
INSERT INTO `sys_dict_type` VALUES (104, '统计维度', 'wh_statistics_dimension', '0', 'admin', '2023-06-06 11:09:47', '', NULL, '工时统计维度');
INSERT INTO `sys_dict_type` VALUES (105, '是否分配完成', 'wh_is_completed', '0', 'admin', '2023-06-10 23:08:21', '', NULL, '任务是否分配完成');
INSERT INTO `sys_dict_type` VALUES (106, '分配阶段', 'wh_distribution_stage', '0', 'admin', '2023-06-13 21:35:33', '', NULL, '任务分配阶段');
INSERT INTO `sys_dict_type` VALUES (107, '架构名称', 'wh_team_name', '0', 'admin', '2023-06-17 13:20:34', 'admin', '2023-06-17 13:21:46', '架构名称');
INSERT INTO `sys_dict_type` VALUES (108, '人司关系', 'sys_hc_relation', '0', 'admin', '2023-06-26 00:41:58', 'admin', '2023-06-26 00:42:36', '人司关系\n');
INSERT INTO `sys_dict_type` VALUES (109, '部署路径', 'wh_deploy_url', '0', 'admin', '2023-07-20 21:59:38', '', NULL, '路径');
INSERT INTO `sys_dict_type` VALUES (110, '周期类型', 'wh_cycle_type', '0', 'admin', '2023-07-26 22:04:22', 'admin', '2023-07-26 22:52:34', NULL);
INSERT INTO `sys_dict_type` VALUES (111, '项目来源', 'wh_pro_sou', '0', 'admin', '2023-07-26 22:08:38', 'admin', '2023-07-26 22:51:59', NULL);
INSERT INTO `sys_dict_type` VALUES (112, '项目类型', 'wh_pro_type', '0', '2023061217', '2023-08-12 11:14:49', '2023061217', '2023-08-12 11:15:16', NULL);
INSERT INTO `sys_dict_type` VALUES (113, '项目是否启用', 'wh_pro_status', '0', 'admin', '2023-08-14 23:45:52', '', NULL, NULL);
INSERT INTO `sys_dict_type` VALUES (114, '组队状态', 'wh_team_status', '0', 'admin', '2023-09-22 00:14:14', '', NULL, '组队状态');
INSERT INTO `sys_dict_type` VALUES (115, '分支类型', 'wh_branch_type', '0', '2023062507', '2023-10-29 17:38:56', '', NULL, '分支类型');
INSERT INTO `sys_dict_type` VALUES (116, '发布类型', 'wh_full_release', '0', 'admin', '2023-11-01 13:38:06', '2023061217', '2023-11-03 04:35:38', '全量发布');
INSERT INTO `sys_dict_type` VALUES (117, '任务下发状态', 'wh_distribute_status', '0', 'admin', '2024-01-03 00:09:46', '', NULL, '任务下发状态');
INSERT INTO `sys_dict_type` VALUES (118, '是否并行开发', 'wh_is_parallel', '0', 'admin', '2024-01-04 00:26:22', '', NULL, '开发人员是否并行开发');
INSERT INTO `sys_dict_type` VALUES (119, '工时明细配置开关', 'wh_config_status', '0', 'admin', '2024-03-01 16:44:40', '', NULL, '工时明细配置开关');
INSERT INTO `sys_dict_type` VALUES (120, '工时申报类型', 'wh_claim_type', '0', 'admin', '2024-03-02 02:47:56', '', NULL, '工时申报类型');

-- ----------------------------
-- Table structure for sys_job
-- ----------------------------
DROP TABLE IF EXISTS `sys_job`;
CREATE TABLE `sys_job`  (
  `job_id` bigint(0) NOT NULL AUTO_INCREMENT COMMENT '任务ID',
  `job_name` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '任务名称',
  `job_group` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT 'DEFAULT' COMMENT '任务组名',
  `invoke_target` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '调用目标字符串',
  `cron_expression` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT 'cron执行表达式',
  `misfire_policy` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '3' COMMENT '计划执行错误策略（1立即执行 2执行一次 3放弃执行）',
  `concurrent` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '1' COMMENT '是否并发执行（0允许 1禁止）',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '0' COMMENT '状态（0正常 1暂停）',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime(0) NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '备注信息',
  PRIMARY KEY (`job_id`, `job_name`, `job_group`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 101 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '定时任务调度表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_job
-- ----------------------------
INSERT INTO `sys_job` VALUES (1, '系统默认（无参）', 'DEFAULT', 'ryTask.ryNoParams', '0/10 * * * * ?', '3', '1', '1', 'admin', '2023-05-20 23:47:20', '', NULL, '');
INSERT INTO `sys_job` VALUES (2, '系统默认（有参）', 'DEFAULT', 'ryTask.ryParams(\'ry\')', '0/15 * * * * ?', '3', '1', '1', 'admin', '2023-05-20 23:47:20', '', NULL, '');
INSERT INTO `sys_job` VALUES (3, '系统默认（多参）', 'DEFAULT', 'ryTask.ryMultipleParams(\'ry\', true, 2000L, 316.50D, 100)', '0/20 * * * * ?', '3', '1', '1', 'admin', '2023-05-20 23:47:20', '', NULL, '');
INSERT INTO `sys_job` VALUES (4, '人员同步', 'DEFAULT', 'thirdPartyTask.syncThirdPartyUsers(4L)', '0 0 8 * * ?', '2', '1', '0', 'admin', '2023-06-25 16:15:00', '2023062507', '2023-06-30 09:52:35', '');
INSERT INTO `sys_job` VALUES (5, '自动创建周期任务', 'DEFAULT', 'projectTask.genCycleTask', '0 10 0 1 * ?', '1', '1', '0', 'admin', '2023-07-28 23:08:18', 'admin', '2023-07-29 00:35:53', '');
INSERT INTO `sys_job` VALUES (6, '项目同步', 'DEFAULT', 'thirdPartyTask.syncThirdPartyProject(6L)', '0 10 8 * * ?', '2', '1', '0', 'admin', '2023-08-06 17:14:07', 'admin', '2023-08-06 17:30:42', '');
INSERT INTO `sys_job` VALUES (100, '视频记录同步', 'DEFAULT', 'videoRecordTask.syncVideoRecord', '0 0/5 * * * ?', '1', '1', '0', 'admin', '2024-03-12 14:30:43', '', '2024-03-12 14:31:56', '');

-- ----------------------------
-- Table structure for sys_job_log
-- ----------------------------
DROP TABLE IF EXISTS `sys_job_log`;
CREATE TABLE `sys_job_log`  (
  `job_log_id` bigint(0) NOT NULL AUTO_INCREMENT COMMENT '任务日志ID',
  `job_name` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '任务名称',
  `job_group` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '任务组名',
  `invoke_target` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '调用目标字符串',
  `job_message` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '日志信息',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '0' COMMENT '执行状态（0正常 1失败）',
  `exception_info` varchar(2000) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '异常信息',
  `create_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`job_log_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '定时任务调度日志表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for sys_logininfor
-- ----------------------------
DROP TABLE IF EXISTS `sys_logininfor`;
CREATE TABLE `sys_logininfor`  (
  `info_id` bigint(0) NOT NULL AUTO_INCREMENT COMMENT '访问ID',
  `user_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '用户账号',
  `ipaddr` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '登录IP地址',
  `login_location` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '登录地点',
  `browser` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '浏览器类型',
  `os` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '操作系统',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '0' COMMENT '登录状态（0成功 1失败）',
  `msg` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '提示消息',
  `login_time` datetime(0) NULL DEFAULT NULL COMMENT '访问时间',
  PRIMARY KEY (`info_id`) USING BTREE,
  INDEX `idx_sys_logininfor_s`(`status`) USING BTREE,
  INDEX `idx_sys_logininfor_lt`(`login_time`) USING BTREE
) ENGINE = InnoDB  CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '系统访问记录' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for sys_menu
-- ----------------------------
DROP TABLE IF EXISTS `sys_menu`;
CREATE TABLE `sys_menu`  (
  `menu_id` bigint(0) NOT NULL AUTO_INCREMENT COMMENT '菜单ID',
  `menu_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '菜单名称',
  `parent_id` bigint(0) NULL DEFAULT 0 COMMENT '父菜单ID',
  `order_num` int(0) NULL DEFAULT 0 COMMENT '显示顺序',
  `path` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '路由地址',
  `component` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '组件路径',
  `query` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '路由参数',
  `is_frame` int(0) NULL DEFAULT 1 COMMENT '是否为外链（0是 1否）',
  `is_cache` int(0) NULL DEFAULT 0 COMMENT '是否缓存（0缓存 1不缓存）',
  `menu_type` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '菜单类型（M目录 C菜单 F按钮）',
  `visible` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '0' COMMENT '菜单状态（0显示 1隐藏）',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '0' COMMENT '菜单状态（0正常 1停用）',
  `perms` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '权限标识',
  `icon` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '#' COMMENT '菜单图标',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime(0) NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '备注',
  PRIMARY KEY (`menu_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2040 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '菜单权限表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_menu
-- ----------------------------
INSERT INTO `sys_menu` VALUES (1, '系统管理', 0, 1, 'system', NULL, '', 1, 0, 'M', '0', '0', '', 'system', 'admin', '2023-05-20 23:46:14', '', NULL, '系统管理目录');
INSERT INTO `sys_menu` VALUES (2, '系统监控', 0, 2, 'monitor', NULL, '', 1, 0, 'M', '0', '0', '', 'monitor', 'admin', '2023-05-20 23:46:14', '', NULL, '系统监控目录');
INSERT INTO `sys_menu` VALUES (3, '系统工具', 0, 3, 'tool', NULL, '', 1, 0, 'M', '0', '0', '', 'tool', 'admin', '2023-05-20 23:46:14', '', NULL, '系统工具目录');
INSERT INTO `sys_menu` VALUES (100, '用户管理', 1, 1, 'user', 'system/user/index', '', 1, 0, 'C', '0', '0', 'system:user:list', 'user', 'admin', '2023-05-20 23:46:14', '', NULL, '用户管理菜单');
INSERT INTO `sys_menu` VALUES (101, '角色管理', 1, 2, 'role', 'system/role/index', '', 1, 0, 'C', '0', '0', 'system:role:list', 'peoples', 'admin', '2023-05-20 23:46:14', '', NULL, '角色管理菜单');
INSERT INTO `sys_menu` VALUES (102, '菜单管理', 1, 3, 'menu', 'system/menu/index', '', 1, 0, 'C', '0', '0', 'system:menu:list', 'tree-table', 'admin', '2023-05-20 23:46:14', '', NULL, '菜单管理菜单');
INSERT INTO `sys_menu` VALUES (103, '部门管理', 1, 4, 'dept', 'system/dept/index', '', 1, 0, 'C', '0', '0', 'system:dept:list', 'tree', 'admin', '2023-05-20 23:46:14', '', NULL, '部门管理菜单');
INSERT INTO `sys_menu` VALUES (104, '岗位管理', 1, 5, 'post', 'system/post/index', '', 1, 0, 'C', '0', '0', 'system:post:list', 'post', 'admin', '2023-05-20 23:46:14', '', NULL, '岗位管理菜单');
INSERT INTO `sys_menu` VALUES (105, '字典管理', 1, 6, 'dict', 'system/dict/index', '', 1, 0, 'C', '0', '0', 'system:dict:list', 'dict', 'admin', '2023-05-20 23:46:14', '', NULL, '字典管理菜单');
INSERT INTO `sys_menu` VALUES (106, '参数设置', 1, 7, 'config', 'system/config/index', '', 1, 0, 'C', '0', '0', 'system:config:list', 'edit', 'admin', '2023-05-20 23:46:15', '', NULL, '参数设置菜单');
INSERT INTO `sys_menu` VALUES (107, '通知公告', 1, 8, 'notice', 'system/notice/index', '', 1, 0, 'C', '0', '0', 'system:notice:list', 'message', 'admin', '2023-05-20 23:46:15', '', NULL, '通知公告菜单');
INSERT INTO `sys_menu` VALUES (108, '日志管理', 1, 9, 'log', '', '', 1, 0, 'M', '0', '0', '', 'log', 'admin', '2023-05-20 23:46:15', '', NULL, '日志管理菜单');
INSERT INTO `sys_menu` VALUES (109, '在线用户', 2, 1, 'online', 'monitor/online/index', '', 1, 0, 'C', '0', '0', 'monitor:online:list', 'online', 'admin', '2023-05-20 23:46:15', '', NULL, '在线用户菜单');
INSERT INTO `sys_menu` VALUES (110, '定时任务', 2, 2, 'job', 'monitor/job/index', '', 1, 0, 'C', '0', '0', 'monitor:job:list', 'job', 'admin', '2023-05-20 23:46:15', '', NULL, '定时任务菜单');
INSERT INTO `sys_menu` VALUES (111, '数据监控', 2, 3, 'druid', 'monitor/druid/index', '', 1, 0, 'C', '0', '0', 'monitor:druid:list', 'druid', 'admin', '2023-05-20 23:46:15', '', NULL, '数据监控菜单');
INSERT INTO `sys_menu` VALUES (112, '服务监控', 2, 4, 'server', 'monitor/server/index', '', 1, 0, 'C', '0', '0', 'monitor:server:list', 'server', 'admin', '2023-05-20 23:46:15', '', NULL, '服务监控菜单');
INSERT INTO `sys_menu` VALUES (113, '缓存监控', 2, 5, 'cache', 'monitor/cache/index', '', 1, 0, 'C', '0', '0', 'monitor:cache:list', 'redis', 'admin', '2023-05-20 23:46:15', '', NULL, '缓存监控菜单');
INSERT INTO `sys_menu` VALUES (114, '缓存列表', 2, 6, 'cacheList', 'monitor/cache/list', '', 1, 0, 'C', '0', '0', 'monitor:cache:list', 'redis-list', 'admin', '2023-05-20 23:46:15', '', NULL, '缓存列表菜单');
INSERT INTO `sys_menu` VALUES (115, '表单构建', 3, 1, 'build', 'tool/build/index', '', 1, 0, 'C', '0', '0', 'tool:build:list', 'build', 'admin', '2023-05-20 23:46:15', '', NULL, '表单构建菜单');
INSERT INTO `sys_menu` VALUES (116, '代码生成', 3, 2, 'gen', 'tool/gen/index', '', 1, 0, 'C', '0', '0', 'tool:gen:list', 'code', 'admin', '2023-05-20 23:46:15', '', NULL, '代码生成菜单');
INSERT INTO `sys_menu` VALUES (117, '系统接口', 3, 3, 'swagger', 'tool/swagger/index', '', 1, 0, 'C', '0', '0', 'tool:swagger:list', 'swagger', 'admin', '2023-05-20 23:46:15', '', NULL, '系统接口菜单');
INSERT INTO `sys_menu` VALUES (500, '操作日志', 108, 1, 'operlog', 'monitor/operlog/index', '', 1, 0, 'C', '0', '0', 'monitor:operlog:list', 'form', 'admin', '2023-05-20 23:46:15', '', NULL, '操作日志菜单');
INSERT INTO `sys_menu` VALUES (501, '登录日志', 108, 2, 'logininfor', 'monitor/logininfor/index', '', 1, 0, 'C', '0', '0', 'monitor:logininfor:list', 'logininfor', 'admin', '2023-05-20 23:46:15', '', NULL, '登录日志菜单');
INSERT INTO `sys_menu` VALUES (1000, '用户查询', 100, 1, '', '', '', 1, 0, 'F', '0', '0', 'system:user:query', '#', 'admin', '2023-05-20 23:46:15', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1001, '用户新增', 100, 2, '', '', '', 1, 0, 'F', '0', '0', 'system:user:add', '#', 'admin', '2023-05-20 23:46:15', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1002, '用户修改', 100, 3, '', '', '', 1, 0, 'F', '0', '0', 'system:user:edit', '#', 'admin', '2023-05-20 23:46:15', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1003, '用户删除', 100, 4, '', '', '', 1, 0, 'F', '0', '0', 'system:user:remove', '#', 'admin', '2023-05-20 23:46:15', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1004, '用户导出', 100, 5, '', '', '', 1, 0, 'F', '0', '0', 'system:user:export', '#', 'admin', '2023-05-20 23:46:15', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1005, '用户导入', 100, 6, '', '', '', 1, 0, 'F', '0', '0', 'system:user:import', '#', 'admin', '2023-05-20 23:46:15', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1006, '重置密码', 100, 7, '', '', '', 1, 0, 'F', '0', '0', 'system:user:resetPwd', '#', 'admin', '2023-05-20 23:46:15', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1007, '角色查询', 101, 1, '', '', '', 1, 0, 'F', '0', '0', 'system:role:query', '#', 'admin', '2023-05-20 23:46:15', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1008, '角色新增', 101, 2, '', '', '', 1, 0, 'F', '0', '0', 'system:role:add', '#', 'admin', '2023-05-20 23:46:15', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1009, '角色修改', 101, 3, '', '', '', 1, 0, 'F', '0', '0', 'system:role:edit', '#', 'admin', '2023-05-20 23:46:15', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1010, '角色删除', 101, 4, '', '', '', 1, 0, 'F', '0', '0', 'system:role:remove', '#', 'admin', '2023-05-20 23:46:15', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1011, '角色导出', 101, 5, '', '', '', 1, 0, 'F', '0', '0', 'system:role:export', '#', 'admin', '2023-05-20 23:46:15', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1012, '菜单查询', 102, 1, '', '', '', 1, 0, 'F', '0', '0', 'system:menu:query', '#', 'admin', '2023-05-20 23:46:15', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1013, '菜单新增', 102, 2, '', '', '', 1, 0, 'F', '0', '0', 'system:menu:add', '#', 'admin', '2023-05-20 23:46:15', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1014, '菜单修改', 102, 3, '', '', '', 1, 0, 'F', '0', '0', 'system:menu:edit', '#', 'admin', '2023-05-20 23:46:15', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1015, '菜单删除', 102, 4, '', '', '', 1, 0, 'F', '0', '0', 'system:menu:remove', '#', 'admin', '2023-05-20 23:46:15', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1016, '部门查询', 103, 1, '', '', '', 1, 0, 'F', '0', '0', 'system:dept:query', '#', 'admin', '2023-05-20 23:46:15', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1017, '部门新增', 103, 2, '', '', '', 1, 0, 'F', '0', '0', 'system:dept:add', '#', 'admin', '2023-05-20 23:46:15', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1018, '部门修改', 103, 3, '', '', '', 1, 0, 'F', '0', '0', 'system:dept:edit', '#', 'admin', '2023-05-20 23:46:15', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1019, '部门删除', 103, 4, '', '', '', 1, 0, 'F', '0', '0', 'system:dept:remove', '#', 'admin', '2023-05-20 23:46:15', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1020, '岗位查询', 104, 1, '', '', '', 1, 0, 'F', '0', '0', 'system:post:query', '#', 'admin', '2023-05-20 23:46:15', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1021, '岗位新增', 104, 2, '', '', '', 1, 0, 'F', '0', '0', 'system:post:add', '#', 'admin', '2023-05-20 23:46:15', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1022, '岗位修改', 104, 3, '', '', '', 1, 0, 'F', '0', '0', 'system:post:edit', '#', 'admin', '2023-05-20 23:46:15', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1023, '岗位删除', 104, 4, '', '', '', 1, 0, 'F', '0', '0', 'system:post:remove', '#', 'admin', '2023-05-20 23:46:15', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1024, '岗位导出', 104, 5, '', '', '', 1, 0, 'F', '0', '0', 'system:post:export', '#', 'admin', '2023-05-20 23:46:15', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1025, '字典查询', 105, 1, '#', '', '', 1, 0, 'F', '0', '0', 'system:dict:query', '#', 'admin', '2023-05-20 23:46:15', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1026, '字典新增', 105, 2, '#', '', '', 1, 0, 'F', '0', '0', 'system:dict:add', '#', 'admin', '2023-05-20 23:46:15', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1027, '字典修改', 105, 3, '#', '', '', 1, 0, 'F', '0', '0', 'system:dict:edit', '#', 'admin', '2023-05-20 23:46:15', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1028, '字典删除', 105, 4, '#', '', '', 1, 0, 'F', '0', '0', 'system:dict:remove', '#', 'admin', '2023-05-20 23:46:15', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1029, '字典导出', 105, 5, '#', '', '', 1, 0, 'F', '0', '0', 'system:dict:export', '#', 'admin', '2023-05-20 23:46:15', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1030, '参数查询', 106, 1, '#', '', '', 1, 0, 'F', '0', '0', 'system:config:query', '#', 'admin', '2023-05-20 23:46:15', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1031, '参数新增', 106, 2, '#', '', '', 1, 0, 'F', '0', '0', 'system:config:add', '#', 'admin', '2023-05-20 23:46:15', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1032, '参数修改', 106, 3, '#', '', '', 1, 0, 'F', '0', '0', 'system:config:edit', '#', 'admin', '2023-05-20 23:46:15', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1033, '参数删除', 106, 4, '#', '', '', 1, 0, 'F', '0', '0', 'system:config:remove', '#', 'admin', '2023-05-20 23:46:15', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1034, '参数导出', 106, 5, '#', '', '', 1, 0, 'F', '0', '0', 'system:config:export', '#', 'admin', '2023-05-20 23:46:15', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1035, '公告查询', 107, 1, '#', '', '', 1, 0, 'F', '0', '0', 'system:notice:query', '#', 'admin', '2023-05-20 23:46:15', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1036, '公告新增', 107, 2, '#', '', '', 1, 0, 'F', '0', '0', 'system:notice:add', '#', 'admin', '2023-05-20 23:46:15', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1037, '公告修改', 107, 3, '#', '', '', 1, 0, 'F', '0', '0', 'system:notice:edit', '#', 'admin', '2023-05-20 23:46:15', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1038, '公告删除', 107, 4, '#', '', '', 1, 0, 'F', '0', '0', 'system:notice:remove', '#', 'admin', '2023-05-20 23:46:15', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1039, '操作查询', 500, 1, '#', '', '', 1, 0, 'F', '0', '0', 'monitor:operlog:query', '#', 'admin', '2023-05-20 23:46:15', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1040, '操作删除', 500, 2, '#', '', '', 1, 0, 'F', '0', '0', 'monitor:operlog:remove', '#', 'admin', '2023-05-20 23:46:15', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1041, '日志导出', 500, 3, '#', '', '', 1, 0, 'F', '0', '0', 'monitor:operlog:export', '#', 'admin', '2023-05-20 23:46:15', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1042, '登录查询', 501, 1, '#', '', '', 1, 0, 'F', '0', '0', 'monitor:logininfor:query', '#', 'admin', '2023-05-20 23:46:16', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1043, '登录删除', 501, 2, '#', '', '', 1, 0, 'F', '0', '0', 'monitor:logininfor:remove', '#', 'admin', '2023-05-20 23:46:16', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1044, '日志导出', 501, 3, '#', '', '', 1, 0, 'F', '0', '0', 'monitor:logininfor:export', '#', 'admin', '2023-05-20 23:46:16', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1045, '账户解锁', 501, 4, '#', '', '', 1, 0, 'F', '0', '0', 'monitor:logininfor:unlock', '#', 'admin', '2023-05-20 23:46:16', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1046, '在线查询', 109, 1, '#', '', '', 1, 0, 'F', '0', '0', 'monitor:online:query', '#', 'admin', '2023-05-20 23:46:16', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1047, '批量强退', 109, 2, '#', '', '', 1, 0, 'F', '0', '0', 'monitor:online:batchLogout', '#', 'admin', '2023-05-20 23:46:16', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1048, '单条强退', 109, 3, '#', '', '', 1, 0, 'F', '0', '0', 'monitor:online:forceLogout', '#', 'admin', '2023-05-20 23:46:16', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1049, '任务查询', 110, 1, '#', '', '', 1, 0, 'F', '0', '0', 'monitor:job:query', '#', 'admin', '2023-05-20 23:46:16', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1050, '任务新增', 110, 2, '#', '', '', 1, 0, 'F', '0', '0', 'monitor:job:add', '#', 'admin', '2023-05-20 23:46:16', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1051, '任务修改', 110, 3, '#', '', '', 1, 0, 'F', '0', '0', 'monitor:job:edit', '#', 'admin', '2023-05-20 23:46:16', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1052, '任务删除', 110, 4, '#', '', '', 1, 0, 'F', '0', '0', 'monitor:job:remove', '#', 'admin', '2023-05-20 23:46:16', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1053, '状态修改', 110, 5, '#', '', '', 1, 0, 'F', '0', '0', 'monitor:job:changeStatus', '#', 'admin', '2023-05-20 23:46:16', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1054, '任务导出', 110, 6, '#', '', '', 1, 0, 'F', '0', '0', 'monitor:job:export', '#', 'admin', '2023-05-20 23:46:16', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1055, '生成查询', 116, 1, '#', '', '', 1, 0, 'F', '0', '0', 'tool:gen:query', '#', 'admin', '2023-05-20 23:46:16', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1056, '生成修改', 116, 2, '#', '', '', 1, 0, 'F', '0', '0', 'tool:gen:edit', '#', 'admin', '2023-05-20 23:46:16', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1057, '生成删除', 116, 3, '#', '', '', 1, 0, 'F', '0', '0', 'tool:gen:remove', '#', 'admin', '2023-05-20 23:46:17', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1058, '导入代码', 116, 4, '#', '', '', 1, 0, 'F', '0', '0', 'tool:gen:import', '#', 'admin', '2023-05-20 23:46:17', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1059, '预览代码', 116, 5, '#', '', '', 1, 0, 'F', '0', '0', 'tool:gen:preview', '#', 'admin', '2023-05-20 23:46:18', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1060, '生成代码', 116, 6, '#', '', '', 1, 0, 'F', '0', '0', 'tool:gen:code', '#', 'admin', '2023-05-20 23:46:19', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2000, '工时管理', 0, 5, 'work', NULL, NULL, 1, 0, 'M', '0', '0', '', 'time', 'admin', '2023-05-16 21:56:35', 'admin', '2023-05-16 21:57:04', '');
INSERT INTO `sys_menu` VALUES (2006, '组队配置', 2000, 1, 'staff', 'work/staff/index', NULL, 1, 0, 'C', '0', '0', 'work:staff:list', 'system', 'admin', '2023-05-16 21:39:06', 'admin', '2023-06-06 10:53:58', '员工信息菜单');
INSERT INTO `sys_menu` VALUES (2007, '员工信息查询', 2006, 1, '#', '', NULL, 1, 0, 'F', '0', '0', 'work:staff:query', '#', 'admin', '2023-05-16 21:39:06', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2008, '员工信息新增', 2006, 2, '#', '', NULL, 1, 0, 'F', '0', '0', 'work:staff:add', '#', 'admin', '2023-05-16 21:39:06', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2009, '员工信息修改', 2006, 3, '#', '', NULL, 1, 0, 'F', '0', '0', 'work:staff:edit', '#', 'admin', '2023-05-16 21:39:06', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2010, '员工信息解绑', 2006, 4, '#', '', NULL, 1, 0, 'F', '0', '0', 'work:staff:remove', '#', 'admin', '2023-05-16 21:39:06', 'admin', '2023-06-13 13:10:14', '');
INSERT INTO `sys_menu` VALUES (2011, '员工信息导出', 2006, 5, '#', '', NULL, 1, 0, 'F', '0', '0', 'work:staff:export', '#', 'admin', '2023-05-16 21:39:06', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2013, '任务下发', 2000, 2, 'task', 'work/task/index', NULL, 1, 0, 'C', '0', '0', 'work:task:list', 'druid', 'admin', '2023-05-17 14:59:53', 'admin', '2023-06-06 10:53:40', '任务菜单');
INSERT INTO `sys_menu` VALUES (2014, '任务查询', 2013, 1, '#', '', NULL, 1, 0, 'F', '0', '0', 'work:task:query', '#', 'admin', '2023-05-17 14:59:53', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2015, '任务新增', 2013, 2, '#', '', NULL, 1, 0, 'F', '0', '0', 'work:task:add', '#', 'admin', '2023-05-17 14:59:53', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2016, '任务修改', 2013, 3, '#', '', NULL, 1, 0, 'F', '0', '0', 'work:task:edit', '#', 'admin', '2023-05-17 14:59:53', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2017, '任务删除', 2013, 4, '#', '', NULL, 1, 0, 'F', '0', '0', 'work:task:remove', '#', 'admin', '2023-05-17 14:59:53', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2018, '任务导出', 2013, 5, '#', '', NULL, 1, 0, 'F', '0', '0', 'work:task:export', '#', 'admin', '2023-05-17 14:59:53', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2019, '工时申报', 2000, 3, 'taskClaim', 'work/taskClaim/index', NULL, 1, 0, 'C', '0', '0', 'work:taskClaim:list', 'post', 'admin', '2023-05-17 15:08:24', 'admin', '2023-06-06 10:50:42', '任务认领菜单');
INSERT INTO `sys_menu` VALUES (2020, '工时申报查询', 2019, 1, '#', '', NULL, 1, 0, 'F', '0', '0', 'work:taskClaim:query', '#', 'admin', '2023-05-17 15:08:24', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2021, '工时申报分配', 2019, 2, '#', '', NULL, 1, 0, 'F', '0', '0', 'work:taskClaim:distribute', '#', 'admin', '2023-05-17 15:08:24', 'admin', '2023-06-07 11:30:29', '');
INSERT INTO `sys_menu` VALUES (2025, '任务分配', 2013, 6, '', NULL, NULL, 1, 0, 'F', '0', '0', 'work:task:distribute', '#', 'admin', '2023-05-28 20:57:54', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2026, '薪酬发放', 2000, 4, 'salaryDistribution', 'work/salaryDistribution/index', NULL, 1, 0, 'C', '0', '0', 'work:salaryDistribution:list', 'button', 'admin', '2023-06-05 22:11:45', 'admin', '2023-06-06 10:50:28', '薪酬发放菜单');
INSERT INTO `sys_menu` VALUES (2028, '薪酬发放分配', 2026, 1, '#', '', NULL, 1, 0, 'F', '0', '0', 'work:salaryDistribution:distribute', '#', 'admin', '2023-06-05 22:11:45', 'admin', '2023-06-05 22:17:51', '');
INSERT INTO `sys_menu` VALUES (2031, '薪酬发放导出', 2026, 2, '#', '', NULL, 1, 0, 'F', '0', '0', 'work:salaryDistribution:export', '#', 'admin', '2023-06-05 22:11:45', 'admin', '2023-06-05 22:18:34', '');
INSERT INTO `sys_menu` VALUES (2032, '工时统计', 2000, 5, 'taskStatistics', 'work/taskStatistics/index', NULL, 1, 0, 'C', '0', '0', 'work:taskStatistics:list', 'chart', 'admin', '2023-06-06 10:48:21', 'admin', '2023-06-06 10:49:57', '');
INSERT INTO `sys_menu` VALUES (2033, '用户信息查询', 2006, 6, '', NULL, NULL, 1, 0, 'F', '0', '0', 'system:user:list', '#', 'admin', '2023-06-07 17:34:55', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2034, '项目创建', 2000, 1, 'project', 'work/project/index', NULL, 1, 0, 'C', '0', '0', 'work:project:list', 'build', 'admin', '2023-07-30 16:05:34', '', NULL, '项目菜单');
INSERT INTO `sys_menu` VALUES (2035, '项目查询', 2034, 1, '#', '', NULL, 1, 0, 'F', '0', '0', 'work:project:query', '#', 'admin', '2023-07-30 16:05:34', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2036, '项目新增', 2034, 2, '#', '', NULL, 1, 0, 'F', '0', '0', 'work:project:add', '#', 'admin', '2023-07-30 16:05:34', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2037, '项目修改', 2034, 3, '#', '', NULL, 1, 0, 'F', '0', '0', 'work:project:edit', '#', 'admin', '2023-07-30 16:05:34', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2038, '项目删除', 2034, 4, '#', '', NULL, 1, 0, 'F', '0', '0', 'work:project:remove', '#', 'admin', '2023-07-30 16:05:34', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2039, '项目导出', 2034, 5, '#', '', NULL, 1, 0, 'F', '0', '0', 'work:project:export', '#', 'admin', '2023-07-30 16:05:34', '', NULL, '');

-- ----------------------------
-- Table structure for sys_notice
-- ----------------------------
DROP TABLE IF EXISTS `sys_notice`;
CREATE TABLE `sys_notice`  (
  `notice_id` int(0) NOT NULL AUTO_INCREMENT COMMENT '公告ID',
  `notice_title` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '公告标题',
  `notice_type` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '公告类型（1通知 2公告）',
  `notice_content` longblob NULL COMMENT '公告内容',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '0' COMMENT '公告状态（0正常 1关闭）',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime(0) NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`notice_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 10 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '通知公告表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for sys_oper_log
-- ----------------------------
DROP TABLE IF EXISTS `sys_oper_log`;
CREATE TABLE `sys_oper_log`  (
  `oper_id` bigint(0) NOT NULL AUTO_INCREMENT COMMENT '日志主键',
  `title` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '模块标题',
  `business_type` int(0) NULL DEFAULT 0 COMMENT '业务类型（0其它 1新增 2修改 3删除）',
  `method` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '方法名称',
  `request_method` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '请求方式',
  `operator_type` int(0) NULL DEFAULT 0 COMMENT '操作类别（0其它 1后台用户 2手机端用户）',
  `oper_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '操作人员',
  `dept_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '部门名称',
  `oper_url` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '请求URL',
  `oper_ip` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '主机地址',
  `oper_location` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '操作地点',
  `oper_param` varchar(2000) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '请求参数',
  `json_result` varchar(2000) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '返回参数',
  `status` int(0) NULL DEFAULT 0 COMMENT '操作状态（0正常 1异常）',
  `error_msg` varchar(2000) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '错误消息',
  `oper_time` datetime(0) NULL DEFAULT NULL COMMENT '操作时间',
  `cost_time` bigint(0) NULL DEFAULT 0 COMMENT '消耗时间',
  PRIMARY KEY (`oper_id`) USING BTREE,
  INDEX `idx_sys_oper_log_bt`(`business_type`) USING BTREE,
  INDEX `idx_sys_oper_log_s`(`status`) USING BTREE,
  INDEX `idx_sys_oper_log_ot`(`oper_time`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2805 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '操作日志记录' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for sys_post
-- ----------------------------
DROP TABLE IF EXISTS `sys_post`;
CREATE TABLE `sys_post`  (
  `post_id` bigint(0) NOT NULL AUTO_INCREMENT COMMENT '岗位ID',
  `post_code` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '岗位编码',
  `post_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '岗位名称',
  `post_sort` int(0) NOT NULL COMMENT '显示顺序',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '状态（0正常 1停用）',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime(0) NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`post_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '岗位信息表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for sys_role
-- ----------------------------
DROP TABLE IF EXISTS `sys_role`;
CREATE TABLE `sys_role`  (
  `role_id` bigint(0) NOT NULL AUTO_INCREMENT COMMENT '角色ID',
  `role_name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '角色名称',
  `role_key` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '角色权限字符串',
  `role_sort` int(0) NOT NULL COMMENT '显示顺序',
  `data_scope` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '1' COMMENT '数据范围（1：全部数据权限 2：自定数据权限 3：本部门数据权限 4：本部门及以下数据权限）',
  `menu_check_strictly` tinyint(1) NULL DEFAULT 1 COMMENT '菜单树选择项是否关联显示',
  `dept_check_strictly` tinyint(1) NULL DEFAULT 1 COMMENT '部门树选择项是否关联显示',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '角色状态（0正常 1停用）',
  `del_flag` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '0' COMMENT '删除标志（0代表存在 2代表删除）',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime(0) NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`role_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 110 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '角色信息表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_role
-- ----------------------------
INSERT INTO `sys_role` VALUES (1, '超级管理员', 'admin', 1, '1', 1, 1, '0', '0', 'admin', '2023-05-20 23:46:14', '', NULL, '超级管理员');
INSERT INTO `sys_role` VALUES (2, '普通角色', 'common', 2, '2', 0, 0, '1', '2', 'admin', '2023-05-20 23:46:14', 'admin', '2023-07-13 14:42:52', '普通角色');
INSERT INTO `sys_role` VALUES (100, '组队配置角色', 'team', 3, '1', 1, 1, '0', '0', 'admin', '2023-05-31 11:09:19', '2023062507', '2023-07-24 13:44:07', NULL);
INSERT INTO `sys_role` VALUES (101, '任务下发角色', 'group', 4, '1', 1, 1, '0', '0', 'admin', '2023-05-31 11:09:39', '2023061217', '2023-07-19 21:41:02', NULL);
INSERT INTO `sys_role` VALUES (102, '工时申报角色', 'develop', 5, '1', 1, 1, '0', '0', 'admin', '2023-05-31 11:10:05', 'admin', '2023-07-13 14:52:19', NULL);
INSERT INTO `sys_role` VALUES (104, '薪酬发放角色', 'money', 6, '1', 1, 1, '0', '0', 'admin', '2023-06-13 13:16:29', 'admin', '2023-07-13 14:52:27', NULL);
INSERT INTO `sys_role` VALUES (105, '综合查询角色', 'check', 30, '1', 1, 1, '0', '0', 'admin', '2023-06-13 13:17:01', '2023061217', '2023-10-30 17:20:43', NULL);
INSERT INTO `sys_role` VALUES (106, '000', '000', 0, '1', 1, 1, '0', '2', 'admin', '2023-06-14 22:43:25', '', NULL, NULL);
INSERT INTO `sys_role` VALUES (107, '系统管理员', 'sys', 0, '1', 1, 1, '0', '0', 'admin', '2023-06-21 15:35:34', 'admin', '2023-07-30 16:29:44', NULL);
INSERT INTO `sys_role` VALUES (108, '定时任务', '123', 0, '1', 0, 0, '1', '2', 'admin', '2023-06-29 23:36:53', 'admin', '2023-07-13 14:42:23', NULL);
INSERT INTO `sys_role` VALUES (109, '任务创建角色', 'add', 1, '1', 1, 1, '0', '0', '2023061217', '2023-07-07 12:00:46', 'admin', '2023-07-13 14:51:38', NULL);

-- ----------------------------
-- Table structure for sys_role_dept
-- ----------------------------
DROP TABLE IF EXISTS `sys_role_dept`;
CREATE TABLE `sys_role_dept`  (
  `role_id` bigint(0) NOT NULL COMMENT '角色ID',
  `dept_id` bigint(0) NOT NULL COMMENT '部门ID',
  PRIMARY KEY (`role_id`, `dept_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '角色和部门关联表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for sys_role_menu
-- ----------------------------
DROP TABLE IF EXISTS `sys_role_menu`;
CREATE TABLE `sys_role_menu`  (
  `role_id` bigint(0) NOT NULL COMMENT '角色ID',
  `menu_id` bigint(0) NOT NULL COMMENT '菜单ID',
  PRIMARY KEY (`role_id`, `menu_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '角色和菜单关联表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_role_menu
-- ----------------------------
INSERT INTO `sys_role_menu` VALUES (100, 2000);
INSERT INTO `sys_role_menu` VALUES (100, 2006);
INSERT INTO `sys_role_menu` VALUES (100, 2007);
INSERT INTO `sys_role_menu` VALUES (100, 2008);
INSERT INTO `sys_role_menu` VALUES (100, 2010);
INSERT INTO `sys_role_menu` VALUES (100, 2033);
INSERT INTO `sys_role_menu` VALUES (101, 2000);
INSERT INTO `sys_role_menu` VALUES (101, 2013);
INSERT INTO `sys_role_menu` VALUES (101, 2014);
INSERT INTO `sys_role_menu` VALUES (101, 2015);
INSERT INTO `sys_role_menu` VALUES (101, 2016);
INSERT INTO `sys_role_menu` VALUES (101, 2025);
INSERT INTO `sys_role_menu` VALUES (102, 2000);
INSERT INTO `sys_role_menu` VALUES (102, 2019);
INSERT INTO `sys_role_menu` VALUES (102, 2020);
INSERT INTO `sys_role_menu` VALUES (102, 2021);
INSERT INTO `sys_role_menu` VALUES (104, 2000);
INSERT INTO `sys_role_menu` VALUES (104, 2026);
INSERT INTO `sys_role_menu` VALUES (104, 2028);
INSERT INTO `sys_role_menu` VALUES (104, 2031);
INSERT INTO `sys_role_menu` VALUES (105, 2000);
INSERT INTO `sys_role_menu` VALUES (105, 2019);
INSERT INTO `sys_role_menu` VALUES (105, 2020);
INSERT INTO `sys_role_menu` VALUES (105, 2032);
INSERT INTO `sys_role_menu` VALUES (107, 1);
INSERT INTO `sys_role_menu` VALUES (107, 100);
INSERT INTO `sys_role_menu` VALUES (107, 101);
INSERT INTO `sys_role_menu` VALUES (107, 102);
INSERT INTO `sys_role_menu` VALUES (107, 105);
INSERT INTO `sys_role_menu` VALUES (107, 106);
INSERT INTO `sys_role_menu` VALUES (107, 1000);
INSERT INTO `sys_role_menu` VALUES (107, 1001);
INSERT INTO `sys_role_menu` VALUES (107, 1002);
INSERT INTO `sys_role_menu` VALUES (107, 1003);
INSERT INTO `sys_role_menu` VALUES (107, 1004);
INSERT INTO `sys_role_menu` VALUES (107, 1005);
INSERT INTO `sys_role_menu` VALUES (107, 1006);
INSERT INTO `sys_role_menu` VALUES (107, 1007);
INSERT INTO `sys_role_menu` VALUES (107, 1008);
INSERT INTO `sys_role_menu` VALUES (107, 1009);
INSERT INTO `sys_role_menu` VALUES (107, 1010);
INSERT INTO `sys_role_menu` VALUES (107, 1011);
INSERT INTO `sys_role_menu` VALUES (107, 1012);
INSERT INTO `sys_role_menu` VALUES (107, 1013);
INSERT INTO `sys_role_menu` VALUES (107, 1014);
INSERT INTO `sys_role_menu` VALUES (107, 1015);
INSERT INTO `sys_role_menu` VALUES (107, 1025);
INSERT INTO `sys_role_menu` VALUES (107, 1026);
INSERT INTO `sys_role_menu` VALUES (107, 1027);
INSERT INTO `sys_role_menu` VALUES (107, 1028);
INSERT INTO `sys_role_menu` VALUES (107, 1029);
INSERT INTO `sys_role_menu` VALUES (107, 1030);
INSERT INTO `sys_role_menu` VALUES (107, 1031);
INSERT INTO `sys_role_menu` VALUES (107, 1032);
INSERT INTO `sys_role_menu` VALUES (107, 1033);
INSERT INTO `sys_role_menu` VALUES (107, 1034);
INSERT INTO `sys_role_menu` VALUES (107, 2000);
INSERT INTO `sys_role_menu` VALUES (107, 2006);
INSERT INTO `sys_role_menu` VALUES (107, 2007);
INSERT INTO `sys_role_menu` VALUES (107, 2008);
INSERT INTO `sys_role_menu` VALUES (107, 2009);
INSERT INTO `sys_role_menu` VALUES (107, 2010);
INSERT INTO `sys_role_menu` VALUES (107, 2011);
INSERT INTO `sys_role_menu` VALUES (107, 2013);
INSERT INTO `sys_role_menu` VALUES (107, 2014);
INSERT INTO `sys_role_menu` VALUES (107, 2015);
INSERT INTO `sys_role_menu` VALUES (107, 2016);
INSERT INTO `sys_role_menu` VALUES (107, 2017);
INSERT INTO `sys_role_menu` VALUES (107, 2018);
INSERT INTO `sys_role_menu` VALUES (107, 2019);
INSERT INTO `sys_role_menu` VALUES (107, 2020);
INSERT INTO `sys_role_menu` VALUES (107, 2021);
INSERT INTO `sys_role_menu` VALUES (107, 2025);
INSERT INTO `sys_role_menu` VALUES (107, 2026);
INSERT INTO `sys_role_menu` VALUES (107, 2028);
INSERT INTO `sys_role_menu` VALUES (107, 2031);
INSERT INTO `sys_role_menu` VALUES (107, 2032);
INSERT INTO `sys_role_menu` VALUES (107, 2033);
INSERT INTO `sys_role_menu` VALUES (107, 2034);
INSERT INTO `sys_role_menu` VALUES (107, 2035);
INSERT INTO `sys_role_menu` VALUES (107, 2036);
INSERT INTO `sys_role_menu` VALUES (107, 2037);
INSERT INTO `sys_role_menu` VALUES (107, 2038);
INSERT INTO `sys_role_menu` VALUES (107, 2039);
INSERT INTO `sys_role_menu` VALUES (109, 2000);
INSERT INTO `sys_role_menu` VALUES (109, 2013);
INSERT INTO `sys_role_menu` VALUES (109, 2014);
INSERT INTO `sys_role_menu` VALUES (109, 2015);
INSERT INTO `sys_role_menu` VALUES (109, 2016);
INSERT INTO `sys_role_menu` VALUES (109, 2017);
INSERT INTO `sys_role_menu` VALUES (109, 2025);

-- ----------------------------
-- Table structure for sys_user
-- ----------------------------
DROP TABLE IF EXISTS `sys_user`;
CREATE TABLE `sys_user`  (
  `user_id` bigint(0) NOT NULL AUTO_INCREMENT COMMENT '用户ID',
  `dept_id` bigint(0) NULL DEFAULT NULL COMMENT '部门ID',
  `user_name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '人员号（用户账号）',
  `nick_name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '用户姓名',
  `user_type` varchar(2) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '00' COMMENT '用户类型（00系统用户）',
  `email` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '用户邮箱',
  `phonenumber` varchar(11) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '手机号码',
  `bank` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '开户银行',
  `account` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '账户',
  `human_company_relation` tinyint(0) NULL DEFAULT NULL COMMENT '人司关系（1劳动关系 2外协开发）',
  `sex` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '0' COMMENT '用户性别（0男 1女 2未知）',
  `avatar` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '头像地址',
  `password` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '密码',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '0' COMMENT '帐号状态（0正常 1停用）',
  `del_flag` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '0' COMMENT '删除标志（0代表存在 2代表删除）',
  `login_ip` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '最后登录IP',
  `login_date` datetime(0) NULL DEFAULT NULL COMMENT '最后登录时间',
  `first_cooperation_time` datetime(0) NULL DEFAULT NULL COMMENT '首次合作时间',
  `end_cooperation_time` datetime(0) NULL DEFAULT NULL COMMENT '上次终止合作时间',
  `config_status` tinyint(1) NOT NULL DEFAULT 0 COMMENT '明细工时配置状态（0 关闭 1 打开）',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime(0) NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`user_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 476 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '用户信息表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_user
-- ----------------------------
INSERT INTO `sys_user` VALUES (1, 100, 'admin', 'admin', '00', '', '', NULL, NULL, NULL, '1', '', 'Dfyj@1964.0', '0', '0', '', '2024-03-25 22:00:54', NULL, NULL, 0, 'admin', '2023-05-20 23:46:12', '', '2024-03-25 22:00:53', NULL);
INSERT INTO `sys_user` VALUES (2, 100, 'adm', 'adm', '00', '', '', NULL, NULL, NULL, '0', '', 'Dfyj@1964.0', '0', '2', '', '2023-06-25 11:02:06', NULL, NULL, 0, 'admin', '2023-06-21 15:36:58', 'admin', '2023-11-04 08:00:00', NULL);
INSERT INTO `sys_user` VALUES (3, 100, 'produ', 'produ', '00', '', '', NULL, NULL, NULL, '1', '', 'Dfyj@1964.0', '0', '2', '', '2023-06-21 15:41:52', NULL, NULL, 0, 'admin', '2023-06-21 15:39:01', '', '2023-09-23 08:00:00', NULL);

-- ----------------------------
-- Table structure for sys_user_post
-- ----------------------------
DROP TABLE IF EXISTS `sys_user_post`;
CREATE TABLE `sys_user_post`  (
  `user_id` bigint(0) NOT NULL COMMENT '用户ID',
  `post_id` bigint(0) NOT NULL COMMENT '岗位ID',
  PRIMARY KEY (`user_id`, `post_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '用户与岗位关联表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for sys_user_role
-- ----------------------------
DROP TABLE IF EXISTS `sys_user_role`;
CREATE TABLE `sys_user_role`  (
  `user_id` bigint(0) NOT NULL COMMENT '用户ID',
  `role_id` bigint(0) NOT NULL COMMENT '角色ID',
  PRIMARY KEY (`user_id`, `role_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '用户和角色关联表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_user_role
-- ----------------------------
INSERT INTO `sys_user_role` VALUES (1, 1);
INSERT INTO `sys_user_role` VALUES (2, 1);
INSERT INTO `sys_user_role` VALUES (3, 107);

-- ----------------------------
-- Table structure for wh_claim_detail
-- ----------------------------
DROP TABLE IF EXISTS `wh_claim_detail`;
CREATE TABLE `wh_claim_detail`  (
  `id` bigint(0) NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `task_id` bigint(0) NOT NULL COMMENT '任务id',
  `claim_type` bigint(0) NOT NULL COMMENT '工时类型 1桌面作业 2会议交流 3现场作业 4其他 ',
  `start_time` datetime(0) NULL DEFAULT NULL COMMENT '开始时间',
  `end_time` datetime(0) NULL DEFAULT NULL COMMENT '截止时间',
  `working_hours` decimal(10, 1) NOT NULL DEFAULT 0.0 COMMENT '工时数',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB  CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '工时申报明细表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for wh_claim_detail_item
-- ----------------------------
DROP TABLE IF EXISTS `wh_claim_detail_item`;
CREATE TABLE `wh_claim_detail_item`  (
  `id` bigint(0) NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `claim_id` bigint(0) NOT NULL COMMENT '申报明细id',
  `video_url` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '视频名称（链接）',
  `start_time` datetime(0) NULL DEFAULT NULL COMMENT '开始时间',
  `end_time` datetime(0) NULL DEFAULT NULL COMMENT '截止时间',
  `duration` time(0) NULL DEFAULT NULL COMMENT '持续时长',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '更新时间',
  `del_flag` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '0' COMMENT '删除标志（0代表存在 1代表删除）',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB  CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '工时申报明细条目表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for wh_project
-- ----------------------------
DROP TABLE IF EXISTS `wh_project`;
CREATE TABLE `wh_project`  (
  `id` bigint(0) NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `project_no` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '项目编号',
  `project_name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '项目名称',
  `project_type` tinyint(1) NULL DEFAULT NULL COMMENT '项目类型（数据字典wh_pro_type）',
  `project_source` tinyint(1) NOT NULL COMMENT '项目来源（1 同步 2创建）',
  `code_source_no` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '代码与源编号',
  `cycle_type` tinyint(1) NOT NULL COMMENT '周期类型（1 单次 2 每日 3 每月）',
  `work_hours_threshold` decimal(10, 1) NOT NULL COMMENT '限定任务工时量',
  `status` tinyint(1) NOT NULL DEFAULT 0 COMMENT '是否启用状态（0 否 1 是）',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '更新时间',
  `del_flag` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '0' COMMENT '删除标志（0代表存在 1代表删除）',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB  CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '项目表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for wh_project_origin
-- ----------------------------
DROP TABLE IF EXISTS `wh_project_origin`;
CREATE TABLE `wh_project_origin`  (
  `id` bigint(0) NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `project_no` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '项目编号',
  `project_name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '项目名称',
  `summary_no` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '摘要编号',
  `code_source_no` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '代码与源镜像摘要编号',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '更新时间',
  `del_flag` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '0' COMMENT '删除标志（0代表存在 1代表删除）',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '项目来源表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for wh_salary_distribution
-- ----------------------------
DROP TABLE IF EXISTS `wh_salary_distribution`;
CREATE TABLE `wh_salary_distribution`  (
  `id` bigint(0) NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `staff_id` bigint(0) NOT NULL COMMENT '员工id',
  `staff_no` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '员工编号',
  `working_hours` decimal(10, 1) NOT NULL DEFAULT 0.0 COMMENT '本月工时',
  `salary` decimal(10, 1) NOT NULL DEFAULT 0.0 COMMENT '本月薪酬',
  `month` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '所属年月',
  `distribute_time` datetime(0) NULL DEFAULT NULL COMMENT '发放时间',
  `status` tinyint(1) NULL DEFAULT 0 COMMENT '发放状态（0 未发放 1 已发放）',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '薪酬发放表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for wh_staff
-- ----------------------------
DROP TABLE IF EXISTS `wh_staff`;
CREATE TABLE `wh_staff`  (
  `id` bigint(0) NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `parent_id` bigint(0) NULL DEFAULT 0 COMMENT '父级ID',
  `team_id` bigint(0) NULL DEFAULT NULL COMMENT '团队id（团队负责人id）',
  `team_name` char(2) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '架构名称 A团队 B小组 C开发 D领薪',
  `team_no` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '架构编号',
  `staff_no` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '员工编号',
  `staff_name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '员工名称',
  `participation_methods` tinyint(0) NOT NULL COMMENT '参与方式（1团队负责人 2小组负责人 3 开发人员 4领薪人员 ）',
  `parallel_flag` tinyint(1) NULL DEFAULT 0 COMMENT '是否并行开发 0 否 1 是',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '更新时间',
  `del_flag` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '0' COMMENT '删除标志（0代表存在 1代表删除）',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '员工信息表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for wh_task
-- ----------------------------
DROP TABLE IF EXISTS `wh_task`;
CREATE TABLE `wh_task`  (
  `id` bigint(0) NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `parent_id` bigint(0) NOT NULL DEFAULT 0 COMMENT '父级ID',
  `project_id` bigint(0) NOT NULL COMMENT '项目ID',
  `task_no` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '任务编号',
  `task_name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '任务名称',
  `app_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '应用名称',
  `distribution_time` datetime(0) NOT NULL COMMENT '任务分配时间',
  `staff_id` bigint(0) NOT NULL COMMENT '员工id',
  `staff_no` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '员工编号',
  `participation_methods` tinyint(1) NULL DEFAULT NULL COMMENT '员工参与方式（合作身份）',
  `description` varchar(1000) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '任务说明',
  `link_url` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '任务链接地址',
  `qr_code` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '任务链接二维码',
  `submit_time` datetime(0) NULL DEFAULT NULL COMMENT '任务提交时间',
  `spend_time` int(0) NULL DEFAULT NULL COMMENT '交互用时（天）',
  `working_hours` decimal(10, 1) NOT NULL DEFAULT 0.0 COMMENT '申报工时',
  `paid_hours` decimal(10, 1) NOT NULL DEFAULT 0.0 COMMENT '领薪累计工时',
  `month` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '所属年月',
  `tag_no` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '标签编号',
  `branch_name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '分支名称',
  `release_flag` tinyint(0) UNSIGNED NULL DEFAULT 0 COMMENT '是否确认发布版本 0 否 1 是',
  `release_tag` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '发布关联tag标签',
  `release_attachment` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '发布附件',
  `deploy_url` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '部署路径',
  `file_url` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '交付文件地址',
  `upload_status` tinyint(1) NULL DEFAULT 0 COMMENT '代码上传状态（0 未上传 1 已上传）',
  `complete_instructions` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '完成说明',
  `stage` tinyint(1) NULL DEFAULT NULL COMMENT '任务分配阶段（1 无需分配 2 等待分配 3 正在分配 4 分配完成）',
  `status` tinyint(1) NULL DEFAULT 0 COMMENT '任务申报状态（0 未申报 1 已申报）',
  `cycle_type` tinyint(1) NOT NULL COMMENT '周期类型（1 单次 2 每日 3 每月）',
  `confirm_status` tinyint(1) NULL DEFAULT 0 COMMENT '确认状态 0 否 1 是',
  `distribute_status` tinyint(1) NULL DEFAULT 0 COMMENT '任务下发状态 0 暂存待发 1 完成下发',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '更新时间',
  `del_flag` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '0' COMMENT '删除标志（0代表存在 1代表删除）',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '任务表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for wh_task_distribution
-- ----------------------------
DROP TABLE IF EXISTS `wh_task_distribution`;
CREATE TABLE `wh_task_distribution`  (
  `id` bigint(0) NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `task_id` bigint(0) NOT NULL COMMENT '任务id',
  `salary_id` bigint(0) NOT NULL COMMENT '薪酬id',
  `staff_id` bigint(0) NOT NULL COMMENT '员工id',
  `task_no` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '任务编号',
  `task_name` varchar(1000) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '任务名称',
  `staff_name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '员工名称',
  `working_hours` decimal(10, 1) NOT NULL DEFAULT 0.0 COMMENT '工时',
  `distribute_time` datetime(0) NULL DEFAULT NULL COMMENT '分配时间',
  `distribute_ratio` decimal(10, 2) NULL DEFAULT NULL COMMENT '分配比例（%）',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `claim_index`(`task_id`, `staff_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '任务工时分配表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for wh_task_statistics
-- ----------------------------
DROP TABLE IF EXISTS `wh_task_statistics`;
CREATE TABLE `wh_task_statistics`  (
  `id` bigint(0) NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `staff_id` bigint(0) NOT NULL COMMENT '员工id',
  `total_working_hours` decimal(10, 1) NULL DEFAULT 0.0 COMMENT '总工时',
  `month` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '所属年月',
  `amount` int(0) NULL DEFAULT NULL COMMENT '分配次数',
  `dimension` tinyint(1) NOT NULL COMMENT '统计维度（1团队 2小组 3 开发）',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `statistics_index`(`staff_id`, `month`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '任务工时统计表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for wh_video_record
-- ----------------------------
DROP TABLE IF EXISTS `wh_video_record`;
CREATE TABLE `wh_video_record`  (
  `id` bigint(0) NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `session_id` int(0) NOT NULL COMMENT '池ID（同步）',
  `user_name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '用户名（账号）',
  `start_time` datetime(0) NULL DEFAULT NULL COMMENT '开始时间',
  `end_time` datetime(0) NULL DEFAULT NULL COMMENT '截止时间',
  `duration` time(0) NULL DEFAULT NULL COMMENT '持续时长',
  `total_recordings` int(0) NOT NULL COMMENT '视频分段数',
  `video_url` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '视频链接地址',
  `claim_status` tinyint(1) NOT NULL DEFAULT 0 COMMENT '申报状态 0 未申报 1已申报',
  `sync_time` datetime(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '同步时间',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '更新时间',
  `del_flag` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '0' COMMENT '删除标志（0代表存在 1代表删除）',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '工时视频记录表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for wh_video_record_detail
-- ----------------------------
DROP TABLE IF EXISTS `wh_video_record_detail`;
CREATE TABLE `wh_video_record_detail`  (
  `id` bigint(0) NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `record_id` int(0) NOT NULL COMMENT '记录ID',
  `recording_id` int(0) NOT NULL COMMENT '同步记录ID',
  `session_id` int(0) NOT NULL COMMENT '同步池ID',
  `segment_id` int(0) NOT NULL COMMENT '片段ID',
  `screen_id` int(0) NOT NULL COMMENT '屏幕ID',
  `start_time` datetime(0) NULL DEFAULT NULL COMMENT '开始时间',
  `end_time` datetime(0) NULL DEFAULT NULL COMMENT '截止时间',
  `duration` time(0) NULL DEFAULT NULL COMMENT '持续时长',
  `video_url` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '视频链接地址',
  `claim_status` tinyint(1) NOT NULL DEFAULT 0 COMMENT '申报状态 0 未申报 1已申报',
  `sync_time` datetime(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '同步时间',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '更新时间',
  `del_flag` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '0' COMMENT '删除标志（0代表存在 1代表删除）',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '工时视频记录详情表' ROW_FORMAT = Dynamic;

SET FOREIGN_KEY_CHECKS = 1;
