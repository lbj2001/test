-- 1、添加数据字典
INSERT INTO `sys_dict_type`(`dict_id`, `dict_name`, `dict_type`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (108, '人司关系', 'sys_hc_relation', '0', 'admin', '2023-06-26 00:41:58', 'admin', '2023-06-26 00:42:36', '人司关系\n');
INSERT INTO `sys_dict_data`(`dict_code`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (123, 1, '劳动关系', '1', 'sys_hc_relation', NULL, 'warning', 'N', '0', 'admin', '2023-06-26 00:42:56', '', NULL, NULL);
INSERT INTO `sys_dict_data`(`dict_code`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (124, 2, '外协开发', '2', 'sys_hc_relation', NULL, 'success', 'N', '0', 'admin', '2023-06-26 00:43:47', '', NULL, NULL);

-- 2、sys_user表增加人司关系字段
alter table sys_user add column human_company_relation tinyint(2)  NULL DEFAULT NULL COMMENT '人司关系（1劳动关系 2外协开发）' after account;

-- 3、同步人员定时器
INSERT INTO `sys_job`(`job_id`, `job_name`, `job_group`, `invoke_target`, `cron_expression`, `misfire_policy`, `concurrent`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (4, '人员同步', 'DEFAULT', 'thirdPartyTask.syncThirdPartyUsers(4L)', '* * 8 * * ?', '2', '1', '0', 'admin', '2023-06-25 16:15:00', 'admin', '2023-06-25 16:24:29', '');


-- 4、更新人员定时器
update sys_job set cron_expression = '0 0 8 * * ?' where job_id = 4;

-- 5、同步首页配置
INSERT INTO `sys_config`(`config_id`, `config_name`, `config_key`, `config_value`, `config_type`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (7, '测试地址', 'sys.test.url', 'http://192.168.9.29:20003', 'Y', 'admin', '2023-06-24 00:39:48', 'admin', '2023-06-29 11:35:07', NULL);
INSERT INTO `sys_config`(`config_id`, `config_name`, `config_key`, `config_value`, `config_type`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (8, '技术支持姓名', 'sys.support.name', '王小冬', 'Y', 'admin', '2023-06-24 00:40:42', 'admin', '2023-06-29 11:26:45', NULL);
INSERT INTO `sys_config`(`config_id`, `config_name`, `config_key`, `config_value`, `config_type`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (9, '技术支持微信', 'sys.support.wechat', 'dream-248877', 'Y', 'admin', '2023-06-24 00:41:13', 'admin', '2023-06-29 11:28:24', NULL);
INSERT INTO `sys_config`(`config_id`, `config_name`, `config_key`, `config_value`, `config_type`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (10, '技术支持联系方式', 'sys.support.phone', '18762255896', 'Y', 'admin', '2023-06-24 00:41:40', 'admin', '2023-06-29 11:30:47', NULL);
INSERT INTO `sys_config`(`config_id`, `config_name`, `config_key`, `config_value`, `config_type`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (11, '系统管理员姓名', 'sys.admin.name', '李雨航', 'Y', 'admin', '2023-06-24 00:42:26', 'admin', '2023-06-29 11:32:12', NULL);
INSERT INTO `sys_config`(`config_id`, `config_name`, `config_key`, `config_value`, `config_type`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (12, '系统管理员微信', 'sys.admin.wechat', 'liiefiee', 'Y', 'admin', '2023-06-24 00:43:05', 'admin', '2023-06-29 11:32:24', NULL);
INSERT INTO `sys_config`(`config_id`, `config_name`, `config_key`, `config_value`, `config_type`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (13, '系统管理员联系方式', 'sys.admin.phone', '18645947123', 'Y', 'admin', '2023-06-24 00:43:35', 'admin', '2023-06-29 11:32:33', NULL);
