-- MySQL dump 10.13  Distrib 5.7.26, for Linux (x86_64)
--
-- Host: localhost    Database: pam
-- ------------------------------------------------------
-- Server version	5.7.26-0ubuntu0.18.04.1

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Temporary table structure for view `asset_info`
--

DROP TABLE IF EXISTS `asset_info`;
/*!50001 DROP VIEW IF EXISTS `asset_info`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `asset_info` AS SELECT 
 1 AS `lft`,
 1 AS `rgt`,
 1 AS `name`,
 1 AS `id`,
 1 AS `faction`,
 1 AS `controlable`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary table structure for view `asset_subtree`
--

DROP TABLE IF EXISTS `asset_subtree`;
/*!50001 DROP VIEW IF EXISTS `asset_subtree`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `asset_subtree` AS SELECT 
 1 AS `id`,
 1 AS `name`,
 1 AS `faction`,
 1 AS `controlable`,
 1 AS `parent_name`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary table structure for view `briefing_info`
--

DROP TABLE IF EXISTS `briefing_info`;
/*!50001 DROP VIEW IF EXISTS `briefing_info`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `briefing_info` AS SELECT 
 1 AS `id`,
 1 AS `mission_id`,
 1 AS `faction`,
 1 AS `text`,
 1 AS `campaign_id`,
 1 AS `mission_status`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary table structure for view `campaign_info_unit`
--

DROP TABLE IF EXISTS `campaign_info_unit`;
/*!50001 DROP VIEW IF EXISTS `campaign_info_unit`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `campaign_info_unit` AS SELECT 
 1 AS `lft`,
 1 AS `rgt`,
 1 AS `id`,
 1 AS `campaign_id`,
 1 AS `acg_unit_id`,
 1 AS `hist_unit_id`,
 1 AS `asset_id`,
 1 AS `report_type`,
 1 AS `name`,
 1 AS `unit_code`,
 1 AS `faction`,
 1 AS `unit_type`,
 1 AS `description`,
 1 AS `image`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary table structure for view `campaign_list`
--

DROP TABLE IF EXISTS `campaign_list`;
/*!50001 DROP VIEW IF EXISTS `campaign_list`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `campaign_list` AS SELECT 
 1 AS `id`,
 1 AS `name`,
 1 AS `is_primary`,
 1 AS `platform`,
 1 AS `campaign_status`,
 1 AS `time`,
 1 AS `open`,
 1 AS `campaign_link`,
 1 AS `description`,
 1 AS `image`,
 1 AS `units`,
 1 AS `sorties`,
 1 AS `participants`,
 1 AS `missions`,
 1 AS `avg_attendance`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary table structure for view `campaign_max_min_date`
--

DROP TABLE IF EXISTS `campaign_max_min_date`;
/*!50001 DROP VIEW IF EXISTS `campaign_max_min_date`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `campaign_max_min_date` AS SELECT 
 1 AS `id`,
 1 AS `mx_date`,
 1 AS `mn_date`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary table structure for view `campaign_member_latest_transfer`
--

DROP TABLE IF EXISTS `campaign_member_latest_transfer`;
/*!50001 DROP VIEW IF EXISTS `campaign_member_latest_transfer`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `campaign_member_latest_transfer` AS SELECT 
 1 AS `campaign_id`,
 1 AS `member_id`,
 1 AS `mx_date`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary table structure for view `campaign_member_latest_unit`
--

DROP TABLE IF EXISTS `campaign_member_latest_unit`;
/*!50001 DROP VIEW IF EXISTS `campaign_member_latest_unit`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `campaign_member_latest_unit` AS SELECT 
 1 AS `member_id`,
 1 AS `depl_unit_id`,
 1 AS `campaign_id`,
 1 AS `acg_unit_id`,
 1 AS `hist_unit_id`,
 1 AS `faction`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary table structure for view `campaign_mission_info`
--

DROP TABLE IF EXISTS `campaign_mission_info`;
/*!50001 DROP VIEW IF EXISTS `campaign_mission_info`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `campaign_mission_info` AS SELECT 
 1 AS `id`,
 1 AS `name`,
 1 AS `campaign_id`,
 1 AS `real_date`,
 1 AS `hist_date`,
 1 AS `mission_status`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary table structure for view `campaign_unit_member_info`
--

DROP TABLE IF EXISTS `campaign_unit_member_info`;
/*!50001 DROP VIEW IF EXISTS `campaign_unit_member_info`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `campaign_unit_member_info` AS SELECT 
 1 AS `campaign_id`,
 1 AS `depl_unit_id`,
 1 AS `acg_unit_id`,
 1 AS `callsign`,
 1 AS `member_id`,
 1 AS `event_type`,
 1 AS `event_value`,
 1 AS `event_date_in`,
 1 AS `event_date_out`,
 1 AS `show_event_start`,
 1 AS `show_event_stop`,
 1 AS `rank_name`,
 1 AS `rank_abr`,
 1 AS `image`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary table structure for view `campaign_unit_member_latest_promotion_date`
--

DROP TABLE IF EXISTS `campaign_unit_member_latest_promotion_date`;
/*!50001 DROP VIEW IF EXISTS `campaign_unit_member_latest_promotion_date`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `campaign_unit_member_latest_promotion_date` AS SELECT 
 1 AS `campaign_id`,
 1 AS `depl_unit_id`,
 1 AS `member_id`,
 1 AS `mx_promotion_date`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary table structure for view `campaign_unit_member_max_min_transfer`
--

DROP TABLE IF EXISTS `campaign_unit_member_max_min_transfer`;
/*!50001 DROP VIEW IF EXISTS `campaign_unit_member_max_min_transfer`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `campaign_unit_member_max_min_transfer` AS SELECT 
 1 AS `member_id`,
 1 AS `acg_unit_id`,
 1 AS `min_transfer_date_in`,
 1 AS `max_transfer_date_out`,
 1 AS `campaign_id`,
 1 AS `depl_unit_id`,
 1 AS `hist_unit_id`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary table structure for view `campaign_unit_plane_asset_status`
--

DROP TABLE IF EXISTS `campaign_unit_plane_asset_status`;
/*!50001 DROP VIEW IF EXISTS `campaign_unit_plane_asset_status`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `campaign_unit_plane_asset_status` AS SELECT 
 1 AS `depl_unit_id`,
 1 AS `campaign_id`,
 1 AS `sorties`,
 1 AS `pilot_ok`,
 1 AS `pilot_wounded`,
 1 AS `pilot_pow`,
 1 AS `pilot_kia`,
 1 AS `asset_ok`,
 1 AS `asset_damaged`,
 1 AS `asset_lost`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary table structure for view `character_latest_report`
--

DROP TABLE IF EXISTS `character_latest_report`;
/*!50001 DROP VIEW IF EXISTS `character_latest_report`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `character_latest_report` AS SELECT 
 1 AS `character_id`,
 1 AS `member_id`,
 1 AS `first_name`,
 1 AS `last_name`,
 1 AS `deployed_unit_id`,
 1 AS `character_status`,
 1 AS `faction`,
 1 AS `last_mission_hist_date`,
 1 AS `rank_name`,
 1 AS `rank_abreviation`,
 1 AS `rank_image`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary table structure for view `character_latest_report_date`
--

DROP TABLE IF EXISTS `character_latest_report_date`;
/*!50001 DROP VIEW IF EXISTS `character_latest_report_date`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `character_latest_report_date` AS SELECT 
 1 AS `character_id`,
 1 AS `max_report_timestamp`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary table structure for view `claim_ground_info`
--

DROP TABLE IF EXISTS `claim_ground_info`;
/*!50001 DROP VIEW IF EXISTS `claim_ground_info`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `claim_ground_info` AS SELECT 
 1 AS `claim_id`,
 1 AS `report_id`,
 1 AS `description`,
 1 AS `accepted`,
 1 AS `accepted_by`,
 1 AS `asset_id`,
 1 AS `claim_detail_id`,
 1 AS `amount`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary table structure for view `claim_lw_info`
--

DROP TABLE IF EXISTS `claim_lw_info`;
/*!50001 DROP VIEW IF EXISTS `claim_lw_info`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `claim_lw_info` AS SELECT 
 1 AS `claim_id`,
 1 AS `report_id`,
 1 AS `description`,
 1 AS `accepted`,
 1 AS `asset_id`,
 1 AS `accepted_by`,
 1 AS `claim_detail_id`,
 1 AS `claim_time`,
 1 AS `place`,
 1 AS `opponent`,
 1 AS `fate_of_crew`,
 1 AS `type_of_destruction`,
 1 AS `type_of_impact`,
 1 AS `confirmed`,
 1 AS `witness_id`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary table structure for view `claim_raf_info`
--

DROP TABLE IF EXISTS `claim_raf_info`;
/*!50001 DROP VIEW IF EXISTS `claim_raf_info`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `claim_raf_info` AS SELECT 
 1 AS `claim_id`,
 1 AS `report_id`,
 1 AS `description`,
 1 AS `accepted`,
 1 AS `accepted_by`,
 1 AS `asset_name`,
 1 AS `claim_detail_id`,
 1 AS `enemy_status`,
 1 AS `shared`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary table structure for view `claim_vvs_info`
--

DROP TABLE IF EXISTS `claim_vvs_info`;
/*!50001 DROP VIEW IF EXISTS `claim_vvs_info`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `claim_vvs_info` AS SELECT 
 1 AS `claim_id`,
 1 AS `report_id`,
 1 AS `description`,
 1 AS `accepted`,
 1 AS `asset_id`,
 1 AS `accepted_by`,
 1 AS `claim_detail_id`,
 1 AS `claim_time`,
 1 AS `place`,
 1 AS `group_claim`,
 1 AS `confirmed`,
 1 AS `witness_id`,
 1 AS `witness_callsign`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary table structure for view `comment_info`
--

DROP TABLE IF EXISTS `comment_info`;
/*!50001 DROP VIEW IF EXISTS `comment_info`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `comment_info` AS SELECT 
 1 AS `comment_id`,
 1 AS `report_id`,
 1 AS `commentator`,
 1 AS `comment_date`,
 1 AS `comment_text`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary table structure for view `current_unit_members`
--

DROP TABLE IF EXISTS `current_unit_members`;
/*!50001 DROP VIEW IF EXISTS `current_unit_members`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `current_unit_members` AS SELECT 
 1 AS `member_id`,
 1 AS `acg_unit_id`,
 1 AS `id`,
 1 AS `callsign`,
 1 AS `member_status`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary table structure for view `depl_unit_info`
--

DROP TABLE IF EXISTS `depl_unit_info`;
/*!50001 DROP VIEW IF EXISTS `depl_unit_info`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `depl_unit_info` AS SELECT 
 1 AS `id`,
 1 AS `campaign_id`,
 1 AS `acg_unit_id`,
 1 AS `hist_unit_id`,
 1 AS `asset_id`,
 1 AS `report_type`,
 1 AS `lft`,
 1 AS `rgt`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary table structure for view `hist_unit_info`
--

DROP TABLE IF EXISTS `hist_unit_info`;
/*!50001 DROP VIEW IF EXISTS `hist_unit_info`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `hist_unit_info` AS SELECT 
 1 AS `id`,
 1 AS `name`,
 1 AS `code`,
 1 AS `faction`,
 1 AS `type`,
 1 AS `description`,
 1 AS `image`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary table structure for view `member_info_with_last_status`
--

DROP TABLE IF EXISTS `member_info_with_last_status`;
/*!50001 DROP VIEW IF EXISTS `member_info_with_last_status`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `member_info_with_last_status` AS SELECT 
 1 AS `member_id`,
 1 AS `username`,
 1 AS `callsign`,
 1 AS `admin`,
 1 AS `member_status`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary table structure for view `member_max_status`
--

DROP TABLE IF EXISTS `member_max_status`;
/*!50001 DROP VIEW IF EXISTS `member_max_status`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `member_max_status` AS SELECT 
 1 AS `id`,
 1 AS `member_id`,
 1 AS `member_status`,
 1 AS `status_date_in`,
 1 AS `status_date_out`,
 1 AS `comment`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary table structure for view `member_max_transfer`
--

DROP TABLE IF EXISTS `member_max_transfer`;
/*!50001 DROP VIEW IF EXISTS `member_max_transfer`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `member_max_transfer` AS SELECT 
 1 AS `id`,
 1 AS `member_id`,
 1 AS `acg_unit_id`,
 1 AS `transfer_date_in`,
 1 AS `transfer_date_out`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary table structure for view `mission_member_faction`
--

DROP TABLE IF EXISTS `mission_member_faction`;
/*!50001 DROP VIEW IF EXISTS `mission_member_faction`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `mission_member_faction` AS SELECT 
 1 AS `member_id`,
 1 AS `mission_id`,
 1 AS `faction`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary table structure for view `mission_member_max_promotion_date`
--

DROP TABLE IF EXISTS `mission_member_max_promotion_date`;
/*!50001 DROP VIEW IF EXISTS `mission_member_max_promotion_date`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `mission_member_max_promotion_date` AS SELECT 
 1 AS `mission_id`,
 1 AS `member_id`,
 1 AS `mx_promotion_date`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary table structure for view `mission_member_rank`
--

DROP TABLE IF EXISTS `mission_member_rank`;
/*!50001 DROP VIEW IF EXISTS `mission_member_rank`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `mission_member_rank` AS SELECT 
 1 AS `mission_id`,
 1 AS `member_id`,
 1 AS `real_value`,
 1 AS `rank_name`,
 1 AS `abreviation`,
 1 AS `disp_value`,
 1 AS `faction`,
 1 AS `image`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary table structure for view `mission_report_nav_list`
--

DROP TABLE IF EXISTS `mission_report_nav_list`;
/*!50001 DROP VIEW IF EXISTS `mission_report_nav_list`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `mission_report_nav_list` AS SELECT 
 1 AS `mission_id`,
 1 AS `depl_unit_id`,
 1 AS `report_id`,
 1 AS `first_name`,
 1 AS `last_name`,
 1 AS `callsign`,
 1 AS `abreviation`,
 1 AS `accepted`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary table structure for view `mission_unit_plane_asset_status`
--

DROP TABLE IF EXISTS `mission_unit_plane_asset_status`;
/*!50001 DROP VIEW IF EXISTS `mission_unit_plane_asset_status`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `mission_unit_plane_asset_status` AS SELECT 
 1 AS `depl_unit_id`,
 1 AS `mission_id`,
 1 AS `sorties`,
 1 AS `pilot_ok`,
 1 AS `pilot_wounded`,
 1 AS `pilot_pow`,
 1 AS `pilot_kia`,
 1 AS `asset_ok`,
 1 AS `asset_damaged`,
 1 AS `asset_lost`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary table structure for view `random_first_name`
--

DROP TABLE IF EXISTS `random_first_name`;
/*!50001 DROP VIEW IF EXISTS `random_first_name`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `random_first_name` AS SELECT 
 1 AS `name`,
 1 AS `faction`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary table structure for view `random_last_name`
--

DROP TABLE IF EXISTS `random_last_name`;
/*!50001 DROP VIEW IF EXISTS `random_last_name`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `random_last_name` AS SELECT 
 1 AS `name`,
 1 AS `faction`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary table structure for view `rank_lookup`
--

DROP TABLE IF EXISTS `rank_lookup`;
/*!50001 DROP VIEW IF EXISTS `rank_lookup`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `rank_lookup` AS SELECT 
 1 AS `real_value`,
 1 AS `rank_name`,
 1 AS `abreviation`,
 1 AS `disp_value`,
 1 AS `faction`,
 1 AS `image`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary table structure for view `rank_translation`
--

DROP TABLE IF EXISTS `rank_translation`;
/*!50001 DROP VIEW IF EXISTS `rank_translation`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `rank_translation` AS SELECT 
 1 AS `real_value`,
 1 AS `disp_value`,
 1 AS `faction`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary table structure for view `report_info`
--

DROP TABLE IF EXISTS `report_info`;
/*!50001 DROP VIEW IF EXISTS `report_info`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `report_info` AS SELECT 
 1 AS `report_id`,
 1 AS `mission_id`,
 1 AS `depl_unit_id`,
 1 AS `asset_id`,
 1 AS `base`,
 1 AS `markings`,
 1 AS `asset_status`,
 1 AS `pilot_status`,
 1 AS `synopsis`,
 1 AS `date_submitted`,
 1 AS `accepted`,
 1 AS `accepted_by`,
 1 AS `character_id`,
 1 AS `first_name`,
 1 AS `last_name`,
 1 AS `member_id`,
 1 AS `callsign`,
 1 AS `faction`,
 1 AS `rank_value`,
 1 AS `rank_name`,
 1 AS `abreviation`,
 1 AS `image`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary table structure for view `report_submission_depl_units`
--

DROP TABLE IF EXISTS `report_submission_depl_units`;
/*!50001 DROP VIEW IF EXISTS `report_submission_depl_units`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `report_submission_depl_units` AS SELECT 
 1 AS `depl_unit_id`,
 1 AS `campaign_id`,
 1 AS `acg_unit_id`,
 1 AS `hist_unit_name`,
 1 AS `hist_unit_code`,
 1 AS `faction`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary table structure for view `transfer_status_events`
--

DROP TABLE IF EXISTS `transfer_status_events`;
/*!50001 DROP VIEW IF EXISTS `transfer_status_events`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `transfer_status_events` AS SELECT 
 1 AS `event_type`,
 1 AS `member_id`,
 1 AS `event_value`,
 1 AS `date_in`,
 1 AS `date_out`*/;
