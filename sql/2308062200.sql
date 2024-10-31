-- 1、定时任务
INSERT INTO `sys_job`(`job_id`, `job_name`, `job_group`, `invoke_target`, `cron_expression`, `misfire_policy`, `concurrent`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (6, '项目同步', 'DEFAULT', 'thirdPartyTask.syncThirdPartyProject(6L)', '0 10 8 * * ?', '2', '1', '0', 'admin', '2023-08-06 17:14:07', 'admin', '2023-08-06 17:30:42', '');


