-- '1', 'Campaign Units', NULL, '0', '0', NULL, NULL
-- '2', 'No.501', 'SD', '2', '1', NULL, NULL
-- '3', 'No.64', 'SH', '2', '1', NULL, NULL
-- '4', 'No.615', 'KW', '2', '1', NULL, NULL
-- '5', '4./JG26', '---  white', '1', '1', NULL, NULL
-- '6', '5./JG26', '---  black', '1', '1', NULL, NULL
-- '7', '6./JG26', '--- brown', '1', '1', NULL, NULL
-- '8', '7./JG26', '|  white', '1', '1', NULL, NULL
-- '9', '6./ZG76', 'M8 . P', '1', '1', NULL, NULL
-- '10', 'No.111', 'JU', '2', '1', NULL, NULL
-- '11', 'Stab/JG26', '< A O ---', '1', '1', NULL, NULL
-- '12', 'No.610', 'DW', '2', '1', NULL, NULL
-- '13', '8./JG26', '| black', '1', '1', NULL, NULL
-- '14', 'No.32', 'GZ', '2', '1', NULL, NULL
-- '15', 'No.302', 'WX', '2', '1', NULL, NULL
-- '16', '9./JG26', '| yellow', '1', '1', NULL, NULL
-- '17', '1./JG26', 'white', '1', '1', NULL, NULL
-- '18', 'Kenley Wing', NULL, '2', '1', NULL, NULL
-- '19', 'Biggin Hill Wing', NULL, '2', '1', NULL, NULL
-- '20', 'No.11 Group', NULL, '2', '1', NULL, NULL
-- '21', 'I./JG26', NULL, '1', '1', NULL, NULL
-- '22', 'II./JG26', NULL, '1', '1', NULL, NULL
-- '23', 'III./JG26', NULL, '1', '1', NULL, NULL
-- '24', 'JG26', NULL, '1', '1', NULL, NULL

-- '2', 'Peace in our Time', '1', '0', '2', '1900 UTC', '0', NULL, NULL, NULL
-- '3', 'Leaning Forward', '1', '0', '2', '1900 UTC', '0', '2', NULL, NULL
-- '4', 'Fall Gelb', '1', '0', '2', '1900 UTC', '0', NULL, NULL, NULL
-- '5', 'Fall Rot', '1', '0', '2', '1900 UTC', '0', '4', NULL, NULL
-- '6', 'Battle of Britain', '1', '0', '1', '1900 UTC', '0', '5', NULL, NULL

-- depl_unit_parent_id, depl_unit_campaign_id, depl_acg_unit_id , depl_hist_unit_id , depl_asset_id , depl_report_type

ALTER TABLE deployed_unit AUTO_INCREMENT = 1;

-- Campaign 2
SET @campaign_ID = 2;
SET @n = 0;
CALL `depl_unit_add_node`(NULL, @campaign_ID, NULL, 1, NULL, NULL); SET @n = @n + 1; SET @cid = @n;
-- '20', 'No.11 Group', NULL, '2', '1', NULL, NULL
-- '18', 'Kenley Wing', NULL, '2', '1', NULL, NULL
-- '19', 'Biggin Hill Wing', NULL, '2', '1', NULL, NULL
CALL `depl_unit_add_node`(@cid, @campaign_ID, NULL, 20, NULL, NULL); SET @n = @n + 1; SET @n11 = @n;
CALL `depl_unit_add_node`(@n11, @campaign_ID, NULL, 18, NULL, NULL); SET @n = @n + 1; SET @kw = @n;
CALL `depl_unit_add_node`(@n11, @campaign_ID, NULL, 19, NULL, NULL); SET @n = @n + 1; SET @bhw = @n;
-- '2', 'No.501', 'SD', '2', '1', NULL, NULL
-- '3', 'No.64', 'SH', '2', '1', NULL, NULL
-- '4', 'No.615', 'KW', '2', '1', NULL, NULL
-- '10', 'No.111', 'JU', '2', '1', NULL, NULL
-- '12', 'No.610', 'DW', '2', '1', NULL, NULL
CALL `depl_unit_add_node`(@kw, @campaign_ID, 2, 2, NULL, NULL); SET @n = @n + 1;
CALL `depl_unit_add_node`(@kw, @campaign_ID, 3, 3, NULL, NULL); SET @n = @n + 1;
CALL `depl_unit_add_node`(@kw, @campaign_ID, 4, 4, NULL, NULL); SET @n = @n + 1;
CALL `depl_unit_add_node`(@bhw, @campaign_ID, 10, 10, NULL, NULL); SET @n = @n + 1;
CALL `depl_unit_add_node`(@bhw, @campaign_ID, 12, 12, NULL, NULL); SET @n = @n + 1;
-- '21', 'I./JG26', NULL, '1', '1', NULL, NULL
-- '22', 'II./JG26', NULL, '1', '1', NULL, NULL
-- '23', 'III./JG26', NULL, '1', '1', NULL, NULL
-- '24', 'JG26', NULL, '1', '1', NULL, NULL
CALL `depl_unit_add_node`(@cid, @campaign_ID, NULL, 24, NULL, NULL); SET @n = @n + 1; SET @jg26 = @n; 
CALL `depl_unit_add_node`(@jg26, @campaign_ID, NULL, 22, NULL, NULL); SET @n = @n + 1; SET @jg26ii = @n;
CALL `depl_unit_add_node`(@jg26, @campaign_ID, NULL, 23, NULL, NULL); SET @n = @n + 1; SET @jg26iii = @n;
-- '5', '4./JG26', '---  white', '1', '1', NULL, NULL
-- '6', '5./JG26', '---  black', '1', '1', NULL, NULL
-- '7', '6./JG26', '--- brown', '1', '1', NULL, NULL
-- '8', '7./JG26', '|  white', '1', '1', NULL, NULL
-- '9', '6./ZG76', 'M8 . P', '1', '1', NULL, NULL
-- '11', 'Stab/JG26', '< A O ---', '1', '1', NULL, NULL
CALL `depl_unit_add_node`(@jg26ii, @campaign_ID, 5, 5, NULL, NULL); SET @n = @n + 1;
CALL `depl_unit_add_node`(@jg26ii, @campaign_ID, 6, 6, NULL, NULL); SET @n = @n + 1;
CALL `depl_unit_add_node`(@jg26ii, @campaign_ID, 7, 7, NULL, NULL); SET @n = @n + 1;
CALL `depl_unit_add_node`(@jg26iii, @campaign_ID, 8, 8, NULL, NULL); SET @n = @n + 1;
CALL `depl_unit_add_node`(@jg26, @campaign_ID, 9, 9, NULL, NULL); SET @n = @n + 1;
CALL `depl_unit_add_node`(@jg26, @campaign_ID, 11, 11, NULL, NULL); SET @n = @n + 1;

