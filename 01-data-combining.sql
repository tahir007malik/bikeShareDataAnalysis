--===============================================================================
--MERGING ALL CSV FILES INTO 2022-annual
--===============================================================================

CREATE TABLE `cyclistic_dataset.2022-annual` AS (
  SELECT * FROM `cyclistic_dataset.2022-01` UNION ALL
  SELECT * FROM `cyclistic_dataset.2022-02` UNION ALL
  SELECT * FROM `cyclistic_dataset.2022-03` UNION ALL
  SELECT * FROM `cyclistic_dataset.2022-04` UNION ALL
  SELECT * FROM `cyclistic_dataset.2022-05` UNION ALL
  SELECT * FROM `cyclistic_dataset.2022-06` UNION ALL
  SELECT * FROM `cyclistic_dataset.2022-07` UNION ALL
  SELECT * FROM `cyclistic_dataset.2022-08` UNION ALL
  SELECT * FROM `cyclistic_dataset.2022-09` UNION ALL
  SELECT * FROM `cyclistic_dataset.2022-10` UNION ALL
  SELECT * FROM `cyclistic_dataset.2022-11` UNION ALL
  SELECT * FROM `cyclistic_dataset.2022-12` 
);