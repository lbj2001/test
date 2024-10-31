-- 1、任务表增加完成说明字段
alter table wh_task add column deploy_url tinyint(1)  NULL DEFAULT NULL COMMENT '部署路径' after tag_no;

alter table wh_task add column upload_status tinyint(1) DEFAULT '0' COMMENT '代码上传状态（0 未上传 1 已上传）' after deploy_url;

-- 2、数据字典
INSERT INTO `sys_dict_type`(`dict_id`, `dict_name`, `dict_type`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (109, '部署路径', 'wh_deploy_url', '0', 'admin', '2023-07-20 21:59:38', '', NULL, '路径');

INSERT INTO `sys_dict_data`(`dict_code`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (125, 1, 'https://gits.sinoaopt.com', '1', 'wh_deploy_url', NULL, 'primary', 'N', '0', 'admin', '2023-07-20 22:00:38', 'admin', '2023-07-20 22:01:00', NULL);
INSERT INTO `sys_dict_data`(`dict_code`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (126, 2, 'https://gits.sinoaopt.cn', '2', 'wh_deploy_url', NULL, 'success', 'N', '0', 'admin', '2023-07-20 22:07:20', 'admin', '2023-07-20 22:07:39', NULL);

-- 3、更新任务表历史数据状态
update wh_task set status = 1 where status = 0;