-- Campaign 3
SET @campaign_ID = 3;
CALL `depl_unit_add_node`(NULL, @campaign_ID, NULL, 1, NULL, NULL); SET @n = @n + 1; SET @cid = @n;
-- '20', 'No.11 Group', NULL, '2', '1', NULL, NULL
-- '18', 'Kenley Wing', NULL, '2', '1', NULL, NULL
-- '19', 'Biggin Hill Wing', NULL, '2', '1', NULL, NULL
CALL `depl_unit_add_node`(@cid, @campaign_ID, NULL, 20, NULL, NULL); SET @n = @n + 1; SET @n11 = @n;
CALL `depl_unit_add_node`(@n11, @campaign_ID, NULL, 18, NULL, NULL); SET @n = @n + 1; SET @kw = @n;
CALL `depl_unit_add_node`(@n11, @campaign_ID, NULL, 19, NULL, NULL); SET @n = @n + 1; SET @bhw = @n;
-- '2', 'No.501', 'SD', '2', '1', NULL, NULL
-- '3', 'No.64', 'SH', '2', '1', NULL, NULL
-- '4', 'No.615', 'KW', '2', '1', NULL, NULL
-- '10', 'No.111', 'JU', '2', '1', NULL, NULL
-- '12', 'No.610', 'DW', '2', '1', NULL, NULL
CALL `depl_unit_add_node`(@kw, @campaign_ID, 2, 2, NULL, NULL); SET @n = @n + 1;
CALL `depl_unit_add_node`(@kw, @campaign_ID, 3, 3, NULL, NULL); SET @n = @n + 1;
CALL `depl_unit_add_node`(@kw, @campaign_ID, 4, 4, NULL, NULL); SET @n = @n + 1;
CALL `depl_unit_add_node`(@bhw, @campaign_ID, 10, 10, NULL, NULL); SET @n = @n + 1;
CALL `depl_unit_add_node`(@bhw, @campaign_ID, 12, 12, NULL, NULL); SET @n = @n + 1;
-- '21', 'I./JG26', NULL, '1', '1', NULL, NULL
-- '22', 'II./JG26', NULL, '1', '1', NULL, NULL
-- '23', 'III./JG26', NULL, '1', '1', NULL, NULL
-- '24', 'JG26', NULL, '1', '1', NULL, NULL
CALL `depl_unit_add_node`(@cid, @campaign_ID, NULL, 24, NULL, NULL); SET @n = @n + 1; SET @jg26 = @n; 
CALL `depl_unit_add_node`(@jg26, @campaign_ID, NULL, 22, NULL, NULL); SET @n = @n + 1; SET @jg26ii = @n;
CALL `depl_unit_add_node`(@jg26, @campaign_ID, NULL, 23, NULL, NULL); SET @n = @n + 1; SET @jg26iii = @n;
-- '5', '4./JG26', '---  white', '1', '1', NULL, NULL
-- '6', '5./JG26', '---  black', '1', '1', NULL, NULL
-- '7', '6./JG26', '--- brown', '1', '1', NULL, NULL
-- '8', '7./JG26', '|  white', '1', '1', NULL, NULL
-- '13', '8./JG26', '| black', '1', '1', NULL, NULL
-- '16', '9./JG26', '| yellow', '1', '1', NULL, NULL
-- '9', '6./ZG76', 'M8 . P', '1', '1', NULL, NULL
-- '11', 'Stab/JG26', '< A O ---', '1', '1', NULL, NULL
CALL `depl_unit_add_node`(@jg26ii, @campaign_ID, 5, 5, NULL, NULL); SET @n = @n + 1;
CALL `depl_unit_add_node`(@jg26ii, @campaign_ID, 6, 6, NULL, NULL); SET @n = @n + 1;
CALL `depl_unit_add_node`(@jg26ii, @campaign_ID, 7, 7, NULL, NULL); SET @n = @n + 1;
CALL `depl_unit_add_node`(@jg26iii, @campaign_ID, 8, 8, NULL, NULL); SET @n = @n + 1;
CALL `depl_unit_add_node`(@jg26iii, @campaign_ID, 13, 13, NULL, NULL); SET @n = @n + 1;
CALL `depl_unit_add_node`(@jg26iii, @campaign_ID, 16, 16, NULL, NULL); SET @n = @n + 1;
CALL `depl_unit_add_node`(@jg26, @campaign_ID, 9, 9, NULL, NULL); SET @n = @n + 1;
CALL `depl_unit_add_node`(@jg26, @campaign_ID, 11, 11, NULL, NULL); SET @n = @n + 1;

