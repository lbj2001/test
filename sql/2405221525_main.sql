
-- 1、调整字段
alter table wh_project add column `main_project_name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '主项目名称' after project_no;

