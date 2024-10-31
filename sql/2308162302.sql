-- 1、项目表增加项目类型字段
alter table wh_project add column project_type tinyint(1) default NULL COMMENT '项目类型（数据字典wh_pro_type）' after project_name;

-- 2、任务表增加交付文件地址
alter table wh_task add column `file_url` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '交付文件地址' after deploy_url;

-- 3、数据字典调整
-- （生产无需执行）
INSERT INTO `sys_dict_type`(`dict_id`, `dict_name`, `dict_type`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (112, '项目类型', 'wh_pro_type', '0', 'admin', '2023-08-12 15:06:25', '', NULL, NULL);
INSERT INTO `sys_dict_data`(`dict_code`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (133, 9, '超时关闭', '9', 'wh_claim_status', NULL, 'primary', 'N', '0', 'admin', '2023-08-12 15:05:42', '', NULL, NULL);
INSERT INTO `sys_dict_data`(`dict_code`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (134, 0, 'IT开发任务', '1', 'wh_pro_type', NULL, 'primary', 'N', '0', 'admin', '2023-08-12 15:07:21', '', NULL, NULL);
INSERT INTO `sys_dict_data`(`dict_code`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (135, 2, 'IT设计任务', '2', 'wh_pro_type', NULL, 'success', 'N', '0', 'admin', '2023-08-12 15:07:45', 'admin', '2023-08-12 15:07:59', NULL);
INSERT INTO `sys_dict_data`(`dict_code`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (136, 9, '非IT类任务', '9', 'wh_pro_type', NULL, 'danger', 'N', '0', 'admin', '2023-08-12 15:08:09', '', NULL, NULL);

-- （生产需执行）
INSERT INTO `sys_dict_type`(`dict_id`, `dict_name`, `dict_type`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (113, '项目是否启用', 'wh_pro_status', '0', 'admin', '2023-08-14 23:45:52', '', NULL, NULL);
INSERT INTO `sys_dict_data`(`dict_code`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (137, 1, '否', '0', 'wh_pro_status', NULL, 'danger', 'N', '0', 'admin', '2023-08-14 23:46:41', '', NULL, NULL);
INSERT INTO `sys_dict_data`(`dict_code`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (138, 2, '是', '1', 'wh_pro_status', NULL, 'success', 'N', '0', 'admin', '2023-08-14 23:46:52', '', NULL, NULL);
INSERT INTO `sys_dict_data`(`dict_code`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (139, 9, '超时关闭', '9', 'wh_is_completed', NULL, 'primary', 'N', '0', 'admin', '2023-08-14 23:50:27', '', NULL, NULL);

