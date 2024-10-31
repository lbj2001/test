-- 1、任务表增加标签字段
alter table wh_task add column tag_no varchar(30)  NULL DEFAULT NULL COMMENT '标签编号' after month;

-- 2、初始化密码配置
update sys_config set config_value = 'Dfyj123' where config_id=2;
update sys_user set password = '$2a$10$AtcQg3EeeCLkA1O4jFjONeyj3yyGAQakfadgI7ZoBDkcWV66RTTDW';

-- 3、修改任务表中链接字段长度
alter table wh_task modify column link_url varchar(500) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '任务链接地址';