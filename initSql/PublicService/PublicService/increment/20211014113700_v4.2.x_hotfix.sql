-- 清理dsc_auth_ref表重复的数据
DELETE
FROM
	dsc_auth_ref
WHERE
	concat(concat(data_info_id,"_"),app_type) IN (
		SELECT
			t.id_type
		FROM
			(
				SELECT
					concat(concat(data_info_id,"_"),app_type) as id_type
				FROM
					dsc_auth_ref
				GROUP BY
					data_info_id,app_type
				HAVING
					count(1) > 1
			) t
	)
AND id NOT IN (
SELECT
	dt.min_id
FROM
	(
		SELECT
			min(id) AS min_id
		FROM
			dsc_auth_ref
		GROUP BY
			data_info_id,app_type
		HAVING
			count(1) > 1
	) dt
);



-- dsc_auth_ref表增加联合唯一索引data_info_app_type
ALTER TABLE `dsc_auth_ref` ADD UNIQUE `data_info_app_type` USING BTREE (`data_info_id`, `app_type`) comment '';