SET character_set_client = @saved_cs_client;

--
-- Dumping routines for database 'pam'
--

--
-- Final view structure for view `asset_info`
--

/*!50001 DROP VIEW IF EXISTS `asset_info`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `asset_info` AS select `asset`.`lft` AS `lft`,`asset`.`rgt` AS `rgt`,`asset`.`name` AS `name`,`asset`.`id` AS `id`,`asset`.`faction` AS `faction`,`asset`.`controlable` AS `controlable` from `asset` order by `asset`.`lft` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `asset_subtree`
--

/*!50001 DROP VIEW IF EXISTS `asset_subtree`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `asset_subtree` AS select `node`.`id` AS `id`,`node`.`name` AS `name`,`node`.`faction` AS `faction`,`node`.`controlable` AS `controlable`,`parent`.`name` AS `parent_name` from (`asset` `node` left join `asset` `parent` on(((`node`.`lft` > `parent`.`lft`) and (`node`.`rgt` < `parent`.`rgt`)))) order by `node`.`lft` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `briefing_info`
--

/*!50001 DROP VIEW IF EXISTS `briefing_info`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `briefing_info` AS select `briefing`.`id` AS `id`,`briefing`.`mission_id` AS `mission_id`,`briefing`.`faction` AS `faction`,`briefing`.`text` AS `text`,`mission`.`campaign_id` AS `campaign_id`,`mission`.`mission_status` AS `mission_status` from (`briefing` left join `mission` on((`mission`.`id` = `briefing`.`mission_id`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `campaign_info_unit`
--

/*!50001 DROP VIEW IF EXISTS `campaign_info_unit`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `campaign_info_unit` AS select `deployed_unit`.`lft` AS `lft`,`deployed_unit`.`rgt` AS `rgt`,`deployed_unit`.`id` AS `id`,`deployed_unit`.`campaign_id` AS `campaign_id`,`deployed_unit`.`acg_unit_id` AS `acg_unit_id`,`deployed_unit`.`hist_unit_id` AS `hist_unit_id`,`deployed_unit`.`asset_id` AS `asset_id`,`deployed_unit`.`report_type` AS `report_type`,`hist_unit`.`name` AS `name`,`hist_unit`.`code` AS `unit_code`,`hist_unit`.`faction` AS `faction`,`hist_unit`.`type` AS `unit_type`,`hist_unit`.`description` AS `description`,`hist_unit`.`image` AS `image` from (`deployed_unit` left join `hist_unit` on((`deployed_unit`.`hist_unit_id` = `hist_unit`.`id`))) order by `deployed_unit`.`lft` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `campaign_list`
--

/*!50001 DROP VIEW IF EXISTS `campaign_list`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `campaign_list` AS select `pam`.`campaign`.`id` AS `id`,`pam`.`campaign`.`name` AS `name`,`pam`.`campaign`.`is_primary` AS `is_primary`,`pam`.`campaign`.`platform` AS `platform`,`pam`.`campaign`.`campaign_status` AS `campaign_status`,`pam`.`campaign`.`time` AS `time`,`pam`.`campaign`.`open` AS `open`,`pam`.`campaign`.`campaign_link` AS `campaign_link`,`pam`.`campaign`.`description` AS `description`,`pam`.`campaign`.`image` AS `image`,`unit_table`.`units` AS `units`,`sortie_table`.`sorties` AS `sorties`,`participant_table`.`participants` AS `participants`,`mission_table`.`missions` AS `missions`,round((`sortie_table`.`sorties` / `mission_table`.`missions`),0) AS `avg_attendance` from ((((`pam`.`campaign` left join (select `pam`.`deployed_unit`.`campaign_id` AS `campaign_id`,count(`pam`.`deployed_unit`.`acg_unit_id`) AS `units` from `pam`.`deployed_unit` where (`pam`.`deployed_unit`.`acg_unit_id` is not null) group by `pam`.`deployed_unit`.`campaign_id`) `unit_table` on((`unit_table`.`campaign_id` = `pam`.`campaign`.`id`))) left join (select `pam`.`campaign`.`id` AS `id`,count(`pam`.`report`.`id`) AS `sorties` from ((`pam`.`campaign` left join `pam`.`mission` on((`pam`.`mission`.`campaign_id` = `pam`.`campaign`.`id`))) left join `pam`.`report` on((`pam`.`report`.`mission_id` = `pam`.`mission`.`id`))) where (`pam`.`report`.`accepted` = 1) group by `pam`.`campaign`.`id`) `sortie_table` on((`sortie_table`.`id` = `pam`.`campaign`.`id`))) left join (select `pam`.`campaign`.`id` AS `id`,count(distinct `pam`.`career_character`.`personified_by`) AS `participants` from (((`pam`.`campaign` left join `pam`.`mission` on((`pam`.`mission`.`campaign_id` = `pam`.`campaign`.`id`))) left join `pam`.`report` on((`pam`.`report`.`mission_id` = `pam`.`mission`.`id`))) left join `pam`.`career_character` on((`pam`.`career_character`.`id` = `pam`.`report`.`character_id`))) where (`pam`.`report`.`accepted` = 1) group by `pam`.`campaign`.`id`) `participant_table` on((`participant_table`.`id` = `pam`.`campaign`.`id`))) left join (select `pam`.`campaign`.`id` AS `id`,count(`pam`.`mission`.`id`) AS `missions` from (`pam`.`campaign` left join `pam`.`mission` on((`pam`.`mission`.`campaign_id` = `pam`.`campaign`.`id`))) group by `pam`.`campaign`.`id`) `mission_table` on((`mission_table`.`id` = `pam`.`campaign`.`id`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `campaign_max_min_date`
--

/*!50001 DROP VIEW IF EXISTS `campaign_max_min_date`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `campaign_max_min_date` AS select `campaign`.`id` AS `id`,max(`mission`.`real_date`) AS `mx_date`,min(`mission`.`real_date`) AS `mn_date` from (`campaign` left join `mission` on((`mission`.`campaign_id` = `campaign`.`id`))) group by `campaign`.`id` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `campaign_member_latest_transfer`
--

/*!50001 DROP VIEW IF EXISTS `campaign_member_latest_transfer`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `campaign_member_latest_transfer` AS select `deployed_unit`.`campaign_id` AS `campaign_id`,`transfer`.`member_id` AS `member_id`,max(`transfer`.`transfer_date_in`) AS `mx_date` from ((`deployed_unit` join `transfer` on((`deployed_unit`.`acg_unit_id` = `transfer`.`acg_unit_id`))) join `campaign_max_min_date` `cmmd` on((`cmmd`.`id` = `deployed_unit`.`campaign_id`))) where ((`transfer`.`transfer_date_in` < `cmmd`.`mx_date`) and ((`transfer`.`transfer_date_out` > `cmmd`.`mn_date`) or isnull(`transfer`.`transfer_date_out`))) group by `deployed_unit`.`campaign_id`,`transfer`.`member_id` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `campaign_member_latest_unit`
--

/*!50001 DROP VIEW IF EXISTS `campaign_member_latest_unit`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `campaign_member_latest_unit` AS select `transfer`.`member_id` AS `member_id`,`deployed_unit`.`id` AS `depl_unit_id`,`deployed_unit`.`campaign_id` AS `campaign_id`,`deployed_unit`.`acg_unit_id` AS `acg_unit_id`,`deployed_unit`.`hist_unit_id` AS `hist_unit_id`,`hist_unit`.`faction` AS `faction` from (((`campaign_member_latest_transfer` left join `transfer` on(((`transfer`.`member_id` = `campaign_member_latest_transfer`.`member_id`) and (`transfer`.`transfer_date_in` = `campaign_member_latest_transfer`.`mx_date`)))) left join `deployed_unit` on(((`deployed_unit`.`campaign_id` = `campaign_member_latest_transfer`.`campaign_id`) and (`deployed_unit`.`acg_unit_id` = `transfer`.`acg_unit_id`)))) left join `hist_unit` on((`hist_unit`.`id` = `deployed_unit`.`hist_unit_id`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `campaign_mission_info`
--

/*!50001 DROP VIEW IF EXISTS `campaign_mission_info`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `campaign_mission_info` AS select `mission`.`id` AS `id`,`mission`.`name` AS `name`,`mission`.`campaign_id` AS `campaign_id`,`mission`.`real_date` AS `real_date`,`mission`.`hist_date` AS `hist_date`,`mission`.`mission_status` AS `mission_status` from `mission` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `campaign_unit_member_info`
--

/*!50001 DROP VIEW IF EXISTS `campaign_unit_member_info`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `campaign_unit_member_info` AS select `Y`.`campaign_id` AS `campaign_id`,`Y`.`depl_unit_id` AS `depl_unit_id`,`Y`.`acg_unit_id` AS `acg_unit_id`,`acg_member`.`callsign` AS `callsign`,`Y`.`member_id` AS `member_id`,`Z`.`event_type` AS `event_type`,`Z`.`event_value` AS `event_value`,`Z`.`date_in` AS `event_date_in`,`Z`.`date_out` AS `event_date_out`,(`Z`.`date_in` between `campaign_max_min_date`.`mn_date` and `campaign_max_min_date`.`mx_date`) AS `show_event_start`,(`Z`.`date_out` between `campaign_max_min_date`.`mn_date` and `campaign_max_min_date`.`mx_date`) AS `show_event_stop`,`rank`.`name` AS `rank_name`,`rank`.`abreviation` AS `rank_abr`,`rank`.`image` AS `image` from ((((((((`campaign_unit_member_max_min_transfer` `Y` join `hist_unit` on((`hist_unit`.`id` = `Y`.`hist_unit_id`))) join `acg_member` on((`acg_member`.`id` = `Y`.`member_id`))) join `campaign_max_min_date` on((`campaign_max_min_date`.`id` = `Y`.`campaign_id`))) left join `transfer_status_events` `Z` on(((`Z`.`member_id` = `Y`.`member_id`) and (((`Z`.`event_type` = 'transfer') and (`Z`.`event_value` = `Y`.`acg_unit_id`)) or (`Z`.`event_type` = 'status')) and (isnull(`Z`.`date_out`) or (`Z`.`date_out` > `Y`.`min_transfer_date_in`)) and (isnull(`Z`.`date_out`) or (`Z`.`date_out` > `campaign_max_min_date`.`mn_date`)) and ifnull(1,((`Z`.`date_in` < `Y`.`max_transfer_date_out`) and (`Z`.`date_in` < `campaign_max_min_date`.`mx_date`)))))) join `campaign_unit_member_latest_promotion_date` `X` on(((`X`.`campaign_id` = `Y`.`campaign_id`) and (`X`.`depl_unit_id` = `Y`.`depl_unit_id`) and (`X`.`member_id` = `Y`.`member_id`)))) join `promotion` on(((`promotion`.`member_id` = `X`.`member_id`) and (`promotion`.`promotion_date` = `X`.`mx_promotion_date`)))) join `rank_translation` on(((`rank_translation`.`real_value` = `promotion`.`rank_value`) and (`rank_translation`.`faction` = `hist_unit`.`faction`)))) join `rank` on(((`rank`.`value` = `rank_translation`.`disp_value`) and (`rank`.`faction` = `hist_unit`.`faction`)))) order by `promotion`.`rank_value` desc,`Y`.`member_id`,`Z`.`date_in` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `campaign_unit_member_latest_promotion_date`
--

/*!50001 DROP VIEW IF EXISTS `campaign_unit_member_latest_promotion_date`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `campaign_unit_member_latest_promotion_date` AS select `deployed_unit`.`campaign_id` AS `campaign_id`,`deployed_unit`.`id` AS `depl_unit_id`,`transfer`.`member_id` AS `member_id`,max(`promotion`.`promotion_date`) AS `mx_promotion_date` from (((`deployed_unit` join `transfer` on((`transfer`.`acg_unit_id` = `deployed_unit`.`acg_unit_id`))) join `campaign_max_min_date` on((`campaign_max_min_date`.`id` = `deployed_unit`.`campaign_id`))) join `promotion` on((`promotion`.`member_id` = `transfer`.`member_id`))) where ((`transfer`.`transfer_date_in` < `campaign_max_min_date`.`mx_date`) and ((`transfer`.`transfer_date_out` > `campaign_max_min_date`.`mn_date`) or isnull(`transfer`.`transfer_date_out`)) and (`promotion`.`promotion_date` < `campaign_max_min_date`.`mx_date`)) group by `deployed_unit`.`campaign_id`,`depl_unit_id`,`transfer`.`member_id` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `campaign_unit_member_max_min_transfer`
--

/*!50001 DROP VIEW IF EXISTS `campaign_unit_member_max_min_transfer`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `campaign_unit_member_max_min_transfer` AS select `transfer`.`member_id` AS `member_id`,`transfer`.`acg_unit_id` AS `acg_unit_id`,min(`transfer`.`transfer_date_in`) AS `min_transfer_date_in`,max(`transfer`.`transfer_date_out`) AS `max_transfer_date_out`,`deployed_unit`.`campaign_id` AS `campaign_id`,`deployed_unit`.`id` AS `depl_unit_id`,`deployed_unit`.`hist_unit_id` AS `hist_unit_id` from ((`deployed_unit` join `transfer` on((`deployed_unit`.`acg_unit_id` = `transfer`.`acg_unit_id`))) join `campaign_max_min_date` on((`campaign_max_min_date`.`id` = `deployed_unit`.`campaign_id`))) where ((`transfer`.`transfer_date_in` < `campaign_max_min_date`.`mx_date`) and ((`transfer`.`transfer_date_out` > `campaign_max_min_date`.`mn_date`) or isnull(`transfer`.`transfer_date_out`))) group by `transfer`.`member_id`,`transfer`.`acg_unit_id`,`deployed_unit`.`campaign_id`,`deployed_unit`.`id`,`deployed_unit`.`hist_unit_id` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `campaign_unit_plane_asset_status`
--

/*!50001 DROP VIEW IF EXISTS `campaign_unit_plane_asset_status`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `campaign_unit_plane_asset_status` AS select `parent`.`id` AS `depl_unit_id`,`node`.`campaign_id` AS `campaign_id`,sum(`X`.`sorties`) AS `sorties`,sum(`X`.`pilot_ok`) AS `pilot_ok`,sum(`X`.`pilot_wounded`) AS `pilot_wounded`,sum(`X`.`pilot_pow`) AS `pilot_pow`,sum(`X`.`pilot_kia`) AS `pilot_kia`,sum(`X`.`asset_ok`) AS `asset_ok`,sum(`X`.`asset_damaged`) AS `asset_damaged`,sum(`X`.`asset_lost`) AS `asset_lost` from (`deployed_unit` `parent` join ((`deployed_unit` `node` left join `mission` on((`mission`.`campaign_id` = `node`.`campaign_id`))) left join `mission_unit_plane_asset_status` `X` on(((`X`.`mission_id` = `mission`.`id`) and (`X`.`depl_unit_id` = `node`.`id`))))) where ((`parent`.`campaign_id` = `node`.`campaign_id`) and (`node`.`lft` between `parent`.`lft` and `parent`.`rgt`)) group by `parent`.`id`,`node`.`campaign_id` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `character_latest_report`
--

/*!50001 DROP VIEW IF EXISTS `character_latest_report`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `character_latest_report` AS select `character_latest_report_date`.`character_id` AS `character_id`,`career_character`.`personified_by` AS `member_id`,`career_character`.`first_name` AS `first_name`,`career_character`.`last_name` AS `last_name`,`report`.`deployed_unit_id` AS `deployed_unit_id`,`report`.`pilot_status` AS `character_status`,`hist_unit`.`faction` AS `faction`,`mission`.`hist_date` AS `last_mission_hist_date`,`mission_member_rank`.`rank_name` AS `rank_name`,`mission_member_rank`.`abreviation` AS `rank_abreviation`,`mission_member_rank`.`image` AS `rank_image` from ((`character_latest_report_date` join (`career_character` left join (((`report` left join `mission` on((`mission`.`id` = `report`.`mission_id`))) left join `deployed_unit` on((`deployed_unit`.`id` = `report`.`deployed_unit_id`))) left join `hist_unit` on((`hist_unit`.`id` = `deployed_unit`.`hist_unit_id`))) on((`career_character`.`id` = `report`.`character_id`)))) left join `mission_member_rank` on(((`mission_member_rank`.`mission_id` = `mission`.`id`) and (`mission_member_rank`.`member_id` = `career_character`.`personified_by`) and (`mission_member_rank`.`faction` = `hist_unit`.`faction`)))) where (`character_latest_report_date`.`max_report_timestamp` = (unix_timestamp(`mission`.`real_date`) + `report`.`id`)) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `character_latest_report_date`
--

/*!50001 DROP VIEW IF EXISTS `character_latest_report_date`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `character_latest_report_date` AS select `report`.`character_id` AS `character_id`,max((unix_timestamp(`mission`.`real_date`) + `report`.`id`)) AS `max_report_timestamp` from (`report` left join `mission` on((`mission`.`id` = `report`.`mission_id`))) group by `report`.`character_id` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `claim_ground_info`
--

/*!50001 DROP VIEW IF EXISTS `claim_ground_info`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `claim_ground_info` AS select `claim`.`id` AS `claim_id`,`claim`.`report_id` AS `report_id`,`claim`.`description` AS `description`,`claim`.`accepted` AS `accepted`,`claim`.`accepted_by` AS `accepted_by`,`claim`.`asset_id` AS `asset_id`,`claim_ground`.`id` AS `claim_detail_id`,`claim_ground`.`amount` AS `amount` from (`claim` join `claim_ground` on((`claim_ground`.`claim_id` = `claim`.`id`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `claim_lw_info`
--

/*!50001 DROP VIEW IF EXISTS `claim_lw_info`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `claim_lw_info` AS select `claim`.`id` AS `claim_id`,`claim`.`report_id` AS `report_id`,`claim`.`description` AS `description`,`claim`.`accepted` AS `accepted`,`claim`.`asset_id` AS `asset_id`,`claim`.`accepted_by` AS `accepted_by`,`claim_lw`.`id` AS `claim_detail_id`,`claim_lw`.`claim_time` AS `claim_time`,`claim_lw`.`place` AS `place`,`claim_lw`.`opponent` AS `opponent`,`claim_lw`.`fate_of_crew` AS `fate_of_crew`,`claim_lw`.`type_of_destruction` AS `type_of_destruction`,`claim_lw`.`type_of_impact` AS `type_of_impact`,`claim_lw`.`confirmed` AS `confirmed`,`claim_lw`.`witness` AS `witness_id` from ((`claim` join `claim_lw` on((`claim_lw`.`claim_id` = `claim`.`id`))) left join `acg_member` on((`acg_member`.`id` = `claim_lw`.`witness`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `claim_raf_info`
--

/*!50001 DROP VIEW IF EXISTS `claim_raf_info`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `claim_raf_info` AS select `claim`.`id` AS `claim_id`,`claim`.`report_id` AS `report_id`,`claim`.`description` AS `description`,`claim`.`accepted` AS `accepted`,`claim`.`accepted_by` AS `accepted_by`,`asset`.`name` AS `asset_name`,`claim_raf`.`id` AS `claim_detail_id`,`claim_raf`.`enemy_status` AS `enemy_status`,`claim_raf`.`shared` AS `shared` from (`claim_raf` left join (`claim` join `asset` on((`asset`.`id` = `claim`.`asset_id`))) on((`claim_raf`.`claim_id` = `claim`.`id`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `claim_vvs_info`
--

/*!50001 DROP VIEW IF EXISTS `claim_vvs_info`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `claim_vvs_info` AS select `claim`.`id` AS `claim_id`,`claim`.`report_id` AS `report_id`,`claim`.`description` AS `description`,`claim`.`accepted` AS `accepted`,`claim`.`asset_id` AS `asset_id`,`claim`.`accepted_by` AS `accepted_by`,`claim_vvs`.`id` AS `claim_detail_id`,`claim_vvs`.`claim_time` AS `claim_time`,`claim_vvs`.`place` AS `place`,`claim_vvs`.`group_claim` AS `group_claim`,`claim_vvs`.`confirmed` AS `confirmed`,`claim_vvs`.`witness` AS `witness_id`,`acg_member`.`callsign` AS `witness_callsign` from ((`claim` join `claim_vvs` on((`claim_vvs`.`claim_id` = `claim`.`id`))) left join `acg_member` on((`acg_member`.`id` = `claim_vvs`.`witness`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `comment_info`
--

/*!50001 DROP VIEW IF EXISTS `comment_info`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `comment_info` AS select `comment`.`id` AS `comment_id`,`comment`.`report_id` AS `report_id`,`acg_member`.`callsign` AS `commentator`,`comment`.`comment_date` AS `comment_date`,`comment`.`comment_text` AS `comment_text` from (`comment` join `acg_member` on((`acg_member`.`id` = `comment`.`member_id`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `current_unit_members`
--

/*!50001 DROP VIEW IF EXISTS `current_unit_members`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `current_unit_members` AS select `member_max_transfer`.`member_id` AS `member_id`,`member_max_transfer`.`acg_unit_id` AS `acg_unit_id`,`acg_member`.`id` AS `id`,`acg_member`.`callsign` AS `callsign`,`member_max_status`.`member_status` AS `member_status` from ((`member_max_transfer` left join `member_max_status` on((`member_max_status`.`member_id` = `member_max_transfer`.`member_id`))) left join `acg_member` on((`acg_member`.`id` = `member_max_transfer`.`member_id`))) where ((`member_max_status`.`member_status` = 0) or (`member_max_status`.`member_status` = 3)) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `depl_unit_info`
--

/*!50001 DROP VIEW IF EXISTS `depl_unit_info`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `depl_unit_info` AS select `deployed_unit`.`id` AS `id`,`deployed_unit`.`campaign_id` AS `campaign_id`,`deployed_unit`.`acg_unit_id` AS `acg_unit_id`,`deployed_unit`.`hist_unit_id` AS `hist_unit_id`,`deployed_unit`.`asset_id` AS `asset_id`,`deployed_unit`.`report_type` AS `report_type`,`deployed_unit`.`lft` AS `lft`,`deployed_unit`.`rgt` AS `rgt` from `deployed_unit` order by `deployed_unit`.`campaign_id`,`deployed_unit`.`lft` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `hist_unit_info`
--

/*!50001 DROP VIEW IF EXISTS `hist_unit_info`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `hist_unit_info` AS select `hist_unit`.`id` AS `id`,`hist_unit`.`name` AS `name`,`hist_unit`.`code` AS `code`,`hist_unit`.`faction` AS `faction`,`hist_unit`.`type` AS `type`,`hist_unit`.`description` AS `description`,`hist_unit`.`image` AS `image` from `hist_unit` where (`hist_unit`.`id` <> 1) order by `hist_unit`.`faction`,`hist_unit`.`name` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `member_info_with_last_status`
--

/*!50001 DROP VIEW IF EXISTS `member_info_with_last_status`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `member_info_with_last_status` AS select `acg_member`.`id` AS `member_id`,`acg_member`.`username` AS `username`,`acg_member`.`callsign` AS `callsign`,`acg_member`.`admin` AS `admin`,`member_max_status`.`member_status` AS `member_status` from (`acg_member` left join `member_max_status` on((`member_max_status`.`member_id` = `acg_member`.`id`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `member_max_status`
--

/*!50001 DROP VIEW IF EXISTS `member_max_status`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `member_max_status` AS select `member_status_log`.`id` AS `id`,`member_status_log`.`member_id` AS `member_id`,`member_status_log`.`member_status` AS `member_status`,`member_status_log`.`status_date_in` AS `status_date_in`,`member_status_log`.`status_date_out` AS `status_date_out`,`member_status_log`.`comment` AS `comment` from `member_status_log` where isnull(`member_status_log`.`status_date_out`) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `member_max_transfer`
--

/*!50001 DROP VIEW IF EXISTS `member_max_transfer`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `member_max_transfer` AS select `transfer`.`id` AS `id`,`transfer`.`member_id` AS `member_id`,`transfer`.`acg_unit_id` AS `acg_unit_id`,`transfer`.`transfer_date_in` AS `transfer_date_in`,`transfer`.`transfer_date_out` AS `transfer_date_out` from `transfer` where isnull(`transfer`.`transfer_date_out`) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `mission_member_faction`
--

/*!50001 DROP VIEW IF EXISTS `mission_member_faction`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `mission_member_faction` AS select `transfer`.`member_id` AS `member_id`,`mission`.`id` AS `mission_id`,`hist_unit`.`faction` AS `faction` from (((`transfer` left join `deployed_unit` on((`deployed_unit`.`acg_unit_id` = `transfer`.`acg_unit_id`))) left join `mission` on((`mission`.`campaign_id` = `deployed_unit`.`campaign_id`))) left join `hist_unit` on((`deployed_unit`.`hist_unit_id` = `hist_unit`.`id`))) where ((`transfer`.`transfer_date_in` <= `mission`.`real_date`) and ((`mission`.`real_date` < `transfer`.`transfer_date_out`) or isnull(`transfer`.`transfer_date_out`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `mission_member_max_promotion_date`
--

/*!50001 DROP VIEW IF EXISTS `mission_member_max_promotion_date`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `mission_member_max_promotion_date` AS select `mission`.`id` AS `mission_id`,`promotion`.`member_id` AS `member_id`,max(`promotion`.`promotion_date`) AS `mx_promotion_date` from (`promotion` left join `mission` on((`promotion`.`promotion_date` <= `mission`.`real_date`))) where (`mission`.`id` is not null) group by `mission_id`,`promotion`.`member_id` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `mission_member_rank`
--

/*!50001 DROP VIEW IF EXISTS `mission_member_rank`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `mission_member_rank` AS select `mission_member_max_promotion_date`.`mission_id` AS `mission_id`,`mission_member_max_promotion_date`.`member_id` AS `member_id`,`rank_lookup`.`real_value` AS `real_value`,`rank_lookup`.`rank_name` AS `rank_name`,`rank_lookup`.`abreviation` AS `abreviation`,`rank_lookup`.`disp_value` AS `disp_value`,`rank_lookup`.`faction` AS `faction`,`rank_lookup`.`image` AS `image` from ((`mission_member_max_promotion_date` join `promotion` on(((`promotion`.`member_id` = `mission_member_max_promotion_date`.`member_id`) and (`promotion`.`promotion_date` = `mission_member_max_promotion_date`.`mx_promotion_date`)))) join `rank_lookup` on((`rank_lookup`.`real_value` = `promotion`.`rank_value`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `mission_report_nav_list`
--

/*!50001 DROP VIEW IF EXISTS `mission_report_nav_list`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `mission_report_nav_list` AS select `report`.`mission_id` AS `mission_id`,`report`.`deployed_unit_id` AS `depl_unit_id`,`report`.`id` AS `report_id`,`career_character`.`first_name` AS `first_name`,`career_character`.`last_name` AS `last_name`,`acg_member`.`callsign` AS `callsign`,`mission_member_rank`.`abreviation` AS `abreviation`,`report`.`accepted` AS `accepted` from (((((`report` join `career_character` on((`career_character`.`id` = `report`.`character_id`))) join `acg_member` on((`acg_member`.`id` = `career_character`.`personified_by`))) join `deployed_unit` on((`deployed_unit`.`id` = `report`.`deployed_unit_id`))) join `hist_unit` on((`hist_unit`.`id` = `deployed_unit`.`hist_unit_id`))) join `mission_member_rank` on(((`mission_member_rank`.`mission_id` = `report`.`mission_id`) and (`mission_member_rank`.`member_id` = `acg_member`.`id`) and (`mission_member_rank`.`faction` = `hist_unit`.`faction`)))) order by `mission_member_rank`.`real_value` desc,`acg_member`.`id` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `mission_unit_plane_asset_status`
--

/*!50001 DROP VIEW IF EXISTS `mission_unit_plane_asset_status`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `mission_unit_plane_asset_status` AS select `report`.`deployed_unit_id` AS `depl_unit_id`,`report`.`mission_id` AS `mission_id`,count(`report`.`id`) AS `sorties`,sum((`report`.`pilot_status` = 0)) AS `pilot_ok`,sum((`report`.`pilot_status` = 1)) AS `pilot_wounded`,sum((`report`.`pilot_status` = 2)) AS `pilot_pow`,sum((`report`.`pilot_status` = 3)) AS `pilot_kia`,sum((`report`.`asset_status` = 0)) AS `asset_ok`,sum((`report`.`asset_status` = 1)) AS `asset_damaged`,sum((`report`.`asset_status` = 2)) AS `asset_lost` from `report` group by `report`.`deployed_unit_id`,`report`.`mission_id` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `random_first_name`
--

/*!50001 DROP VIEW IF EXISTS `random_first_name`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `random_first_name` AS select `namepool`.`name` AS `name`,`namepool`.`faction` AS `faction` from `namepool` where (`namepool`.`type` = 'FirstName') order by rand() */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `random_last_name`
--