-- Campaign 4
SET @campaign_ID = 4;
CALL `depl_unit_add_node`(NULL, @campaign_ID, NULL, 1, NULL, NULL); SET @n = @n + 1; SET @cid = @n;
-- '20', 'No.11 Group', NULL, '2', '1', NULL, NULL
-- '18', 'Kenley Wing', NULL, '2', '1', NULL, NULL
-- '19', 'Biggin Hill Wing', NULL, '2', '1', NULL, NULL
CALL `depl_unit_add_node`(@cid, @campaign_ID, NULL, 20, NULL, NULL); SET @n = @n + 1; SET @n11 = @n;
CALL `depl_unit_add_node`(@n11, @campaign_ID, NULL, 18, NULL, NULL); SET @n = @n + 1; SET @kw = @n;
CALL `depl_unit_add_node`(@n11, @campaign_ID, NULL, 19, NULL, NULL); SET @n = @n + 1; SET @bhw = @n;
-- '2', 'No.501', 'SD', '2', '1', NULL, NULL
-- '3', 'No.64', 'SH', '2', '1', NULL, NULL
-- '4', 'No.615', 'KW', '2', '1', NULL, NULL
-- '10', 'No.111', 'JU', '2', '1', NULL, NULL
-- '12', 'No.610', 'DW', '2', '1', NULL, NULL
-- '14', 'No.32', 'GZ', '2', '1', NULL, NULL
-- '15', 'No.302', 'WX', '2', '1', NULL, NULL
CALL `depl_unit_add_node`(@kw, @campaign_ID, 2, 2, NULL, NULL); SET @n = @n + 1;
CALL `depl_unit_add_node`(@kw, @campaign_ID, 3, 3, NULL, NULL); SET @n = @n + 1;
CALL `depl_unit_add_node`(@kw, @campaign_ID, 4, 4, NULL, NULL); SET @n = @n + 1;
CALL `depl_unit_add_node`(@bhw, @campaign_ID, 10, 10, NULL, NULL); SET @n = @n + 1;
CALL `depl_unit_add_node`(@bhw, @campaign_ID, 12, 12, NULL, NULL); SET @n = @n + 1;
CALL `depl_unit_add_node`(@bhw, @campaign_ID, 14, 14, NULL, NULL); SET @n = @n + 1;
CALL `depl_unit_add_node`(@n11, @campaign_ID, 15, 15, NULL, NULL); SET @n = @n + 1;
-- '21', 'I./JG26', NULL, '1', '1', NULL, NULL
-- '22', 'II./JG26', NULL, '1', '1', NULL, NULL
-- '23', 'III./JG26', NULL, '1', '1', NULL, NULL
-- '24', 'JG26', NULL, '1', '1', NULL, NULL
CALL `depl_unit_add_node`(@cid, @campaign_ID, NULL, 24, NULL, NULL); SET @n = @n + 1; SET @jg26 = @n; 
CALL `depl_unit_add_node`(@jg26, @campaign_ID, NULL, 22, NULL, NULL); SET @n = @n + 1; SET @jg26ii = @n;
CALL `depl_unit_add_node`(@jg26, @campaign_ID, NULL, 23, NULL, NULL); SET @n = @n + 1; SET @jg26iii = @n;
-- '5', '4./JG26', '---  white', '1', '1', NULL, NULL
-- '6', '5./JG26', '---  black', '1', '1', NULL, NULL
-- '7', '6./JG26', '--- brown', '1', '1', NULL, NULL
-- '8', '7./JG26', '|  white', '1', '1', NULL, NULL
-- '13', '8./JG26', '| black', '1', '1', NULL, NULL
-- '9', '6./ZG76', 'M8 . P', '1', '1', NULL, NULL
-- '11', 'Stab/JG26', '< A O ---', '1', '1', NULL, NULL
CALL `depl_unit_add_node`(@jg26ii, @campaign_ID, 5, 5, NULL, NULL); SET @n = @n + 1;
CALL `depl_unit_add_node`(@jg26ii, @campaign_ID, 6, 6, NULL, NULL); SET @n = @n + 1;
CALL `depl_unit_add_node`(@jg26ii, @campaign_ID, 7, 7, NULL, NULL); SET @n = @n + 1;
CALL `depl_unit_add_node`(@jg26iii, @campaign_ID, 8, 8, NULL, NULL); SET @n = @n + 1;
CALL `depl_unit_add_node`(@jg26iii, @campaign_ID, 13, 13, NULL, NULL); SET @n = @n + 1;
CALL `depl_unit_add_node`(@jg26iii, @campaign_ID, 16, 16, NULL, NULL); SET @n = @n + 1;
CALL `depl_unit_add_node`(@jg26, @campaign_ID, 9, 9, NULL, NULL); SET @n = @n + 1;
CALL `depl_unit_add_node`(@jg26, @campaign_ID, 11, 11, NULL, NULL); SET @n = @n + 1;

