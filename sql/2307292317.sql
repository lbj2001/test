-- 1、项目表创建
CREATE TABLE `wh_project` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `project_no` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '项目编号',
  `project_name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '项目名称',
  `project_source` tinyint(1) NOT NULL COMMENT '项目来源（1 同步 2创建）',
  `cycle_type` tinyint(1) NOT NULL COMMENT '周期类型（1 单次 2 每日 3 每月）',
  `work_hours_threshold` decimal(10,1) NOT NULL COMMENT '限定任务工时量',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '创建者',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '更新者',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `del_flag` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '0' COMMENT '删除标志（0代表存在 1代表删除）',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC COMMENT='项目表';

-- 2、项目创建菜单
insert into sys_menu (menu_name, parent_id, order_num, path, component, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark)
values('项目创建', '2000', '1', 'project', 'work/project/index', 1, 0, 'C', '0', '0', 'work:project:list', 'build', 'admin', sysdate(), '', null, '项目菜单');

-- 按钮父菜单ID
SELECT @parentId := LAST_INSERT_ID();

-- 按钮 SQL
insert into sys_menu (menu_name, parent_id, order_num, path, component, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark)
values('项目查询', @parentId, '1',  '#', '', 1, 0, 'F', '0', '0', 'work:project:query',        '#', 'admin', sysdate(), '', null, '');

insert into sys_menu (menu_name, parent_id, order_num, path, component, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark)
values('项目新增', @parentId, '2',  '#', '', 1, 0, 'F', '0', '0', 'work:project:add',          '#', 'admin', sysdate(), '', null, '');

insert into sys_menu (menu_name, parent_id, order_num, path, component, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark)
values('项目修改', @parentId, '3',  '#', '', 1, 0, 'F', '0', '0', 'work:project:edit',         '#', 'admin', sysdate(), '', null, '');

insert into sys_menu (menu_name, parent_id, order_num, path, component, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark)
values('项目删除', @parentId, '4',  '#', '', 1, 0, 'F', '0', '0', 'work:project:remove',       '#', 'admin', sysdate(), '', null, '');

insert into sys_menu (menu_name, parent_id, order_num, path, component, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark)
values('项目导出', @parentId, '5',  '#', '', 1, 0, 'F', '0', '0', 'work:project:export',       '#', 'admin', sysdate(), '', null, '');

-- 3、任务表增加项目Id字段
alter table wh_task add column project_id bigint NOT NULL COMMENT '项目ID' after parent_id;
alter table wh_task add column staff_no varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '员工编号' after staff_id;
alter table wh_task add column cycle_type tinyint(1) NOT NULL COMMENT '周期类型（1 单次 2 每日 3 每月）' after status;

-- 4、数据字典
INSERT INTO `sys_dict_type`(`dict_id`, `dict_name`, `dict_type`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (110, '周期类型', 'wh_cycle_type', '0', 'admin', '2023-07-26 22:04:22', 'admin', '2023-07-26 22:52:34', NULL);
INSERT INTO `sys_dict_type`(`dict_id`, `dict_name`, `dict_type`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (111, '项目来源', 'wh_pro_sou', '0', 'admin', '2023-07-26 22:08:38', 'admin', '2023-07-26 22:51:59', NULL);

INSERT INTO `sys_dict_data`(`dict_code`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (128, 1, '单次任务', '1', 'wh_cycle_type', NULL, 'primary', 'N', '0', 'admin', '2023-07-26 22:05:20', '', NULL, NULL);
INSERT INTO `sys_dict_data`(`dict_code`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (129, 2, '每日任务', '2', 'wh_cycle_type', NULL, 'success', 'N', '0', 'admin', '2023-07-26 22:05:41', '', NULL, NULL);
INSERT INTO `sys_dict_data`(`dict_code`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (130, 3, '每月任务', '3', 'wh_cycle_type', NULL, 'danger', 'N', '0', 'admin', '2023-07-26 22:06:19', '', NULL, NULL);
INSERT INTO `sys_dict_data`(`dict_code`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (131, 1, '同步来源', '1', 'wh_pro_sou', NULL, 'primary', 'N', '0', 'admin', '2023-07-26 22:09:06', 'admin', '2023-07-26 22:11:57', NULL);
INSERT INTO `sys_dict_data`(`dict_code`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (132, 2, '创建新增', '2', 'wh_pro_sou', NULL, 'success', 'N', '0', 'admin', '2023-07-26 22:11:46', '', NULL, NULL);

-- 5、参数设置
INSERT INTO `sys_config`(`config_id`, `config_name`, `config_key`, `config_value`, `config_type`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (14, '项目限定任务工时量', 'sys.workhours.threshold', '50', 'Y', 'admin', '2023-07-28 15:09:53', 'admin', '2023-07-29 00:32:31', NULL);

-- 6、定时任务
INSERT INTO `sys_job`(`job_id`, `job_name`, `job_group`, `invoke_target`, `cron_expression`, `misfire_policy`, `concurrent`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (5, '自动创建周期任务', 'DEFAULT', 'projectTask.genCycleTask', '0 10 0 1 * ?', '1', '1', '0', 'admin', '2023-07-28 23:08:18', 'admin', '2023-07-29 00:35:53', '');

-- 7、调整项目表字段
alter table wh_project add column status tinyint(1) NOT NULL default '0' COMMENT '是否启用状态（0 否 1 是）' after work_hours_threshold;

