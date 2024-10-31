-- 1、调整用户表字段
alter table sys_user add column config_status tinyint(1) NOT NULL default '0' COMMENT '明细工时配置状态（0 关闭 1 打开）' after end_cooperation_time;

alter table wh_project_origin add column `sync_id` bigint DEFAULT NULL COMMENT '同步主键id' after code_source_no;

-- 2、数据字典
INSERT INTO `sys_dict_type`(`dict_id`, `dict_name`, `dict_type`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (119, '工时明细配置开关', 'wh_config_status', '0', 'admin', '2024-03-01 16:44:40', '', NULL, '工时明细配置开关');
INSERT INTO `sys_dict_type`(`dict_id`, `dict_name`, `dict_type`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (120, '工时申报类型', 'wh_claim_type', '0', 'admin', '2024-03-02 02:47:56', '', NULL, '工时申报类型');

INSERT INTO `sys_dict_data`(`dict_code`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (158, 1, '关闭', '0', 'wh_config_status', NULL, 'danger', 'N', '0', 'admin', '2024-03-01 16:45:15', '', NULL, NULL);
INSERT INTO `sys_dict_data`(`dict_code`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (159, 2, '打开', '1', 'wh_config_status', NULL, 'success', 'N', '0', 'admin', '2024-03-01 16:45:29', '', NULL, NULL);
INSERT INTO `sys_dict_data`(`dict_code`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (160, 1, '桌面作业', '1', 'wh_claim_type', NULL, 'primary', 'N', '0', 'admin', '2024-03-02 02:48:31', '', NULL, NULL);
INSERT INTO `sys_dict_data`(`dict_code`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (161, 2, '会议交流', '2', 'wh_claim_type', NULL, 'success', 'N', '0', 'admin', '2024-03-02 02:48:45', '', NULL, NULL);
INSERT INTO `sys_dict_data`(`dict_code`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (162, 3, '现场作业', '3', 'wh_claim_type', NULL, 'warning', 'N', '0', 'admin', '2024-03-02 02:49:00', 'admin', '2024-03-02 02:49:09', NULL);
INSERT INTO `sys_dict_data`(`dict_code`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (163, 4, '其他', '4', 'wh_claim_type', NULL, 'danger', 'N', '0', 'admin', '2024-03-02 02:49:27', 'admin', '2024-03-02 02:49:35', NULL);

-- 3、工时申报明细表
CREATE TABLE `wh_claim_detail` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `task_id` bigint NOT NULL COMMENT '任务id',
  `claim_type` bigint NOT NULL COMMENT '工时类型 1桌面作业 2会议交流 3现场作业 4其他 ',
  `start_time` datetime DEFAULT NULL COMMENT '开始时间',
  `end_time` datetime DEFAULT NULL COMMENT '截止时间',
  `working_hours` decimal(10,1) NOT NULL DEFAULT '0.0' COMMENT '工时数',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '创建者',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '更新者',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC COMMENT='工时申报明细表';

CREATE TABLE `wh_claim_detail_item` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `claim_id` bigint NOT NULL COMMENT '申报明细id',
	`video_url` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '视频名称（链接）',
  `start_time` datetime DEFAULT NULL COMMENT '开始时间',
  `end_time` datetime DEFAULT NULL COMMENT '截止时间',
  `duration` time DEFAULT NULL COMMENT '持续时长',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '创建者',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '更新者',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
	`del_flag` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '0' COMMENT '删除标志（0代表存在 1代表删除）',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC COMMENT='工时申报明细条目表';

-- 4、工时视频记录表
CREATE TABLE `wh_video_record` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `session_id` int NOT NULL COMMENT '池ID（同步）',
  `user_name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '用户名（账号）',
  `start_time` datetime DEFAULT NULL COMMENT '开始时间',
  `end_time` datetime DEFAULT NULL COMMENT '截止时间',
  `duration` time DEFAULT NULL COMMENT '持续时长',
  `total_recordings` int NOT NULL COMMENT '视频分段数',
  `video_url` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '视频链接地址',
  `claim_status` tinyint(1) NOT NULL DEFAULT '0' COMMENT '申报状态 0 未申报 1已申报',
  `sync_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '同步时间',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '创建者',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '更新者',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `del_flag` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '0' COMMENT '删除标志（0代表存在 1代表删除）',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC COMMENT='工时视频记录表';

CREATE TABLE `wh_video_record_detail` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `record_id` int NOT NULL COMMENT '记录ID',
	`recording_id` int NOT NULL COMMENT '同步记录ID',
	`session_id` int NOT NULL COMMENT '同步池ID',
	`segment_id` int NOT NULL COMMENT '片段ID',
	`screen_id` int NOT NULL COMMENT '屏幕ID',
  `start_time` datetime DEFAULT NULL COMMENT '开始时间',
  `end_time` datetime DEFAULT NULL COMMENT '截止时间',
  `duration` time DEFAULT NULL COMMENT '持续时长',
  `video_url` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '视频链接地址',
  `claim_status` tinyint(1) NOT NULL DEFAULT '0' COMMENT '申报状态 0 未申报 1已申报',
  `sync_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '同步时间',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '创建者',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '更新者',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `del_flag` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '0' COMMENT '删除标志（0代表存在 1代表删除）',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC COMMENT='工时视频记录详情表';


-- 5、定时任务
INSERT INTO `sys_job`(`job_id`, `job_name`, `job_group`, `invoke_target`, `cron_expression`, `misfire_policy`, `concurrent`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (100, '视频记录同步', 'DEFAULT', 'videoRecordTask.syncVideoRecord', '0 0/5 * * * ?', '1', '1', '0', 'admin', '2024-03-12 14:30:43', '', '2024-03-12 14:31:56', '');

-- 6、参数配置
INSERT INTO `sys_config`(`config_id`, `config_name`, `config_key`, `config_value`, `config_type`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (102, '虚拟桌面录制服务器IP地址或域名', 'sys.video.address', 'https://recording.dfyj.com:9443', 'Y', 'admin', '2024-03-16 10:33:16', '', NULL, NULL);

-- 7、项目表增加摘要编号
alter table wh_project add column `summary_no` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '摘要编号' after project_source;

-- 处理历史数据
update wh_project join wh_project_origin on wh_project.code_source_no = wh_project_origin.code_source_no set wh_project.summary_no = wh_project_origin.summary_no