-- Campaign 5
SET @campaign_ID = 5;
CALL `depl_unit_add_node`(NULL, @campaign_ID, NULL, 1, NULL, NULL); SET @n = @n + 1; SET @cid = @n;
-- '20', 'No.11 Group', NULL, '2', '1', NULL, NULL
-- '18', 'Kenley Wing', NULL, '2', '1', NULL, NULL
-- '19', 'Biggin Hill Wing', NULL, '2', '1', NULL, NULL
CALL `depl_unit_add_node`(@cid, @campaign_ID, NULL, 20, NULL, NULL); SET @n = @n + 1; SET @n11 = @n;
CALL `depl_unit_add_node`(@n11, @campaign_ID, NULL, 18, NULL, NULL); SET @n = @n + 1; SET @kw = @n;
CALL `depl_unit_add_node`(@n11, @campaign_ID, NULL, 19, NULL, NULL); SET @n = @n + 1; SET @bhw = @n;
-- '2', 'No.501', 'SD', '2', '1', NULL, NULL
-- '3', 'No.64', 'SH', '2', '1', NULL, NULL
-- '4', 'No.615', 'KW', '2', '1', NULL, NULL
-- '10', 'No.111', 'JU', '2', '1', NULL, NULL
-- '12', 'No.610', 'DW', '2', '1', NULL, NULL
-- '14', 'No.32', 'GZ', '2', '1', NULL, NULL
-- '15', 'No.302', 'WX', '2', '1', NULL, NULL
CALL `depl_unit_add_node`(@kw, @campaign_ID, 2, 2, NULL, NULL); SET @n = @n + 1;
CALL `depl_unit_add_node`(@kw, @campaign_ID, 3, 3, NULL, NULL); SET @n = @n + 1;
CALL `depl_unit_add_node`(@kw, @campaign_ID, 4, 4, NULL, NULL); SET @n = @n + 1;
CALL `depl_unit_add_node`(@bhw, @campaign_ID, 10, 10, NULL, NULL); SET @n = @n + 1;
CALL `depl_unit_add_node`(@bhw, @campaign_ID, 12, 12, NULL, NULL); SET @n = @n + 1;
CALL `depl_unit_add_node`(@bhw, @campaign_ID, 14, 14, NULL, NULL); SET @n = @n + 1;
CALL `depl_unit_add_node`(@n11, @campaign_ID, 15, 15, NULL, NULL); SET @n = @n + 1;
-- '21', 'I./JG26', NULL, '1', '1', NULL, NULL
-- '22', 'II./JG26', NULL, '1', '1', NULL, NULL
-- '23', 'III./JG26', NULL, '1', '1', NULL, NULL
-- '24', 'JG26', NULL, '1', '1', NULL, NULL
CALL `depl_unit_add_node`(@cid, @campaign_ID, NULL, 24, NULL, NULL); SET @n = @n + 1; SET @jg26 = @n; 
CALL `depl_unit_add_node`(@jg26, @campaign_ID, NULL, 22, NULL, NULL); SET @n = @n + 1; SET @jg26ii = @n;
CALL `depl_unit_add_node`(@jg26, @campaign_ID, NULL, 23, NULL, NULL); SET @n = @n + 1; SET @jg26iii = @n;
-- '5', '4./JG26', '---  white', '1', '1', NULL, NULL
-- '6', '5./JG26', '---  black', '1', '1', NULL, NULL
-- '7', '6./JG26', '--- brown', '1', '1', NULL, NULL
-- '8', '7./JG26', '|  white', '1', '1', NULL, NULL
-- '13', '8./JG26', '| black', '1', '1', NULL, NULL
-- '16', '9./JG26', '| yellow', '1', '1', NULL, NULL
-- '9', '6./ZG76', 'M8 . P', '1', '1', NULL, NULL
-- '11', 'Stab/JG26', '< A O ---', '1', '1', NULL, NULL
CALL `depl_unit_add_node`(@jg26ii, @campaign_ID, 5, 5, NULL, NULL); SET @n = @n + 1;
CALL `depl_unit_add_node`(@jg26ii, @campaign_ID, 6, 6, NULL, NULL); SET @n = @n + 1;
CALL `depl_unit_add_node`(@jg26ii, @campaign_ID, 7, 7, NULL, NULL); SET @n = @n + 1;
CALL `depl_unit_add_node`(@jg26iii, @campaign_ID, 8, 8, NULL, NULL); SET @n = @n + 1;
CALL `depl_unit_add_node`(@jg26iii, @campaign_ID, 13, 13, NULL, NULL); SET @n = @n + 1;
CALL `depl_unit_add_node`(@jg26iii, @campaign_ID, 16, 16, NULL, NULL); SET @n = @n + 1;
CALL `depl_unit_add_node`(@jg26, @campaign_ID, 9, 9, NULL, NULL); SET @n = @n + 1;
CALL `depl_unit_add_node`(@jg26, @campaign_ID, 11, 11, NULL, NULL); SET @n = @n + 1;

