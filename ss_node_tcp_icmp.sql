/*
 Navicat Premium Data Transfer

 Source Server         : 新新新加坡后台（低级权限）
 Source Server Type    : MySQL
 Source Server Version : 80011
 Source Host           : 173.82.95.67:3306
 Source Schema         : shadow3

 Target Server Type    : MySQL
 Target Server Version : 80011
 File Encoding         : 65001

 Date: 29/08/2018 16:44:30
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for ss_node_tcp_icmp
-- ----------------------------
DROP TABLE IF EXISTS `ss_node_tcp_icmp`;
CREATE TABLE `ss_node_tcp_icmp`  (
  `t_id` int(11) NOT NULL AUTO_INCREMENT,
  `t_s_id` int(11) NULL DEFAULT NULL COMMENT '节点id',
  `t_icmp_status` tinyint(1) NULL DEFAULT NULL COMMENT '0阻断，1正常',
  `t_tcp_status` tinyint(1) NULL DEFAULT NULL COMMENT '0阻断，1正常',
  `created_at` int(11) NULL DEFAULT NULL,
  `updated_at` int(11) NULL DEFAULT NULL,
  `end_at` int(11) NULL DEFAULT NULL COMMENT '异常时间',
  PRIMARY KEY (`t_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

SET FOREIGN_KEY_CHECKS = 1;
