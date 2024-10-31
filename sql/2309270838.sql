-- 1、表字段调整 代码与源编号
alter table wh_project add column code_source_no varchar(50) default NULL COMMENT '代码与源编号' after project_source;
alter table wh_task add column confirm_status tinyint(1) default '0' COMMENT '确认状态 0 否 1 是' after cycle_type;
alter table wh_task drop column distribution_nature;
alter table wh_salary_distribution drop index salary_index;


-- 2、增加组队状态数据字典
INSERT INTO `sys_dict_type`(`dict_id`, `dict_name`, `dict_type`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (114, '组队状态', 'wh_team_status', '0', 'admin', '2023-09-22 00:14:14', '', NULL, '组队状态');
INSERT INTO `sys_dict_data`(`dict_code`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (140, 1, '正在组队', '0', 'wh_team_status', NULL, 'success', 'N', '0', 'admin', '2023-09-22 00:15:02', 'admin', '2023-09-22 00:15:33', NULL);
INSERT INTO `sys_dict_data`(`dict_code`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (141, 2, '解除组队', '1', 'wh_team_status', NULL, 'danger', 'N', '0', 'admin', '2023-09-22 00:15:17', '', NULL, NULL);

-- 3、历史数据调整
update wh_task set confirm_status=1 where upload_status=1;

-- 4、薪水分配表增加字典及历史数据调整
alter table wh_salary_distribution add column staff_no varchar(30) NOT NULL COMMENT '员工编号' after staff_id;
update wh_salary_distribution,wh_staff set wh_salary_distribution.staff_no = wh_staff.staff_no where wh_salary_distribution.staff_id = wh_staff.id;

-- 5、项目来源表
CREATE TABLE `wh_project_origin` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `project_no` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '项目编号',
  `project_name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '项目名称',
  `summary_no` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '摘要编号',
  `code_source_no` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '代码与源镜像摘要编号',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '创建者',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '更新者',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `del_flag` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '0' COMMENT '删除标志（0代表存在 1代表删除）',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC COMMENT='项目来源表';