-- Campaign 6
SET @campaign_ID = 6;
CALL `depl_unit_add_node`(NULL, @campaign_ID, NULL, 1, NULL, NULL); SET @n = @n + 1; SET @cid = @n;
-- '20', 'No.11 Group', NULL, '2', '1', NULL, NULL
-- '18', 'Kenley Wing', NULL, '2', '1', NULL, NULL
-- '19', 'Biggin Hill Wing', NULL, '2', '1', NULL, NULL
CALL `depl_unit_add_node`(@cid, @campaign_ID, NULL, 20, NULL, NULL); SET @n = @n + 1; SET @n11 = @n;
CALL `depl_unit_add_node`(@n11, @campaign_ID, NULL, 18, NULL, NULL); SET @n = @n + 1; SET @kw = @n;
CALL `depl_unit_add_node`(@n11, @campaign_ID, NULL, 19, NULL, NULL); SET @n = @n + 1; SET @bhw = @n;
-- '2', 'No.501', 'SD', '2', '1', NULL, NULL
-- '3', 'No.64', 'SH', '2', '1', NULL, NULL
-- '4', 'No.615', 'KW', '2', '1', NULL, NULL
-- '10', 'No.111', 'JU', '2', '1', NULL, NULL
-- '12', 'No.610', 'DW', '2', '1', NULL, NULL
-- '14', 'No.32', 'GZ', '2', '1', NULL, NULL
-- '15', 'No.302', 'WX', '2', '1', NULL, NULL
CALL `depl_unit_add_node`(@kw, @campaign_ID, 2, 2, NULL, NULL); SET @n = @n + 1;
CALL `depl_unit_add_node`(@kw, @campaign_ID, 3, 3, NULL, NULL); SET @n = @n + 1;
CALL `depl_unit_add_node`(@kw, @campaign_ID, 4, 4, NULL, NULL); SET @n = @n + 1;
CALL `depl_unit_add_node`(@bhw, @campaign_ID, 10, 10, NULL, NULL); SET @n = @n + 1;
CALL `depl_unit_add_node`(@bhw, @campaign_ID, 12, 12, NULL, NULL); SET @n = @n + 1;
CALL `depl_unit_add_node`(@bhw, @campaign_ID, 14, 14, NULL, NULL); SET @n = @n + 1;
CALL `depl_unit_add_node`(@n11, @campaign_ID, 15, 15, NULL, NULL); SET @n = @n + 1;
-- '21', 'I./JG26', NULL, '1', '1', NULL, NULL
-- '22', 'II./JG26', NULL, '1', '1', NULL, NULL
-- '23', 'III./JG26', NULL, '1', '1', NULL, NULL
-- '24', 'JG26', NULL, '1', '1', NULL, NULL
CALL `depl_unit_add_node`(@cid, @campaign_ID, NULL, 24, NULL, NULL); SET @n = @n + 1; SET @jg26 = @n; 
CALL `depl_unit_add_node`(@jg26, @campaign_ID, NULL, 21, NULL, NULL); SET @n = @n + 1; SET @jg26i = @n;
CALL `depl_unit_add_node`(@jg26, @campaign_ID, NULL, 22, NULL, NULL); SET @n = @n + 1; SET @jg26ii = @n;
CALL `depl_unit_add_node`(@jg26, @campaign_ID, NULL, 23, NULL, NULL); SET @n = @n + 1; SET @jg26iii = @n;
-- '5', '4./JG26', '---  white', '1', '1', NULL, NULL
-- '6', '5./JG26', '---  black', '1', '1', NULL, NULL
-- '7', '6./JG26', '--- brown', '1', '1', NULL, NULL
-- '8', '7./JG26', '|  white', '1', '1', NULL, NULL
-- '13', '8./JG26', '| black', '1', '1', NULL, NULL
-- '16', '9./JG26', '| yellow', '1', '1', NULL, NULL
-- '9', '6./ZG76', 'M8 . P', '1', '1', NULL, NULL
-- '11', 'Stab/JG26', '< A O ---', '1', '1', NULL, NULL
-- '17', '1./JG26', 'white', '1', '1', NULL, NULL
CALL `depl_unit_add_node`(@jg26i, @campaign_ID, 17, 17, NULL, NULL); SET @n = @n + 1;
CALL `depl_unit_add_node`(@jg26ii, @campaign_ID, 5, 5, NULL, NULL); SET @n = @n + 1;
CALL `depl_unit_add_node`(@jg26ii, @campaign_ID, 6, 6, NULL, NULL); SET @n = @n + 1;
CALL `depl_unit_add_node`(@jg26ii, @campaign_ID, 7, 7, NULL, NULL); SET @n = @n + 1;
CALL `depl_unit_add_node`(@jg26iii, @campaign_ID, 8, 8, NULL, NULL); SET @n = @n + 1;
CALL `depl_unit_add_node`(@jg26iii, @campaign_ID, 13, 13, NULL, NULL); SET @n = @n + 1;
CALL `depl_unit_add_node`(@jg26iii, @campaign_ID, 16, 16, NULL, NULL); SET @n = @n + 1;
CALL `depl_unit_add_node`(@jg26, @campaign_ID, 9, 9, NULL, NULL); SET @n = @n + 1;
CALL `depl_unit_add_node`(@jg26, @campaign_ID, 11, 11, NULL, NULL); SET @n = @n + 1;

