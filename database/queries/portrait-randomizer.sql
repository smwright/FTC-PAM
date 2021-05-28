SELECT 
CONCAT(
	"2-",
	ELT(FLOOR(RAND()*7)+1, '1', '2', '3', '4' , '5' , '6' , '7'), "-",
    ELT(FLOOR(RAND()*6)+1, '1', '2', '3', '4' , '5' , '6'), "-",
    ELT(FLOOR(RAND()*7)+1, '1', '2', '3', '4' , '5' , '6' , '7'), "-",
    ELT(FLOOR(RAND()*7)+1, '1', '2', '3', '4' , '5' , '6' , '7'), "-",
    ELT(FLOOR(RAND()*7)+1, '1', '2', '3', '4' , '5' , '6' , '7'), "-",
    ELT(FLOOR(RAND()*7)+1, '1', '2', '3', '4' , '5' , '6' , '7')
);

UPDATE career_character
SET
portrait_seed = CONCAT(
	"2-",
	ELT(FLOOR(RAND()*7)+1, '1', '2', '3', '4' , '5' , '6' , '7'), "-",
    ELT(FLOOR(RAND()*6)+1, '1', '2', '3', '4' , '5' , '6'), "-",
    ELT(FLOOR(RAND()*7)+1, '1', '2', '3', '4' , '5' , '6' , '7'), "-",
    ELT(FLOOR(RAND()*7)+1, '1', '2', '3', '4' , '5' , '6' , '7'), "-",
    ELT(FLOOR(RAND()*7)+1, '1', '2', '3', '4' , '5' , '6' , '7'), "-",
    ELT(FLOOR(RAND()*7)+1, '1', '2', '3', '4' , '5' , '6' , '7')
) WHERE id IN (
SELECT DISTINCT
character_id
FROM report 
LEFT JOIN deployed_unit ON report.deployed_unit_id = deployed_unit.id
LEFT JOIN hist_unit ON deployed_unit.hist_unit_id = hist_unit.id
WHERE faction = 1);


-- lw_images: { //images for the Luftwaffe character portraits
--         background: [2],
--         ears: [1, 2, 3, 4, 5, 6, 7],
--         eyes: [1, 2, 3, 4, 5, 6],
--         hair: [1, 2, 3, 4, 5, 6, 7],
--         head: [1, 2, 3, 4, 5, 6, 7],
--         mouth: [1, 2, 3, 4, 5, 6, 7],
--         nose: [1, 2, 3, 4, 5, 6, 7],
--       },
SELECT 
CONCAT(
	ELT(FLOOR(RAND()*1)+1, '4'), "-",
	ELT(FLOOR(RAND()*8)+1, '1', '2', '3', '5' , '7' , '9', '10', '11'), "-",
    ELT(FLOOR(RAND()*5)+1, '4', '5', '9', '10' , '13'), "-",
    ELT(FLOOR(RAND()*4)+1, '7', '8', '10', '11'), "-",
    ELT(FLOOR(RAND()*8)+1, '1', '2', '3', '4' , '5' , '6', '7', '8'), "-",
    ELT(FLOOR(RAND()*5)+1, '3', '4', '6', '7' , '13'), "-",
    ELT(FLOOR(RAND()*6)+1, '2', '4', '5', '6' , '8' , '9')
);

UPDATE career_character
SET
portrait_seed = CONCAT(
	ELT(FLOOR(RAND()*1)+1, '4'), "-",
	ELT(FLOOR(RAND()*8)+1, '1', '2', '3', '5' , '7' , '9', '10', '11'), "-",
    ELT(FLOOR(RAND()*5)+1, '4', '5', '9', '10' , '13'), "-",
    ELT(FLOOR(RAND()*4)+1, '7', '8', '10', '11'), "-",
    ELT(FLOOR(RAND()*8)+1, '1', '2', '3', '4' , '5' , '6', '7', '8'), "-",
    ELT(FLOOR(RAND()*5)+1, '3', '4', '6', '7' , '13'), "-",
    ELT(FLOOR(RAND()*6)+1, '2', '4', '5', '6' , '8' , '9')
) WHERE id IN (
SELECT DISTINCT
character_id
FROM report 
LEFT JOIN deployed_unit ON report.deployed_unit_id = deployed_unit.id
LEFT JOIN hist_unit ON deployed_unit.hist_unit_id = hist_unit.id
WHERE faction = 2);
--       raf_images: { //images for the Luftwaffe character portraits
--         background: [4],
--         ears: [1, 2, 3, 5, 7, 9, 10, 11],
--         eyes: [4, 5, 9, 10, 13],
--         hair: [7, 8, 10, 11],
--         head: [1, 2, 3, 4, 5, 6, 7, 8],
--         mouth: [3, 4, 6, 7, 13],
--         nose: [2, 4, 5, 6, 8, 9],
--       },

