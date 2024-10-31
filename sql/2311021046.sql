-- 1、任务表字段调整 
alter table wh_task add column branch_name varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '分支名称' after tag_no;
alter table wh_task add column release_flag tinyint(1) DEFAULT '0' COMMENT '是否确认发布版本 0 否 1 是' after branch_name;
alter table wh_task add column release_tag varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '发布关联tag标签' after release_flag;
alter table wh_task add column release_attachment varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '发布附件' after release_tag;

-- 2、数据字典
INSERT INTO `sys_dict_type`(`dict_id`, `dict_name`, `dict_type`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (115, '分支类型', 'wh_branch_type', '0', '2023062507', '2023-10-29 17:38:56', '', NULL, '分支类型');
INSERT INTO `sys_dict_type`(`dict_id`, `dict_name`, `dict_type`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (116, '全量发布', 'wh_full_release', '0', 'admin', '2023-11-01 13:38:06', '', NULL, '全量发布');

INSERT INTO `sys_dict_data`(`dict_code`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (142, 1, '主分支', 'main', 'wh_branch_type', NULL, 'default', 'N', '0', '2023062507', '2023-10-29 17:39:17', '', NULL, NULL);
INSERT INTO `sys_dict_data`(`dict_code`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (144, 1, '增量发布', '0', 'wh_full_release', NULL, 'primary', 'N', '0', 'admin', '2023-11-01 13:38:49', '', NULL, NULL);
INSERT INTO `sys_dict_data`(`dict_code`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (145, 2, '全量成功', '1', 'wh_full_release', NULL, 'success', 'N', '0', 'admin', '2023-11-01 13:39:07', '', NULL, NULL);
INSERT INTO `sys_dict_data`(`dict_code`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (146, 3, '全量失败', '2', 'wh_full_release', NULL, 'danger', 'N', '0', 'admin', '2023-11-01 13:39:26', '', NULL, NULL);

-- 3、添加参数配置
INSERT INTO `sys_config`(`config_id`, `config_name`, `config_key`, `config_value`, `config_type`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (100, '发布版注意事项', 'sys.release.attention', '1、文件格式 2、文件大小', 'Y', 'admin', '2023-11-01 02:27:20', '', NULL, NULL);
INSERT INTO `sys_config`(`config_id`, `config_name`, `config_key`, `config_value`, `config_type`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (101, '发布版模板', 'sys.release.template', 'http://localhost:9000/b006/2023/11/01/123_20231101020201A005.xlsx', 'Y', 'admin', '2023-11-01 10:00:08', '', NULL, NULL);

-- 4、更新历史数据
update wh_task set branch_name = 'main', release_flag = 0 where tag_no != '空' and tag_no IS NOT NULL;
