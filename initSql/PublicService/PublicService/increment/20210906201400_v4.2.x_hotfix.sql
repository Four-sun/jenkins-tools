-- 删除ps_tenant表dtuic_tenant_id重复的重复数据
DELETE
FROM
	ps_tenant
WHERE
	dtuic_tenant_id IN (
		SELECT
			t.dtuic_tenant_id
		FROM
			(
				SELECT
					dtuic_tenant_id
				FROM
					ps_tenant
				GROUP BY
					dtuic_tenant_id
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
			ps_tenant
		GROUP BY
			dtuic_tenant_id
		HAVING
			count(1) > 1
	) dt
);

-- ps_tenant表去除tenant_name索引，增加dtuic_tenant_id索引
ALTER TABLE `ps_tenant` DROP INDEX `index_tenant_name`,
ADD UNIQUE `index_tenant_id` USING BTREE (`dtuic_tenant_id`) comment '';
