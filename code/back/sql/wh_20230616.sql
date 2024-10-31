-- 1、员工信息表
DROP TABLE IF EXISTS `wh_staff`;
CREATE TABLE `wh_staff`  (
     `id` bigint(0) NOT NULL AUTO_INCREMENT COMMENT '主键ID',
     `parent_id` bigint(0) NULL DEFAULT 0 COMMENT '父级ID',
     `team_id` bigint(0) NULL DEFAULT NULL COMMENT '团队id（团队负责人id）',
     `staff_no` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '员工编号',
     `staff_name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '员工名称',
     `participation_methods` tinyint(0) NOT NULL COMMENT '参与方式（1团队负责人 2小组负责人 3 开发人员 4领薪人员 ）',
     `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '创建者',
     `create_time` datetime(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '创建时间',
     `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '更新者',
     `update_time` datetime(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '更新时间',
     `del_flag` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '0' COMMENT '删除标志（0代表存在 1代表删除）',
     PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '员工信息表' ROW_FORMAT = Dynamic;

-- 2、任务表
DROP TABLE IF EXISTS `wh_task`;
CREATE TABLE `wh_task`  (
    `id` bigint(0) NOT NULL AUTO_INCREMENT COMMENT '主键ID',
    `parent_id` bigint(0) NOT NULL DEFAULT 0 COMMENT '父级ID',
    `task_no` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '任务编号',
    `task_name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '任务名称',
    `app_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '应用名称',
    `distribution_time` datetime(0) NOT NULL COMMENT '任务分配时间',
    `distribution_nature` tinyint(1) NOT NULL DEFAULT 0 COMMENT '分配性质（1创建 2优化）',
    `staff_id` bigint(0) NOT NULL COMMENT '员工id',
    `participation_methods` tinyint(1) NULL DEFAULT NULL COMMENT '员工参与方式（合作身份）',
    `description` varchar(1000) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '任务说明',
    `link_url` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '任务链接地址',
    `submit_time` datetime(0) NULL DEFAULT NULL COMMENT '任务提交时间',
    `spend_time` int(0) NULL DEFAULT NULL COMMENT '交互用时（天）',
    `working_hours` decimal(10, 1) NOT NULL DEFAULT 0.0 COMMENT '申报工时',
    `paid_hours` decimal(10, 1) NOT NULL DEFAULT 0.0 COMMENT '领薪累计工时',
    `month` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '所属年月',
    `stage` tinyint(1) NULL DEFAULT NULL COMMENT '任务分配阶段（1 无需分配 2 等待分配 3 正在分配 4 分配完成）',
    `status` tinyint(1) NULL DEFAULT 0 COMMENT '任务申报状态（0 未申报 1 已申报）',
    `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '创建者',
    `create_time` datetime(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '创建时间',
    `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '更新者',
    `update_time` datetime(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '更新时间',
    `del_flag` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '0' COMMENT '删除标志（0代表存在 1代表删除）',
    PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '任务表' ROW_FORMAT = Dynamic;

-- 3、任务工时分配表
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

-- 4、任务工时统计表
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

-- 5、任务工时统计表
DROP TABLE IF EXISTS `wh_salary_distribution`;
CREATE TABLE `wh_salary_distribution`  (
   `id` bigint(0) NOT NULL AUTO_INCREMENT COMMENT '主键id',
   `staff_id` bigint(0) NOT NULL COMMENT '员工id',
   `working_hours` decimal(10, 1) NOT NULL DEFAULT 0.0 COMMENT '本月工时',
   `salary` decimal(10, 1) NOT NULL DEFAULT 0.0 COMMENT '本月薪酬',
   `month` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '所属年月',
   `distribute_time` datetime(0) NULL DEFAULT NULL COMMENT '发放时间',
   `status` tinyint(1) NULL DEFAULT 0 COMMENT '发放状态（0 未发放 1 已发放）',
   `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '创建者',
   `create_time` datetime(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '创建时间',
   `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '更新者',
   `update_time` datetime(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '更新时间',
   PRIMARY KEY (`id`) USING BTREE,
   UNIQUE INDEX `salary_index`(`staff_id`, `month`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '薪酬发放表' ROW_FORMAT = Dynamic;

-- 6、菜单数据
INSERT INTO `sys_menu` VALUES (2000, '工时管理', 0, 5, 'work', NULL, NULL, 1, 0, 'M', '0', '0', '', 'time', 'admin', '2023-05-16 21:56:35', 'admin', '2023-05-16 21:57:04', '');
INSERT INTO `sys_menu` VALUES (2006, '组队配置', 2000, 1, 'staff', 'work/staff/index', NULL, 1, 0, 'C', '0', '0', 'work:staff:list', 'system', 'admin', '2023-05-16 21:39:06', 'admin', '2023-06-06 10:53:58', '员工信息菜单');
INSERT INTO `sys_menu` VALUES (2007, '员工信息查询', 2006, 1, '#', '', NULL, 1, 0, 'F', '0', '0', 'work:staff:query', '#', 'admin', '2023-05-16 21:39:06', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2008, '员工信息新增', 2006, 2, '#', '', NULL, 1, 0, 'F', '0', '0', 'work:staff:add', '#', 'admin', '2023-05-16 21:39:06', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2009, '员工信息修改', 2006, 3, '#', '', NULL, 1, 0, 'F', '0', '0', 'work:staff:edit', '#', 'admin', '2023-05-16 21:39:06', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2010, '员工信息删除', 2006, 4, '#', '', NULL, 1, 0, 'F', '0', '0', 'work:staff:remove', '#', 'admin', '2023-05-16 21:39:06', '', NULL, '');
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

-- 7、数据字典
INSERT INTO `sys_dict_type` VALUES (100, '参与方式', 'wh_participation_methods', '0', 'admin', '2023-05-16 22:28:36', '', NULL, '人员参与方式');
INSERT INTO `sys_dict_type` VALUES (101, '分配性质', 'wh_distribution_nature', '0', 'admin', '2023-05-16 22:32:00', '', NULL, NULL);
INSERT INTO `sys_dict_type` VALUES (102, '申报状态', 'wh_claim_status', '0', 'admin', '2023-06-04 17:41:20', 'admin', '2023-06-04 17:48:45', '任务分配状态');
INSERT INTO `sys_dict_type` VALUES (103, '发放状态', 'wh_salary_status', '0', 'admin', '2023-06-05 23:39:11', 'admin', '2023-06-05 23:39:30', '薪酬发放状态');
INSERT INTO `sys_dict_type` VALUES (104, '统计维度', 'wh_statistics_dimension', '0', 'admin', '2023-06-06 11:09:47', '', NULL, '工时统计维度');
INSERT INTO `sys_dict_type` VALUES (105, '是否分配完成', 'wh_is_completed', '0', 'admin', '2023-06-10 23:08:21', '', NULL, '任务是否分配完成');
INSERT INTO `sys_dict_type` VALUES (106, '分配阶段', 'wh_distribution_stage', '0', 'admin', '2023-06-13 21:35:33', '', NULL, '任务分配阶段');

INSERT INTO `sys_dict_data` VALUES (100, 1, '团队负责人', '1', 'wh_participation_methods', NULL, 'primary', 'N', '0', 'admin', '2023-05-16 22:29:59', 'admin', '2023-05-16 22:33:01', NULL);
INSERT INTO `sys_dict_data` VALUES (101, 2, '小组负责人', '2', 'wh_participation_methods', NULL, 'success', 'N', '0', 'admin', '2023-05-16 22:30:15', 'admin', '2023-05-16 22:33:09', NULL);
INSERT INTO `sys_dict_data` VALUES (102, 3, '开发人员', '3', 'wh_participation_methods', NULL, 'info', 'N', '0', 'admin', '2023-05-16 22:30:27', 'admin', '2023-05-16 22:33:15', NULL);
INSERT INTO `sys_dict_data` VALUES (103, 4, '领薪人员', '4', 'wh_participation_methods', NULL, 'warning', 'N', '0', 'admin', '2023-05-16 22:30:46', 'admin', '2023-05-16 22:33:20', NULL);
INSERT INTO `sys_dict_data` VALUES (104, 1, '创建', '1', 'wh_distribution_nature', NULL, 'primary', 'N', '0', 'admin', '2023-05-16 22:32:21', 'admin', '2023-05-16 22:34:23', NULL);
INSERT INTO `sys_dict_data` VALUES (105, 2, '优化', '2', 'wh_distribution_nature', NULL, 'success', 'N', '0', 'admin', '2023-05-16 22:32:33', 'admin', '2023-05-16 22:34:29', NULL);
INSERT INTO `sys_dict_data` VALUES (106, 1, '未申报', '0', 'wh_claim_status', NULL, 'danger', 'N', '0', 'admin', '2023-06-04 17:41:57', 'admin', '2023-06-04 17:45:15', NULL);
INSERT INTO `sys_dict_data` VALUES (107, 2, '已申报', '1', 'wh_claim_status', NULL, 'success', 'N', '0', 'admin', '2023-06-04 17:44:59', '', NULL, NULL);
INSERT INTO `sys_dict_data` VALUES (108, 1, '未发放', '0', 'wh_salary_status', NULL, 'danger', 'N', '0', 'admin', '2023-06-05 23:39:51', '', NULL, NULL);
INSERT INTO `sys_dict_data` VALUES (109, 2, '已发放', '1', 'wh_salary_status', NULL, 'success', 'N', '0', 'admin', '2023-06-05 23:40:07', '', NULL, NULL);
INSERT INTO `sys_dict_data` VALUES (110, 1, '团队统计', '1', 'wh_statistics_dimension', NULL, 'primary', 'N', '0', 'admin', '2023-06-06 11:10:17', 'admin', '2023-06-06 11:11:01', NULL);
INSERT INTO `sys_dict_data` VALUES (111, 2, '小组统计', '2', 'wh_statistics_dimension', NULL, 'success', 'N', '0', 'admin', '2023-06-06 11:10:37', 'admin', '2023-06-06 11:11:28', NULL);
INSERT INTO `sys_dict_data` VALUES (112, 3, '开发统计', '3', 'wh_statistics_dimension', NULL, 'danger', 'N', '0', 'admin', '2023-06-06 11:11:20', '', NULL, NULL);
INSERT INTO `sys_dict_data` VALUES (113, 1, '否', '0', 'wh_is_completed', NULL, 'danger', 'N', '0', 'admin', '2023-06-10 23:09:03', '', NULL, NULL);
INSERT INTO `sys_dict_data` VALUES (114, 2, '是', '1', 'wh_is_completed', NULL, 'success', 'N', '0', 'admin', '2023-06-10 23:09:17', '', NULL, NULL);
INSERT INTO `sys_dict_data` VALUES (115, 1, '无需分配', '1', 'wh_distribution_stage', NULL, 'danger', 'N', '0', 'admin', '2023-06-13 21:36:34', 'admin', '2023-06-13 21:36:50', NULL);
INSERT INTO `sys_dict_data` VALUES (116, 2, '等待分配', '2', 'wh_distribution_stage', NULL, 'warning', 'N', '0', 'admin', '2023-06-13 21:37:03', '', NULL, NULL);
INSERT INTO `sys_dict_data` VALUES (117, 3, '正在分配', '3', 'wh_distribution_stage', NULL, 'primary', 'N', '0', 'admin', '2023-06-13 21:37:18', '', NULL, NULL);
INSERT INTO `sys_dict_data` VALUES (118, 4, '分配完成', '4', 'wh_distribution_stage', NULL, 'default', 'N', '0', 'admin', '2023-06-13 21:37:28', '', NULL, NULL);


