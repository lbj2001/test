-- --------------------------------------------------------
-- 第一部分开始：ALTER TABLE 修改表结构语句
-- --------------------------------------------------------
alter table wh_task drop column confirm_status;

-- --------------------------------------------------------
-- 第一部分结束
-- --------------------------------------------------------


-- --------------------------------------------------------
-- 第二部分开始：CREATE TABLE 创建表结构语句，需优先DROP TABLE IF EXISTS `表名`;
-- 例：
-- DROP TABLE IF EXISTS `table_abc`;
-- CREATE TABLE `table_abc` (
--   `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键ID',
--   `parent_id` bigint NOT NULL DEFAULT '0' COMMENT '父级ID',
--   PRIMARY KEY (`id`) USING BTREE
-- ) ENGINE=InnoDB AUTO_INCREMENT=1050 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC COMMENT='abc表';
-- --------------------------------------------------------

-- --------------------------------------------------------
-- 第二部分结束
-- --------------------------------------------------------


BEGIN;
-- --------------------------------------------------------
-- 第三部分开始：INSERT、UPDATE、DELETE 增删改数据语句，按顺序存放
-- --------------------------------------------------------
update wh_task set cycle_type = 3 where project_type = 9 and DATE_FORMAT(distribution_time, '%Y-%m') = '2024-09';
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (2041, '工时检索', 2000, 3, 'taskInquire', 'work/taskInquire/index', NULL, 1, 0, 'C', '0', '0', 'work:taskInquire:list', 'education', 'admin', '2024-10-14 16:09:58', 'admin', '2024-10-14 16:45:51', '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (2042, '工时检索查询', 2041, 1, '', NULL, NULL, 1, 0, 'F', '0', '0', 'work:taskInquire:query', '#', 'admin', '2024-10-14 16:14:32', '', NULL, '');

-- --------------------------------------------------------
-- 第三部分结束
-- --------------------------------------------------------
COMMIT;


-- --------------------------------------------------------
-- 第四部分开始：其他语句
-- --------------------------------------------------------

-- --------------------------------------------------------
-- 第四部分结束
-- --------------------------------------------------------
