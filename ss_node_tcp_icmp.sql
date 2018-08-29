/**
监测 TCP ICMP 阻断功能对应表
节点id对应ssrpanel 中的ss_node表id
ssrpanel项目地址
https://github.com/ouhaohan8023/shadow.com
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