-- Campaign 7
SET @campaign_ID = 7;
SET @BoB_unit_shift = 7;
-- IN depl_unit_parent_id INT,
-- IN depl_unit_campaign_id INT,
-- IN depl_acg_unit_id INT,
-- IN depl_hist_unit_id INT,
-- IN depl_asset_id INT,
-- IN depl_report_type INT

-- unit-id	hist_unit	acg_unit
-- 18		27-2		610 (12)
-- 19		2./JG51		8th (13)
-- 20		4./JG52		6th (7)
-- 21		208-1		ZG (9)
-- 22		233-1		111 (10)
-- 23		7./StG1 	Stab (11)
-- 24		34-3		615 (4)
-- 25		495-2		501 (2)
-- 26		15./JG27	5th (6)
-- 27		3./JG52		7th (8)
-- 28		126-PVO		32 (14)
-- 29		27-1		64 (3)
-- 30		10./LG2		4th (5)
-- 32		1./JG51		1st (17)
-- 33		11./JG51	9th (16)
CALL `depl_unit_add_node`(NULL, @campaign_ID, NULL, 1, NULL, NULL);
CALL `depl_unit_add_node`(1, @campaign_ID, 12, 18 + @BoB_unit_shift, NULL, NULL);
CALL `depl_unit_add_node`(1, @campaign_ID, 13, 19 + @BoB_unit_shift, NULL, NULL);
CALL `depl_unit_add_node`(1, @campaign_ID, 7, 20 + @BoB_unit_shift, NULL, NULL);
CALL `depl_unit_add_node`(1, @campaign_ID, 9, 21 + @BoB_unit_shift, NULL, NULL);
CALL `depl_unit_add_node`(1, @campaign_ID, 10, 22 + @BoB_unit_shift, NULL, NULL);
CALL `depl_unit_add_node`(1, @campaign_ID, 11, 23 + @BoB_unit_shift, NULL, NULL);
CALL `depl_unit_add_node`(1, @campaign_ID, 4, 24 + @BoB_unit_shift, NULL, NULL);
CALL `depl_unit_add_node`(1, @campaign_ID, 2, 25 + @BoB_unit_shift, NULL, NULL);
CALL `depl_unit_add_node`(1, @campaign_ID, 6, 26 + @BoB_unit_shift, NULL, NULL);
CALL `depl_unit_add_node`(1, @campaign_ID, 8, 27 + @BoB_unit_shift, NULL, NULL);
CALL `depl_unit_add_node`(1, @campaign_ID, 14, 28 + @BoB_unit_shift, NULL, NULL);
CALL `depl_unit_add_node`(1, @campaign_ID, 3, 29 + @BoB_unit_shift, NULL, NULL);
CALL `depl_unit_add_node`(1, @campaign_ID, 5, 30 + @BoB_unit_shift, NULL, NULL);
CALL `depl_unit_add_node`(1, @campaign_ID, 17, 32 + @BoB_unit_shift, NULL, NULL);
CALL `depl_unit_add_node`(1, @campaign_ID, 16, 33 + @BoB_unit_shift, NULL, NULL);