SELECT 
CONCAT(
	ELT(FLOOR(RAND()*3)+1, '3', '5' , '6'), "-",
	ELT(FLOOR(RAND()*6)+1, '1', '2', '3', '4' , '5' , '6'), "-",
    ELT(FLOOR(RAND()*6)+1, '1', '2', '3', '4' , '5' , '6'), "-",
    ELT(FLOOR(RAND()*6)+1, '1', '2', '3', '4' , '5' , '6'), "-",
    ELT(FLOOR(RAND()*6)+1, '1', '2', '3', '4' , '5' , '6'), "-",
    ELT(FLOOR(RAND()*6)+1, '1', '2', '3', '4' , '5' , '6'), "-",
    ELT(FLOOR(RAND()*6)+1, '1', '2', '3', '4' , '5' , '6')
);


--       usaaf_images: { //images for the Luftwaffe character portraits
--         background: [3, 5, 6],
--         ears: [1, 2, 3, 4, 5, 6],
--         eyes: [1, 2, 3, 4, 5, 6],
--         hair: [1, 2, 3, 4, 5, 6],
--         head: [1, 2, 3, 4, 5, 6],
--         mouth: [1, 2, 3, 4, 5, 6],
--         nose: [1, 2, 3, 4, 5, 6],
--       },

SELECT 
CONCAT(
	ELT(FLOOR(RAND()*2)+1, '1', '5'), "-",
	ELT(FLOOR(RAND()*3)+1, '4', '6', '8'), "-",
    ELT(FLOOR(RAND()*8)+1, '1', '2', '3', '6' , '7' , '8', '11', '12'), "-",
    ELT(FLOOR(RAND()*7)+1, '1', '2', '3', '4' , '5' , '6', '9'), "-",
    ELT(FLOOR(RAND()*8)+1, '1', '2', '3', '4' , '5' , '6', '7', '8'), "-",
    ELT(FLOOR(RAND()*11)+1, '1', '2', '5', '8' , '9' , '10', '11', '12', '14', '15', '16'), "-",
    ELT(FLOOR(RAND()*4)+1, '1', '3', '7', '10')
);
UPDATE career_character
SET
portrait_seed = CONCAT(
	ELT(FLOOR(RAND()*2)+1, '1', '5'), "-",
	ELT(FLOOR(RAND()*3)+1, '4', '6', '8'), "-",
    ELT(FLOOR(RAND()*8)+1, '1', '2', '3', '6' , '7' , '8', '11', '12'), "-",
    ELT(FLOOR(RAND()*7)+1, '1', '2', '3', '4' , '5' , '6', '9'), "-",
    ELT(FLOOR(RAND()*8)+1, '1', '2', '3', '4' , '5' , '6', '7', '8'), "-",
    ELT(FLOOR(RAND()*11)+1, '1', '2', '5', '8' , '9' , '10', '11', '12', '14', '15', '16'), "-",
    ELT(FLOOR(RAND()*4)+1, '1', '3', '7', '10')
) WHERE id IN (
SELECT DISTINCT
character_id
FROM report 
LEFT JOIN deployed_unit ON report.deployed_unit_id = deployed_unit.id
LEFT JOIN hist_unit ON deployed_unit.hist_unit_id = hist_unit.id
WHERE faction = 3);
--       vvs_images: { //images for the Luftwaffe character portraits
--         background: [1, 5],
--         ears: [4, 6, 8],
--         eyes: [1, 2, 3, 6, 7, 8, 11, 12],
--         hair: [1, 2, 3, 4, 5, 6, 9],
--         head: [1, 2, 3, 4, 5, 6, 7, 8],
--         mouth: [1, 2, 5, 8, 9, 10, 11, 12, 14, 15, 16],
--         nose: [1, 3, 7, 10],
--       }