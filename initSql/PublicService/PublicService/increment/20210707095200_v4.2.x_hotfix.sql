-- 加唯一索引前清除可能存在的重复数据
DELETE
FROM
	ps_user
WHERE
	dtuic_user_id IN (
		SELECT
			t.dtuic_user_id
		FROM
			(
				SELECT
					dtuic_user_id
				FROM
					ps_user
				GROUP BY
					dtuic_user_id
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
			ps_user
		GROUP BY
			dtuic_user_id
		HAVING
			count(1) > 1
	) dt
);


-- ps_user表添加联合唯一索引is_deleted,dtuic_user_id
ALTER TABLE `ps_user` ADD UNIQUE `dtuic_ref` USING BTREE (`is_deleted`, `dtuic_user_id`) comment '';