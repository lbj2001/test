-- 1、增加菜单按钮
INSERT INTO `sys_menu`(`menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES ('工时配置', 100, 8, '', NULL, NULL, 1, 0, 'F', '0', '0', 'system:user:whourConfig', '#', 'admin', '2024-04-19 21:22:12', 'admin', '2024-04-19 21:22:33', '');

-- 2、调整字段
alter table wh_task add column `project_type` tinyint(1) DEFAULT NULL COMMENT '项目类型（数据字典wh_pro_type）' after project_id;
alter table wh_task add column `inner_branch` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '内部分支' after branch_name;

alter table wh_claim_detail drop column `start_time`;
alter table wh_claim_detail drop column `end_time`;
alter table wh_claim_detail add column `description` varchar(500) DEFAULT NULL COMMENT '说明' after claim_type;
alter table wh_claim_detail add column `total_hours` decimal(10,1) DEFAULT '0.0' COMMENT '累计时长' after description;
alter table wh_claim_detail add column `lock_time` datetime DEFAULT NULL COMMENT '锁定时间' after total_hours;
alter table wh_claim_detail add column `lock_status` tinyint(1) DEFAULT '0' COMMENT '锁定状态 0否 1是' after lock_time;

alter table wh_claim_detail_item add column `lock_time` datetime DEFAULT NULL COMMENT '锁定时间' after duration;
alter table wh_claim_detail_item add column `lock_status` tinyint(1) DEFAULT NULL COMMENT '锁定状态 0否 1是' after lock_time;

alter table wh_video_record add column `time_limit` tinyint(1) DEFAULT '0' COMMENT '是否超1min时长限制 0否 1是' after claim_status;
alter table wh_video_record_detail add column `time_limit` tinyint(1) DEFAULT '0' COMMENT '是否超1min时长限制 0否 1是' after claim_status;

alter table wh_project add column `branch_type` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '分支类型' after cycle_type;
alter table wh_project add column `project_leader` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '项目负责人' after project_source;

-- 3、数据字典新增
INSERT INTO `sys_dict_data`(`dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (10, '暂存', '10', 'wh_claim_status', NULL, 'warning', 'N', '0', 'admin', '2024-04-27 18:52:10', 'admin', '2024-04-27 19:26:35', NULL);

-- 4、历史数据调整
update wh_task join wh_project on wh_task.project_id = wh_project.id set wh_task.project_type = wh_project.project_type;

-- 5、增加角色
INSERT INTO `sys_role`(`role_name`, `role_key`, `role_sort`, `data_scope`, `menu_check_strictly`, `dept_check_strictly`, `status`, `del_flag`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES ('项目类型分配角色', 'distribute', 10, '1', 1, 1, '0', '0', 'admin', '2024-05-06 01:03:39', '', NULL, NULL);