/*!50001 DROP VIEW IF EXISTS `random_last_name`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `random_last_name` AS select `namepool`.`name` AS `name`,`namepool`.`faction` AS `faction` from `namepool` where (`namepool`.`type` = 'LastName') order by rand() */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `rank_lookup`
--

/*!50001 DROP VIEW IF EXISTS `rank_lookup`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `rank_lookup` AS select `rank_translation`.`real_value` AS `real_value`,`rank`.`name` AS `rank_name`,`rank`.`abreviation` AS `abreviation`,`rank`.`value` AS `disp_value`,`rank`.`faction` AS `faction`,`rank`.`image` AS `image` from (`rank_translation` join `rank` on(((`rank`.`value` = `rank_translation`.`disp_value`) and (`rank`.`faction` = `rank_translation`.`faction`)))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `rank_translation`
--

/*!50001 DROP VIEW IF EXISTS `rank_translation`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `rank_translation` AS select `rank`.`value` AS `real_value`,min(`x`.`value`) AS `disp_value`,`x`.`faction` AS `faction` from (`rank` left join `rank` `x` on((`x`.`value` >= `rank`.`value`))) group by `rank`.`value`,`x`.`faction` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `report_info`
--

/*!50001 DROP VIEW IF EXISTS `report_info`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `report_info` AS select `report`.`id` AS `report_id`,`report`.`mission_id` AS `mission_id`,`report`.`deployed_unit_id` AS `depl_unit_id`,`report`.`asset_id` AS `asset_id`,`report`.`base` AS `base`,`report`.`markings` AS `markings`,`report`.`asset_status` AS `asset_status`,`report`.`pilot_status` AS `pilot_status`,`report`.`synopsis` AS `synopsis`,`report`.`date_submitted` AS `date_submitted`,`report`.`accepted` AS `accepted`,`report`.`accepted_by` AS `accepted_by`,`career_character`.`id` AS `character_id`,`career_character`.`first_name` AS `first_name`,`career_character`.`last_name` AS `last_name`,`acg_member`.`id` AS `member_id`,`acg_member`.`callsign` AS `callsign`,`hist_unit`.`faction` AS `faction`,`mission_member_rank`.`real_value` AS `rank_value`,`mission_member_rank`.`rank_name` AS `rank_name`,`mission_member_rank`.`abreviation` AS `abreviation`,`mission_member_rank`.`image` AS `image` from ((((((`report` left join `deployed_unit` on((`deployed_unit`.`id` = `report`.`deployed_unit_id`))) left join `hist_unit` on((`hist_unit`.`id` = `deployed_unit`.`hist_unit_id`))) left join `career_character` on((`career_character`.`id` = `report`.`character_id`))) left join `acg_member` on((`acg_member`.`id` = `career_character`.`personified_by`))) left join `asset` on((`asset`.`id` = `report`.`asset_id`))) left join `mission_member_rank` on(((`mission_member_rank`.`mission_id` = `report`.`mission_id`) and (`mission_member_rank`.`member_id` = `acg_member`.`id`) and (`mission_member_rank`.`faction` = `hist_unit`.`faction`)))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `report_submission_depl_units`
--

/*!50001 DROP VIEW IF EXISTS `report_submission_depl_units`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `report_submission_depl_units` AS select `deployed_unit`.`id` AS `depl_unit_id`,`deployed_unit`.`campaign_id` AS `campaign_id`,`deployed_unit`.`acg_unit_id` AS `acg_unit_id`,`hist_unit`.`name` AS `hist_unit_name`,`hist_unit`.`code` AS `hist_unit_code`,`hist_unit`.`faction` AS `faction` from (`deployed_unit` left join `hist_unit` on((`deployed_unit`.`hist_unit_id` = `hist_unit`.`id`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `transfer_status_events`
--

/*!50001 DROP VIEW IF EXISTS `transfer_status_events`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `transfer_status_events` AS select 'transfer' AS `event_type`,`transfer`.`member_id` AS `member_id`,`transfer`.`acg_unit_id` AS `event_value`,`transfer`.`transfer_date_in` AS `date_in`,`transfer`.`transfer_date_out` AS `date_out` from `transfer` union select 'status' AS `1`,`member_status_log`.`member_id` AS `member_id`,`member_status_log`.`member_status` AS `member_status`,`member_status_log`.`status_date_in` AS `status_date_in`,`member_status_log`.`status_date_out` AS `status_date_out` from `member_status_log` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2019-06-14 21:54:53
