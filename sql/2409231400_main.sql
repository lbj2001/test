-- 1、调整字段
alter table wh_staff add column `work_content` varchar(1000) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '工作内容' after parallel_flag;
alter table sys_user add column `working_price` decimal(10,1) NOT NULL DEFAULT '0.0' COMMENT '工时单价' after config_status;
alter table wh_task_distribution add column `working_price` decimal(10,1) NOT NULL DEFAULT '0.0' COMMENT '工时单价' after working_hours;

-- 2、历史数据
update wh_staff set work_content = '默认' where del_flag = 0;
update sys_user set working_price = 100.0 where del_flag = 0;
update wh_task_distribution set working_price = 100.0;