/*
 Navicat Premium Data Transfer

 Source Server         : localhost_3306
 Source Server Type    : MySQL
 Source Server Version : 80024
 Source Host           : localhost:3306
 Source Schema         : chinafestival

 Target Server Type    : MySQL
 Target Server Version : 80024
 File Encoding         : 65001

 Date: 02/03/2022 20:20:56
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for actions
-- ----------------------------
DROP TABLE IF EXISTS `actions`;
CREATE TABLE `actions`  (
  `a_id` int(0) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '活动id',
  `informatin` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '详细信息',
  `title` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '标题',
  `sort` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '分类（按节日分）',
  `endtime` longtext CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '活动结束时间',
  `starttime` longtext CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '活动开始时间',
  `place` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '地点',
  `needpeople` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '招集人数',
  `way` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '方式(线上/线下)',
  `picture` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '图片',
  `joinpeople` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '参加人数',
  `statecode` int(0) NULL DEFAULT NULL COMMENT '活动状态码（-1=未开始，0=进行中，1=已结束，）',
  PRIMARY KEY (`a_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 7 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of actions
-- ----------------------------
INSERT INTO `actions` VALUES (1, 'jbh', '案件尺寸', '是', '2022-02-15', '2022-02-15', 'v', '1', 'dfv', '', '4', 1);
INSERT INTO `actions` VALUES (2, 'jbh', '案件尺寸', '是', '2022-04-15', '2022-03-15', 'v', '1', 'dfv', NULL, '4', 1);
INSERT INTO `actions` VALUES (6, 'S', '1', '这些', '21:12:18', '21:12:18', '这些', '2', '线上', 'https://b2.kuibu.net/file/imgdisk/imgs/2022/01/441e522cfbd76be8.png', NULL, 1);
INSERT INTO `actions` VALUES (7, '啊是正常', '阿萨', '找学长', '21:12:18', '21:12:18', 'z下', '1', '这些', 'https://b2.kuibu.net/file/imgdisk/imgs/2022/01/441e522cfbd76be8.png', NULL, 1);

-- ----------------------------
-- Table structure for actions_user
-- ----------------------------
DROP TABLE IF EXISTS `actions_user`;
CREATE TABLE `actions_user`  (
  `id` int(0) NOT NULL AUTO_INCREMENT COMMENT '活动人员id',
  `a_id` int(0) NOT NULL COMMENT '活动id',
  `u_id` int(0) NULL DEFAULT NULL COMMENT '用户id',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of actions_user
-- ----------------------------
INSERT INTO `actions_user` VALUES (3, 3, 1);
INSERT INTO `actions_user` VALUES (4, 1, 3);
INSERT INTO `actions_user` VALUES (5, 3, 1);

-- ----------------------------
-- Table structure for admins
-- ----------------------------
DROP TABLE IF EXISTS `admins`;
CREATE TABLE `admins`  (
  `a_id` int(0) NOT NULL AUTO_INCREMENT COMMENT '账号',
  `a_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '昵称',
  `password` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '密码',
  PRIMARY KEY (`a_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 6 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of admins
-- ----------------------------
INSERT INTO `admins` VALUES (1, 'admin', '123456');
INSERT INTO `admins` VALUES (2, 'admin1', '123456');
INSERT INTO `admins` VALUES (3, 'admin2', '123456');
INSERT INTO `admins` VALUES (4, 'sdc', '12345');

-- ----------------------------
-- Table structure for dynamics
-- ----------------------------
DROP TABLE IF EXISTS `dynamics`;
CREATE TABLE `dynamics`  (
  `d_id` int(0) NOT NULL AUTO_INCREMENT COMMENT '动态id',
  `details` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '内容',
  `picture` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '图片',
  `datetime` datetime(0) NULL DEFAULT NULL COMMENT '发布时间',
  `user_id` int(0) NOT NULL COMMENT '用户id',
  `num_review` int(0) NULL DEFAULT NULL COMMENT '评论数',
  `praise` int(0) NULL DEFAULT NULL COMMENT '点赞数',
  PRIMARY KEY (`d_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of dynamics
-- ----------------------------
INSERT INTO `dynamics` VALUES (1, 'kjc', NULL, '2022-02-15 15:40:17', 1, 3, 1);
INSERT INTO `dynamics` VALUES (2, '浓缩', 'null', '2022-02-28 15:43:55', 1, NULL, NULL);

-- ----------------------------
-- Table structure for festivals
-- ----------------------------
DROP TABLE IF EXISTS `festivals`;
CREATE TABLE `festivals`  (
  `festival_id` int(0) NOT NULL AUTO_INCREMENT COMMENT '节日id',
  `festival_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '节日名称',
  PRIMARY KEY (`festival_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of festivals
-- ----------------------------
INSERT INTO `festivals` VALUES (1, 'SpringFestival');

-- ----------------------------
-- Table structure for festivals_action
-- ----------------------------
DROP TABLE IF EXISTS `festivals_action`;
CREATE TABLE `festivals_action`  (
  `id` int(0) NOT NULL AUTO_INCREMENT COMMENT '作品id',
  `title` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '作品标题',
  `details` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '作品内容',
  `pucture` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '作品图片',
  `writer` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '作品作者',
  `times` longtext CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '作品发布时间',
  `festival_id` int(0) NULL DEFAULT NULL COMMENT '节日ID',
  `actions` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '节日活动（美食，手工，文案，诗句）',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of festivals_action
-- ----------------------------
INSERT INTO `festivals_action` VALUES (1, 'zc ', 'zccx x', 'https://b2.kuibu.net/file/imgdisk/imgs/2022/01/441e522cfbd76be8.png', 'z ', '21:12:18', 1, 'xz ');
INSERT INTO `festivals_action` VALUES (2, 'zs', '数', 'https://b2.kuibu.net/file/imgdisk/imgs/2022/01/441e522cfbd76be8.png', '阿萨', '2022-03-01 22:59:29', 1, '手工');
INSERT INTO `festivals_action` VALUES (3, '这些', '', 'https://b2.kuibu.net/file/imgdisk/imgs/2022/01/441e522cfbd76be8.png', 'z下', '2022-03-02 14:42:30', 1, '这些');
INSERT INTO `festivals_action` VALUES (4, '现在', '真的', 'https://b2.kuibu.net/file/imgdisk/imgs/2022/01/441e522cfbd76be8.png', '单纯', '2022-03-02 14:43:55', 1, '现场');

-- ----------------------------
-- Table structure for reviews
-- ----------------------------
DROP TABLE IF EXISTS `reviews`;
CREATE TABLE `reviews`  (
  `r_id` int(0) NOT NULL COMMENT '评论id、',
  `d_dateime` datetime(0) NULL DEFAULT NULL COMMENT '发表时间',
  `d_id` int(0) NULL DEFAULT NULL COMMENT '动态id',
  `d_details` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '评论内容',
  `u_id` int(0) NULL DEFAULT NULL COMMENT '用户id',
  PRIMARY KEY (`r_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of reviews
-- ----------------------------
INSERT INTO `reviews` VALUES (1, '2022-03-02 19:40:49', 1, 'c ', 1);

-- ----------------------------
-- Table structure for users
-- ----------------------------
DROP TABLE IF EXISTS `users`;
CREATE TABLE `users`  (
  `u_id` int(0) NOT NULL AUTO_INCREMENT COMMENT '账号',
  `u_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '用户名',
  `signature` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '个性签名',
  `headphoto` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '头像',
  `statecode` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '1' COMMENT '状态码',
  `password` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '密码',
  PRIMARY KEY (`u_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of users
-- ----------------------------
INSERT INTO `users` VALUES (1, 'xs', 's', NULL, '1', '123456');
INSERT INTO `users` VALUES (2, 'xs', 's', NULL, '1', '123456');
INSERT INTO `users` VALUES (3, 'zc', 'z', '', '1', '1234');
INSERT INTO `users` VALUES (4, 'qv', 'awd', '', '1', '12345');

-- ----------------------------
-- View structure for actions_view
-- ----------------------------
DROP VIEW IF EXISTS `actions_view`;
CREATE ALGORITHM = UNDEFINED SQL SECURITY DEFINER VIEW `actions_view` AS select `actions_user`.`u_id` AS `u_id`,`actions`.`informatin` AS `informatin`,`actions`.`title` AS `title`,`actions_user`.`a_id` AS `a_id`,`actions`.`endtime` AS `endtime`,`actions`.`starttime` AS `starttime`,`actions`.`place` AS `place`,`actions`.`picture` AS `picture`,`actions`.`joinpeople` AS `joinpeople`,`actions`.`statecode` AS `statecode`,`actions`.`sort` AS `sort`,`actions`.`way` AS `way`,`actions`.`needpeople` AS `needpeople` from (`actions` join `actions_user` on((`actions`.`a_id` = `actions_user`.`a_id`)));

-- ----------------------------
-- Records of users
-- ----------------------------
INSERT INTO `users` VALUES (3, 'jbh', '案件尺寸', 1, '2022-02-15', '2022-02-15', 'v', '', '4', 1, '是', 'dfv', '1');

-- ----------------------------
-- View structure for dynames_review
-- ----------------------------
DROP VIEW IF EXISTS `dynames_review`;
CREATE ALGORITHM = UNDEFINED SQL SECURITY DEFINER VIEW `dynames_review` AS select `reviews`.`r_id` AS `r_id`,`reviews`.`d_dateime` AS `d_dateime`,`reviews`.`d_id` AS `d_id`,`reviews`.`d_details` AS `d_details`,`reviews`.`u_id` AS `u_id`,`dynamics`.`details` AS `details`,`dynamics`.`picture` AS `picture`,`dynamics`.`datetime` AS `datetime`,`dynamics`.`user_id` AS `user_id`,`dynamics`.`num_review` AS `num_review`,`dynamics`.`praise` AS `praise` from (`dynamics` join `reviews`);

-- ----------------------------
-- Records of users
-- ----------------------------
INSERT INTO `users` VALUES (1, '2022-03-02 19:40:49', 1, 'c ', 1, 'kjc', NULL, '2022-02-15 15:40:17', 1, 3, 1);
INSERT INTO `users` VALUES (1, '2022-03-02 19:40:49', 1, 'c ', 1, '浓缩', 'null', '2022-02-28 15:43:55', 1, NULL, NULL);

-- ----------------------------
-- View structure for dynamics_view
-- ----------------------------
DROP VIEW IF EXISTS `dynamics_view`;
CREATE ALGORITHM = UNDEFINED SQL SECURITY DEFINER VIEW `dynamics_view` AS select `dynamics`.`d_id` AS `d_id`,`dynamics`.`details` AS `details`,`dynamics`.`picture` AS `picture`,`dynamics`.`datetime` AS `datetime`,`dynamics`.`user_id` AS `user_id`,`users`.`u_name` AS `u_name`,`users`.`headphoto` AS `headphoto` from (`users` join `dynamics`);

-- ----------------------------
-- Records of users
-- ----------------------------
INSERT INTO `users` VALUES (2, '浓缩', 'null', '2022-02-28 15:43:55', 1, 'xs', NULL);
INSERT INTO `users` VALUES (1, 'kjc', NULL, '2022-02-15 15:40:17', 1, 'xs', NULL);
INSERT INTO `users` VALUES (2, '浓缩', 'null', '2022-02-28 15:43:55', 1, 'xs', NULL);
INSERT INTO `users` VALUES (1, 'kjc', NULL, '2022-02-15 15:40:17', 1, 'xs', NULL);
INSERT INTO `users` VALUES (2, '浓缩', 'null', '2022-02-28 15:43:55', 1, 'zc', '');
INSERT INTO `users` VALUES (1, 'kjc', NULL, '2022-02-15 15:40:17', 1, 'zc', '');
INSERT INTO `users` VALUES (2, '浓缩', 'null', '2022-02-28 15:43:55', 1, 'qv', '');
INSERT INTO `users` VALUES (1, 'kjc', NULL, '2022-02-15 15:40:17', 1, 'qv', '');

-- ----------------------------
-- View structure for reviews_view
-- ----------------------------
DROP VIEW IF EXISTS `reviews_view`;
CREATE ALGORITHM = UNDEFINED SQL SECURITY DEFINER VIEW `reviews_view` AS select `users`.`u_name` AS `u_name`,`users`.`headphoto` AS `headphoto`,`reviews`.`r_id` AS `r_id`,`reviews`.`d_dateime` AS `d_dateime`,`reviews`.`d_id` AS `d_id`,`reviews`.`d_details` AS `d_details`,`reviews`.`u_id` AS `u_id` from (`users` join `reviews` on((`users`.`u_id` = `reviews`.`u_id`)));

-- ----------------------------
-- Records of users
-- ----------------------------
INSERT INTO `users` VALUES ('xs', NULL, 1, '2022-03-02 19:40:49', 1, 'c ', 1);

SET FOREIGN_KEY_CHECKS = 1;
