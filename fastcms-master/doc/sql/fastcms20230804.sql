/*
 Navicat MySQL Data Transfer

 Source Server         : localhost
 Source Server Type    : MySQL
 Source Server Version : 80019
 Source Host           : localhost:3306
 Source Schema         : fastcms

 Target Server Type    : MySQL
 Target Server Version : 80019
 File Encoding         : 65001

 Date: 04/08/2023 21:48:55
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for article
-- ----------------------------
DROP TABLE IF EXISTS `article`;
CREATE TABLE `article` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `create_user_id` bigint DEFAULT NULL,
  `title` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `content_html` longtext COLLATE utf8mb4_unicode_ci,
  `summary` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `seo_keywords` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `seo_description` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `out_link` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '文章外链',
  `sort_num` int DEFAULT '0' COMMENT '文章排序，值越大越靠前',
  `view_count` int DEFAULT '0' COMMENT '浏览量',
  `comment_enable` tinyint DEFAULT '1' COMMENT '是否开启评论',
  `thumbnail` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '文章缩略图',
  `status` varchar(32) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `suffix` varchar(32) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '页面后缀',
  `attach_id` bigint DEFAULT NULL COMMENT '附件',
  `json_ext` text COLLATE utf8mb4_unicode_ci COMMENT 'json格式的扩展字段',
  `created` datetime DEFAULT NULL,
  `updated` datetime DEFAULT NULL,
  `version` int DEFAULT '0' COMMENT '乐观锁',
  PRIMARY KEY (`id`),
  KEY `user_id` (`create_user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ----------------------------
-- Records of article
-- ----------------------------
BEGIN;
INSERT INTO `article` VALUES (1, 1, '关于导航', '<p>关于导航关于导航关于导航关于导航关于导航</p>', '关于导航关于导航关于导航关于导航', '关于导航关于导航', '关于导航关于导航', '', 0, 6, 1, '/attachment/20230423/4d96cca9e59947a0a9efd7c6acb8cadc.png', 'publish', '', NULL, NULL, '2023-08-04 09:10:17', '2023-08-04 09:40:05', 0);
COMMIT;

-- ----------------------------
-- Table structure for article_category
-- ----------------------------
DROP TABLE IF EXISTS `article_category`;
CREATE TABLE `article_category` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `create_user_id` bigint DEFAULT NULL,
  `parent_id` bigint DEFAULT '0' COMMENT '上级分类id',
  `title` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `type` varchar(32) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `sort_num` int DEFAULT '0',
  `icon` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `suffix` varchar(32) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '页面后缀',
  `path` varchar(32) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '访问路径',
  `created` datetime DEFAULT NULL,
  `updated` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ----------------------------
-- Records of article_category
-- ----------------------------
BEGIN;
INSERT INTO `article_category` VALUES (1, 1, 0, '测试分类', 'category', 0, '', '', '', '2023-08-04 09:38:49', NULL);
COMMIT;

-- ----------------------------
-- Table structure for article_category_relation
-- ----------------------------
DROP TABLE IF EXISTS `article_category_relation`;
CREATE TABLE `article_category_relation` (
  `article_id` bigint NOT NULL,
  `category_id` bigint NOT NULL,
  PRIMARY KEY (`article_id`,`category_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ----------------------------
-- Records of article_category_relation
-- ----------------------------
BEGIN;
INSERT INTO `article_category_relation` VALUES (1, 1);
COMMIT;

-- ----------------------------
-- Table structure for article_comment
-- ----------------------------
DROP TABLE IF EXISTS `article_comment`;
CREATE TABLE `article_comment` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `user_id` bigint DEFAULT NULL,
  `parent_id` bigint DEFAULT '0',
  `article_id` bigint DEFAULT NULL,
  `content` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `sort_num` int DEFAULT '0',
  `reply_count` int DEFAULT '0' COMMENT '回复数',
  `up_count` int DEFAULT '0' COMMENT '点赞数',
  `down_count` int DEFAULT '0' COMMENT '踩赞数',
  `status` varchar(32) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '评论状态 ',
  `created` datetime DEFAULT NULL,
  `updated` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `parent_id` (`parent_id`),
  KEY `article_id` (`article_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ----------------------------
-- Table structure for article_tag
-- ----------------------------
DROP TABLE IF EXISTS `article_tag`;
CREATE TABLE `article_tag` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `create_user_id` bigint DEFAULT NULL,
  `tag_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `type` varchar(32) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `sort_num` int DEFAULT '0',
  `created` datetime DEFAULT NULL,
  `updated` datetime DEFAULT NULL,
  `suffix` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `icon` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ----------------------------
-- Table structure for article_tag_relation
-- ----------------------------
DROP TABLE IF EXISTS `article_tag_relation`;
CREATE TABLE `article_tag_relation` (
  `article_id` bigint NOT NULL,
  `tag_id` bigint NOT NULL,
  PRIMARY KEY (`article_id`,`tag_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ----------------------------
-- Table structure for attachment
-- ----------------------------
DROP TABLE IF EXISTS `attachment`;
CREATE TABLE `attachment` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `create_user_id` bigint DEFAULT NULL,
  `file_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '原始文件名',
  `file_desc` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '文件描述',
  `file_path` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '文件相对路径',
  `file_type` varchar(32) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '文件类型',
  `created` datetime DEFAULT NULL,
  `updated` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=28 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='附件表';

-- ----------------------------
-- Records of attachment
-- ----------------------------
BEGIN;
INSERT INTO `attachment` VALUES (1, 1, 'Greenflash.jpeg', NULL, '/attachment/20230325/02ca8a30ebb94db1aa991318577f09ff.jpeg', 'image', '2023-03-25 16:36:42', NULL);
INSERT INTO `attachment` VALUES (2, 1, '蝴蝶.png', NULL, '/attachment/20230406/379222bf151544aebce2f95173712b1d.png', 'image', '2023-04-06 20:52:37', NULL);
INSERT INTO `attachment` VALUES (3, 1, '蝴蝶.png', NULL, '/attachment/20230406/b3cacd71d57a40c59ee98c617572f884.png', 'image', '2023-04-06 20:55:32', NULL);
INSERT INTO `attachment` VALUES (4, 1, '蝴蝶.png', NULL, '/attachment/20230406/56390710592248adb1fcdb54edc5589c.png', 'image', '2023-04-06 21:19:44', NULL);
INSERT INTO `attachment` VALUES (5, 1, '蝴蝶.png', NULL, '/attachment/20230406/7d51cada2b964e129381bfe68702a3dc.png', 'image', '2023-04-06 21:21:05', NULL);
INSERT INTO `attachment` VALUES (6, 1, '主图-06.jpg', NULL, '/attachment/20230415/1e1d1dc7bf074106a85741702bffd51c.jpg', 'image', '2023-04-15 17:47:06', NULL);
INSERT INTO `attachment` VALUES (7, 1, 'SKU-TPU無味高彈斜邊透明1.505.jpg', NULL, '/attachment/20230415/02dc6e156b424b2aa4b8528ac4f4824c.jpg', 'image', '2023-04-15 17:48:56', NULL);
INSERT INTO `attachment` VALUES (8, 1, '主图-04.jpg', NULL, '/attachment/20230415/d7acf098d1af464a97f9d5682585a673.jpg', 'image', '2023-04-15 17:51:30', NULL);
INSERT INTO `attachment` VALUES (9, 1, '1-5.jpeg', NULL, '/attachment/20230415/4ffbcfb1c2bf435ead7ca95cb91e7869.jpeg', 'image', '2023-04-15 17:53:30', NULL);
INSERT INTO `attachment` VALUES (10, 1, '1-5.jpeg', NULL, '/attachment/20230415/b74d3770cbc4489293603a3222fa7cd7.jpeg', 'image', '2023-04-15 17:54:06', NULL);
INSERT INTO `attachment` VALUES (11, 1, '主图-03.jpg', NULL, '/attachment/20230415/c97a6d54c80b4282b3386a49e5d11eac.jpg', 'image', '2023-04-15 17:56:31', NULL);
INSERT INTO `attachment` VALUES (12, 1, '3.jpeg', NULL, '/attachment/20230415/c6896157e6cc4ccd91331346eb9aeea4.jpeg', 'image', '2023-04-15 17:57:45', NULL);
INSERT INTO `attachment` VALUES (13, 1, '主图-02.jpg', NULL, '/attachment/20230415/c60fe7af382941058a783c4e0c380d32.jpg', 'image', '2023-04-15 17:58:32', NULL);
INSERT INTO `attachment` VALUES (14, 1, 'SKU-適合1-2人01.jpg', NULL, '/attachment/20230417/b6af3cea0a6f4f779d5fa7efad7264a2.jpg', 'image', '2023-04-17 15:29:42', NULL);
INSERT INTO `attachment` VALUES (15, 1, 'SKU-適合2-5人02.jpg', NULL, '/attachment/20230417/9f11facff9084fdfb0273c0f0642c389.jpg', 'image', '2023-04-17 15:29:48', NULL);
INSERT INTO `attachment` VALUES (16, 1, 'curinglight.png', NULL, '/attachment/20230417/cb021ab37281463290692800e22ac3a6.png', 'image', '2023-04-17 15:46:23', NULL);
INSERT INTO `attachment` VALUES (17, 1, 'curinglight.png', NULL, '/attachment/20230417/75e7ca6e719846aca39d19c843387321.png', 'image', '2023-04-17 15:46:27', NULL);
INSERT INTO `attachment` VALUES (18, 1, 'banner.png', NULL, '/attachment/20230417/f0a2551815c94fc59cd3e1b8452b8ca4.png', 'image', '2023-04-17 16:37:24', NULL);
INSERT INTO `attachment` VALUES (19, 1, 'banner.png', NULL, '/attachment/20230417/5fb469abbcd24b4fae304d19b7678507.png', 'image', '2023-04-17 16:37:30', NULL);
INSERT INTO `attachment` VALUES (20, 1, 'banner.png', NULL, '/attachment/20230423/8b867b3a3bcc4ff380e6facaa8b392c1.png', 'image', '2023-04-23 11:30:58', NULL);
INSERT INTO `attachment` VALUES (21, 1, 'banner.png', NULL, '/attachment/20230423/2a8b2b469bd0443ca6e385ccf1d372be.png', 'image', '2023-04-23 11:31:44', NULL);
INSERT INTO `attachment` VALUES (22, 1, 'banner.png', NULL, '/attachment/20230423/4d96cca9e59947a0a9efd7c6acb8cadc.png', 'image', '2023-04-23 11:45:04', NULL);
INSERT INTO `attachment` VALUES (23, 1, 'curinglight.png', NULL, '/attachment/20230423/c4ab4ccee60c4056a8d96c3fc8646a3b.png', 'image', '2023-04-23 12:33:33', NULL);
INSERT INTO `attachment` VALUES (24, 1, 'curinglight.png', NULL, '/attachment/20230423/af2b7c60c2d343e3afc14bfd499cf18a.png', 'image', '2023-04-23 12:34:04', NULL);
INSERT INTO `attachment` VALUES (25, 1, '知行营业执照副本.pdf', NULL, '/attachment/20230423/323041cb24c94800beb2f51464a76654.pdf', 'office', '2023-04-23 21:41:23', NULL);
INSERT INTO `attachment` VALUES (26, 1, '20230406_34c24a3349bbfefd_404867326896_mp4_264_hd_taobao.mp4', NULL, '/attachment/20230423/e14930ed987f4960b01f20a8041147e2.mp4', 'video', '2023-04-23 21:53:37', NULL);
INSERT INTO `attachment` VALUES (27, 1, '主图-03.jpg', NULL, '/attachment/20230720/4912039a43654b9f98cb92657049e67b.jpg', 'image', '2023-07-20 17:23:17', NULL);
COMMIT;

-- ----------------------------
-- Table structure for config
-- ----------------------------
DROP TABLE IF EXISTS `config`;
CREATE TABLE `config` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `KEY` varchar(128) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `value` text COLLATE utf8mb4_unicode_ci COMMENT '配置值',
  PRIMARY KEY (`id`),
  KEY `key` (`KEY`)
) ENGINE=InnoDB AUTO_INCREMENT=31 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='系统配置表';

-- ----------------------------
-- Records of config
-- ----------------------------
BEGIN;
INSERT INTO `config` VALUES (1, 'enable_template_id', 'www.greenflash.cn');
INSERT INTO `config` VALUES (2, 'serverIp', '192.168.2.5');
INSERT INTO `config` VALUES (3, 'serverPort', '8080');
INSERT INTO `config` VALUES (4, 'public_website_domain', 'http://localhost:8080');
INSERT INTO `config` VALUES (5, 'website_name', '绿闪科技');
INSERT INTO `config` VALUES (6, 'website_case_num', '<a href=\"https://beian.miit.gov.cn\">湘ICP备18020047号-1 beian.miit.gov.cn</a>');
INSERT INTO `config` VALUES (7, 'website_copyright', 'Copyright <a href=\"https://www.greenflash.cn\" target=\"_blank\">湖南绿闪数字科技有限公司</a> @2020 - 至今 <a href=\"https://www.greenflash.cn\" target=\"_blank\"> greenflash.cn</a> All Rights Reserved .');
INSERT INTO `config` VALUES (8, 'website_title', '企业cms');
INSERT INTO `config` VALUES (9, 'baiduSiteVer', 'codeva-cCAOSG8MBO');
INSERT INTO `config` VALUES (10, 'baiduhmid', 'efccc04cb44fc49faddac5876180b369');
INSERT INTO `config` VALUES (11, 'tj51laid', NULL);
INSERT INTO `config` VALUES (12, 'tj51lack', NULL);
INSERT INTO `config` VALUES (13, 'GoogleAdsClient', NULL);
INSERT INTO `config` VALUES (14, 'nightMode', 'false');
INSERT INTO `config` VALUES (15, 'enablePreLoad', 'true');
INSERT INTO `config` VALUES (16, 'textPreLoad', '绿闪数字');
INSERT INTO `config` VALUES (17, 'expandSidebar', 'false');
INSERT INTO `config` VALUES (18, 'siteTitle', '绿闪科技');
INSERT INTO `config` VALUES (19, 'upload', 'https://www.yuque.com/forms/share/1a1fee15-f7a9-4ee6-9dd4-b0ba9fef1871');
INSERT INTO `config` VALUES (20, 'about', '绿闪科技');
INSERT INTO `config` VALUES (21, 'qweatherKey', '085791e805a24491b43b06cf58ab31e7');
INSERT INTO `config` VALUES (22, 'enablePageCommentAdminVerify', 'true');
INSERT INTO `config` VALUES (23, 'enablePageCommentVerifyCode', 'true');
INSERT INTO `config` VALUES (24, 'enablePageComment', 'true');
INSERT INTO `config` VALUES (25, 'enableStaticWebSite', 'false');
INSERT INTO `config` VALUES (26, 'fakeStaticSuffix', '.html');
INSERT INTO `config` VALUES (27, 'enableFakeStatic', 'true');
INSERT INTO `config` VALUES (28, 'enableArticleCommentVerifyCode', 'true');
INSERT INTO `config` VALUES (29, 'enableArticleCommentAdminVerify', 'true');
INSERT INTO `config` VALUES (30, 'enableArticleComment', 'true');
COMMIT;

-- ----------------------------
-- Table structure for department
-- ----------------------------
DROP TABLE IF EXISTS `department`;
CREATE TABLE `department` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `parent_id` bigint DEFAULT '0' COMMENT '上级部门',
  `cmpy_id` bigint DEFAULT NULL COMMENT '所属公司id',
  `dept_name` varchar(128) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '部门名称',
  `dept_desc` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '部门描述',
  `dept_phone` varchar(32) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '联系电话',
  `dept_addr` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '部门地址',
  `dept_leader` varchar(32) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '部门负责人',
  `status` tinyint DEFAULT '1' COMMENT '0，禁用，1启用',
  `sort_num` int DEFAULT '0' COMMENT '排序',
  `created` datetime DEFAULT NULL,
  `updated` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ----------------------------
-- Records of department
-- ----------------------------
BEGIN;
INSERT INTO `department` VALUES (1, 0, 1, '知行公司', '知行医疗公司', '', '', '', 1, 0, '2023-03-25 16:57:54', '2023-03-29 17:59:12');
INSERT INTO `department` VALUES (2, 0, 1, '测速-知行', '测速', '18874909295', '哦', '测速', 1, 0, '2023-03-27 15:18:41', '2023-04-03 10:06:43');
INSERT INTO `department` VALUES (3, 0, 2, '杰瑞-jr', '杰瑞JR', '', '', '', 1, 0, '2023-04-03 10:07:15', NULL);
COMMIT;

-- ----------------------------
-- Table structure for department_user
-- ----------------------------
DROP TABLE IF EXISTS `department_user`;
CREATE TABLE `department_user` (
  `dept_id` bigint NOT NULL,
  `user_id` bigint NOT NULL,
  PRIMARY KEY (`dept_id`,`user_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ----------------------------
-- Records of department_user
-- ----------------------------
BEGIN;
INSERT INTO `department_user` VALUES (1, 2);
INSERT INTO `department_user` VALUES (1, 3);
COMMIT;

-- ----------------------------
-- Table structure for ext_cmpy_meta_en
-- ----------------------------
DROP TABLE IF EXISTS `ext_cmpy_meta_en`;
CREATE TABLE `ext_cmpy_meta_en` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `parent_id` bigint DEFAULT '0' COMMENT '上级公司',
  `cmpy_simple_name` varchar(128) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '公司简称',
  `cmpy_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '公司全称',
  `cmpy_desc` text COLLATE utf8mb4_unicode_ci COMMENT '公司描述',
  `cmpy_logo` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '公司logo',
  `cmpy_website` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '公司网站',
  `cmpy_phone` varchar(32) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '联系电话',
  `cmpy_addr` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '公司地址',
  `cmpy_leader` varchar(32) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '公司负责人',
  `cmpy_id` bigint DEFAULT NULL COMMENT '公司id',
  `status` tinyint DEFAULT '1' COMMENT '0，禁用，1启用',
  `sort_num` int DEFAULT '0' COMMENT '排序',
  `created` datetime DEFAULT NULL,
  `updated` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='公司表';

-- ----------------------------
-- Records of ext_cmpy_meta_en
-- ----------------------------
BEGIN;
INSERT INTO `ext_cmpy_meta_en` VALUES (1, 0, 'Betterway Medical ', 'Foshan Betterway Medical Technology Co., Ltd', 'FOSHAN BETTERWAY MEDICAL TECHNOLOGY CO., LTD. focuses on the design, R & D and technology output of dental small equipment products, integrating production, sales and service. It is an innovative enterprise to meet the needs of customers in the new era.\nThe core R & D team of the company is composed of very experienced engineers , they are professional and have the leading technical level in root canal products and dental area. The company attaches importance to the innovation and independent intellectual property rights of products that keep pace with the times, and is committed to launching ingenious products to meet the increasing needs of users with the development of the times and the continuous improvement of medical level. At present, the main products include Endo motor, Apex Locator, Electric Motor, etc.\nSince its establishment, the company has taken quality as the cornerstone of its business, the needs of customers as the direction of struggle, and innovation as the driving force of product innovation. The company always adheres to the scientific and rigorous road of product research and innovation, through scientific method demonstration and rigorous process control, to ensure that the product quality and performance fully meet the expectations of customers. \n', 'https://omo-oss-image.thefastimg.com/portal-saas/n…2f4193-dd76-497f-98f0-0ff8162c1b9e.png_290xaf.png', 'http://en.betterwayfs.com/', '+86 0757-81265651', 'Unit 304, 3/F, Building 7, Guangdong New Light Source Industrial Park, Langsha Village, Shishan Town, Nanhai District, Foshan', NULL, 1, 1, 0, NULL, NULL);
COMMIT;

-- ----------------------------
-- Table structure for ext_cmpy_meta_zh
-- ----------------------------
DROP TABLE IF EXISTS `ext_cmpy_meta_zh`;
CREATE TABLE `ext_cmpy_meta_zh` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `parent_id` bigint DEFAULT '0' COMMENT '上级公司',
  `cmpy_simple_name` varchar(128) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '公司简称',
  `cmpy_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '公司全称',
  `cmpy_desc` text COLLATE utf8mb4_unicode_ci COMMENT '公司描述',
  `cmpy_logo` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '公司logo',
  `cmpy_website` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '公司网站',
  `cmpy_phone` varchar(32) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '联系电话',
  `cmpy_addr` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '公司地址',
  `cmpy_leader` varchar(32) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '公司负责人',
  `cmpy_id` bigint DEFAULT NULL COMMENT '公司Id',
  `status` tinyint DEFAULT '1' COMMENT '0，禁用，1启用',
  `sort_num` int DEFAULT '0' COMMENT '排序',
  `lang` char(10) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'zh,en',
  `created` datetime DEFAULT NULL,
  `updated` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='公司表';

-- ----------------------------
-- Records of ext_cmpy_meta_zh
-- ----------------------------
BEGIN;
INSERT INTO `ext_cmpy_meta_zh` VALUES (1, 0, '知行医疗科技', '佛山市知行医疗科技有限公司', '\n佛山市知行医疗科技有限公司（品牌名Betterway）是一家集研发、生产、销售于一体，专注齿科小设备的生产销售型企业,致力于为全球口腔市场提供品质卓越的产品。  \n公司成立于2021年，生产基地位于佛山市新光源产业基地园区。公司研发中心的 电子工程师及机械工程师是牙科产品的资深工程师，从事产品开发超过8年，拥有丰 富的开发经验。公司一贯坚持“严谨务实，开拓创新，诚信经营”为经营宗旨，不懈追 求“性能更优、服务更佳、信誉更高”之目标，真正视用户为“上帝”。品质是企业的立 足之本，公司设有专业的质检流程，推行全面质量管理，建立完善的质量管控体系。 公司秉持锐意进取，不断创新，扩大牙科设备产品系列,致力于满足牙科医生、技 术员和卫生师的需求。建立公司与客户的联系网络，深入临床，加强交流，不断研发 出创新设备，改善产品质量，打造更高价值的产品。我们力争不断创造价值，超越期 望，成为客户必不可少的合作伙伴。 ', 'https://omo-oss-image.thefastimg.com/portal-saas/n…2f4193-dd76-497f-98f0-0ff8162c1b9e.png_290xaf.png', 'http://www.betterwayfs.com/', '0757-81265651', '佛山市南海区狮山镇罗村朗沙广东新光源产业园区内D区7栋3层304单元工业厂房', '李先生', 1, 1, 0, 'zh-CN', '2023-03-23 14:59:06', '2023-03-23 14:59:10');
INSERT INTO `ext_cmpy_meta_zh` VALUES (2, 0, 'Betterway Medical ', 'Foshan Betterway Medical Technology Co., Ltd', 'FOSHAN BETTERWAY MEDICAL TECHNOLOGY CO., LTD. focuses on the design, R & D and technology output of dental small equipment products, integrating production, sales and service. It is an innovative enterprise to meet the needs of customers in the new era.\nThe core R & D team of the company is composed of very experienced engineers , they are professional and have the leading technical level in root canal products and dental area. The company attaches importance to the innovation and independent intellectual property rights of products that keep pace with the times, and is committed to launching ingenious products to meet the increasing needs of users with the development of the times and the continuous improvement of medical level. At present, the main products include Endo motor, Apex Locator, Electric Motor, etc.\nSince its establishment, the company has taken quality as the cornerstone of its business, the needs of customers as the direction of struggle, and innovation as the driving force of product innovation. The company always adheres to the scientific and rigorous road of product research and innovation, through scientific method demonstration and rigorous process control, to ensure that the product quality and performance fully meet the expectations of customers. \n', 'https://omo-oss-image.thefastimg.com/portal-saas/n…2f4193-dd76-497f-98f0-0ff8162c1b9e.png_290xaf.png', 'http://en.betterwayfs.com/', '+86 0757-81265651', 'Unit 304, 3/F, Building 7, Guangdong New Light Source Industrial Park, Langsha Village, Shishan Town, Nanhai District, Foshan', NULL, 1, 1, 0, 'en', NULL, NULL);
COMMIT;

-- ----------------------------
-- Table structure for ext_company
-- ----------------------------
DROP TABLE IF EXISTS `ext_company`;
CREATE TABLE `ext_company` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `parent_id` bigint DEFAULT '0' COMMENT '上级公司',
  `cmpy_simple_name` varchar(128) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '公司简称',
  `cmpy_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '公司全称',
  `cmpy_desc` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '公司描述',
  `cmpy_logo` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '公司logo',
  `cmpy_website` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '公司网站',
  `cmpy_phone` varchar(32) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '联系电话',
  `cmpy_addr` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '公司地址',
  `cmpy_leader` varchar(32) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '公司负责人',
  `status` tinyint DEFAULT '1' COMMENT '0，禁用，1启用',
  `sort_num` int DEFAULT '0' COMMENT '排序',
  `created` datetime DEFAULT NULL,
  `updated` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='公司表';

-- ----------------------------
-- Records of ext_company
-- ----------------------------
BEGIN;
INSERT INTO `ext_company` VALUES (1, 0, '知行医疗', '佛山知行医疗科技有限公司', '佛山市知行医疗科技有限公司（品牌名Betterway）是一家集研发、生产、销售于一体，专注齿科小设备的生产销售型企业,致力于为全球口腔市场提供品质卓越的产品。', 'https://omo-oss-image.thefastimg.com/portal-saas/n…2f4193-dd76-497f-98f0-0ff8162c1b9e.png_290xaf.png', 'http://www.betterwayfs.com/', '0757-81265651', '佛山市南海区狮山镇罗村朗沙广东新光源产业园区内D区7栋3层304单元工业厂房', NULL, 1, 0, '2023-03-21 14:43:49', '2023-03-21 14:43:52');
INSERT INTO `ext_company` VALUES (2, 0, '杰瑞医疗', '佛山杰瑞医疗器械有限公司', '佛山杰瑞医疗器械有限公司是一家专业生产牙科医疗器械的公司', NULL, NULL, '', '佛山市南海', '', 1, 0, NULL, NULL);
COMMIT;

-- ----------------------------
-- Table structure for ext_company_media
-- ----------------------------
DROP TABLE IF EXISTS `ext_company_media`;
CREATE TABLE `ext_company_media` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `create_user_id` bigint DEFAULT NULL,
  `banner_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '文件名称',
  `banner_url` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'pdf访问路径',
  `jump_url` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '跳转地址',
  `sort_num` int DEFAULT '0' COMMENT '排序',
  `icon` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '图标',
  `cmpy_id` bigint DEFAULT NULL COMMENT '公司id',
  `lang` char(10) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'zh,en',
  `resource_type` char(2) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '0=pic,1=video',
  `video_cover_url` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '视频显示封面',
  `created` datetime DEFAULT NULL,
  `updated` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='公司banner';

-- ----------------------------
-- Records of ext_company_media
-- ----------------------------
BEGIN;
INSERT INTO `ext_company_media` VALUES (1, NULL, '根测', 'https://omo-oss-image.thefastimg.com/portal-saas/new2022081609323154761/cms/image/526b60ea-ecc5-4908-907a-25a0c943aa28.png', NULL, 0, NULL, 1, 'zh-CN', '0', NULL, NULL, NULL);
INSERT INTO `ext_company_media` VALUES (2, NULL, '公司', 'https://omo-oss-image.thefastimg.com/portal-saas/new2022081609323154761/cms/image/526b60ea-ecc5-4908-907a-25a0c943aa28.png', NULL, 0, NULL, 1, 'zh-CN', '0', NULL, NULL, NULL);
INSERT INTO `ext_company_media` VALUES (3, NULL, '根测介绍视频', 'https://omo-oss-video.thefastvideo.com/portal-saas/new2022081609323068449/cms/vedio/6ca01c94-bf85-4d26-8779-bc905c679343.mp4', NULL, 0, NULL, 1, 'zh-CN', '1', 'https://omo-oss-image.thefastimg.com/portal-saas/n…ms/image/646fee08-5e3a-475f-8b92-d62f7979b514.png', NULL, NULL);
COMMIT;

-- ----------------------------
-- Table structure for ext_prod
-- ----------------------------
DROP TABLE IF EXISTS `ext_prod`;
CREATE TABLE `ext_prod` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `create_user_id` bigint DEFAULT NULL,
  `title_zh` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '产品名称',
  `title_en` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '产品英文',
  `prod_mode` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '产品型号',
  `sort_num` int DEFAULT '0' COMMENT '排序',
  `icon` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT ' 产品图片',
  `meta_zh` bigint DEFAULT NULL COMMENT '产品详情元数据',
  `meta_en` bigint DEFAULT NULL COMMENT '产品详情',
  `cmpy_id` bigint DEFAULT NULL COMMENT ' 公司id',
  `category_id` bigint DEFAULT NULL COMMENT '产品分类id',
  `hot_sale` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '0，非热，1热销',
  `created` datetime DEFAULT NULL,
  `show_flag` varchar(6) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT 'Y' COMMENT '显示Y,不显示N',
  `updated` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='产品表';

-- ----------------------------
-- Records of ext_prod
-- ----------------------------
BEGIN;
INSERT INTO `ext_prod` VALUES (1, NULL, 'EP Smart根管预备机', NULL, 'EP Smart', 1, 'https://omo-oss-image.thefastimg.com/portal-saas/new2022081609323154761/cms/image/dc8e55a3-9afb-4786-8862-ff75ac31cc22.png', NULL, NULL, 1, 1, '1', NULL, 'Y', NULL);
INSERT INTO `ext_prod` VALUES (2, NULL, 'ProPex根管长度测量仪', NULL, 'ProPex', 1, 'https://omo-oss-image.thefastimg.com/portal-saas/new2022081609323154761/cms/image/b558014a-6839-4dc3-a4bc-45a926e141bb.png', NULL, NULL, 1, 2, '1', NULL, 'Y', NULL);
INSERT INTO `ext_prod` VALUES (4, NULL, 'EP Pro 无刷根管预备机', NULL, 'EP Pro ', 2, 'https://omo-oss-image.thefastimg.com/portal-saas/new2022081609323154761/cms/image/dc8e55a3-9afb-4786-8862-ff75ac31cc22.png', NULL, NULL, 1, 1, '1', NULL, 'Y', NULL);
INSERT INTO `ext_prod` VALUES (5, NULL, 'Endo Smart Ⅱ根管预备机', NULL, 'Endo Smart Ⅱ', 3, 'https://omo-oss-image.thefastimg.com/portal-saas/new2022081609323154761/cms/image/501d981a-bc38-46f7-990c-f05b244ebc44.png', NULL, NULL, 1, 1, '1', NULL, 'Y', NULL);
INSERT INTO `ext_prod` VALUES (7, NULL, 'C25 光固化机', NULL, 'C25', 2, 'https://omo-oss-image.thefastimg.com/portal-saas/new2022081609323154761/cms/image/6d0da3c2-d614-4b24-b6b9-ea073493069e.png', NULL, NULL, 1, 3, '1', NULL, 'Y', NULL);
INSERT INTO `ext_prod` VALUES (8, NULL, '测试产品', 'test', 'T-model2', 1, 'http://localhost:8080/attachment/20230423/af2b7c60c2d343e3afc14bfd499cf18a.png', NULL, NULL, 2, 6, '1', '2023-04-20 15:49:16', 'N', '2023-07-27 09:38:56');
COMMIT;

-- ----------------------------
-- Table structure for ext_prod_banner
-- ----------------------------
DROP TABLE IF EXISTS `ext_prod_banner`;
CREATE TABLE `ext_prod_banner` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `create_user_id` bigint DEFAULT NULL,
  `category_id` bigint DEFAULT NULL COMMENT '产品分类',
  `prod_id` bigint DEFAULT '0' COMMENT '产品id',
  `banner_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '文件名称',
  `banner_url` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'pdf访问路径',
  `jump_url` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '跳转地址',
  `sort_num` int DEFAULT '0' COMMENT '排序',
  `icon` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'pdf图标',
  `cmpy_id` bigint NOT NULL COMMENT '公司id',
  `lang` char(10) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'zh,en',
  `banner_model` char(255) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '0=home,1=detail',
  `created` datetime DEFAULT NULL,
  `updated` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='产品分类';

-- ----------------------------
-- Records of ext_prod_banner
-- ----------------------------
BEGIN;
INSERT INTO `ext_prod_banner` VALUES (1, NULL, 3, 7, 'C25 Plus光固化机', 'https://omo-oss-image.thefastimg.com/portal-saas/new2022081609323154761/cms/image/526b60ea-ecc5-4908-907a-25a0c943aa28.png', '1', 1, NULL, 1, 'zh-CN', '1', NULL, NULL);
INSERT INTO `ext_prod_banner` VALUES (2, NULL, 3, 3, 'C25 Plus', 'https://omo-oss-image.thefastimg.com/portal-saas/new2022081609323154761/cms/image/526b60ea-ecc5-4908-907a-25a0c943aa28.png', '2', 2, NULL, 1, 'zh-CN', '1', NULL, NULL);
INSERT INTO `ext_prod_banner` VALUES (3, NULL, 3, 3, 'C25 Plus', 'https://omo-oss-image.thefastimg.com/portal-saas/new2022081609323154761/cms/image/af8768a0-adbd-4c2d-b0af-ff4bd99f9943.png_1920xaf.png', '3', 1, NULL, 1, 'zh-CN', '0', NULL, NULL);
INSERT INTO `ext_prod_banner` VALUES (4, NULL, 3, 7, 'C25 Plus光固化机', 'https://omo-oss-image.thefastimg.com/portal-saas/new2022081609323154761/cms/image/16f470a6-3807-4f8b-a42c-7c93a9fb6941.png_1920xaf.png', '4', 2, NULL, 1, 'zh-CN', '0', NULL, NULL);
INSERT INTO `ext_prod_banner` VALUES (5, NULL, 1, 1, 'EP Smart根管预备机', 'https://omo-oss-image.thefastimg.com/portal-saas/new2022081609323154761/cms/image/59f1e3b5-82d8-40e6-b7da-84e9a0ea8c3c.png_1920xaf.png', '5', 1, NULL, 1, 'zh-CN', '1', NULL, NULL);
INSERT INTO `ext_prod_banner` VALUES (6, NULL, 1, 1, 'EP Smart根管预备机', 'https://omo-oss-image.thefastimg.com/portal-saas/new2022081609323154761/cms/image/af8768a0-adbd-4c2d-b0af-ff4bd99f9943.png_1920xaf.png', '6', 2, NULL, 1, 'zh-CN', '0', NULL, NULL);
INSERT INTO `ext_prod_banner` VALUES (7, NULL, 2, 2, 'ProPex根管长度测量仪', 'https://omo-oss-image.thefastimg.com/portal-saas/new2022081609323154761/cms/image/16f470a6-3807-4f8b-a42c-7c93a9fb6941.png_1920xaf.png', '7', 1, NULL, 1, 'zh-CN', '1', NULL, NULL);
INSERT INTO `ext_prod_banner` VALUES (9, NULL, 1, 5, 'Endo Smart Ⅱ根管预备机', 'https://omo-oss-image.thefastimg.com/portal-saas/new2022081609323154761/cms/image/017072d7-fbd5-4075-add1-411ff91fe92e.png_1920xaf.png', '9', 1, NULL, 1, 'zh-CN', '1', NULL, NULL);
INSERT INTO `ext_prod_banner` VALUES (10, NULL, 2, 2, 'ProPex根管长度测量仪', 'https://omo-oss-image.thefastimg.com/portal-saas/new2022081609323154761/cms/image/16f470a6-3807-4f8b-a42c-7c93a9fb6941.png_1920xaf.png', '10', 1, NULL, 1, 'zh-CN', '0', NULL, NULL);
INSERT INTO `ext_prod_banner` VALUES (11, NULL, 1, 5, 'Endo Smart Ⅱ根管预备机', 'https://omo-oss-image.thefastimg.com/portal-saas/new2022081609323154761/cms/image/017072d7-fbd5-4075-add1-411ff91fe92e.png_1920xaf.png', '11', 1, NULL, 1, 'zh-CN', '0', NULL, NULL);
INSERT INTO `ext_prod_banner` VALUES (12, NULL, 1, 4, 'EP Pro 无刷根管预备机', 'https://omo-oss-image.thefastimg.com/portal-saas/new2022081609323154761/cms/image/af8768a0-adbd-4c2d-b0af-ff4bd99f9943.png_1920xaf.png', '12', 1, NULL, 1, 'zh-CN', '1', NULL, NULL);
COMMIT;

-- ----------------------------
-- Table structure for ext_prod_category
-- ----------------------------
DROP TABLE IF EXISTS `ext_prod_category`;
CREATE TABLE `ext_prod_category` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `create_user_id` bigint DEFAULT NULL,
  `parent_id` bigint DEFAULT '0' COMMENT '上级分类id',
  `title_zh` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '产品分类名称',
  `title_en` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '产品分类英文',
  `sort_num` int DEFAULT '0' COMMENT '排序',
  `icon_zh` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '分类图片',
  `icon_en` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `banner_zh` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `banner_en` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `cmpy_id` bigint DEFAULT NULL COMMENT '公司id',
  `has_top` tinyint DEFAULT NULL COMMENT '0，非，1置顶',
  `created` datetime DEFAULT NULL,
  `show_flag` varchar(6) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT 'Y' COMMENT '显示Y,不显示N',
  `updated` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='产品分类';

-- ----------------------------
-- Records of ext_prod_category
-- ----------------------------
BEGIN;
INSERT INTO `ext_prod_category` VALUES (1, NULL, 0, '根管预备机', NULL, 1, 'https://omo-oss-image.thefastimg.com/portal-saas/new2022081609323154761/cms/image/5367817b-b8a4-40b5-a54d-654d80530160.png', NULL, 'https://omo-oss-image.thefastimg.com/portal-saas/new2022081609323154761/cms/image/af8768a0-adbd-4c2d-b0af-ff4bd99f9943.png_1920xaf.png', NULL, 1, 1, '2023-03-23 14:40:10', 'Y', '2023-03-23 14:40:14');
INSERT INTO `ext_prod_category` VALUES (2, NULL, 0, '牙根尖定位', NULL, 0, 'https://omo-oss-image.thefastimg.com/portal-saas/new2022081609323154761/cms/image/b558014a-6839-4dc3-a4bc-45a926e141bb.png', NULL, 'https://omo-oss-image.thefastimg.com/portal-saas/new2022081609323154761/cms/image/16f470a6-3807-4f8b-a42c-7c93a9fb6941.png_1920xaf.png', NULL, 1, 1, NULL, 'Y', NULL);
INSERT INTO `ext_prod_category` VALUES (3, NULL, 0, '光固化', NULL, 0, 'https://omo-oss-image.thefastimg.com/portal-saas/new2022081609323154761/cms/image/3e4c0317-bcc9-4c85-9f7c-2b7c0d076af9.png', NULL, 'https://omo-oss-image.thefastimg.com/portal-saas/new2022081609323154761/cms/image/526b60ea-ecc5-4908-907a-25a0c943aa28.png', NULL, 1, 1, NULL, 'Y', NULL);
INSERT INTO `ext_prod_category` VALUES (4, NULL, 0, '热熔牙胶系统', NULL, 0, '', NULL, '', NULL, 1, 1, NULL, 'Y', NULL);
INSERT INTO `ext_prod_category` VALUES (5, NULL, 0, '电动马达', NULL, 0, '', NULL, 'http://192.168.2.5:8080/attachment/20230417/5fb469abbcd24b4fae304d19b7678507.png', 'http://192.168.2.5:8080/attachment/20230417/f0a2551815c94fc59cd3e1b8452b8ca4.png', 1, 0, NULL, 'Y', NULL);
INSERT INTO `ext_prod_category` VALUES (6, NULL, 0, '光固化', '', 1, 'http://192.168.2.5:8080/attachment/20230417/cb021ab37281463290692800e22ac3a6.png', 'http://192.168.2.5:8080/attachment/20230417/75e7ca6e719846aca39d19c843387321.png', 'https://omo-oss-image.thefastimg.com/portal-saas/new2022081609323154761/cms/image/526b60ea-ecc5-4908-907a-25a0c943aa28.png', NULL, 2, 1, NULL, 'Y', NULL);
COMMIT;

-- ----------------------------
-- Table structure for ext_prod_meta_en
-- ----------------------------
DROP TABLE IF EXISTS `ext_prod_meta_en`;
CREATE TABLE `ext_prod_meta_en` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `create_user_id` bigint DEFAULT NULL,
  `prod_id` bigint DEFAULT '0' COMMENT '产品id',
  `category_id` bigint DEFAULT NULL COMMENT '产品分类id',
  `banner_pic` json NOT NULL COMMENT 'banner图片json数组',
  `prod_pic` json DEFAULT NULL COMMENT '产品图片json数组',
  `prod_desc` longtext COLLATE utf8mb4_unicode_ci COMMENT ' 产品描述',
  `prod_args` text COLLATE utf8mb4_unicode_ci COMMENT '产品技术参数',
  `prod_pdf` bigint DEFAULT NULL COMMENT '产品pdf手册id,备用',
  `created` datetime DEFAULT NULL,
  `updated` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='产品详情表';

-- ----------------------------
-- Table structure for ext_prod_meta_zh
-- ----------------------------
DROP TABLE IF EXISTS `ext_prod_meta_zh`;
CREATE TABLE `ext_prod_meta_zh` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `create_user_id` bigint DEFAULT NULL,
  `prod_id` bigint DEFAULT '0' COMMENT '产品id',
  `title` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '产品名称',
  `icon` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '产品图片',
  `category_id` bigint DEFAULT NULL COMMENT '产品分类id',
  `prod_desc` longtext COLLATE utf8mb4_unicode_ci COMMENT ' 产品描述',
  `prod_args` text COLLATE utf8mb4_unicode_ci COMMENT '产品技术参数',
  `cmpy_id` bigint DEFAULT NULL,
  `lang` char(10) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'zh,en',
  `created` datetime DEFAULT NULL,
  `updated` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='产品详情表';

-- ----------------------------
-- Records of ext_prod_meta_zh
-- ----------------------------
BEGIN;
INSERT INTO `ext_prod_meta_zh` VALUES (1, NULL, 1, 'EP Smart根管预备机', 'https://omo-oss-image.thefastimg.com/portal-saas/new2022081609323154761/cms/image/dc8e55a3-9afb-4786-8862-ff75ac31cc22.png', 1, 'EP Smart根管预备机', '电源适配器：AC100-240V</br>锂 电 池：3.7V/1900mAh</br>\n扭 矩：0.6N.cm~4.0N.cm</br>转 速：120r/min~650r/min</br>往返角度：30，60，90，150，180，210，250，370</br>屏  幕：0.96英寸TFT彩色液晶', 1, 'zh-CN', NULL, NULL);
INSERT INTO `ext_prod_meta_zh` VALUES (2, NULL, 2, 'ProPex根管长度测量仪', 'https://omo-oss-image.thefastimg.com/portal-saas/new2022081609323154761/cms/image/dc8e55a3-9afb-4786-8862-ff75ac31cc22.png', 2, 'EP Smart根管预备机', '屏幕尺寸：4.0英寸</br>电源适配器：AC100-240V,50/60Hz</br>电池：ICR14500 3.7V/800mAh</br>\n输入功率：5VA</br>', 1, 'zh-CN', NULL, NULL);
INSERT INTO `ext_prod_meta_zh` VALUES (4, NULL, 4, 'EP Pro 无刷根管预备机', 'https://omo-oss-image.thefastimg.com/portal-saas/new2022081609323154761/cms/image/dc8e55a3-9afb-4786-8862-ff75ac31cc22.png', 1, 'EP Pro 无刷根管预备机', '电源适配器：AC100-240V</br>锂电池：3.7V/1900mAh</br>\n扭矩：0.6N.cm~4.0N.cm</br>', 1, 'zh-CN', NULL, NULL);
INSERT INTO `ext_prod_meta_zh` VALUES (5, NULL, 5, 'Endo Smart Ⅱ根管预备机', 'https://omo-oss-image.thefastimg.com/portal-saas/new2022081609323154761/cms/image/501d981a-bc38-46f7-990c-f05b244ebc44.png', 1, 'Endo Smart Ⅱ根管预备机', '电源适配器：AC100-240V</br>锂电池：3.7V/1900mAh</br>\n扭矩：0.6N.cm~4.0N.cm</br>', 1, 'zh-CN', NULL, NULL);
INSERT INTO `ext_prod_meta_zh` VALUES (7, NULL, 7, 'C25 光固化机', 'https://omo-oss-image.thefastimg.com/portal-saas/new2022081609323154761/cms/image/6d0da3c2-d614-4b24-b6b9-ea073493069e.png', 3, 'C25 光固化机', '电源适配器：AC100-240V</br>锂电池：3.7V/1900mAh</br>\n扭矩：0.6N.cm~4.0N.cm</br>', 1, 'zh-CN', NULL, NULL);
INSERT INTO `ext_prod_meta_zh` VALUES (13, NULL, 8, 'test', '', 6, '什么也没留下', '什么也没留下', NULL, 'en', '2023-04-21 08:42:52', NULL);
COMMIT;

-- ----------------------------
-- Table structure for ext_prod_pdf
-- ----------------------------
DROP TABLE IF EXISTS `ext_prod_pdf`;
CREATE TABLE `ext_prod_pdf` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `create_user_id` bigint DEFAULT NULL,
  `category_id` bigint NOT NULL COMMENT '产品分类',
  `prod_id` bigint NOT NULL DEFAULT '0' COMMENT '产品id',
  `pdf_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '文件名称',
  `pdf_url` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'pdf访问路径',
  `sort_num` int DEFAULT '0' COMMENT '排序',
  `icon` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'pdf图标',
  `cmpy_id` bigint DEFAULT NULL COMMENT '公司id',
  `lang` char(10) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'zh,en',
  `created` datetime DEFAULT NULL,
  `updated` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='产品分类';

-- ----------------------------
-- Records of ext_prod_pdf
-- ----------------------------
BEGIN;
INSERT INTO `ext_prod_pdf` VALUES (2, NULL, 1, 1, 'EP Smart根管预备机', 'https://omo-oss-image.thefastimg.com/portal-saas/new2022081609323154761/cms/image/dc8e55a3-9afb-4786-8862-ff75ac31cc22.png', 1, NULL, 1, 'zh-CN', NULL, NULL);
INSERT INTO `ext_prod_pdf` VALUES (3, NULL, 1, 2, 'ProPex根管长度测量仪', 'https://omo-oss-image.thefastimg.com/portal-saas/new2022081609323154761/cms/image/b558014a-6839-4dc3-a4bc-45a926e141bb.png', 1, NULL, 1, 'zh-CN', NULL, NULL);
INSERT INTO `ext_prod_pdf` VALUES (4, NULL, 1, 4, 'EP Pro 无刷根管预备机', 'https://omo-oss-image.thefastimg.com/portal-saas/new2022081609323154761/cms/image/dc8e55a3-9afb-4786-8862-ff75ac31cc22.png', 1, NULL, 1, 'zh-CN', NULL, NULL);
INSERT INTO `ext_prod_pdf` VALUES (5, NULL, 1, 5, 'Endo Smart Ⅱ根管预备机', 'https://omo-oss-image.thefastimg.com/portal-saas/new2022081609323154761/cms/image/501d981a-bc38-46f7-990c-f05b244ebc44.png', 1, NULL, 1, 'zh-CN', NULL, NULL);
COMMIT;

-- ----------------------------
-- Table structure for ext_prod_pic
-- ----------------------------
DROP TABLE IF EXISTS `ext_prod_pic`;
CREATE TABLE `ext_prod_pic` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `create_user_id` bigint DEFAULT NULL,
  `category_id` bigint NOT NULL COMMENT '产品分类',
  `prod_id` bigint NOT NULL DEFAULT '0' COMMENT '产品id',
  `pic_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '文件名称',
  `pic_url` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '访问路径',
  `sort_num` int DEFAULT '0' COMMENT '排序',
  `icon` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '图标',
  `cmpy_id` bigint DEFAULT NULL COMMENT '公司id',
  `lang` char(10) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'zh,en',
  `pic_type` int unsigned DEFAULT '0' COMMENT '0=产品详情，1=产品主图，2=产品营销图',
  `created` datetime DEFAULT NULL,
  `updated` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=35 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='产品分类';

-- ----------------------------
-- Records of ext_prod_pic
-- ----------------------------
BEGIN;
INSERT INTO `ext_prod_pic` VALUES (4, NULL, 1, 4, 'EP Pro无刷根管预备机', 'https://omo-oss-image.thefastimg.com/portal-saas/new2022081609323154761/cms/image/d82d81ad-2787-4b43-96d2-7b3edafeb579.jpg', 1, 'https://omo-oss-image.thefastimg.com/portal-saas/new2022081609323154761/cms/image/dc8e55a3-9afb-4786-8862-ff75ac31cc22.png', 1, 'zh-CN', 0, NULL, NULL);
INSERT INTO `ext_prod_pic` VALUES (5, NULL, 1, 4, 'EP Pro无刷根管预备机', 'https://omo-oss-image.thefastimg.com/portal-saas/new2022081609323154761/cms/image/f6097927-0d54-4ecc-8034-4ad7b46a97d5.jpg', 2, 'https://omo-oss-image.thefastimg.com/portal-saas/new2022081609323154761/cms/image/dc8e55a3-9afb-4786-8862-ff75ac31cc22.png', 1, 'zh-CN', 0, NULL, NULL);
INSERT INTO `ext_prod_pic` VALUES (6, NULL, 1, 4, 'EP Pro无刷根管预备机', 'https://omo-oss-image.thefastimg.com/portal-saas/new2022081609323154761/cms/image/a4f94f93-cd0c-4aab-ae7d-28377910e5c5.jpg', 3, 'https://omo-oss-image.thefastimg.com/portal-saas/new2022081609323154761/cms/image/dc8e55a3-9afb-4786-8862-ff75ac31cc22.png', 1, 'zh-CN', 0, NULL, NULL);
INSERT INTO `ext_prod_pic` VALUES (7, NULL, 1, 4, 'EP Pro无刷根管预备机', 'https://omo-oss-image.thefastimg.com/portal-saas/new2022081609323154761/cms/image/271d6b20-0f32-4e3b-aa20-3684e764950c.jpg', 4, 'https://omo-oss-image.thefastimg.com/portal-saas/new2022081609323154761/cms/image/dc8e55a3-9afb-4786-8862-ff75ac31cc22.png', 1, 'zh-CN', 0, NULL, NULL);
INSERT INTO `ext_prod_pic` VALUES (9, NULL, 1, 4, 'EP Pro无刷根管预备机', 'https://omo-oss-image.thefastimg.com/portal-saas/new2022081609323154761/cms/image/b5fb24fe-3a91-48a6-8767-6dca51183e43.jpg', 6, 'https://omo-oss-image.thefastimg.com/portal-saas/new2022081609323154761/cms/image/dc8e55a3-9afb-4786-8862-ff75ac31cc22.png', 1, 'zh-CN', 0, NULL, NULL);
INSERT INTO `ext_prod_pic` VALUES (10, NULL, 1, 4, 'EP Pro无刷根管预备机', 'https://omo-oss-image.thefastimg.com/portal-saas/new2022081609323154761/cms/image/41ad045c-b0f9-4bd1-a41d-859b8f8d550f.jpg', 7, 'https://omo-oss-image.thefastimg.com/portal-saas/new2022081609323154761/cms/image/dc8e55a3-9afb-4786-8862-ff75ac31cc22.png', 1, 'zh-CN', 0, NULL, NULL);
INSERT INTO `ext_prod_pic` VALUES (11, NULL, 1, 4, 'EP Pro无刷根管预备机', 'https://omo-oss-image.thefastimg.com/portal-saas/new2022081609323154761/cms/image/dc8e55a3-9afb-4786-8862-ff75ac31cc22.png', 1, 'https://omo-oss-image.thefastimg.com/portal-saas/new2022081609323154761/cms/image/dc8e55a3-9afb-4786-8862-ff75ac31cc22.png', 1, 'zh-CN', 1, NULL, '2023-04-23 12:32:56');
INSERT INTO `ext_prod_pic` VALUES (14, NULL, 1, 1, 'EP Smart根管预备机', 'https://omo-oss-image.thefastimg.com/portal-saas/new2022081609323154761/cms/image/5367817b-b8a4-40b5-a54d-654d80530160.png', 1, 'https://omo-oss-image.thefastimg.com/portal-saas/new2022081609323154761/cms/image/5367817b-b8a4-40b5-a54d-654d80530160.png', 1, 'zh-CN', 1, NULL, NULL);
INSERT INTO `ext_prod_pic` VALUES (15, NULL, 1, 1, 'EP Smart根管预备机', 'https://omo-oss-image.thefastimg.com/portal-saas/new2022081609323154761/cms/image/d82d81ad-2787-4b43-96d2-7b3edafeb579.jpg', 1, 'https://omo-oss-image.thefastimg.com/portal-saas/new2022081609323154761/cms/image/5367817b-b8a4-40b5-a54d-654d80530160.png', 1, 'zh-CN', 0, NULL, NULL);
INSERT INTO `ext_prod_pic` VALUES (16, NULL, 1, 1, 'EP Smart根管预备机', 'https://omo-oss-image.thefastimg.com/portal-saas/new2022081609323154761/cms/image/f6097927-0d54-4ecc-8034-4ad7b46a97d5.jpg', 2, NULL, 1, 'zh-CN', 0, NULL, NULL);
INSERT INTO `ext_prod_pic` VALUES (17, NULL, 1, 1, 'EP Smart根管预备机', 'https://omo-oss-image.thefastimg.com/portal-saas/new2022081609323154761/cms/image/a4f94f93-cd0c-4aab-ae7d-28377910e5c5.jpg', 3, NULL, 1, 'zh-CN', 0, NULL, NULL);
INSERT INTO `ext_prod_pic` VALUES (18, NULL, 1, 1, 'EP Smart根管预备机', 'https://omo-oss-image.thefastimg.com/portal-saas/new2022081609323154761/cms/image/deae5f0f-5d9d-46f2-aee2-c721477ab962.jpg', 4, NULL, 1, 'zh-CN', 0, NULL, NULL);
INSERT INTO `ext_prod_pic` VALUES (19, NULL, 1, 5, 'Endo Smart Ⅱ根管预备机', 'https://omo-oss-image.thefastimg.com/portal-saas/new2022081609323154761/cms/image/501d981a-bc38-46f7-990c-f05b244ebc44.png', 1, NULL, 1, 'zh-CN', 1, NULL, NULL);
INSERT INTO `ext_prod_pic` VALUES (20, NULL, 1, 5, 'Endo Smart Ⅱ根管预备机', 'https://omo-oss-image.thefastimg.com/portal-saas/new2022081609323154761/cms/image/6531639f-d629-41a3-862d-83a696837d07.jpg', 1, NULL, 1, 'zh-CN', 0, NULL, NULL);
INSERT INTO `ext_prod_pic` VALUES (21, NULL, 1, 5, 'Endo Smart Ⅱ根管预备机', 'https://omo-oss-image.thefastimg.com/portal-saas/new2022081609323154761/cms/image/9573d307-1e0d-4f90-b2b2-378e991bd475.jpg', 2, NULL, 1, 'zh-CN', 0, NULL, NULL);
INSERT INTO `ext_prod_pic` VALUES (22, NULL, 1, 5, 'Endo Smart Ⅱ根管预备机', 'https://omo-oss-image.thefastimg.com/portal-saas/new2022081609323154761/cms/image/630009b5-ca7f-45f4-9601-3c2fbec19391.jpg', 3, NULL, 1, 'zh-CN', 0, NULL, NULL);
INSERT INTO `ext_prod_pic` VALUES (23, NULL, 1, 5, 'Endo Smart Ⅱ根管预备机', 'https://omo-oss-image.thefastimg.com/portal-saas/new2022081609323154761/cms/image/e77ae3e5-cd9f-4f96-bb6c-2c616e2a377a.jpg', 4, NULL, 1, 'zh-CN', 0, NULL, NULL);
INSERT INTO `ext_prod_pic` VALUES (24, NULL, 1, 5, 'Endo Smart Ⅱ根管预备机', 'https://omo-oss-image.thefastimg.com/portal-saas/new2022081609323154761/cms/image/51cbbcb0-9192-48b2-877d-fbdd62cbabdc.jpg', 5, NULL, 1, 'zh-CN', 0, NULL, NULL);
INSERT INTO `ext_prod_pic` VALUES (25, NULL, 2, 2, 'ProPex根管长度测量仪', 'https://omo-oss-image.thefastimg.com/portal-saas/new2022081609323154761/cms/image/b558014a-6839-4dc3-a4bc-45a926e141bb.png', 1, NULL, 1, 'zh-CN', 1, NULL, NULL);
INSERT INTO `ext_prod_pic` VALUES (26, NULL, 2, 2, 'ProPex根管长度测量仪', 'https://omo-oss-image.thefastimg.com/portal-saas/new2022081609323154761/cms/image/41d5f7b5-4e1b-42ef-976a-413d46703280.jpg', 1, NULL, 1, 'zh-CN', 0, NULL, NULL);
INSERT INTO `ext_prod_pic` VALUES (27, NULL, 2, 2, 'ProPex根管长度测量仪', 'https://omo-oss-image.thefastimg.com/portal-saas/new2022081609323154761/cms/image/ddd515ce-25df-4a75-af8f-42c49b2f1f2c.jpg', 2, NULL, 1, 'zh-CN', 0, NULL, NULL);
INSERT INTO `ext_prod_pic` VALUES (28, NULL, 2, 2, 'ProPex根管长度测量仪', 'https://omo-oss-image.thefastimg.com/portal-saas/new2022081609323154761/cms/image/009930fa-e2d8-44e3-99a6-210b0a3e414a.jpg', 3, NULL, 1, 'zh-CN', 0, NULL, NULL);
INSERT INTO `ext_prod_pic` VALUES (29, NULL, 2, 2, 'ProPex根管长度测量仪', 'https://omo-oss-image.thefastimg.com/portal-saas/new2022081609323154761/cms/image/51c6f281-260b-4bc5-a150-838c0767df26.jpg', 4, NULL, 2, 'zh-CN', 0, NULL, NULL);
INSERT INTO `ext_prod_pic` VALUES (30, NULL, 2, 2, 'ProPex根管长度测量仪', 'https://omo-oss-image.thefastimg.com/portal-saas/new2022081609323154761/cms/image/d5306d3e-a37e-4099-b037-269c5aa0f12a.jpg', 5, NULL, 1, 'zh-CN', 0, NULL, NULL);
INSERT INTO `ext_prod_pic` VALUES (31, NULL, 3, 7, 'C25 光固化机', 'https://omo-oss-image.thefastimg.com/portal-saas/new2022081609323154761/cms/image/6d0da3c2-d614-4b24-b6b9-ea073493069e.png', 1, NULL, 1, 'zh-CN', 1, NULL, NULL);
INSERT INTO `ext_prod_pic` VALUES (32, NULL, 3, 7, 'C25 光固化机', 'https://omo-oss-image.thefastimg.com/portal-saas/new2022081609323154761/cms/image/1a00c2f7-7112-48bf-9259-421764b3febe.jpg', 1, NULL, 1, 'zh-CN', 0, NULL, NULL);
INSERT INTO `ext_prod_pic` VALUES (33, NULL, 3, 7, 'C25 光固化机', 'https://omo-oss-image.thefastimg.com/portal-saas/new2022081609323154761/cms/image/b7601da4-6189-49a3-9bb5-351fc0619333.jpg', 2, NULL, 1, 'zh-CN', 0, NULL, NULL);
INSERT INTO `ext_prod_pic` VALUES (34, NULL, 3, 7, 'C25 光固化机', 'https://omo-oss-image.thefastimg.com/portal-saas/new2022081609323154761/cms/image/b8cd9cfc-72fc-45c5-b125-ec5b452a4c22.jpg', 3, NULL, 1, 'zh-CN', 0, NULL, NULL);
COMMIT;

-- ----------------------------
-- Table structure for ext_prod_video
-- ----------------------------
DROP TABLE IF EXISTS `ext_prod_video`;
CREATE TABLE `ext_prod_video` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `create_user_id` bigint DEFAULT NULL,
  `category_id` bigint NOT NULL COMMENT '产品分类',
  `prod_id` bigint NOT NULL DEFAULT '0' COMMENT '产品id',
  `video_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '文件名称',
  `video_url` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'pdf访问路径',
  `video_cover_url` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '视频显示封面',
  `sort_num` int DEFAULT '0' COMMENT '排序',
  `icon` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'pdf图标',
  `cmpy_id` bigint DEFAULT NULL COMMENT '公司id',
  `lang` char(10) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'zh,en',
  `created` datetime DEFAULT NULL,
  `updated` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='产品分类';

-- ----------------------------
-- Records of ext_prod_video
-- ----------------------------
BEGIN;
INSERT INTO `ext_prod_video` VALUES (2, NULL, 1, 1, 'EP Smart根管预备机', 'https://omo-oss-video.thefastvideo.com/portal-saas/new2022081609323154761/cms/vedio/d4fa479b-2eef-42f8-9288-602da92f2c75.mp4', 'https://omo-oss-image.thefastimg.com/portal-saas/new2022081609323154761/cms/image/59f1e3b5-82d8-40e6-b7da-84e9a0ea8c3c.png_1920xaf.png', 1, 'https://omo-oss-image.thefastimg.com/portal-saas/new2022081609323154761/cms/image/59f1e3b5-82d8-40e6-b7da-84e9a0ea8c3c.png_1920xaf.png', 1, 'zh-CN', NULL, NULL);
INSERT INTO `ext_prod_video` VALUES (3, NULL, 1, 5, 'Endo Smart Ⅱ根管预备机', 'https://omo-oss-video.thefastvideo.com/portal-saas/new2022081609323154761/cms/vedio/3bd5a230-321f-4b40-90b5-9a3e3cc5626a.mp4', 'https://omo-oss-image.thefastimg.com/portal-saas/new2022081609323154761/cms/image/017072d7-fbd5-4075-add1-411ff91fe92e.png_1920xaf.png', 1, NULL, 1, 'zh-CN', NULL, NULL);
INSERT INTO `ext_prod_video` VALUES (4, NULL, 1, 4, 'EP Pro 无刷根管预备机', 'https://omo-oss-video.thefastvideo.com/portal-saas/new2022081609323154761/cms/vedio/950bf0ac-3952-4f4b-9386-9dce535e73a3.mp4', 'https://omo-oss-image.thefastimg.com/portal-saas/new2022081609323154761/cms/image/af8768a0-adbd-4c2d-b0af-ff4bd99f9943.png_1920xaf.png', 3, NULL, 1, 'zh-CN', NULL, NULL);
INSERT INTO `ext_prod_video` VALUES (5, NULL, 2, 2, 'ProPex根管长度测量仪', 'https://omo-oss-video.thefastvideo.com/portal-saas/new2022081609323154761/cms/vedio/28344451-e3a7-429f-a5dc-2b32fe06a903.mp4', 'https://omo-oss-image.thefastimg.com/portal-saas/new2022081609323154761/cms/image/16f470a6-3807-4f8b-a42c-7c93a9fb6941.png_1920xaf.png', 1, NULL, 1, 'zh-CN', NULL, NULL);
INSERT INTO `ext_prod_video` VALUES (6, NULL, 3, 7, 'C25 光固化机', 'https://omo-oss-video.thefastvideo.com/portal-saas/new2022081609323154761/cms/vedio/838e4a55-2533-41f5-af9b-b5d259cc30c5.mp4', 'https://omo-oss-image.thefastimg.com/portal-saas/new2022081609323154761/cms/image/16f470a6-3807-4f8b-a42c-7c93a9fb6941.png_1920xaf.png', 1, NULL, 1, 'zh-CN', NULL, NULL);
COMMIT;

-- ----------------------------
-- Table structure for menu
-- ----------------------------
DROP TABLE IF EXISTS `menu`;
CREATE TABLE `menu` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `parent_id` bigint DEFAULT '0',
  `create_user_id` bigint DEFAULT NULL,
  `menu_name` varchar(32) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `menu_url` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `menu_icon` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `sort_num` int DEFAULT '0',
  `target` varchar(32) COLLATE utf8mb4_unicode_ci DEFAULT '_self',
  `status` varchar(32) COLLATE utf8mb4_unicode_ci DEFAULT 'show' COMMENT '显示或隐藏',
  `created` datetime DEFAULT NULL,
  `updated` datetime DEFAULT NULL,
  `url_type` tinyint DEFAULT '0' COMMENT '1，文章，2，页面，3，分类， 4，标签',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='网站菜单表';

-- ----------------------------
-- Records of menu
-- ----------------------------
BEGIN;
INSERT INTO `menu` VALUES (1, 0, 1, '测试分类', 'http://localhost:8080/a/c/1.html', '', 0, '_blank', 'show', '2023-08-04 09:42:02', NULL, 3);
INSERT INTO `menu` VALUES (2, 1, 1, '测试2', 'https://www.greenflash.cn', '', 0, '_blank', 'show', '2023-08-04 09:48:29', NULL, 0);
COMMIT;

-- ----------------------------
-- Table structure for nav_link
-- ----------------------------
DROP TABLE IF EXISTS `nav_link`;
CREATE TABLE `nav_link` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `link_name` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `link_url` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `qrcode` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '博客二维码',
  `link_icon` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `url_type` tinyint DEFAULT '0' COMMENT '1，文章，2，页面，3，分类， 4，标签 5网页链接 6 友情链接',
  `sort_num` int DEFAULT '0',
  `target` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT '_self',
  `status` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT 'show' COMMENT '显示或隐藏',
  `link_desc` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '描述',
  `cat_ids` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '分类',
  `created` datetime DEFAULT NULL,
  `updated` datetime DEFAULT NULL,
  `create_user_id` bigint DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=122 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='网站菜单表';

-- ----------------------------
-- Records of nav_link
-- ----------------------------
BEGIN;
INSERT INTO `nav_link` VALUES (5, '抖音电商平台认知', 'https://school.jinritemai.com/doudian/web/article/105000', '', 'https://lf3-fe.ecombdstatic.com/obj/ecom-cdn-default/ecom/fe-alliance-home/out/favicon.ico', 5, 2, '_blank', 'show', '抖音电商平台认知-视频', '6', '2023-07-25 11:20:07', NULL, 1);
INSERT INTO `nav_link` VALUES (6, '注册及养号', 'https://zhuanlan.zhihu.com/p/645748214', '', 'https://lf3-fe.ecombdstatic.com/obj/ecom-cdn-default/ecom/fe-alliance-home/out/favicon.ico', 5, 1, '_blank', 'show', '注册及养号、网络环境要稳定：稳定IP(其实就是保持网络稳定)', '6', '2023-07-25 11:22:12', NULL, 1);
INSERT INTO `nav_link` VALUES (7, '抖音电商入驻开店', 'https://school.jinritemai.com/doudian/web/shopin', '', 'https://lf3-fe.ecombdstatic.com/obj/ecom-cdn-default/ecom/fe-alliance-home/out/favicon.ico', 5, 3, '_blank', 'show', '', '6', '2023-07-25 11:23:52', '2023-07-25 11:25:51', 1);
INSERT INTO `nav_link` VALUES (8, '什么是企业号', 'https://renzheng.douyin.com/support/content/123472', '', 'https://renzheng.douyin.com/support/backend/file/attachment-thumbnail?attachmentId=561103&mappingId=77&mappingType=8', 5, 1, '_blank', 'show', '企业号是企业商家在抖音做生意的一站式经营平台。为企业商家提供蓝V标识、用户洞察、粉丝触达、转化工具、培训指导等，服务企业更好地经营用户，并通过持续地经营并深化企业与用户的关系，从而实现品牌、销量等商业价值的持续成长。', '7', '2023-07-25 13:14:29', NULL, 1);
INSERT INTO `nav_link` VALUES (9, '企业号认证', 'https://renzheng.douyin.com/site/home', '', 'https://renzheng.douyin.com/support/backend/file/attachment-thumbnail?attachmentId=561103&mappingId=77&mappingType=8', 5, 2, '_blank', 'show', '', '7', '2023-07-25 13:16:09', NULL, 1);
INSERT INTO `nav_link` VALUES (10, '企业号运营', 'https://renzheng.douyin.com/support/content/123767', '', 'https://renzheng.douyin.com/support/backend/file/attachment-thumbnail?attachmentId=561103&mappingId=77&mappingType=8', 5, 1, '_blank', 'show', '企业号运营知识学习途径', '7', '2023-07-25 13:20:22', NULL, 1);
INSERT INTO `nav_link` VALUES (11, '直播环境搭建', 'https://school.jinritemai.com/doudian/web/article/101642', '', 'https://lf3-fe.ecombdstatic.com/obj/ecom-cdn-default/ecom/fe-alliance-home/out/favicon.ico', 5, 1, '_blank', 'show', '直播带货环境搭建及设备讲解', '8', '2023-07-25 13:23:20', NULL, 1);
INSERT INTO `nav_link` VALUES (12, '开通直播带货', 'https://school.jinritemai.com/doudian/web/article/106437', '', 'https://lf3-fe.ecombdstatic.com/obj/ecom-cdn-default/ecom/fe-alliance-home/out/favicon.ico', 5, 1, '_blank', 'show', '如何开通和使用直播带货功能', '8', '2023-07-25 13:25:29', NULL, 1);
INSERT INTO `nav_link` VALUES (13, '购物车加商品', 'https://school.jinritemai.com/doudian/web/article/102057', '', 'https://lf3-fe.ecombdstatic.com/obj/ecom-cdn-default/ecom/fe-alliance-home/out/favicon.ico', 5, 1, '_blank', 'show', '如何往购物车中添加商品', '8', '2023-07-25 13:29:46', NULL, 1);
INSERT INTO `nav_link` VALUES (14, '小黄车挂品开播', 'https://school.jinritemai.com/doudian/web/article/105005', '', 'https://lf3-fe.ecombdstatic.com/obj/ecom-cdn-default/ecom/fe-alliance-home/out/favicon.ico', 5, 1, '_blank', 'show', '新手商家入门宝典丨搞定直播开播', '8', '2023-07-25 13:31:55', NULL, 1);
INSERT INTO `nav_link` VALUES (15, '直播间提人气', 'https://school.jinritemai.com/doudian/web/article/102434', '', 'https://lf3-fe.ecombdstatic.com/obj/ecom-cdn-default/ecom/fe-alliance-home/out/favicon.ico', 5, 1, '_blank', 'show', '直播间人气提示秘籍', '8', '2023-07-25 13:39:42', NULL, 1);
INSERT INTO `nav_link` VALUES (16, '直播伴侣', 'https://streamingtool.douyin.com/', '', 'https://lf1-cdn-tos.bytescm.com/obj/venus/favicon-mate.ico', 5, 1, '_blank', 'show', '直播伴侣已覆盖泛娱乐直播、游戏直播、电商直播、虚拟直播、PICO直播等类型，后续将开放更多直播类型', '9', '2023-07-25 13:42:08', NULL, 1);
INSERT INTO `nav_link` VALUES (17, '直播伴侣使用', 'https://school.jinritemai.com/doudian/web/article/105056', '', 'https://lf1-cdn-tos.bytescm.com/obj/venus/favicon-mate.ico', 5, 2, '_blank', 'show', '直播伴侣已覆盖泛娱乐直播、游戏直播、电商直播、虚拟直播、PICO直播等类型，后续将开放更多直播类型', '9', '2023-07-25 13:43:10', NULL, 1);
INSERT INTO `nav_link` VALUES (18, '直播常用工具', 'https://school.jinritemai.com/doudian/web/article/108031', '', 'https://lf3-fe.ecombdstatic.com/obj/ecom-cdn-default/ecom/fe-alliance-home/out/favicon.ico', 5, 1, '_blank', 'show', '直播间常用工具及使用方法', '9', '2023-07-25 13:47:02', NULL, 1);
INSERT INTO `nav_link` VALUES (19, '直播带货营销攻略', 'https://school.jinritemai.com/doudian/web/article/101891', '', 'https://lf3-fe.ecombdstatic.com/obj/ecom-cdn-default/ecom/fe-alliance-home/out/favicon.ico', 5, 1, '_blank', 'show', '直播带货营销攻略', '10', '2023-07-25 13:50:36', NULL, 1);
INSERT INTO `nav_link` VALUES (20, '直播人设定位', 'https://school.jinritemai.com/doudian/web/article/107633', '', 'https://lf3-fe.ecombdstatic.com/obj/ecom-cdn-default/ecom/fe-alliance-home/out/favicon.ico', 5, 1, '_blank', 'show', '如何玩转直播带货之直播人设的定位', '10', '2023-07-25 13:51:42', NULL, 1);
INSERT INTO `nav_link` VALUES (21, '直播团队运营规划', 'https://school.jinritemai.com/doudian/web/article/110577', '', 'https://lf3-fe.ecombdstatic.com/obj/ecom-cdn-default/ecom/fe-alliance-home/out/favicon.ico', 5, 1, '_blank', 'show', '直播团队运营规划', '10', '2023-07-25 13:53:18', NULL, 1);
INSERT INTO `nav_link` VALUES (22, '直播互动氛围', 'https://school.jinritemai.com/doudian/web/article/110442', '', 'https://lf3-fe.ecombdstatic.com/obj/ecom-cdn-default/ecom/fe-alliance-home/out/favicon.ico', 5, 1, '_blank', 'show', '如何提升你的直播间用户停留时长&互动氛围？', '10', '2023-07-25 13:59:29', NULL, 1);
INSERT INTO `nav_link` VALUES (23, '直播间人气提示秘籍', 'https://school.jinritemai.com/doudian/web/article/102434', '', 'https://lf3-fe.ecombdstatic.com/obj/ecom-cdn-default/ecom/fe-alliance-home/out/favicon.ico', 5, 1, '_blank', 'show', '直播间人气提示秘籍', '10', '2023-07-25 14:00:37', NULL, 1);
INSERT INTO `nav_link` VALUES (24, '巨量百应', 'https://buyin.jinritemai.com/mpa/account/login?log_out=1&type=24', '', 'https://lf1-fe.ecombdstatic.com/obj/eden-cn/upelogps/bitbug_favicon.ico', 5, 1, '_blank', 'show', '巨量百应、buyin、精选联盟、抖拍档、抖音服务商、巨量百应', '9', '2023-07-25 14:08:06', NULL, 1);
INSERT INTO `nav_link` VALUES (25, '巨量千川', 'https://qianchuan.jinritemai.com/', '', 'https://lf1-cdn2-tos.bytegoofy.com/ad/ecom_marketing_fe/favicon.ico', 5, 1, '_blank', 'show', '巨量千川是巨量引擎旗下的电商广告平台，为商家和达人们提供抖音电商一体化营销解决方案。巨量千川与抖音电商深度融合，为商家和达人们提供抖音电商一体化营销解决方案。', '13,9', '2023-07-25 14:10:23', '2023-07-25 16:32:10', 1);
INSERT INTO `nav_link` VALUES (26, '抖音灵机', 'https://livedata.douyin.com/', '', 'https://lf3-fe.ecombdstatic.com/obj/ecom-cdn-default/ecom/fe-alliance-home/out/favicon.ico', 5, 1, '_blank', 'show', '', '9', '2023-07-25 14:13:56', '2023-07-25 14:16:54', 1);
INSERT INTO `nav_link` VALUES (27, '剪映专业版', 'https://www.capcut.cn/', '', 'https://lf-cdn-tos.bytescm.com/obj/static/ies/ulike/web/resource/fe_official/assets/imgs/lv/favicon.ico', 5, 1, '_blank', 'show', '', '20,9', '2023-07-25 14:22:02', '2023-07-26 10:04:23', 1);
INSERT INTO `nav_link` VALUES (28, '电商罗盘', 'https://compass.jinritemai.com/', '', 'https://lf3-fe.ecombdstatic.com/obj/ecom-cdn-default/ecom/fe-alliance-home/out/favicon.ico', 5, 1, '_blank', 'show', '抖音电商官方推出的数据产品，帮助商家/达人/机构以数据引领生意增长，让生意增长有洞察方向，让生意经营可诊断可优化', '13', '2023-07-25 16:27:22', NULL, 1);
INSERT INTO `nav_link` VALUES (29, '巨量算数', 'https://trendinsight.oceanengine.com/', '', 'https://lf3-static.bytednsdoc.com/obj/eden-cn/kyhgpdeh7nuvanuhd/count/trendinsight.ico', 5, 1, '_blank', 'show', '巨量算数是巨量引擎旗下内容消费趋势洞察品牌。以今日头条、抖音、西瓜视频等内容消费场景为依托，巨量算数官网输出内容趋势、产业研究、广告策略等前沿的洞察与观点，同时，开放算数指数、算数榜单等营销分析工具，满足企业、营销从业者、创作者等数据洞察需求。', '13', '2023-07-25 16:30:28', NULL, 1);
INSERT INTO `nav_link` VALUES (30, '蝉妈妈', 'https://www.chanmama.com/', '', 'https://cdn-static.chanmama.com/sub-module/web/favicon.ico', 5, 1, '_blank', 'show', '蝉妈妈数据是一款垂直于抖音短视频电商的数据分析服务平台，提供抖音直播、短视频、爆款商品、视频素材和DOU+精准ROI等抖音生态数据服务', '13', '2023-07-25 16:35:57', NULL, 1);
INSERT INTO `nav_link` VALUES (31, '飞瓜数据', 'https://www.feigua.cn/', '', 'https://www.feigua.cn/favicon.ico', 5, 1, '_blank', 'show', '飞瓜数据是短视频领域权威的数据分析平台，提供抖音数据和快手数据', '13', '2023-07-25 16:45:49', NULL, 1);
INSERT INTO `nav_link` VALUES (32, '抖店智能店长', '#', '', 'https://dddz.jiancent.com/dz.ico', 5, 1, '_blank', 'show', '', '26', '2023-07-25 16:53:40', '2023-07-29 17:50:35', 1);
INSERT INTO `nav_link` VALUES (33, '妙手', 'http://www.99miaoshou.com/', '', 'https://erp-static-c1.chengji-inc.com/earth.ico', 5, 1, '_blank', 'show', '', '26', '2023-07-25 16:57:27', '2023-07-29 17:50:44', 1);
INSERT INTO `nav_link` VALUES (34, '批量邀约达人', 'http://www.bjkcyy.cn/', '', 'http://www.bjkcyy.cn/favicon.ico?1674400078', 5, 1, '_blank', 'show', '', '26', '2023-07-25 17:08:02', '2023-07-29 17:51:45', 1);
INSERT INTO `nav_link` VALUES (35, '至尊宝插件', 'http://www.3351r.com', '', 'http://www.3351r.com/img/little/icon.jpg', 5, 1, '_blank', 'show', '', '26', '2023-07-25 17:19:40', '2023-07-29 17:52:01', 1);
INSERT INTO `nav_link` VALUES (36, 'Pr', 'https://www.adobe.com/cn/products/premiere.html', '', 'https://www.adobe.com/content/dam/cc/Adobe_favicon.ico', 5, 1, '_blank', 'show', 'Premiere Pro 是适用于快速创作出色视频的主流视频编辑软件。', '20', '2023-07-26 10:10:17', NULL, 1);
INSERT INTO `nav_link` VALUES (37, '达芬奇', 'https://www.onlinedown.net/soft/10046988.htm', '', 'https://img.onlinedown.net/download/202204/163419-626ba30b57617.jpg', 5, 1, '_blank', 'show', '达芬奇是一款在同一个软件工具中，将剪辑、调色、视觉特效、动态图形和音频后期制作融于一身的解决方案', '20', '2023-07-26 10:20:31', NULL, 1);
INSERT INTO `nav_link` VALUES (38, '快影', 'https://www.kuaishou.com/kuaiying', '', 'https://s2-11673.kwimgs.com/udata/pkg/fe/favicon.70ff1fcc.ico', 5, 1, '_blank', 'show', '全面的视频剪辑倒放、变速和转场等功能，一应俱全', '20', '2023-07-26 10:23:00', NULL, 1);
INSERT INTO `nav_link` VALUES (39, '必剪', 'https://bcut.bilibili.cn/', '', 'https://static.hdslb.com/images/favicon.ico', 5, 1, '_blank', 'show', '必剪PC端,必剪桌面端,bilibili云剪辑', '20', '2023-07-26 10:26:10', NULL, 1);
INSERT INTO `nav_link` VALUES (40, '讯飞快读', 'https://peiyin.xunfei.cn/make', '', 'https://peiyin.xunfei.cn/themes/images/bigpeiyinge_favicon.ico', 5, 1, '_blank', 'show', '讯飞配音是国内专业的广告配音平台,提供各种合成配音服务,如:广告配音、宣传片配音、儿童配音、地摊叫卖配音等多语种网络配音', '21', '2023-07-26 10:33:14', NULL, 1);
INSERT INTO `nav_link` VALUES (41, '全能文字转语音', 'https://www.xunjieshipin.com/quannengwzzyy', '', 'https://www.xunjieshipin.com/wp-content/themes/project-shipin_v7.2.2/favicon.ico', 5, 1, '_blank', 'show', '全能文字转语音是一款具备真人发声效果的智能配音软件,支持文字转语音、视频转语音、语音转文字等实用功能,适用于短视频配音', '21', '2023-07-26 10:35:41', '2023-07-26 10:36:01', 1);
INSERT INTO `nav_link` VALUES (42, '知意配音', 'https://www.zhiyipeiyin.com/newproduction.html', '', 'https://imgweb.kejipro.cn/p3037/t10/202007/c4466585-c4ca-4c16-b9a3-26d907f04ba7.png', 5, 1, '_blank', 'show', '知意配音,在线文字转语音,配音软件,语音合成,视频配音,广告配音,知意配音官网', '21', '2023-07-26 10:49:02', NULL, 1);
INSERT INTO `nav_link` VALUES (43, '悦录', 'http://voiceclub.cn/', '', 'http://voiceclub.cn/static/img/favicon.ico', 5, 1, '_blank', 'show', '录音转文字，语音转文字，录音转文字助手，录音转文字软件，免费音频转文字', '21', '2023-07-26 14:53:02', NULL, 1);
INSERT INTO `nav_link` VALUES (44, '配音神器', 'https://peiyinya.com/', '', 'https://pysq.stoss.shipook.com/imgs/mpimg/pysq_pche.png', 5, 1, '_blank', 'show', '配音神器—配音神器网页版—免费配音—ai配音神器—在线配音', '21', '2023-07-26 14:56:22', NULL, 1);
INSERT INTO `nav_link` VALUES (45, '魔音工坊', 'https://www.moyin.com/', '', 'https://www.moyin.com/favicon.ico', 5, 1, '_blank', 'show', '在线文字转语音、短视频配音、语音合成、配音网站', '21', '2023-07-26 15:00:23', NULL, 1);
INSERT INTO `nav_link` VALUES (46, '水印宝', 'http://www.shuiyinbao.com/', '', 'https://pp.myapp.com/ma_icon/0/icon_52743760_1689936461/256', 5, 1, '_blank', 'show', '水印宝去水印是一款移动应用程序，通常在手机上使用。如果您想在电脑上使用水印宝去水印，可以尝试使用应用宝电脑版', '22', '2023-07-26 15:05:10', NULL, 1);
INSERT INTO `nav_link` VALUES (47, '金舟水印助手', 'https://www.jinzhousoft.net/', '', 'https://www.jinzhousoft.net/static/common/imgs/logo.svg', 5, 1, '_blank', 'show', '视频,图片去水印/加水印软件，支持文件批量上传处理，且兼容常见图片/视频格式，一键式操作，方便快捷。', '22', '2023-07-26 15:07:59', NULL, 1);
INSERT INTO `nav_link` VALUES (48, '轻抖', 'https://www.qingdou.vip/pctool/work-benches', '', 'https://www.qingdou.vip/favicon.ico', 5, 1, '_blank', 'show', '百万达人都在用—轻抖短视频创作工具：支持各大主流平台批量提取视频、找达人', '22', '2023-07-26 15:10:05', '2023-07-26 15:10:30', 1);
INSERT INTO `nav_link` VALUES (49, '短视频小秘书', 'https://www.pgyer.com/Cv3B0w', '', 'https://cdn-app-icon.pgyer.com/6/a/4/6/9/6a46983d173e6abba2019e2fb8ead0d6?x-oss-process=image/resize,m_lfit,h_120,w_120/format,jpg', 5, 1, '_blank', 'show', '短视频小秘书是一款短视频解析app,支持kuai手、dou音、you管等多达180多个平台,而且无需root直接一键解析下载,同时还为你去除水印,满足你的诸多需求,你值得拥有', '22', '2023-07-26 15:14:58', NULL, 1);
INSERT INTO `nav_link` VALUES (50, 'remove.bg在线抠图', 'https://www.remove.bg/zh', '', 'https://www.remove.bg/favicon-32x32.png?v=YAXaAv7pao', 5, 1, '_blank', 'show', '', '22,29', '2023-07-27 17:04:01', '2023-07-31 13:20:22', 1);
INSERT INTO `nav_link` VALUES (51, '菜鸟图库', 'https://www.sucai999.com/', '', 'https://www.sucai999.com/favicon.ico', 5, 1, '_blank', 'show', '网站主要为新手设计师提供免费素材，这些素材的质量都很高，类别也很多，像平面、UI、电商、视频、图片等素材站内都能找到', '23', '2023-07-29 15:46:01', NULL, 1);
INSERT INTO `nav_link` VALUES (52, '大美工', 'https://dameigong.cn/', '', 'https://dameigong.cn/favicon.ico', 5, 1, '_blank', 'show', '超多电商、banner海报、详情页，全部都是天猫淘宝采集下来的优秀作品，非常值得拿来参考学习。', '23', '2023-07-29 15:56:03', NULL, 1);
INSERT INTO `nav_link` VALUES (53, 'Pexels', 'https://www.pexels.com/zh-cn/', '', 'https://www.pexels.com/assets/static/images/meta/favicon.ico', 5, 1, '_blank', 'show', '', '23,24', '2023-07-29 16:02:40', '2023-07-29 16:32:08', 1);
INSERT INTO `nav_link` VALUES (54, 'Pixabay', 'https://pixabay.com/zh/', '', 'https://pixabay.com/favicon.ico', 5, 1, '_blank', 'show', 'Pixabay是一个免费正版高清的图片素材库，同时可以下载免费插画、矢量图，免费视频、免费音频等。', '23', '2023-07-29 16:06:45', NULL, 1);
INSERT INTO `nav_link` VALUES (55, 'Colorhub', 'https://www.colorhub.me/', '', 'https://www.colorhub.me/colorhub.png', 5, 1, '_blank', 'show', 'Colorhub是一个高清无版权的图片网站，除了可按中文关键词检索，还支持按颜色进行检索。已收录约110,208 张图片。', '23', '2023-07-29 16:10:24', NULL, 1);
INSERT INTO `nav_link` VALUES (56, 'Videvo', 'https://www.videvo.net/', '', 'https://www.videvo.net/favicon.ico', 5, 1, '_blank', 'show', 'Videvo 网站是一个提供完全免费的视频录像和动态动画视频的网站,可应用于任何商业项目。', '24', '2023-07-29 16:31:04', NULL, 1);
INSERT INTO `nav_link` VALUES (57, '爱给网', 'https://www.aigei.com/', '', 'https://cdn-sqn.aigei.com/assets/site/img/icon/favicon.ico', 5, 1, '_blank', 'show', '免费素材的网站，视频、配乐、音效，里面的内容非常齐全', '23,24', '2023-07-29 16:36:16', NULL, 1);
INSERT INTO `nav_link` VALUES (58, 'newcger', 'https://www.newcger.com/', '', 'https://www.newcger.com/favicon.ico', 5, 1, '_blank', 'show', '新 CG 儿作为国内免费的视频素材网站，在业内的声望也是首屈一指的', '24', '2023-07-29 16:44:35', NULL, 1);
INSERT INTO `nav_link` VALUES (59, 'Mixkit', 'https://mixkit.co/', '', 'https://mixkit.co/favicon.ico', 5, 1, '_blank', 'show', 'Mixkit 也是一个免费的高画质视频素材网站，并明确说明可以自由下载，并且用于商业用途。', '24', '2023-07-29 17:32:00', NULL, 1);
INSERT INTO `nav_link` VALUES (60, '秀米编辑器', 'https://xiumi.us/', '', 'https://xiumi.us/favicon.ico', 5, 1, '_blank', 'show', '原创模板素材，精选风格排版，独一无二的排版方式，设计出只属于你的图文，打动你的人群。', '25', '2023-07-29 17:40:06', NULL, 1);
INSERT INTO `nav_link` VALUES (61, '135编辑器', 'https://www.135editor.com/', '', 'https://www.135editor.com/favicon.ico', 5, 1, '_blank', 'show', '135编辑器是一款提供微信公众号文章排版和内容编辑的在线工具,样式丰富,支持秒刷、收藏样式和颜色、图片素材编辑、图片水印、一键排版等功能,轻松编辑微信公众号图文。', '25', '2023-07-29 17:41:19', NULL, 1);
INSERT INTO `nav_link` VALUES (62, '365微信编辑器', 'https://www.365editor.com/', '', 'https://www.365editor.com/favicon.ico', 5, 1, '_blank', 'show', '365微信编辑器是一款拥有海量素材,文案图库提供高效图文排版的1345图文编辑器,支持实时预览,一键秒刷,多平台一键同步', '25', '2023-07-29 17:42:30', NULL, 1);
INSERT INTO `nav_link` VALUES (63, '壹伴微信编辑器', 'https://yiban.io/', '', 'https://assets.yiban.io/assets/imgs/favicon-new-8615028296.ico', 5, 1, '_blank', 'show', '壹伴微信编辑器插件-200万公众号新媒体运营者青睐的在线微信编辑工具、拥有万千公众号模板,公众号素材样式、具备公众号排版,多公众号管理,数据分析,定时群发等功能', '25', '2023-07-29 17:44:49', NULL, 1);
INSERT INTO `nav_link` VALUES (64, 'i排版', 'http://ipaiban.com/', '', 'http://ipaiban.com/src/img/favicon.ico', 5, 1, '_blank', 'show', '微信编辑器i排版是一款排版效率高、界面简洁、样式原创设计的微信排版工具，支持全文编辑，实时预览、一键样式、一键添加签名的微信图文编辑器。', '25', '2023-07-29 17:48:42', NULL, 1);
INSERT INTO `nav_link` VALUES (65, '改图宝', 'https://www.gaitubao.com/', '', 'https://www.gaitubao.com/favicon.ico', 5, 1, '_blank', 'show', '可以在线修改图片像素及尺寸、裁剪、压缩文件大小及处理各类考试网上报名照片及证件照', '29', '2023-07-31 13:19:31', NULL, 1);
INSERT INTO `nav_link` VALUES (66, '美图秀秀', 'https://pc.meitu.com/', '', 'https://pc.meitudata.com/web-xiuxiu-offical/release/2861a7c974/_next/static/media/favicon.88867287.ico', 5, 1, '_blank', 'show', '美图秀秀P图软件提供图片美化工具、人像美容、添加文字、抠图软件、拼图', '29', '2023-07-31 13:23:26', NULL, 1);
INSERT INTO `nav_link` VALUES (67, '图片去水印', 'https://www.apowersoft.cn/online-watermark-remover', '', 'https://www.apowersoft.cn/favicon.ico', 5, 1, '_blank', 'show', '一键快速去除视频&图片水印', '29', '2023-07-31 13:28:31', NULL, 1);
INSERT INTO `nav_link` VALUES (68, '跨境电商图片翻译', 'https://www.aliprice.com/imageTranslation/index.html', '', 'https://static-cn.aliprice.com/static/index/img/favicon.ico', 5, 1, '_blank', 'show', '跨境电商图片翻译', '29', '2023-07-31 13:36:13', NULL, 1);
INSERT INTO `nav_link` VALUES (69, '翻译狗-跨境图片翻译', 'http://www.fanyigou.net/trans/totran/tranImg.html', '', 'http://www.fanyigou.net/static/images/favicon.ico', 5, 1, '_blank', 'show', '翻译狗 —— 媲美人工翻译的文档翻译平台', '29', '2023-07-31 13:37:36', NULL, 1);
INSERT INTO `nav_link` VALUES (70, '以图搜货源', 'https://www.aliprice.com/', '', 'https://static-cn.aliprice.com/static/index/img/favicon.ico', 5, 1, '_blank', 'show', '阿里巴巴图片搜索在阿里巴巴和1688.com上找货源', '30', '2023-07-31 13:41:24', NULL, 1);
INSERT INTO `nav_link` VALUES (71, 'Fatkun电商图片批量下载', 'https://ext.se.360.cn/webstore/search/Fatkun', '', 'https://p0.qhimg.com/t01bddc796cc70f11fa.png', 5, 1, '_blank', 'show', '快捷地一键下载页面上所有图片。可以自动解析为高清大图。', '30', '2023-07-31 13:48:24', NULL, 1);
INSERT INTO `nav_link` VALUES (72, '沉浸式翻译', 'https://immersivetranslate.com/', '', 'https://immersivetranslate.com/img/favicon.svg', 5, 1, '_blank', 'show', '沉浸式翻译是一款浏览器插件，可以智能识别网页主内容区进行双语翻译，插件支持全平台浏览器，PDF文件翻译，EPUB电子书双语翻译、制作、导出，字幕文件翻译等功能。', '30', '2023-07-31 16:40:21', NULL, 1);
INSERT INTO `nav_link` VALUES (73, '找货神器', 'https://s.1688.com/shen/home.html', '', 'https://img.alicdn.com/tfs/TB1uh..zbj1gK0jSZFuXXcrHpXa-16-16.ico?_=2020', 5, 1, '_blank', 'show', '找货神器1688', '30', '2023-07-31 16:52:25', NULL, 1);
INSERT INTO `nav_link` VALUES (74, 'Bigjpg图片放大', 'https://bigjpg.com/', '', 'https://bigjpg.com/htdocs/favicon.ico', 5, 1, '_blank', 'show', 'Bigjpg - 使用人工智能深度卷積神經網絡(CNN)智能無損免費放大圖片', '29', '2023-08-01 09:41:25', NULL, 1);
INSERT INTO `nav_link` VALUES (75, 'tinify图片压缩', 'https://tinify.cn/', '', 'https://tinify.cn/images/favicon.ico', 5, 1, '_blank', 'show', 'TinyPNG使用智能有损压缩技术将您的WebP, PNG and JPEG图片的文件大小降低。 通过选择性的减少图片中的颜色，只需要很少的字节数就能保存数据。', '29', '2023-08-01 09:43:26', NULL, 1);
INSERT INTO `nav_link` VALUES (76, '视频无损放大', 'https://bigmp4.com/', '', 'https://bigmp4.com/htdocs/favicon.ico', 5, 1, '_blank', 'show', '人工智能视频无损放大\n使用2023年最先进人工智能 AI 模型，能将视频无损高清放大、增强画质、智能补帧使画面丝滑流畅栩栩如生同时支持黑白视频上色和慢动作', '32', '2023-08-01 09:49:24', NULL, 1);
INSERT INTO `nav_link` VALUES (77, '黑白图像上色', 'https://palette.fm/', '', 'https://palette.fm/favicon.png', 5, 1, '_blank', 'show', 'palette.fm简介 Palette.fm 是一个利用 ai 模型为黑白图像智能上色的在线图片处理网站', '29', '2023-08-01 09:55:48', NULL, 1);
INSERT INTO `nav_link` VALUES (78, '老照片无损修复', 'https://jpghd.com/zh', '', 'https://jpghd.com/htdocs/favicon.ico', 5, 1, '_blank', 'show', 'jpgHD.com - 利用2023年最先进人工智能 AI 将老照片无损高清修复（支持老照片修复、老照片上色和魔法动态照片)', '29', '2023-08-01 10:00:34', NULL, 1);
INSERT INTO `nav_link` VALUES (79, '改图神器', 'https://img.logosc.cn/bigjpg', '', 'https://img.logosc.cn/favicon-32x32.png', 5, 1, '_blank', 'show', '图片无损放大变清晰，模糊图片在线修复变高清 - AI改图神器', '29', '2023-08-01 10:03:28', NULL, 1);
INSERT INTO `nav_link` VALUES (80, '资料头像生成', 'https://pfpmaker.com/', '', 'https://pfpmaker.com/favicon.ico', 5, 1, '_blank', 'show', 'ProfilePicMaker是一个在线的头像制作网站，它可以将你上传的图片，经过简单的处理之后，得到一个很棒的头像，保存之后用社交，个人资料等其他需要头像的软件之中。', '32', '2023-08-01 10:09:35', NULL, 1);
INSERT INTO `nav_link` VALUES (81, 'iloveimg批量图片工具', 'https://www.iloveimg.com/zh-cn', '', 'https://www.iloveimg.com/img/favicons-img/favicon-16x16.png', 5, 1, '_blank', 'show', '可批量编辑图片 的所有工具\n你的在线图片编辑器就在这里，而且永远免费！', '29', '2023-08-01 10:13:35', NULL, 1);
INSERT INTO `nav_link` VALUES (82, '修復老照片', 'https://imagecolorizer.com/zh-tw', '', 'https://imagecolorizer.com/favicon.ico', 5, 1, '_blank', 'show', 'ImageColorizer是一款基于人工智能的云端编辑和图形设计工具。 此平台提供了各种工具，可以使您的旧黑白照片焕然一新。', '32', '2023-08-01 10:17:18', NULL, 1);
INSERT INTO `nav_link` VALUES (83, '照片修复', 'https://hotpot.ai/restore-picture', '', 'https://hotpot.ai/images/apple-touch-icon.png', 5, 1, '_blank', 'show', 'ImageColorizer是一款基于人工智能的云端编辑和图形设计工具。 此平台提供了各种工具，可以使您的旧黑白照片焕然一新。', '32', '2023-08-01 10:21:22', NULL, 1);
INSERT INTO `nav_link` VALUES (84, '腾讯AIDesign', 'https://ailogo.qq.com/guide/brandname', '', 'https://ailogo.qq.com/favicon.ico?v=1.1', 5, 1, '_blank', 'show', '腾讯AIDesign是完全免费的,没有任何次数限制,并且可以商用', '34', '2023-08-01 10:32:45', NULL, 1);
INSERT INTO `nav_link` VALUES (85, '美图设计室', 'https://www.x-design.com/logo-design/', '', 'https://pc.meitudata.com/logo-design/favicon-32x32.png', 5, 1, '_blank', 'show', '美图设计室-是美图秀秀旗下的智能设计在线协作平台', '34', '2023-08-01 10:37:13', NULL, 1);
INSERT INTO `nav_link` VALUES (86, 'logo123', 'https://ai.logo123.com/start', '', 'https://ai.logo123.com/img/logo-icons/ailogo.svg', 5, 1, '_blank', 'show', '超级智能好用的Logo在线设计生成器为您提供免费公司logo设计制作。', '34', '2023-08-01 10:39:09', NULL, 1);
INSERT INTO `nav_link` VALUES (87, '标小智', 'https://www.logosc.cn/', '', 'https://www.logosc.cn/img/logo-icons/logosc-new.svg', 5, 1, '_blank', 'show', '人工智能为您在线LOGO设计，生成企业VI，打造个性品牌！', '34', '2023-08-01 10:42:05', NULL, 1);
INSERT INTO `nav_link` VALUES (88, '免费AI公司起名', 'https://www.logosc.cn/nameGPT', '', 'https://www.logosc.cn/img/logo-icons/logosc-new.svg', 5, 1, '_blank', 'show', '一句话描述您的公司或者产品，Name.GPT就能自动生成多种风格的企业品牌名称\n', '34', '2023-08-01 14:57:57', NULL, 1);
INSERT INTO `nav_link` VALUES (89, '在线视频下载工具', 'https://www.videofk.com/zh-CN/online-video-download', '', 'https://www.videofk.com/videofk/images/v16X16.ico?v=2', 5, 1, '_blank', 'show', 'Videofk是一款支持绝大多数视频媒体网站的在线视频嗅探下载工具', '32', '2023-08-01 16:54:13', NULL, 1);
INSERT INTO `nav_link` VALUES (90, 'PDF Tools', 'https://tools.pdf24.org/zh/', '', 'https://tools.pdf24.org/static/img/pdf24.png?v=5cf19973', 5, 1, '_blank', 'show', '', '32,35', '2023-08-01 17:02:32', '2023-08-01 17:05:46', 1);
INSERT INTO `nav_link` VALUES (91, 'PT超级市场', 'https://www.pptsupermarket.com/', '', 'https://www.pptsupermarket.com/favicon.ico', 5, 1, '_blank', 'show', '免费下载PPT模板与PPT作品，提供免费的PPT代做服务，提供一站式PPT(模板、定制、工具、教程)服务，有了它，一切制作PPT的烦恼都将成为过去！', '35', '2023-08-01 17:11:32', NULL, 1);
INSERT INTO `nav_link` VALUES (92, '美图AI PPT', 'https://www.x-design.com/ppt/', '', 'https://pc.meitudata.com/user-poster-editor/favicon-32x32.png', 5, 1, '_blank', 'show', '美图AI PPT 一键生成ppt', '35', '2023-08-01 17:38:49', NULL, 1);
INSERT INTO `nav_link` VALUES (93, '美图AI商品图', 'https://www.x-design.com/product-shoot/', '', 'https://pc.meitudata.com/user-poster-editor/favicon-32x32.png', 5, 1, '_blank', 'show', '美图AI商品图一键生成', '32,34', '2023-08-01 17:44:22', NULL, 1);
INSERT INTO `nav_link` VALUES (94, 'ChatPPT', 'https://www.chat-ppt.com/', '', 'https://www.chat-ppt.com/favicon.ico', 5, 1, '_blank', 'show', 'ChatPPT命令式一键生成PPT', '35', '2023-08-01 17:49:40', NULL, 1);
INSERT INTO `nav_link` VALUES (95, 'AI思维导图', 'https://shutu.cn/', '', 'https://static.shutu.cn/images/favicon.ico', 5, 1, '_blank', 'show', 'TreeMind树图新一代“AI人工智能”思维导图', '35', '2023-08-01 17:52:38', NULL, 1);
INSERT INTO `nav_link` VALUES (96, '酷表ChatExcel', 'https://chatexcel.com/', '', 'https://chatexcel.com/static/pic/icon/icon-black-bold.png', 5, 1, '_blank', 'show', '酷表ChatExcel帮你处理Excel表格，上传你的文件，输入你的需求，AI自动就帮主你处理。', '35', '2023-08-01 17:58:13', NULL, 1);
INSERT INTO `nav_link` VALUES (97, 'obs直播录播软件', 'https://obsproject.com/', '', 'https://obsproject.com/favicon-96x96.png', 5, 1, '_blank', 'show', 'obs直播录播软件，开源免费，直播推流必备', '37', '2023-08-02 16:24:51', NULL, 1);
INSERT INTO `nav_link` VALUES (98, 'vizard在线录屏软件', 'https://vizard.video/', '', 'https://vizard.video/img/icons/favicon-32x32.png', 5, 1, '_blank', 'show', '在线录屏软件，不用下载软件', '37', '2023-08-02 16:37:34', NULL, 1);
INSERT INTO `nav_link` VALUES (99, 'EV录屏', 'https://www.ieway.cn/evcapture.html', '', 'https://ctpublic.ieway.cn/public/v5/imgs/favicon.ico', 5, 1, '_blank', 'show', '免费无水印，集视频录制与直播功能于一身的桌面录屏软件', '37', '2023-08-02 16:42:55', NULL, 1);
INSERT INTO `nav_link` VALUES (100, '芦笋录屏', 'https://lusun.com/', '', 'https://lusun.com/favicon.ico', 5, 1, '_blank', 'show', '芦笋录屏，极简视频录制工具。同时录制人像和屏幕，美颜、虚拟头像等让视频信息更生动；可一键分享，通过异步视频高效沟通。', '37', '2023-08-02 16:44:58', NULL, 1);
INSERT INTO `nav_link` VALUES (101, '傲软录屏', 'https://www.apowersoft.cn/record-all-screen', '', 'https://qncdn.aoscdn.com/img/favicon.png', 5, 1, '_blank', 'show', 'Windows、Mac、Android、iOS多平台录屏工具', '37', '2023-08-02 16:59:39', NULL, 1);
INSERT INTO `nav_link` VALUES (102, '万能播放器Potplayer', 'http://www.potplayercn.com/', '', 'http://www.potplayercn.com/wp-content/themes/pot/images/favicon.ico', 5, 1, '_blank', 'show', 'PotPlayer(64-bit)正式版是款比较全能的媒体播放器工具。', '37', '2023-08-02 17:08:28', NULL, 1);
INSERT INTO `nav_link` VALUES (103, '锐动天地视频编辑专家', 'http://www.17rd.com/download.htm', '', 'http://www.17rd.com/favicon.ico', 5, 1, '_blank', 'show', '锐动天地视频编辑专家最新版是一款多功能的视频编辑处理软件', '42', '2023-08-03 09:58:40', NULL, 1);
INSERT INTO `nav_link` VALUES (104, '哈士奇电商插件', 'https://hsq.dangxun.com/', '', 'https://s.dxcdn.cn/hsq_7.4.9/8862a8475e9f620c76a0bc5f727ae3c2be6421d1093dfba7302f05d915ac50e5.png', 5, 1, '_blank', 'show', '哈士奇电商插件官网，多功能免费，老电商人熟悉的一款浏览器插件，适用淘宝、天猫、1688、拼多多、京东、抖店、苏宁、跨境等各大电商平台的运营插件', '30', '2023-08-03 10:18:20', NULL, 1);
INSERT INTO `nav_link` VALUES (105, '文字雨', 'http://wenziyu.top/', '', 'http://wenziyu.top/favicon.ico', 5, 1, '_blank', 'show', '文字雨效果', '41', '2023-08-03 14:43:44', NULL, 1);
INSERT INTO `nav_link` VALUES (106, '放烟花', 'http://fangyanhua.top/', '', 'https://s3-us-west-2.amazonaws.com/s.cdpn.io/329180/firework-burst-icon-v2.png', 5, 1, '_blank', 'show', '放烟花效果', '41', '2023-08-03 14:45:06', NULL, 1);
INSERT INTO `nav_link` VALUES (107, '流星雨', 'https://ms.darkmap.cn/', '', 'https://ms.darkmap.cn/img/favicon.png', 5, 1, '_blank', 'show', '流星雨', '41', '2023-08-03 14:46:56', NULL, 1);
INSERT INTO `nav_link` VALUES (108, '闹钟在线', 'https://naozhong.net.cn/', '', 'https://naozhong.net.cn/img/favicons/android-chrome-192x192.png', 5, 1, '_blank', 'show', '在线闹钟。为在线闹钟设置时钟和分钟。将在设置的时间出现闹钟消息并播放预先选择的声音。', '41', '2023-08-03 14:48:40', NULL, 1);
INSERT INTO `nav_link` VALUES (109, 'obs-ndi', 'https://obsproject.com/forum/threads/obs-ndi-newtek-ndi%E2%84%A2-integration-into-obs-studio.69240/', '', 'https://obsproject.com/favicon-96x96.png', 5, 1, '_blank', 'show', 'obs-teleport替代NDI\nhttps://www.bilibili.com/read/cv22136471\nhttps://zhuanlan.zhihu.com/p/600729782', '40', '2023-08-03 14:54:24', '2023-08-03 15:40:41', 1);
INSERT INTO `nav_link` VALUES (110, 'tuna歌词显示插件', 'https://obsproject.com/forum/resources/tuna.843/', '', 'https://obsproject.com/favicon-96x96.png', 5, 1, '_blank', 'show', '', '40', '2023-08-03 14:58:20', '2023-08-03 14:58:52', 1);
INSERT INTO `nav_link` VALUES (111, 'VLC免费播放器', 'https://www.videolan.org/vlc/', '', 'https://images.videolan.org/images/favicon.ico', 5, 1, '_blank', 'show', 'VLC 是一个免费的开源跨平台多媒体播放器和框架，可播放大多数多媒体文件以及 DVD、音频 CD、VCD 和各种流媒体协议。', '40', '2023-08-03 15:15:13', NULL, 1);
INSERT INTO `nav_link` VALUES (112, 'OBS 虚拟摄像头Virtualcam', 'https://obsproject.com/forum/resources/obs-virtualcam.949/', '', 'https://obsproject.com/favicon-96x96.png', 5, 1, '_blank', 'show', 'OBS 虚拟摄像头OBS Virtualcam', '40', '2023-08-03 15:16:44', NULL, 1);
INSERT INTO `nav_link` VALUES (113, 'OBS官网文档', 'https://obsproject.com/help', '', 'https://obsproject.com/favicon-96x96.png', 5, 1, '_blank', 'show', 'OBS官网文档', '39', '2023-08-03 15:18:01', NULL, 1);
INSERT INTO `nav_link` VALUES (114, 'audio-monitor', 'https://obsproject.com/forum/resources/audio-monitor.1186/', '', 'https://obsproject.com/favicon-96x96.png', 5, 1, '_blank', 'show', 'audio-monitor将来源声音输出给指定设备播放，方便单独调节音量，能让主播与观众听到不', '40', '2023-08-03 15:20:03', NULL, 1);
INSERT INTO `nav_link` VALUES (115, 'OBS 多地址推流', 'https://github.com/sorayuki/obs-multi-rtmp', '', 'https://obsproject.com/favicon-96x96.png', 5, 1, '_blank', 'show', 'OBS 多地址推流，同时在多个平台上进行直播', '40', '2023-08-03 15:22:47', NULL, 1);
INSERT INTO `nav_link` VALUES (116, 'obs-teleport替代NDI', 'https://github.com/fzwoch/obs-teleport', '', 'https://obsproject.com/favicon-96x96.png', 5, 1, '_blank', 'show', 'obs-teleport替代NDI\nhttps://www.bilibili.com/read/cv22136471', '40', '2023-08-03 15:25:33', '2023-08-03 15:29:00', 1);
INSERT INTO `nav_link` VALUES (117, '直播入门攻略', 'https://www.zhihu.com/tardis/bd/art/360638543', '', 'https://obsproject.com/favicon-96x96.png', 5, 1, '_blank', 'show', '直播入门攻略：从直播小白到网红达人', '39', '2023-08-03 15:29:51', NULL, 1);
INSERT INTO `nav_link` VALUES (118, 'OBS中文网', 'https://www.obsxx.com/', '', 'https://obsproject.com/favicon-96x96.png', 5, 1, '_blank', 'show', 'OBS中文网提供最新官网版OBS直播推流屏幕窗口录制软件下载', '39', '2023-08-03 15:42:00', NULL, 1);
INSERT INTO `nav_link` VALUES (119, '直播入门攻略', 'https://zhuanlan.zhihu.com/p/597231652', '', 'https://obsproject.com/favicon-96x96.png', 5, 1, '_blank', 'show', 'OBS中文网提供最新官网版OBS直播推流屏幕窗口录制软件下载', '39', '2023-08-03 15:45:57', NULL, 1);
INSERT INTO `nav_link` VALUES (120, '绿闪科技', 'https://www.greenflash.cn', '', 'https://www.greenflash.cn/favicon0.ico', 6, 1, '_blank', 'show', '', '27', '2023-08-04 08:49:39', NULL, 1);
INSERT INTO `nav_link` VALUES (121, '百度', 'https://www.baidu.com', '', 'https://www.baidu.com/favicon.ico', 6, 1, '_blank', 'show', '百度', '27', '2023-08-04 09:03:16', NULL, 1);
COMMIT;

-- ----------------------------
-- Table structure for nav_menu
-- ----------------------------
DROP TABLE IF EXISTS `nav_menu`;
CREATE TABLE `nav_menu` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `parent_id` bigint DEFAULT '0',
  `create_user_id` bigint DEFAULT NULL,
  `menu_name` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `menu_icon` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '分类图标',
  `top_menu` int unsigned DEFAULT '0' COMMENT '0为一级商品，1否',
  `sort_num` int DEFAULT '0',
  `is_hide` varchar(32) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'show显示或隐藏hidden\nshow显示或隐藏hidden\n',
  `status` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT 'show' COMMENT 'show显示或隐藏hidden\n',
  `created` datetime DEFAULT NULL,
  `updated` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=43 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='导航网站菜单表';

-- ----------------------------
-- Records of nav_menu
-- ----------------------------
BEGIN;
INSERT INTO `nav_menu` VALUES (5, 0, 1, '抖音直播', 'fa fa-superpowers', 0, 2, 'show', 'show', '2023-07-25 10:58:50', '2023-07-29 17:53:55');
INSERT INTO `nav_menu` VALUES (6, 5, 1, '注册&开通小店', '', 0, 1, 'show', 'show', '2023-07-25 11:00:43', '2023-07-25 13:07:38');
INSERT INTO `nav_menu` VALUES (7, 5, 1, '抖音企业号', '', 0, 2, 'show', 'show', '2023-07-25 13:02:28', '2023-07-25 13:07:51');
INSERT INTO `nav_menu` VALUES (8, 5, 1, '直播设备环境', '', 0, 3, 'show', 'show', '2023-07-25 13:04:14', '2023-07-25 13:08:02');
INSERT INTO `nav_menu` VALUES (9, 5, 1, '直播工具', '', 0, 4, 'show', 'show', '2023-07-25 13:04:34', '2023-07-25 13:08:08');
INSERT INTO `nav_menu` VALUES (10, 5, 1, '直播运营', '', 0, 5, 'show', 'show', '2023-07-25 13:10:05', '2023-07-25 13:40:26');
INSERT INTO `nav_menu` VALUES (12, 0, 1, '抖店常用工具', 'fa fa-wpexplorer', 0, 1, 'show', 'show', '2023-07-25 16:22:53', '2023-07-29 17:53:44');
INSERT INTO `nav_menu` VALUES (13, 12, 1, '抖店选品工具', '', 0, 0, 'show', 'show', '2023-07-25 16:23:10', '2023-07-29 17:53:03');
INSERT INTO `nav_menu` VALUES (19, 0, 1, '自媒体工具', 'fa fa-meetup', 0, 0, 'show', 'show', '2023-07-26 09:58:33', '2023-07-29 17:53:31');
INSERT INTO `nav_menu` VALUES (20, 19, 1, '剪辑工具', '', 0, 0, 'show', 'show', '2023-07-26 10:00:04', NULL);
INSERT INTO `nav_menu` VALUES (21, 19, 1, '配音工具', '', 0, 0, 'show', 'show', '2023-07-26 10:00:25', NULL);
INSERT INTO `nav_menu` VALUES (22, 19, 1, '去水印工具', '', 0, 0, 'show', 'show', '2023-07-26 10:00:48', NULL);
INSERT INTO `nav_menu` VALUES (23, 19, 1, '图片素材', '', 0, 0, 'show', 'show', '2023-07-26 10:01:19', NULL);
INSERT INTO `nav_menu` VALUES (24, 19, 1, '视频素材', '', 0, 0, 'show', 'show', '2023-07-26 10:01:30', NULL);
INSERT INTO `nav_menu` VALUES (25, 19, 1, '排版工具', '', 0, 0, 'show', 'show', '2023-07-26 10:01:55', NULL);
INSERT INTO `nav_menu` VALUES (26, 12, 1, '抖店常用工具', '', 0, 0, 'show', 'show', '2023-07-29 17:50:00', '2023-07-29 17:52:29');
INSERT INTO `nav_menu` VALUES (27, 0, 1, '友情链接', '', 0, 0, 'hidden', 'hidden', '2023-07-29 17:55:07', '2023-07-31 13:15:21');
INSERT INTO `nav_menu` VALUES (28, 0, 1, '电商常用工具', 'fa fa-shower', 0, 0, 'show', 'show', '2023-07-31 12:03:07', NULL);
INSERT INTO `nav_menu` VALUES (29, 28, 1, '图片工具', 'fa fa-etsy', 0, 0, 'show', 'show', '2023-07-31 13:18:23', NULL);
INSERT INTO `nav_menu` VALUES (30, 28, 1, '电商必备插件', 'fa fa-meetup', 0, 0, 'show', 'show', '2023-07-31 13:39:01', NULL);
INSERT INTO `nav_menu` VALUES (32, 28, 1, '电商其他工具', 'fa fa-snowflake-o', 0, 0, 'show', 'show', '2023-08-01 09:48:20', '2023-08-01 09:50:24');
INSERT INTO `nav_menu` VALUES (33, 0, 1, 'AI常用工具', 'fa fa-bandcamp', 0, 0, 'show', 'show', '2023-08-01 10:28:02', NULL);
INSERT INTO `nav_menu` VALUES (34, 33, 1, '开公司AI工具', '', 0, 0, 'show', 'show', '2023-08-01 10:28:37', '2023-08-01 14:42:34');
INSERT INTO `nav_menu` VALUES (35, 33, 1, '办公AI工具', '', 0, 0, 'show', 'show', '2023-08-01 17:05:18', NULL);
INSERT INTO `nav_menu` VALUES (36, 0, 1, '直播录屏工具', 'fa fa-meetup', 0, 0, 'show', 'show', '2023-08-01 18:30:28', '2023-08-02 16:38:36');
INSERT INTO `nav_menu` VALUES (37, 36, 1, '录屏工具', '', 0, 0, 'show', 'show', '2023-08-01 18:30:47', '2023-08-02 16:38:59');
INSERT INTO `nav_menu` VALUES (38, 0, 1, 'OBS直播', 'fa fa-wpexplorer', 0, 0, 'show', 'show', '2023-08-02 17:12:06', NULL);
INSERT INTO `nav_menu` VALUES (39, 38, 1, 'OBS学习资源', '', 0, 0, 'show', 'show', '2023-08-02 17:12:33', NULL);
INSERT INTO `nav_menu` VALUES (40, 38, 1, 'OBS常用插件', '', 0, 0, 'show', 'show', '2023-08-02 17:12:53', NULL);
INSERT INTO `nav_menu` VALUES (41, 38, 1, 'OBS素材资源', '', 0, 0, 'show', 'show', '2023-08-02 17:13:10', NULL);
INSERT INTO `nav_menu` VALUES (42, 36, 1, '其他好用工具', '', 0, 0, 'show', 'show', '2023-08-02 17:13:30', NULL);
COMMIT;

-- ----------------------------
-- Table structure for nav_menu_link
-- ----------------------------
DROP TABLE IF EXISTS `nav_menu_link`;
CREATE TABLE `nav_menu_link` (
  `menu_id` bigint NOT NULL AUTO_INCREMENT,
  `link_id` bigint NOT NULL,
  PRIMARY KEY (`menu_id`,`link_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=43 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ----------------------------
-- Records of nav_menu_link
-- ----------------------------
BEGIN;
INSERT INTO `nav_menu_link` VALUES (6, 5);
INSERT INTO `nav_menu_link` VALUES (6, 6);
INSERT INTO `nav_menu_link` VALUES (6, 7);
INSERT INTO `nav_menu_link` VALUES (7, 8);
INSERT INTO `nav_menu_link` VALUES (7, 9);
INSERT INTO `nav_menu_link` VALUES (7, 10);
INSERT INTO `nav_menu_link` VALUES (8, 11);
INSERT INTO `nav_menu_link` VALUES (8, 12);
INSERT INTO `nav_menu_link` VALUES (8, 13);
INSERT INTO `nav_menu_link` VALUES (8, 14);
INSERT INTO `nav_menu_link` VALUES (8, 15);
INSERT INTO `nav_menu_link` VALUES (9, 16);
INSERT INTO `nav_menu_link` VALUES (9, 17);
INSERT INTO `nav_menu_link` VALUES (9, 18);
INSERT INTO `nav_menu_link` VALUES (9, 24);
INSERT INTO `nav_menu_link` VALUES (9, 25);
INSERT INTO `nav_menu_link` VALUES (9, 26);
INSERT INTO `nav_menu_link` VALUES (9, 27);
INSERT INTO `nav_menu_link` VALUES (10, 19);
INSERT INTO `nav_menu_link` VALUES (10, 20);
INSERT INTO `nav_menu_link` VALUES (10, 21);
INSERT INTO `nav_menu_link` VALUES (10, 22);
INSERT INTO `nav_menu_link` VALUES (10, 23);
INSERT INTO `nav_menu_link` VALUES (13, 25);
INSERT INTO `nav_menu_link` VALUES (13, 28);
INSERT INTO `nav_menu_link` VALUES (13, 29);
INSERT INTO `nav_menu_link` VALUES (13, 30);
INSERT INTO `nav_menu_link` VALUES (13, 31);
INSERT INTO `nav_menu_link` VALUES (20, 27);
INSERT INTO `nav_menu_link` VALUES (20, 36);
INSERT INTO `nav_menu_link` VALUES (20, 37);
INSERT INTO `nav_menu_link` VALUES (20, 38);
INSERT INTO `nav_menu_link` VALUES (20, 39);
INSERT INTO `nav_menu_link` VALUES (21, 40);
INSERT INTO `nav_menu_link` VALUES (21, 41);
INSERT INTO `nav_menu_link` VALUES (21, 42);
INSERT INTO `nav_menu_link` VALUES (21, 43);
INSERT INTO `nav_menu_link` VALUES (21, 44);
INSERT INTO `nav_menu_link` VALUES (21, 45);
INSERT INTO `nav_menu_link` VALUES (22, 46);
INSERT INTO `nav_menu_link` VALUES (22, 47);
INSERT INTO `nav_menu_link` VALUES (22, 48);
INSERT INTO `nav_menu_link` VALUES (22, 49);
INSERT INTO `nav_menu_link` VALUES (22, 50);
INSERT INTO `nav_menu_link` VALUES (23, 51);
INSERT INTO `nav_menu_link` VALUES (23, 52);
INSERT INTO `nav_menu_link` VALUES (23, 53);
INSERT INTO `nav_menu_link` VALUES (23, 54);
INSERT INTO `nav_menu_link` VALUES (23, 55);
INSERT INTO `nav_menu_link` VALUES (23, 57);
INSERT INTO `nav_menu_link` VALUES (24, 53);
INSERT INTO `nav_menu_link` VALUES (24, 56);
INSERT INTO `nav_menu_link` VALUES (24, 57);
INSERT INTO `nav_menu_link` VALUES (24, 58);
INSERT INTO `nav_menu_link` VALUES (24, 59);
INSERT INTO `nav_menu_link` VALUES (25, 60);
INSERT INTO `nav_menu_link` VALUES (25, 61);
INSERT INTO `nav_menu_link` VALUES (25, 62);
INSERT INTO `nav_menu_link` VALUES (25, 63);
INSERT INTO `nav_menu_link` VALUES (25, 64);
INSERT INTO `nav_menu_link` VALUES (26, 32);
INSERT INTO `nav_menu_link` VALUES (26, 33);
INSERT INTO `nav_menu_link` VALUES (26, 34);
INSERT INTO `nav_menu_link` VALUES (26, 35);
INSERT INTO `nav_menu_link` VALUES (27, 120);
INSERT INTO `nav_menu_link` VALUES (27, 121);
INSERT INTO `nav_menu_link` VALUES (29, 50);
INSERT INTO `nav_menu_link` VALUES (29, 65);
INSERT INTO `nav_menu_link` VALUES (29, 66);
INSERT INTO `nav_menu_link` VALUES (29, 67);
INSERT INTO `nav_menu_link` VALUES (29, 68);
INSERT INTO `nav_menu_link` VALUES (29, 69);
INSERT INTO `nav_menu_link` VALUES (29, 74);
INSERT INTO `nav_menu_link` VALUES (29, 75);
INSERT INTO `nav_menu_link` VALUES (29, 77);
INSERT INTO `nav_menu_link` VALUES (29, 78);
INSERT INTO `nav_menu_link` VALUES (29, 79);
INSERT INTO `nav_menu_link` VALUES (29, 81);
INSERT INTO `nav_menu_link` VALUES (30, 70);
INSERT INTO `nav_menu_link` VALUES (30, 71);
INSERT INTO `nav_menu_link` VALUES (30, 72);
INSERT INTO `nav_menu_link` VALUES (30, 73);
INSERT INTO `nav_menu_link` VALUES (30, 104);
INSERT INTO `nav_menu_link` VALUES (32, 76);
INSERT INTO `nav_menu_link` VALUES (32, 80);
INSERT INTO `nav_menu_link` VALUES (32, 82);
INSERT INTO `nav_menu_link` VALUES (32, 83);
INSERT INTO `nav_menu_link` VALUES (32, 89);
INSERT INTO `nav_menu_link` VALUES (32, 90);
INSERT INTO `nav_menu_link` VALUES (32, 93);
INSERT INTO `nav_menu_link` VALUES (34, 84);
INSERT INTO `nav_menu_link` VALUES (34, 85);
INSERT INTO `nav_menu_link` VALUES (34, 86);
INSERT INTO `nav_menu_link` VALUES (34, 87);
INSERT INTO `nav_menu_link` VALUES (34, 88);
INSERT INTO `nav_menu_link` VALUES (34, 93);
INSERT INTO `nav_menu_link` VALUES (35, 90);
INSERT INTO `nav_menu_link` VALUES (35, 91);
INSERT INTO `nav_menu_link` VALUES (35, 92);
INSERT INTO `nav_menu_link` VALUES (35, 94);
INSERT INTO `nav_menu_link` VALUES (35, 95);
INSERT INTO `nav_menu_link` VALUES (35, 96);
INSERT INTO `nav_menu_link` VALUES (37, 97);
INSERT INTO `nav_menu_link` VALUES (37, 98);
INSERT INTO `nav_menu_link` VALUES (37, 99);
INSERT INTO `nav_menu_link` VALUES (37, 100);
INSERT INTO `nav_menu_link` VALUES (37, 101);
INSERT INTO `nav_menu_link` VALUES (37, 102);
INSERT INTO `nav_menu_link` VALUES (39, 113);
INSERT INTO `nav_menu_link` VALUES (39, 117);
INSERT INTO `nav_menu_link` VALUES (39, 118);
INSERT INTO `nav_menu_link` VALUES (39, 119);
INSERT INTO `nav_menu_link` VALUES (40, 109);
INSERT INTO `nav_menu_link` VALUES (40, 110);
INSERT INTO `nav_menu_link` VALUES (40, 111);
INSERT INTO `nav_menu_link` VALUES (40, 112);
INSERT INTO `nav_menu_link` VALUES (40, 114);
INSERT INTO `nav_menu_link` VALUES (40, 115);
INSERT INTO `nav_menu_link` VALUES (40, 116);
INSERT INTO `nav_menu_link` VALUES (41, 105);
INSERT INTO `nav_menu_link` VALUES (41, 106);
INSERT INTO `nav_menu_link` VALUES (41, 107);
INSERT INTO `nav_menu_link` VALUES (41, 108);
INSERT INTO `nav_menu_link` VALUES (42, 103);
COMMIT;

-- ----------------------------
-- Table structure for order
-- ----------------------------
DROP TABLE IF EXISTS `order`;
CREATE TABLE `order` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `order_sn` varchar(128) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '订单号',
  `create_user_id` bigint DEFAULT NULL,
  `order_title` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `buyer_msg` varchar(512) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '用户留言',
  `order_amount` decimal(10,2) DEFAULT NULL COMMENT '订单商品金额之和',
  `pay_status` tinyint DEFAULT NULL COMMENT '支付状态',
  `delivery_id` bigint DEFAULT NULL COMMENT '发货情况',
  `delivery_status` tinyint DEFAULT NULL COMMENT '1待发货，2已发货',
  `consignee_username` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '收货人地址',
  `consignee_mobile` varchar(32) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '收货人手机号（电话）',
  `consignee_addr_detail` varchar(256) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '收件人的详细地址',
  `invoice_id` int unsigned DEFAULT NULL COMMENT '发票',
  `invoice_status` tinyint DEFAULT NULL COMMENT '发票开具状态：1 未申请发票、 2 发票申请中、 3 发票开具中、 4 无需开具发票、 5发票已经开具',
  `postage_amount` decimal(10,2) DEFAULT NULL COMMENT '订单邮费',
  `pay_amount` decimal(10,2) DEFAULT NULL COMMENT '支付金额，商品金额 + 邮费 - 优惠或减免金额',
  `remarks` text COLLATE utf8mb4_unicode_ci COMMENT '管理员后台备注',
  `trade_status` tinyint DEFAULT NULL COMMENT '交易状态：1交易中、 2交易完成（但是可以申请退款） 、3取消交易 、4申请退款、 5拒绝退款、 6退款中、 7退款完成、 8交易结束',
  `version` int DEFAULT '0',
  `json_ext` text COLLATE utf8mb4_unicode_ci COMMENT 'JSON扩展',
  `status` tinyint DEFAULT '1' COMMENT '删除状态：1 正常 ，0 已经删除',
  `created` datetime DEFAULT NULL COMMENT '创建时间',
  `updated` datetime DEFAULT NULL COMMENT '修改时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `order_sn` (`order_sn`),
  KEY `user_id` (`create_user_id`),
  KEY `user_status` (`create_user_id`,`trade_status`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='订单表';

-- ----------------------------
-- Table structure for order_invoice
-- ----------------------------
DROP TABLE IF EXISTS `order_invoice`;
CREATE TABLE `order_invoice` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `type` varchar(32) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '发票类型',
  `title` varchar(128) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '发票抬头',
  `content` varchar(128) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '发票内容',
  `identity` varchar(32) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '纳税人识别号',
  `name` varchar(128) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '单位名称',
  `mobile` varchar(32) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '发票收取人手机号',
  `email` varchar(32) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '发票收取人邮箱',
  `status` tinyint DEFAULT NULL COMMENT '发票状态',
  `updated` datetime DEFAULT NULL COMMENT '修改时间',
  `created` datetime DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='发票信息表';

-- ----------------------------
-- Table structure for order_item
-- ----------------------------
DROP TABLE IF EXISTS `order_item`;
CREATE TABLE `order_item` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `order_id` bigint NOT NULL COMMENT '订单id',
  `order_sn` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '订单号',
  `seller_id` bigint DEFAULT NULL COMMENT '卖家id',
  `product_id` bigint DEFAULT NULL COMMENT '产品id',
  `product_type` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '产品类型',
  `product_count` int DEFAULT NULL COMMENT '产品数量',
  `postage_cost` decimal(10,2) DEFAULT NULL COMMENT '邮费',
  `total_amount` decimal(10,2) DEFAULT NULL COMMENT '具体金额 = 产品价格+运费+其他价格',
  `updated` datetime DEFAULT NULL COMMENT '修改时间',
  `created` datetime DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`),
  KEY `order_id` (`order_id`),
  KEY `order_sn` (`order_sn`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='订单明细表';

-- ----------------------------
-- Table structure for payment_record
-- ----------------------------
DROP TABLE IF EXISTS `payment_record`;
CREATE TABLE `payment_record` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT 'id',
  `product_relative_id` bigint DEFAULT NULL COMMENT '相关产品ID',
  `trx_no` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '支付流水号',
  `trx_type` varchar(30) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '交易业务类型  ：消费、充值等',
  `trx_nonce_str` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '签名随机字符串，一般是用来防止重放攻击',
  `create_user_id` bigint DEFAULT NULL,
  `payer_fee` decimal(20,6) DEFAULT '0.000000' COMMENT '付款方手续费',
  `order_ip` varchar(30) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '下单ip(客户端ip,从网关中获取)',
  `order_from` varchar(30) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '订单来源',
  `pay_status` tinyint DEFAULT NULL COMMENT '支付状态：0生成订单未支付（预支付）、1支付成功、 2支付失败',
  `pay_type` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '支付类型编号',
  `pay_bank_type` varchar(128) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '支付银行类型',
  `pay_amount` decimal(20,6) DEFAULT '0.000000' COMMENT '订单金额',
  `pay_success_amount` decimal(20,6) DEFAULT NULL COMMENT '成功支付金额',
  `pay_success_time` datetime DEFAULT NULL COMMENT '支付成功时间',
  `thirdparty_type` varchar(32) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '第三方支付平台',
  `thirdparty_appid` varchar(32) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '微信appid 或者 支付宝的appid，thirdparty 指的是支付的第三方比如微信、支付宝、PayPal等',
  `thirdparty_mch_id` varchar(32) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '商户号',
  `thirdparty_trade_type` varchar(16) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '交易类型',
  `thirdparty_transaction_id` varchar(32) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `thirdparty_user_openid` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `remark` text COLLATE utf8mb4_unicode_ci COMMENT '备注',
  `updated` datetime DEFAULT NULL,
  `created` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `trx_no` (`trx_no`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='支付记录表';

-- ----------------------------
-- Table structure for permission
-- ----------------------------
DROP TABLE IF EXISTS `permission`;
CREATE TABLE `permission` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `parent_id` bigint DEFAULT '0' COMMENT '父节点id',
  `name` varchar(32) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `path` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `component` varchar(128) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `title` varchar(32) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `icon` varchar(128) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `is_link` tinyint(1) DEFAULT '0',
  `is_hide` tinyint(1) DEFAULT '0',
  `is_keep_alive` tinyint(1) DEFAULT '0',
  `is_affix` tinyint(1) DEFAULT '0',
  `is_iframe` tinyint(1) DEFAULT '0',
  `sort_num` int DEFAULT '0',
  `category` varchar(16) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created` datetime DEFAULT NULL,
  `updated` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=51 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='权限表';

-- ----------------------------
-- Records of permission
-- ----------------------------
BEGIN;
INSERT INTO `permission` VALUES (1, 0, 'home', '/home', 'home/index', 'message.router.home', 'iconfont icon-shouye', 0, 0, 1, 1, 0, 0, 'admin', '2021-10-31 23:48:10', '2022-02-19 13:30:50');
INSERT INTO `permission` VALUES (2, 0, 'system', '/system', 'layout/routerView/parent', 'message.router.system', 'iconfont icon-xitongshezhi', 0, 0, 0, 0, 0, 0, 'admin', '2021-11-07 18:16:47', '2022-02-19 12:42:14');
INSERT INTO `permission` VALUES (3, 2, 'systemMenu', '/system/menu', 'system/menu/index', 'message.router.systemMenu', 'iconfont icon-caidan', 0, 0, 0, 0, 0, 0, 'admin', '2021-11-07 18:18:00', NULL);
INSERT INTO `permission` VALUES (4, 2, 'systemRole', '/system/role', 'system/role/index', 'message.router.systemRole', 'el-icon-s-custom', 0, 0, 0, 0, 0, 0, 'admin', '2021-11-08 12:00:50', NULL);
INSERT INTO `permission` VALUES (5, 2, 'systemUser', '/system/user', 'system/user/index', 'message.router.systemUser', 'el-icon-user-solid', 0, 0, 0, 0, 0, 0, 'admin', '2021-11-08 12:02:28', NULL);
INSERT INTO `permission` VALUES (6, 0, 'attach', '/attach', 'layout/routerView/parent', 'message.router.attach', 'el-icon-picture', 0, 0, 0, 0, 0, 0, NULL, '2021-11-21 10:05:27', '2022-02-19 12:42:27');
INSERT INTO `permission` VALUES (7, 6, 'attachManager', '/attach/index', 'attach/index', 'message.router.attachManager', 'el-icon-picture-outline', 0, 0, 0, 0, 0, 0, NULL, '2021-11-21 10:11:16', NULL);
INSERT INTO `permission` VALUES (8, 6, 'attachSet', '/attach/set', 'attach/set', 'message.router.attachSet', 'el-icon-s-tools', 0, 0, 0, 0, 0, 0, NULL, '2021-11-21 10:12:33', NULL);
INSERT INTO `permission` VALUES (9, 0, 'plugin', '/plugin', 'layout/routerView/parent', 'message.router.plugin', 'el-icon-s-home', 0, 0, 0, 0, 0, 0, NULL, '2021-11-21 10:14:05', '2022-02-19 12:42:45');
INSERT INTO `permission` VALUES (10, 9, 'pluginManager', '/plugin/index', 'plugin/index', 'message.router.pluginManager', 'el-icon-s-management', 0, 0, 0, 0, 0, 0, NULL, '2021-11-21 10:15:58', '2021-12-07 10:30:45');
INSERT INTO `permission` VALUES (11, 0, 'article', '/article', 'layout/routerView/parent', 'message.router.article', 'el-icon-s-order', 0, 0, 0, 0, 0, 0, NULL, '2021-11-21 10:18:10', '2022-02-19 12:42:53');
INSERT INTO `permission` VALUES (12, 11, 'articleManager', '/article/index', 'article/index', 'message.router.articleManager', 'el-icon-s-fold', 0, 0, 0, 0, 0, 0, NULL, '2021-11-21 10:18:50', '2021-11-23 15:33:39');
INSERT INTO `permission` VALUES (13, 11, 'articleWrite', '/article/write', 'article/write', 'message.router.articleWrite', 'el-icon-edit', 0, 0, 0, 0, 0, 0, NULL, '2021-11-21 10:18:50', '2021-11-23 15:33:39');
INSERT INTO `permission` VALUES (14, 11, 'articleCategory', '/article/category', 'article/category', 'message.router.articleCategory', 'el-icon-s-operation', 0, 0, 0, 0, 0, 0, NULL, '2021-11-21 10:20:16', '2021-12-11 16:36:37');
INSERT INTO `permission` VALUES (15, 11, 'articleComment', '/article/comment', 'article/comment', 'message.router.articleComment', 'el-icon-chat-dot-square', 0, 0, 0, 0, 0, 0, NULL, '2021-11-21 10:21:14', '2021-12-11 16:36:58');
INSERT INTO `permission` VALUES (16, 11, 'articleSet', '/article/set', 'article/set', 'message.router.articleSet', 'el-icon-setting', 0, 0, 0, 0, 0, 0, NULL, '2021-11-21 10:19:39', '2021-12-11 16:31:02');
INSERT INTO `permission` VALUES (17, 0, 'page', '/page', 'layout/routerView/parent', 'message.router.page', 'el-icon-document-copy', 0, 0, 0, 0, 0, 0, NULL, '2021-11-21 10:22:10', '2022-02-19 12:42:59');
INSERT INTO `permission` VALUES (18, 17, 'pageManager', '/page/index', 'page/index', 'message.router.pageManager', 'el-icon-document', 0, 0, 0, 0, 0, 0, NULL, '2021-11-21 10:23:22', '2021-12-07 10:31:22');
INSERT INTO `permission` VALUES (19, 17, 'pageWrite', '/page/write', 'page/write', 'message.router.pageWrite', 'el-icon-edit-outline', 0, 0, 0, 0, 0, 0, NULL, '2021-11-21 10:25:56', '2021-12-11 16:37:58');
INSERT INTO `permission` VALUES (20, 17, 'pageComment', '/page/comment', 'page/comment', 'message.router.pageComment', 'el-icon-chat-dot-square', 0, 0, 0, 0, 0, 0, NULL, '2021-11-21 10:25:56', '2021-12-11 16:37:58');
INSERT INTO `permission` VALUES (21, 17, 'pageSet', '/page/set', 'page/set', 'message.router.pageSet', 'el-icon-setting', 0, 0, 0, 0, 0, 0, NULL, '2021-11-21 10:26:27', '2021-12-11 16:38:16');
INSERT INTO `permission` VALUES (22, 0, 'template', '/template', 'layout/routerView/parent', 'message.router.template', 'el-icon-folder-opened', 0, 0, 0, 0, 0, 0, NULL, '2021-11-21 10:28:05', '2022-02-19 12:43:06');
INSERT INTO `permission` VALUES (23, 22, 'templateManager', '/template/index', 'template/index', 'message.router.templateManager', 'el-icon-folder', 0, 0, 0, 0, 0, 0, NULL, '2021-11-21 10:28:39', '2021-12-07 10:32:31');
INSERT INTO `permission` VALUES (24, 22, 'templateEdit', '/template/edit', 'template/edit', 'message.router.templateEdit', 'el-icon-folder-checked', 0, 0, 0, 0, 0, 0, NULL, '2021-11-21 10:29:13', '2021-12-07 10:33:00');
INSERT INTO `permission` VALUES (25, 22, 'templateMenu', '/template/menu', 'template/menu', 'message.router.templateMenu', 'el-icon-notebook-2', 0, 0, 0, 0, 0, 0, NULL, '2021-11-21 10:29:49', '2021-12-10 19:31:26');
INSERT INTO `permission` VALUES (26, 22, 'templateSet', '/template/set', 'template/set', 'message.router.templateSet', 'el-icon-setting', 0, 0, 0, 0, 0, 0, NULL, '2021-11-21 10:30:17', NULL);
INSERT INTO `permission` VALUES (27, 0, 'setting', '/setting', 'layout/routerView/parent', 'message.router.setting', 'el-icon-s-tools', 0, 0, 0, 0, 0, 999, NULL, '2021-12-02 14:28:36', '2022-02-19 13:31:10');
INSERT INTO `permission` VALUES (28, 27, 'websiteSet', '/setting/website', 'setting/website', 'message.router.websiteSet', 'el-icon-eleme', 0, 0, 0, 0, 0, 0, NULL, '2021-12-02 14:30:44', NULL);
INSERT INTO `permission` VALUES (29, 0, 'order', '/order', 'layout/routerView/parent', 'message.router.order', 'el-icon-shopping-bag-1', 0, 0, 0, 0, 0, 0, NULL, '2022-02-19 11:30:56', '2022-02-19 12:43:11');
INSERT INTO `permission` VALUES (30, 29, 'orderManager', '/order/index', 'order/index', 'message.router.orderManager', 'el-icon-postcard', 0, 0, 0, 0, 0, 0, NULL, '2022-02-19 11:33:21', NULL);
INSERT INTO `permission` VALUES (31, 29, 'orderSet', '/order/set', 'order/set', 'message.router.orderSet', 'el-icon-setting', 0, 0, 0, 0, 0, 999, NULL, '2022-02-19 11:34:19', NULL);
INSERT INTO `permission` VALUES (32, 27, 'wechatSet', '/setting/wechat', 'setting/wechat', 'message.router.wechatSet', 'el-icon-star-off', 0, 0, 0, 0, 0, 0, NULL, '2022-03-02 23:18:57', NULL);
INSERT INTO `permission` VALUES (33, 27, 'connectionSet', '/setting/connection', 'setting/connection', 'message.router.connectionSet', 'el-icon-phone-outline', 0, 0, 0, 0, 0, 0, NULL, '2022-03-22 20:22:34', '2022-03-22 20:23:09');
INSERT INTO `permission` VALUES (34, 2, 'systemDept', '/system/dept', 'system/dept/index', 'message.router.systemDept', 'el-icon-office-building', 0, 0, 0, 0, 0, 0, NULL, '2022-03-23 19:35:15', '2022-03-23 19:38:05');
INSERT INTO `permission` VALUES (35, 29, 'paymentManager', '/payment/index', 'payment/index', 'message.router.paymentManager', 'el-icon-goods', 0, 0, 0, 0, 0, 0, NULL, '2022-04-07 11:22:16', NULL);
INSERT INTO `permission` VALUES (36, 29, 'cashoutManager', '/cashout/index', 'cashout/index', 'message.router.cashoutManager', 'el-icon-files', 0, 0, 0, 0, 0, 0, NULL, '2022-04-07 11:25:14', NULL);
INSERT INTO `permission` VALUES (37, 0, 'user', '/user', 'layout/routerView/parent', 'message.router.user', 'el-icon-user', 0, 0, 0, 0, 0, 0, NULL, '2022-04-27 11:02:31', NULL);
INSERT INTO `permission` VALUES (38, 37, 'userManager', '/user/index', 'user/index', 'message.router.userManager', 'el-icon-user-solid', 0, 0, 0, 0, 0, 0, NULL, '2022-04-27 11:13:00', NULL);
INSERT INTO `permission` VALUES (39, 2, 'systemRes', '/system/res', 'system/res/index', 'message.router.systemRes', 'el-icon-s-data', 0, 0, 0, 0, 0, 0, NULL, '2022-05-02 18:15:51', '2022-05-02 18:20:17');
INSERT INTO `permission` VALUES (40, 27, 'systemSet', '/setting/system', 'setting/system', 'message.router.systemSet', 'el-icon-lock', 0, 0, 0, 0, 0, 0, NULL, '2022-08-06 12:48:45', '2022-08-06 12:49:45');
INSERT INTO `permission` VALUES (41, 11, 'articleTag', '/article/tag', 'article/tag', 'message.router.articleTag', 'el-icon-price-tag', 0, 0, 0, 0, 0, 0, NULL, '2022-11-25 16:05:46', NULL);
INSERT INTO `permission` VALUES (42, 2, 'systemCompany', '/system/company', 'system/company/index', 'message.router.systemCompany', 'el-icon-s-shop', 0, 0, 0, 0, 0, 0, NULL, '2023-03-25 17:15:17', NULL);
INSERT INTO `permission` VALUES (43, 0, 'product', '/product', 'layout/routerView/parent', 'message.router.product', 'el-icon-s-shop', 0, 0, 0, 0, 0, 0, NULL, '2023-04-03 10:30:02', '2023-04-03 10:42:10');
INSERT INTO `permission` VALUES (44, 43, 'productCategory', '/product/productCategory', '/product/productCategory/index', 'message.router.productCategory', 'el-icon-folder-opened', 0, 0, 0, 0, 0, 0, NULL, '2023-04-03 10:35:21', '2023-04-15 14:53:44');
INSERT INTO `permission` VALUES (45, 43, 'productBanner', '/product/productBanner', '/product/productBanner/index', 'message.router.productBanner', '', 0, 1, 0, 0, 0, 0, NULL, '2023-04-06 20:33:02', NULL);
INSERT INTO `permission` VALUES (46, 43, 'productList', '/product/product', '/product/product/index', 'message.router.productList', 'el-icon-notebook-2', 0, 0, 0, 0, 0, 0, NULL, '2023-04-17 17:03:00', '2023-04-17 17:03:28');
INSERT INTO `permission` VALUES (47, 0, 'navsite', '/navsite', 'layout/routerView/parent', 'message.router.navsite', 'el-icon-platform-eleme', 0, 0, 0, 0, 0, 0, NULL, '2023-06-29 15:15:36', '2023-06-29 15:50:37');
INSERT INTO `permission` VALUES (48, 47, 'navCategory', '/navsite/navCategory', '/navsite/navCategory/index', 'message.router.navCategory', 'el-icon-eleme', 0, 0, 0, 0, 0, 0, NULL, '2023-06-29 15:49:00', '2023-06-29 16:20:00');
INSERT INTO `permission` VALUES (49, 47, 'navlink', '/navsite/navlink', '/navsite/navlink/index', 'message.router.navlink', 'el-icon-picture', 0, 0, 0, 0, 0, 0, NULL, '2023-06-29 15:52:42', '2023-06-29 15:53:15');
INSERT INTO `permission` VALUES (50, 43, 'wechatTest', '/product/test', '/product/test/wechatTest', 'message.router.wechatTest', 'el-icon-eleme', 0, 0, 0, 0, 0, 0, NULL, '2023-07-27 10:49:47', '2023-07-27 10:53:08');
COMMIT;

-- ----------------------------
-- Table structure for resource
-- ----------------------------
DROP TABLE IF EXISTS `resource`;
CREATE TABLE `resource` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `resource_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '资源名称',
  `resource_path` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '资源路径',
  `action_type` varchar(16) COLLATE utf8mb4_unicode_ci DEFAULT 'r' COMMENT 'r读 w写',
  `created` datetime DEFAULT NULL,
  `updated` datetime DEFAULT NULL,
  `language` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '语言',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=503 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='接口资源表';

-- ----------------------------
-- Records of resource
-- ----------------------------
BEGIN;
INSERT INTO `resource` VALUES (416, '订单删除', 'orders:delete', 'w', '2023-06-19 11:31:10', NULL, 'zh');
INSERT INTO `resource` VALUES (417, '用户类型修改', 'users:changeUserType', 'w', '2023-06-19 11:31:10', NULL, 'zh');
INSERT INTO `resource` VALUES (418, '页面保存', 'pages:save', 'w', '2023-06-19 11:31:10', NULL, 'zh');
INSERT INTO `resource` VALUES (419, '订单支付列表', 'orders:payment/list', 'r', '2023-06-19 11:31:10', NULL, 'zh');
INSERT INTO `resource` VALUES (420, '路由保存', 'routers:save', 'w', '2023-06-19 11:31:10', NULL, 'zh');
INSERT INTO `resource` VALUES (421, '模板文件上传', 'templates:files/upload', 'w', '2023-06-19 11:31:10', NULL, 'zh');
INSERT INTO `resource` VALUES (422, '用户保存', 'users:save', 'w', '2023-06-19 11:31:10', NULL, 'zh');
INSERT INTO `resource` VALUES (423, '订单详情', 'orders:detail', 'r', '2023-06-19 11:31:10', NULL, 'zh');
INSERT INTO `resource` VALUES (424, '用户删除', 'users:delete', 'w', '2023-06-19 11:31:10', NULL, 'zh');
INSERT INTO `resource` VALUES (425, '文章删除', 'articles:delete', 'w', '2023-06-19 11:31:10', NULL, 'zh');
INSERT INTO `resource` VALUES (426, '产品分类列表', 'category:list', 'r', '2023-06-19 11:31:10', NULL, 'zh');
INSERT INTO `resource` VALUES (427, '角色保存', 'roles:save', 'w', '2023-06-19 11:31:10', NULL, 'zh');
INSERT INTO `resource` VALUES (428, '用户标签分配', 'users:tags/save', 'w', '2023-06-19 11:31:10', NULL, 'zh');
INSERT INTO `resource` VALUES (429, '产品分类保存', 'category:save', 'w', '2023-06-19 11:31:10', NULL, 'zh');
INSERT INTO `resource` VALUES (430, '附件删除', 'attachment:delete', 'w', '2023-06-19 11:31:10', NULL, 'zh');
INSERT INTO `resource` VALUES (431, '附件修改', 'attachment:update', 'w', '2023-06-19 11:31:10', NULL, 'zh');
INSERT INTO `resource` VALUES (432, '插件配置', 'plugin:config/url', 'w', '2023-06-19 11:31:10', NULL, 'zh');
INSERT INTO `resource` VALUES (433, '订单提现详情', 'orders:cashout/detail', 'r', '2023-06-19 11:31:10', NULL, 'zh');
INSERT INTO `resource` VALUES (434, '用户密码修改', 'users:password/update', 'w', '2023-06-19 11:31:10', NULL, 'zh');
INSERT INTO `resource` VALUES (435, '模板安装', 'templates:install', 'w', '2023-06-19 11:31:10', NULL, 'zh');
INSERT INTO `resource` VALUES (436, '插件列表', 'plugin:list', 'r', '2023-06-19 11:31:10', NULL, 'zh');
INSERT INTO `resource` VALUES (437, '模板文件列表', 'templates:files/tree/list', 'r', '2023-06-19 11:31:10', NULL, 'zh');
INSERT INTO `resource` VALUES (438, '页面评论保存', 'pages:comment/save', 'w', '2023-06-19 11:31:10', NULL, 'zh');
INSERT INTO `resource` VALUES (439, '产品分类列表', 'category:plist', 'r', '2023-06-19 11:31:10', NULL, 'zh');
INSERT INTO `resource` VALUES (440, '模板卸载', 'templates:unInstall', 'w', '2023-06-19 11:31:10', NULL, 'zh');
INSERT INTO `resource` VALUES (441, '插件安装', 'plugin:install', 'w', '2023-06-19 11:31:10', NULL, 'zh');
INSERT INTO `resource` VALUES (442, '公司删除', 'cmpy:delete', 'w', '2023-06-19 11:31:10', NULL, 'zh');
INSERT INTO `resource` VALUES (443, '公司分页列表', 'cmpy:plist', 'r', '2023-06-19 11:31:10', NULL, 'zh');
INSERT INTO `resource` VALUES (444, '文章详情', 'articles:get', 'r', '2023-06-19 11:31:10', NULL, 'zh');
INSERT INTO `resource` VALUES (445, '文章评论列表', 'articles:comment/list', 'r', '2023-06-19 11:31:10', NULL, 'zh');
INSERT INTO `resource` VALUES (446, '公司列表', 'cmpy:list', 'r', '2023-06-19 11:31:10', NULL, 'zh');
INSERT INTO `resource` VALUES (447, '配置保存', 'config:save', 'w', '2023-06-19 11:31:10', NULL, 'zh');
INSERT INTO `resource` VALUES (448, '模板菜单详情', 'templates:menu/get', 'r', '2023-06-19 11:31:10', NULL, 'zh');
INSERT INTO `resource` VALUES (449, '模板文件信息', 'templates:files/get', 'r', '2023-06-19 11:31:10', NULL, 'zh');
INSERT INTO `resource` VALUES (450, '部门列表', 'department:list', 'r', '2023-06-19 11:31:10', NULL, 'zh');
INSERT INTO `resource` VALUES (451, '页面列表', 'pages:list', 'r', '2023-06-19 11:31:10', NULL, 'zh');
INSERT INTO `resource` VALUES (452, '附件列表', 'attachment:list', 'r', '2023-06-19 11:31:10', NULL, 'zh');
INSERT INTO `resource` VALUES (453, '角色权限保存', 'roles:permissions/save', 'w', '2023-06-19 11:31:10', NULL, 'zh');
INSERT INTO `resource` VALUES (454, '用户密码重置', 'users:resetPassword', 'w', '2023-06-19 11:31:10', NULL, 'zh');
INSERT INTO `resource` VALUES (455, '模板启用', 'templates:enable', 'w', '2023-06-19 11:31:10', NULL, 'zh');
INSERT INTO `resource` VALUES (456, '用户列表', 'users:list', 'r', '2023-06-19 11:31:10', NULL, 'zh');
INSERT INTO `resource` VALUES (457, '文章评论删除', 'articles:comment/delete/', 'w', '2023-06-19 11:31:10', NULL, 'zh');
INSERT INTO `resource` VALUES (458, '模板菜单保存', 'templates:menu/save', 'w', '2023-06-19 11:31:10', NULL, 'zh');
INSERT INTO `resource` VALUES (459, '文章列表', 'articles:list', 'r', '2023-06-19 11:31:10', NULL, 'zh');
INSERT INTO `resource` VALUES (460, '部门删除', 'department:delete', 'w', '2023-06-19 11:31:10', NULL, 'zh');
INSERT INTO `resource` VALUES (461, '订单列表', 'orders:list', 'r', '2023-06-19 11:31:10', NULL, 'zh');
INSERT INTO `resource` VALUES (462, '产品分页列表', 'prod:plist', 'r', '2023-06-19 11:31:10', NULL, 'zh');
INSERT INTO `resource` VALUES (463, '资源列表', 'resource:list', 'r', '2023-06-19 11:31:10', NULL, 'zh');
INSERT INTO `resource` VALUES (464, '文章保存', 'articles:save', 'w', '2023-06-19 11:31:10', NULL, 'zh');
INSERT INTO `resource` VALUES (465, '模板菜单列表', 'templates:menu/list', 'r', '2023-06-19 11:31:10', NULL, 'zh');
INSERT INTO `resource` VALUES (466, '订单提现拒绝', 'orders:cashout/refuse', 'w', '2023-06-19 11:31:10', NULL, 'zh');
INSERT INTO `resource` VALUES (467, '页面评论列表', 'pages:comment/list', 'r', '2023-06-19 11:31:10', NULL, 'zh');
INSERT INTO `resource` VALUES (468, '订单支付详情', 'orders:payment/detail', 'r', '2023-06-19 11:31:10', NULL, 'zh');
INSERT INTO `resource` VALUES (469, '文章分类删除', 'articles:category/delete', 'w', '2023-06-19 11:31:10', NULL, 'zh');
INSERT INTO `resource` VALUES (470, '文章标签保存', 'articles:tag/save', 'w', '2023-06-19 11:31:10', NULL, 'zh');
INSERT INTO `resource` VALUES (471, '模板文件删除', 'templates:file/delete', 'w', '2023-06-19 11:31:10', NULL, 'zh');
INSERT INTO `resource` VALUES (472, '附件上传', 'attachment:upload', 'w', '2023-06-19 11:31:10', NULL, 'zh');
INSERT INTO `resource` VALUES (473, '用户角色分配', 'users:roles/save', 'w', '2023-06-19 11:31:10', NULL, 'zh');
INSERT INTO `resource` VALUES (474, '页面删除', 'pages:delete', 'w', '2023-06-19 11:31:10', NULL, 'zh');
INSERT INTO `resource` VALUES (475, '附件详情', 'attachment:get', 'r', '2023-06-19 11:31:10', NULL, 'zh');
INSERT INTO `resource` VALUES (476, '页面详情', 'pages:get', 'r', '2023-06-19 11:31:10', NULL, 'zh');
INSERT INTO `resource` VALUES (477, '产品分类详情', 'category:get', 'r', '2023-06-19 11:31:10', NULL, 'zh');
INSERT INTO `resource` VALUES (478, '角色列表', 'roles:list', 'r', '2023-06-19 11:31:10', NULL, 'zh');
INSERT INTO `resource` VALUES (479, '产品保存', 'prod:save', 'w', '2023-06-19 11:31:10', NULL, 'zh');
INSERT INTO `resource` VALUES (480, '部门保存', 'department:save', 'w', '2023-06-19 11:31:10', NULL, 'zh');
INSERT INTO `resource` VALUES (481, '路由列表', 'routers:list', 'r', '2023-06-19 11:31:10', NULL, 'zh');
INSERT INTO `resource` VALUES (482, '路由删除', 'routers:delete', 'w', '2023-06-19 11:31:10', NULL, 'zh');
INSERT INTO `resource` VALUES (483, '产品列表', 'prod:list', 'r', '2023-06-19 11:31:10', NULL, 'zh');
INSERT INTO `resource` VALUES (484, '角色删除', 'roles:delete', 'w', '2023-06-19 11:31:10', NULL, 'zh');
INSERT INTO `resource` VALUES (485, '公司详情', 'cmpy:get', 'r', '2023-06-19 11:31:10', NULL, 'zh');
INSERT INTO `resource` VALUES (486, '公司保存', 'cmpy:save', 'w', '2023-06-19 11:31:10', NULL, 'zh');
INSERT INTO `resource` VALUES (487, '产品详情', 'prod:get', 'r', '2023-06-19 11:31:10', NULL, 'zh');
INSERT INTO `resource` VALUES (488, '订单提现确认', 'orders:cashout/confirm', 'w', '2023-06-19 11:31:10', NULL, 'zh');
INSERT INTO `resource` VALUES (489, '模板列表', 'templates:list', 'r', '2023-06-19 11:31:10', NULL, 'zh');
INSERT INTO `resource` VALUES (490, '模板文件保存', 'templates:file/save', 'w', '2023-06-19 11:31:10', NULL, 'zh');
INSERT INTO `resource` VALUES (491, '模板菜单删除', 'templates:menu/delete', 'w', '2023-06-19 11:31:10', NULL, 'zh');
INSERT INTO `resource` VALUES (492, '文章分类保存', 'articles:category/save', 'w', '2023-06-19 11:31:10', NULL, 'zh');
INSERT INTO `resource` VALUES (493, '文章标签删除', 'articles:tag/delete', 'w', '2023-06-19 11:31:10', NULL, 'zh');
INSERT INTO `resource` VALUES (494, '角色权限列表', 'roles:permissions/list', 'r', '2023-06-19 11:31:10', NULL, 'zh');
INSERT INTO `resource` VALUES (495, '页面评论删除', 'pages:comment/delete', 'w', '2023-06-19 11:31:10', NULL, 'zh');
INSERT INTO `resource` VALUES (496, '产品分类删除', 'category:delete', 'w', '2023-06-19 11:31:10', NULL, 'zh');
INSERT INTO `resource` VALUES (497, '用户详情', 'users:get', 'r', '2023-06-19 11:31:10', NULL, 'zh');
INSERT INTO `resource` VALUES (498, '资源同步', 'resource:sync', 'w', '2023-06-19 11:31:10', NULL, 'zh');
INSERT INTO `resource` VALUES (499, '文章评论保存', 'articles:comment/save', 'w', '2023-06-19 11:31:10', NULL, 'zh');
INSERT INTO `resource` VALUES (500, '配置列表', 'config:list', 'r', '2023-06-19 11:31:10', NULL, 'zh');
INSERT INTO `resource` VALUES (501, '订单提现列表', 'orders:cashout/list', 'r', '2023-06-19 11:31:10', NULL, 'zh');
INSERT INTO `resource` VALUES (502, '插件卸载', 'plugin:unInstall', 'w', '2023-06-19 11:31:10', NULL, 'zh');
COMMIT;

-- ----------------------------
-- Table structure for role
-- ----------------------------
DROP TABLE IF EXISTS `role`;
CREATE TABLE `role` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `role_name` varchar(128) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '角色名称',
  `role_desc` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '角色描述',
  `created` datetime DEFAULT NULL,
  `updated` datetime DEFAULT NULL,
  `active` int DEFAULT '1' COMMENT '是否启用',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='角色表';

-- ----------------------------
-- Records of role
-- ----------------------------
BEGIN;
INSERT INTO `role` VALUES (1, '超级管理员', '超级管理员角色是系统内置角色，拥有系统最大权限', '2023-03-01 20:12:30', '2023-03-01 20:12:30', 1);
INSERT INTO `role` VALUES (2, '管理员', '系统操作', '2023-03-25 20:44:24', NULL, 1);
INSERT INTO `role` VALUES (3, '小程序管理员', '小程序管理员', '2023-06-19 10:31:05', NULL, 1);
COMMIT;

-- ----------------------------
-- Table structure for role_permission
-- ----------------------------
DROP TABLE IF EXISTS `role_permission`;
CREATE TABLE `role_permission` (
  `role_id` bigint NOT NULL COMMENT '角色id',
  `permission_id` bigint NOT NULL COMMENT '权限id',
  PRIMARY KEY (`role_id`,`permission_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='角色权限关联表';

-- ----------------------------
-- Records of role_permission
-- ----------------------------
BEGIN;
INSERT INTO `role_permission` VALUES (3, 1);
INSERT INTO `role_permission` VALUES (3, 43);
INSERT INTO `role_permission` VALUES (3, 44);
INSERT INTO `role_permission` VALUES (3, 45);
INSERT INTO `role_permission` VALUES (3, 46);
COMMIT;

-- ----------------------------
-- Table structure for role_resource
-- ----------------------------
DROP TABLE IF EXISTS `role_resource`;
CREATE TABLE `role_resource` (
  `role_id` bigint NOT NULL,
  `resource_path` varchar(128) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`role_id`,`resource_path`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='接口资源关联表';

-- ----------------------------
-- Records of role_resource
-- ----------------------------
BEGIN;
INSERT INTO `role_resource` VALUES (3, 'articles:category/delete');
INSERT INTO `role_resource` VALUES (3, 'articles:category/save');
INSERT INTO `role_resource` VALUES (3, 'articles:comment/delete/');
INSERT INTO `role_resource` VALUES (3, 'articles:comment/list');
INSERT INTO `role_resource` VALUES (3, 'articles:comment/save');
INSERT INTO `role_resource` VALUES (3, 'articles:delete');
INSERT INTO `role_resource` VALUES (3, 'articles:get');
INSERT INTO `role_resource` VALUES (3, 'articles:list');
INSERT INTO `role_resource` VALUES (3, 'articles:save');
INSERT INTO `role_resource` VALUES (3, 'articles:tag/delete');
INSERT INTO `role_resource` VALUES (3, 'articles:tag/save');
INSERT INTO `role_resource` VALUES (3, 'attachment:delete');
INSERT INTO `role_resource` VALUES (3, 'attachment:get');
INSERT INTO `role_resource` VALUES (3, 'attachment:list');
INSERT INTO `role_resource` VALUES (3, 'attachment:update');
INSERT INTO `role_resource` VALUES (3, 'attachment:upload');
INSERT INTO `role_resource` VALUES (3, 'category:delete');
INSERT INTO `role_resource` VALUES (3, 'category:get');
INSERT INTO `role_resource` VALUES (3, 'category:list');
INSERT INTO `role_resource` VALUES (3, 'category:plist');
INSERT INTO `role_resource` VALUES (3, 'category:save');
INSERT INTO `role_resource` VALUES (3, 'cmpy:delete');
INSERT INTO `role_resource` VALUES (3, 'cmpy:get');
INSERT INTO `role_resource` VALUES (3, 'cmpy:list');
INSERT INTO `role_resource` VALUES (3, 'cmpy:plist');
INSERT INTO `role_resource` VALUES (3, 'cmpy:save');
INSERT INTO `role_resource` VALUES (3, 'config:list');
INSERT INTO `role_resource` VALUES (3, 'config:save');
INSERT INTO `role_resource` VALUES (3, 'department:delete');
INSERT INTO `role_resource` VALUES (3, 'department:list');
INSERT INTO `role_resource` VALUES (3, 'department:save');
INSERT INTO `role_resource` VALUES (3, 'orders:cashout/confirm');
INSERT INTO `role_resource` VALUES (3, 'orders:cashout/detail');
INSERT INTO `role_resource` VALUES (3, 'orders:cashout/list');
INSERT INTO `role_resource` VALUES (3, 'orders:cashout/refuse');
INSERT INTO `role_resource` VALUES (3, 'orders:delete');
INSERT INTO `role_resource` VALUES (3, 'orders:detail');
INSERT INTO `role_resource` VALUES (3, 'orders:list');
INSERT INTO `role_resource` VALUES (3, 'orders:payment/detail');
INSERT INTO `role_resource` VALUES (3, 'orders:payment/list');
INSERT INTO `role_resource` VALUES (3, 'pages:comment/delete');
INSERT INTO `role_resource` VALUES (3, 'pages:comment/list');
INSERT INTO `role_resource` VALUES (3, 'pages:comment/save');
INSERT INTO `role_resource` VALUES (3, 'pages:delete');
INSERT INTO `role_resource` VALUES (3, 'pages:get');
INSERT INTO `role_resource` VALUES (3, 'pages:list');
INSERT INTO `role_resource` VALUES (3, 'pages:save');
INSERT INTO `role_resource` VALUES (3, 'plugin:config/url');
INSERT INTO `role_resource` VALUES (3, 'plugin:install');
INSERT INTO `role_resource` VALUES (3, 'plugin:list');
INSERT INTO `role_resource` VALUES (3, 'plugin:unInstall');
INSERT INTO `role_resource` VALUES (3, 'prod:get');
INSERT INTO `role_resource` VALUES (3, 'prod:list');
INSERT INTO `role_resource` VALUES (3, 'prod:plist');
INSERT INTO `role_resource` VALUES (3, 'prod:save');
INSERT INTO `role_resource` VALUES (3, 'resource:list');
INSERT INTO `role_resource` VALUES (3, 'resource:sync');
INSERT INTO `role_resource` VALUES (3, 'roles:delete');
INSERT INTO `role_resource` VALUES (3, 'roles:list');
INSERT INTO `role_resource` VALUES (3, 'roles:permissions/list');
INSERT INTO `role_resource` VALUES (3, 'roles:permissions/save');
INSERT INTO `role_resource` VALUES (3, 'roles:save');
INSERT INTO `role_resource` VALUES (3, 'routers:delete');
INSERT INTO `role_resource` VALUES (3, 'routers:list');
INSERT INTO `role_resource` VALUES (3, 'routers:save');
INSERT INTO `role_resource` VALUES (3, 'templates:enable');
INSERT INTO `role_resource` VALUES (3, 'templates:file/delete');
INSERT INTO `role_resource` VALUES (3, 'templates:file/save');
INSERT INTO `role_resource` VALUES (3, 'templates:files/get');
INSERT INTO `role_resource` VALUES (3, 'templates:files/tree/list');
INSERT INTO `role_resource` VALUES (3, 'templates:files/upload');
INSERT INTO `role_resource` VALUES (3, 'templates:install');
INSERT INTO `role_resource` VALUES (3, 'templates:list');
INSERT INTO `role_resource` VALUES (3, 'templates:menu/delete');
INSERT INTO `role_resource` VALUES (3, 'templates:menu/get');
INSERT INTO `role_resource` VALUES (3, 'templates:menu/list');
INSERT INTO `role_resource` VALUES (3, 'templates:menu/save');
INSERT INTO `role_resource` VALUES (3, 'templates:unInstall');
INSERT INTO `role_resource` VALUES (3, 'users:changeUserType');
INSERT INTO `role_resource` VALUES (3, 'users:delete');
INSERT INTO `role_resource` VALUES (3, 'users:get');
INSERT INTO `role_resource` VALUES (3, 'users:list');
INSERT INTO `role_resource` VALUES (3, 'users:password/update');
INSERT INTO `role_resource` VALUES (3, 'users:resetPassword');
INSERT INTO `role_resource` VALUES (3, 'users:roles/save');
INSERT INTO `role_resource` VALUES (3, 'users:save');
INSERT INTO `role_resource` VALUES (3, 'users:tags/save');
COMMIT;

-- ----------------------------
-- Table structure for single_page
-- ----------------------------
DROP TABLE IF EXISTS `single_page`;
CREATE TABLE `single_page` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `create_user_id` bigint DEFAULT NULL,
  `title` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '标题',
  `path` varchar(32) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `content_html` longtext COLLATE utf8mb4_unicode_ci COMMENT '内容',
  `out_link` varchar(512) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '链接',
  `seo_keywords` varchar(256) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'SEO关键字',
  `seo_description` varchar(256) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'SEO描述信息',
  `summary` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '摘要',
  `thumbnail` varchar(128) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '缩略图',
  `style` varchar(32) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '样式',
  `status` varchar(32) COLLATE utf8mb4_unicode_ci DEFAULT 'publish' COMMENT '状态',
  `suffix` varchar(32) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '页面后缀',
  `view_count` int unsigned DEFAULT '0' COMMENT '访问量',
  `comment_enable` tinyint DEFAULT NULL,
  `created` datetime DEFAULT NULL COMMENT '创建日期',
  `updated` datetime DEFAULT NULL COMMENT '最后更新日期',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='单页表';

-- ----------------------------
-- Records of single_page
-- ----------------------------
BEGIN;
INSERT INTO `single_page` VALUES (1, 1, '关于导航', 'aboutNav.html', '<p>关于导航关于导航关于导航关于导航关于导航</p>', NULL, '关于导航关于导航', '关于导航关于导航关于导航', NULL, NULL, NULL, 'publish', NULL, 2, 0, '2023-08-04 09:11:56', NULL);
COMMIT;

-- ----------------------------
-- Table structure for single_page_comment
-- ----------------------------
DROP TABLE IF EXISTS `single_page_comment`;
CREATE TABLE `single_page_comment` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `parent_id` bigint unsigned DEFAULT NULL COMMENT '回复的评论ID',
  `page_id` bigint unsigned DEFAULT NULL COMMENT '评论的内容ID',
  `create_user_id` bigint DEFAULT NULL,
  `content` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '评论的内容',
  `reply_count` int unsigned DEFAULT '0' COMMENT '评论的回复数量',
  `sort_num` int DEFAULT '0' COMMENT '排序编号，常用语置顶等',
  `status` varchar(32) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '评论的状态',
  `created` datetime DEFAULT NULL COMMENT '评论的时间',
  `updated` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `page_id` (`page_id`),
  KEY `user_id` (`create_user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='页面评论表';

-- ----------------------------
-- Table structure for test
-- ----------------------------
DROP TABLE IF EXISTS `test`;
CREATE TABLE `test` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ----------------------------
-- Table structure for user
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `user_name` varchar(32) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '真实名称',
  `nick_name` varchar(32) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '用户昵称',
  `real_name` varchar(32) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '真实姓名',
  `email` varchar(128) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `head_img` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `mobile` varchar(32) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '手机号码',
  `address` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `company` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `autograph` varchar(1024) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '个性签名',
  `sex` tinyint DEFAULT '1' COMMENT '1男0女',
  `source` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '来源',
  `password` varchar(256) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '登录密码',
  `salt` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '加密盐值',
  `status` tinyint DEFAULT '1' COMMENT '0禁用1正常',
  `login_time` datetime DEFAULT NULL COMMENT '最近登录时间',
  `access_ip` varchar(32) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '登录IP',
  `user_type` tinyint DEFAULT '2' COMMENT '1 系统用户，2 用户',
  `created` datetime DEFAULT NULL,
  `updated` datetime DEFAULT NULL,
  `version` int DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `user_type` (`user_type`),
  KEY `user_name_index` (`user_name`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='用户';

-- ----------------------------
-- Records of user
-- ----------------------------
BEGIN;
INSERT INTO `user` VALUES (1, 'admin', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, NULL, '$2a$10$Lpudyy6BI./H9UJc9eIPjuflK4g.A.CnwCb1qgE2PGbWyjv2yDfbq', '1622734716287', 1, '2023-08-04 15:04:28', '127.0.0.1', 1, '2023-03-01 20:12:30', '2023-03-01 20:12:30', 66);
INSERT INTO `user` VALUES (2, 'test', '', NULL, '', NULL, '', '', '', NULL, 1, 'admin_create', '$2a$10$B8OSl7n4LSXcfZvhPzmg3.p2zXSHoy4ZwdrHhxuzvOkgOoakSq8am', NULL, 1, NULL, NULL, 1, '2023-03-25 16:58:29', '2023-04-03 10:08:48', 0);
INSERT INTO `user` VALUES (3, 'zxtest', '', NULL, '', NULL, '', '', '', NULL, 1, 'admin_create', '$2a$10$PuJgzAZI9U8seMayk6gR4udi9j6aGpadnWPDiNxp2g0XC3ix51t5O', NULL, 1, '2023-06-19 17:31:52', '127.0.0.1', 1, '2023-06-19 10:32:30', '2023-06-19 10:32:52', 3);
COMMIT;

-- ----------------------------
-- Table structure for user_amount
-- ----------------------------
DROP TABLE IF EXISTS `user_amount`;
CREATE TABLE `user_amount` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `create_user_id` bigint DEFAULT NULL,
  `amount` decimal(20,6) NOT NULL DEFAULT '0.000000',
  `version` int DEFAULT '0',
  `updated` datetime DEFAULT NULL,
  `created` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `user_id` (`create_user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='用户余额';

-- ----------------------------
-- Table structure for user_amount_payout
-- ----------------------------
DROP TABLE IF EXISTS `user_amount_payout`;
CREATE TABLE `user_amount_payout` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `create_user_id` bigint DEFAULT NULL,
  `user_real_name` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '用户的真实名字',
  `user_idcard` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '用户的身份证号码',
  `amount` decimal(10,2) DEFAULT NULL COMMENT '提现金额',
  `pay_type` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '提现类型',
  `pay_to` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '提现账号：可能是微信的openId，可能是支付宝账号，可能是银行账号',
  `pay_success_proof` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '提现成功证明，一般是转账截图',
  `fee` decimal(10,2) DEFAULT NULL COMMENT '提现手续费',
  `statement_id` bigint DEFAULT NULL COMMENT '申请提现成功后会生成一个扣款记录',
  `status` tinyint DEFAULT '0' COMMENT '状态',
  `remarks` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '用户备注',
  `feedback` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '回绝提现时给出原因',
  `audit_type` tinyint DEFAULT '1' COMMENT '审核类型 1人工审核，0自动到账',
  `options` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `created` datetime DEFAULT NULL,
  `updated` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `userid` (`create_user_id`),
  KEY `status` (`status`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='提现申请表';

-- ----------------------------
-- Table structure for user_amount_statement
-- ----------------------------
DROP TABLE IF EXISTS `user_amount_statement`;
CREATE TABLE `user_amount_statement` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `create_user_id` bigint DEFAULT NULL,
  `action` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '金额变动方向 add, del',
  `action_type` int DEFAULT NULL COMMENT '金额变得业务类型1，提现，2，余额支付 等其他业务类型',
  `action_desc` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '金额变动描述',
  `action_order_id` bigint unsigned DEFAULT NULL COMMENT '相关的订单ID',
  `action_payment_id` bigint unsigned DEFAULT NULL COMMENT '相关的支付ID',
  `old_amount` decimal(20,6) NOT NULL COMMENT '用户之前的余额',
  `change_amount` decimal(20,6) NOT NULL COMMENT '变动金额',
  `new_amount` decimal(20,6) NOT NULL COMMENT '变动之后的余额',
  `created` datetime DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`),
  KEY `user_id` (`create_user_id`),
  KEY `action` (`action`),
  KEY `action_type` (`action_type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='用户余额流水情况';

-- ----------------------------
-- Table structure for user_openid
-- ----------------------------
DROP TABLE IF EXISTS `user_openid`;
CREATE TABLE `user_openid` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `user_id` bigint DEFAULT NULL COMMENT '用户ID',
  `type` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '第三方类型：wechat，dingding，qq...',
  `value` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '第三方的openId的值',
  `version` int DEFAULT '0',
  `created` datetime DEFAULT NULL,
  `updated` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`),
  KEY `type_value` (`type`,`value`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='账号绑定信息表';

-- ----------------------------
-- Table structure for user_role
-- ----------------------------
DROP TABLE IF EXISTS `user_role`;
CREATE TABLE `user_role` (
  `user_id` bigint NOT NULL COMMENT '用户id',
  `role_id` bigint NOT NULL COMMENT '角色id',
  PRIMARY KEY (`user_id`,`role_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='用户角色关联表';

-- ----------------------------
-- Records of user_role
-- ----------------------------
BEGIN;
INSERT INTO `user_role` VALUES (1, 1);
INSERT INTO `user_role` VALUES (2, 2);
INSERT INTO `user_role` VALUES (3, 3);
COMMIT;

-- ----------------------------
-- Table structure for user_tag
-- ----------------------------
DROP TABLE IF EXISTS `user_tag`;
CREATE TABLE `user_tag` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `title` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `desc` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `sort_num` int DEFAULT NULL,
  `created` datetime DEFAULT NULL,
  `updated` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ----------------------------
-- Table structure for user_tag_relation
-- ----------------------------
DROP TABLE IF EXISTS `user_tag_relation`;
CREATE TABLE `user_tag_relation` (
  `user_id` bigint NOT NULL AUTO_INCREMENT,
  `tag_id` bigint NOT NULL,
  PRIMARY KEY (`user_id`,`tag_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

SET FOREIGN_KEY_CHECKS = 1;
