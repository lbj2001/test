-- 1、任务表增加完成说明字段
alter table wh_task add column complete_instructions varchar(500)  NULL DEFAULT NULL COMMENT '完成说明' after tag_no;

alter table wh_task add column qr_code varchar(200)  NULL DEFAULT NULL COMMENT '任务链接二维码' after link_url;
