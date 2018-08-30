/**
节点对应表
ssrpanel项目地址
https://github.com/ouhaohan8023/shadow.com
 */

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for ss_node
-- ----------------------------
DROP TABLE IF EXISTS `ss_node`;
CREATE TABLE `ss_node`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '名称',
  `group_id` int(11) NOT NULL DEFAULT 0 COMMENT '所属分组',
  `country_code` char(5) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '国家代码',
  `server` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '服务器域名地址',
  `ip` char(15) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '服务器IPV4地址',
  `ipv6` char(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '服务器IPV6地址',
  `desc` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '节点简单描述',
  `method` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT 'aes-192-ctr' COMMENT '加密方式',
  `protocol` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT 'auth_chain_a' COMMENT '协议',
  `protocol_param` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '协议参数',
  `obfs` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT 'tls1.2_ticket_auth' COMMENT '混淆',
  `obfs_param` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '混淆参数',
  `traffic_rate` float NOT NULL DEFAULT 1 COMMENT '流量比率',
  `bandwidth` int(11) NOT NULL DEFAULT 100 COMMENT '出口带宽，单位M',
  `traffic` bigint(20) NOT NULL DEFAULT 1000 COMMENT '每月可用流量，单位G',
  `monitor_url` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '监控地址',
  `is_subscribe` tinyint(4) NULL DEFAULT 1 COMMENT '是否允许用户订阅该节点：0-否、1-是',
  `compatible` tinyint(4) NULL DEFAULT 0 COMMENT '兼容SS',
  `single` tinyint(4) NULL DEFAULT 0 COMMENT '单端口多用户：0-否、1-是',
  `single_force` tinyint(4) NULL DEFAULT NULL COMMENT '模式：0-兼容模式、1-严格模式',
  `single_port` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '端口号，用,号分隔',
  `single_passwd` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '密码',
  `single_method` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '加密方式',
  `single_protocol` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '协议',
  `single_obfs` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '混淆',
  `sort` int(11) NOT NULL DEFAULT 0 COMMENT '排序值，值越大越靠前显示',
  `status` tinyint(4) NOT NULL DEFAULT 1 COMMENT '状态：0-维护、1-正常',
  `created_at` datetime(0) NOT NULL,
  `updated_at` datetime(0) NOT NULL,
  `is_build` tinyint(1) NOT NULL DEFAULT 0 COMMENT '0未部署，1已部署',
  `root` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '服务器账号',
  `pwd` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '服务器密码',
  `serverport` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '22' COMMENT '服务器端口',
  `client_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '客户端名称',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 61 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '节点信息表' ROW_FORMAT = Dynamic;

SET FOREIGN_KEY_CHECKS = 1;
