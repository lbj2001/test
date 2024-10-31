-- 1、添加数据字典
INSERT INTO `sys_dict_type`(`dict_id`, `dict_name`, `dict_type`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (107, '架构名称', 'wh_team_name', '0', 'admin', '2023-06-17 13:20:34', 'admin', '2023-06-17 13:21:46', '架构名称');

INSERT INTO `sys_dict_data`(`dict_code`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (119, 1, '团队', 'A', 'wh_team_name', NULL, 'primary', 'N', '0', 'admin', '2023-06-17 13:23:47', 'admin', '2023-06-17 13:24:25', NULL);
INSERT INTO `sys_dict_data`(`dict_code`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (120, 2, '小组', 'B', 'wh_team_name', NULL, 'success', 'N', '0', 'admin', '2023-06-17 13:24:20', '', NULL, NULL);
INSERT INTO `sys_dict_data`(`dict_code`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (121, 3, '开发', 'C', 'wh_team_name', NULL, 'info', 'N', '0', 'admin', '2023-06-17 13:26:03', '', NULL, NULL);
INSERT INTO `sys_dict_data`(`dict_code`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (122, 4, '领薪', 'D', 'wh_team_name', NULL, 'warning', 'N', '0', 'admin', '2023-06-17 13:26:30', '', NULL, NULL);

-- 2、staff表增加架构名称、编号字段
alter table wh_staff add column team_name char(2) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '架构名称 A团队 B小组 C开发 D领薪' after team_id;
alter table wh_staff add column team_no varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '架构编号' after team_name;

-- 3、sys_user表增加开户银行、账户字段
alter table sys_user add column bank varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '开户银行' after phonenumber;
alter table sys_user add column account varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '账户' after bank;
alter table sys_user modify column user_name varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '人员号（用户账号）';
alter table sys_user modify column nick_name varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '用户姓名';