-- Campaign 8
SET @campaign_ID = 8;
-- IN depl_unit_parent_id INT,
-- IN depl_unit_campaign_id INT,
-- IN depl_acg_unit_id INT,
-- IN depl_hist_unit_id INT,
-- IN depl_asset_id INT,
-- IN depl_report_type INT

-- unit-id	hist_unit	acg_unit
-- 18		27-2		610 (12)
-- 34		4./ZG26		8th (13)
-- 20		4./JG52		6th (7)
-- 21		208-1		ZG (9)
-- 22		233-1		111 (10)
-- 23		7./StG1 	Stab (11)
-- 24		34-3		615 (4)
-- 25		495-2		501 (2)
-- 26		15./JG27	5th (6)
-- 35		495-1		7th (8)
-- 28		126-PVO		32 (14)
-- 29		27-1		64 (3)
-- 30		10./LG2		4th (5)
-- 32		1./JG51		1st (17)
-- 33		11./JG51	9th (16)
CALL `depl_unit_add_node`(NULL, @campaign_ID, NULL, 1, NULL, NULL);
CALL `depl_unit_add_node`(1, @campaign_ID, 12, 18 + @BoB_unit_shift, NULL, NULL);
CALL `depl_unit_add_node`(1, @campaign_ID, 13, 34 + @BoB_unit_shift, NULL, NULL);
CALL `depl_unit_add_node`(1, @campaign_ID, 7, 20 + @BoB_unit_shift, NULL, NULL);
CALL `depl_unit_add_node`(1, @campaign_ID, 9, 21 + @BoB_unit_shift, NULL, NULL);
CALL `depl_unit_add_node`(1, @campaign_ID, 10, 22 + @BoB_unit_shift, NULL, NULL);
CALL `depl_unit_add_node`(1, @campaign_ID, 11, 23 + @BoB_unit_shift, NULL, NULL);
CALL `depl_unit_add_node`(1, @campaign_ID, 4, 24 + @BoB_unit_shift, NULL, NULL);
CALL `depl_unit_add_node`(1, @campaign_ID, 2, 25 + @BoB_unit_shift, NULL, NULL);
CALL `depl_unit_add_node`(1, @campaign_ID, 6, 26 + @BoB_unit_shift, NULL, NULL);
CALL `depl_unit_add_node`(1, @campaign_ID, 8, 35 + @BoB_unit_shift, NULL, NULL);
CALL `depl_unit_add_node`(1, @campaign_ID, 14, 28 + @BoB_unit_shift, NULL, NULL);
CALL `depl_unit_add_node`(1, @campaign_ID, 3, 29 + @BoB_unit_shift, NULL, NULL);
CALL `depl_unit_add_node`(1, @campaign_ID, 5, 30 + @BoB_unit_shift, NULL, NULL);
CALL `depl_unit_add_node`(1, @campaign_ID, 17, 32 + @BoB_unit_shift, NULL, NULL);
CALL `depl_unit_add_node`(1, @campaign_ID, 16, 33 + @BoB_unit_shift, NULL, NULL);

-- Campaign 9
SET @campaign_ID = 9;
-- IN depl_unit_parent_id INT,
-- IN depl_unit_campaign_id INT,
-- IN depl_acg_unit_id INT,
-- IN depl_hist_unit_id INT,
-- IN depl_asset_id INT,
-- IN depl_report_type INT

