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