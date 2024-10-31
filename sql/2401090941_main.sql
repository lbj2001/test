-- 1、表字段调整 
alter table wh_staff add column parallel_flag tinyint(1) DEFAULT '0' COMMENT '是否并行开发 0 否 1 是' after participation_methods;

alter table wh_task add column distribute_status tinyint(1) DEFAULT '0' COMMENT '任务下发状态 0 暂存待发 1 完成下发' after confirm_status;

-- 2、数据字典
INSERT INTO `sys_dict_type`(`dict_id`, `dict_name`, `dict_type`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (117, '任务下发状态', 'wh_distribute_status', '0', 'admin', '2024-01-03 00:09:46', '', NULL, '任务下发状态');
INSERT INTO `sys_dict_type`(`dict_id`, `dict_name`, `dict_type`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (118, '是否并行开发', 'wh_is_parallel', '0', 'admin', '2024-01-04 00:26:22', '', NULL, '开发人员是否并行开发');
INSERT INTO `sys_dict_data`(`dict_code`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES ((select max(dict_code)+1 from sys_dict_data s), 1, '暂存待发', '0', 'wh_distribute_status', NULL, 'danger', 'N', '0', 'admin', '2024-01-03 00:10:40', '', NULL, NULL);
INSERT INTO `sys_dict_data`(`dict_code`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES ((select max(dict_code)+1 from sys_dict_data s), 2, '完成下发', '1', 'wh_distribute_status', NULL, 'success', 'N', '0', 'admin', '2024-01-03 00:11:00', '', NULL, NULL);
INSERT INTO `sys_dict_data`(`dict_code`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES ((select max(dict_code)+1 from sys_dict_data s), 1, '否', '0', 'wh_is_parallel', NULL, 'danger', 'N', '0', 'admin', '2024-01-04 00:26:42', '', NULL, NULL);
INSERT INTO `sys_dict_data`(`dict_code`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES ((select max(dict_code)+1 from sys_dict_data s), 2, '是', '1', 'wh_is_parallel', NULL, 'success', 'N', '0', 'admin', '2024-01-04 00:26:53', '', NULL, NULL);


-- 3、历史数据调整
update wh_task set distribute_status = 1