-- unit-id	hist_unit	acg_unit
-- 18		27-2		610 (12)
-- 19		2./JG51		8th (13)
-- 20		4./JG52		6th (7)
-- 21		208-1		ZG (9)
-- 22		233-1		111 (10)
-- 23		7./StG1 	Stab (11)
-- 24		34-3		615 (4)
-- 25		495-2		501 (2)
-- 26		15./JG27	5th (6)
-- 35		495-1		7th (8)
-- 28		126-PVO		32 (14)
-- 29		27-1		64 (3)
-- 30		10./LG2		4th (5)
-- 36		4./ZG26		1st (17)
-- 33		11./JG51	9th (16)
CALL `depl_unit_add_node`(NULL, @campaign_ID, NULL, 1, NULL, NULL);
CALL `depl_unit_add_node`(1, @campaign_ID, 12, 18 + @BoB_unit_shift, NULL, NULL);
CALL `depl_unit_add_node`(1, @campaign_ID, 13, 19 + @BoB_unit_shift, NULL, NULL);
CALL `depl_unit_add_node`(1, @campaign_ID, 7, 20 + @BoB_unit_shift, NULL, NULL);
CALL `depl_unit_add_node`(1, @campaign_ID, 9, 21 + @BoB_unit_shift, NULL, NULL);
CALL `depl_unit_add_node`(1, @campaign_ID, 10, 22 + @BoB_unit_shift, NULL, NULL);
CALL `depl_unit_add_node`(1, @campaign_ID, 11, 23 + @BoB_unit_shift, NULL, NULL);
CALL `depl_unit_add_node`(1, @campaign_ID, 4, 24 + @BoB_unit_shift, NULL, NULL);
CALL `depl_unit_add_node`(1, @campaign_ID, 2, 25 + @BoB_unit_shift, NULL, NULL);
CALL `depl_unit_add_node`(1, @campaign_ID, 6, 26 + @BoB_unit_shift, NULL, NULL);
CALL `depl_unit_add_node`(1, @campaign_ID, 8, 35 + @BoB_unit_shift, NULL, NULL);
CALL `depl_unit_add_node`(1, @campaign_ID, 14, 28 + @BoB_unit_shift, NULL, NULL);
CALL `depl_unit_add_node`(1, @campaign_ID, 3, 29 + @BoB_unit_shift, NULL, NULL);
CALL `depl_unit_add_node`(1, @campaign_ID, 5, 30 + @BoB_unit_shift, NULL, NULL);
CALL `depl_unit_add_node`(1, @campaign_ID, 17, 36 + @BoB_unit_shift, NULL, NULL);
CALL `depl_unit_add_node`(1, @campaign_ID, 16, 33 + @BoB_unit_shift, NULL, NULL);


-- Campaign 10
SET @campaign_ID = 10;
-- IN depl_unit_parent_id INT,
-- IN depl_unit_campaign_id INT,
-- IN depl_acg_unit_id INT,
-- IN depl_hist_unit_id INT,
-- IN depl_asset_id INT,
-- IN depl_report_type INT

-- unit-id	hist_unit	acg_unit
-- 18		27-2		610 (12)
-- 21		208-1		ZG (9)
-- 22		233-1		111 (10)
-- 24		34-3		615 (4)
-- 25		495-2		501 (2)
-- 26		15./JG27	5th (6)
-- 28		126-PVO		32 (14)
-- 30		10./LG2		4th (5)
-- 33		11./JG51	9th (16)
-- 35		495-1		7th (8)
-- 36		4./ZG26		6th (7)
-- 37       5./KG3      Stab (11)
-- 38		62 ShAP		64 (3)
-- 39       9./JG51		1st (17)
-- 40       8./JG51     8th (13)

CALL `depl_unit_add_node`(NULL, @campaign_ID, NULL, 1, NULL, NULL);
CALL `depl_unit_add_node`(1, @campaign_ID, 12, 18 + @BoB_unit_shift, NULL, NULL);
CALL `depl_unit_add_node`(1, @campaign_ID, 9, 21 + @BoB_unit_shift, NULL, NULL);
CALL `depl_unit_add_node`(1, @campaign_ID, 10, 22 + @BoB_unit_shift, NULL, NULL);
CALL `depl_unit_add_node`(1, @campaign_ID, 4, 24 + @BoB_unit_shift, NULL, NULL);
CALL `depl_unit_add_node`(1, @campaign_ID, 2, 25 + @BoB_unit_shift, NULL, NULL);
CALL `depl_unit_add_node`(1, @campaign_ID, 6, 26 + @BoB_unit_shift, NULL, NULL);
CALL `depl_unit_add_node`(1, @campaign_ID, 14, 28 + @BoB_unit_shift, NULL, NULL);
CALL `depl_unit_add_node`(1, @campaign_ID, 5, 30 + @BoB_unit_shift, NULL, NULL);
CALL `depl_unit_add_node`(1, @campaign_ID, 16, 33 + @BoB_unit_shift, NULL, NULL);
CALL `depl_unit_add_node`(1, @campaign_ID, 8, 35 + @BoB_unit_shift, NULL, NULL);
CALL `depl_unit_add_node`(1, @campaign_ID, 7, 36 + @BoB_unit_shift, NULL, NULL);
CALL `depl_unit_add_node`(1, @campaign_ID, 11, 37 + @BoB_unit_shift, NULL, NULL);
CALL `depl_unit_add_node`(1, @campaign_ID, 3, 38 + @BoB_unit_shift, NULL, NULL);
CALL `depl_unit_add_node`(1, @campaign_ID, 17, 39 + @BoB_unit_shift, NULL, NULL);
CALL `depl_unit_add_node`(1, @campaign_ID, 13, 40 + @BoB_unit_shift, NULL, NULL);