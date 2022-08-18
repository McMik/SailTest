

WITH sqlelem AS (
SELECT
	tbname, 
	tbname AS fedtbname,
	listagg (name,',') WITHIN GROUP ( ORDER BY COLNO ) AS colset,
	listagg ('src.'||name,',') WITHIN GROUP ( ORDER BY COLNO ) AS srccolset,
	listagg ('tgt.'||name||' = '||'src.'||name,',') WITHIN GROUP ( ORDER BY COLNO ) AS setcolset
FROM
	SYSIBM.SYSCOLUMNS
WHERE
	TBCREATOR = 'GAUSS_BIGD'
	AND tbname like 'MSCRM%'
	AND HIDDEN <> 'S'
GROUP BY
	TBNAME)
SELECT 
'MERGE
INTO
	gauss_bigd.'||tbname||' AS tgt
		USING (
	SELECT
		src.*
	FROM
		fed_mscrm_dev.'||fedtbname||' src
	WHERE
				to_timestamp(to_char(MAXCHANGEDDATE,''YYYY-MM-DD-HH24:MI:SS.FF6''),''YYYY-MM-DD-HH24:MI:SS.FF6'') >= (
		SELECT
			DATE(NVL(MAX(MAXCHANGEDDATE),TO_DATE(''1000-01-01'',''YYYY-MM-DD'')))
		FROM gauss_bigd.'||tbname||')) AS src
		ON src.sourceid = tgt.SOURCEID
		AND src. = tgt.
	WHEN MATCHED THEN 
UPDATE
SET '||setcolset||'	WHEN NOT MATCHED THEN
INSERT
	('||colset||') 
VALUES 
('||srccolset||');'
FROM sqlelem;




