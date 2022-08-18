SELECT *
FROM SYSIBM.syscolumns WHERE tbname='MSCRM_PHONECALLS' AND tbcreator='FED_MSCRM_DEV' AND coltype IN ('VARCHAR','VARGRAPH')
ORDER BY colno;


SELECT 'select * from fed_mscrm_dev.mscrm_phonecalls where '||name||' like ''xxxxxxxx'';' 
FROM SYSIBM.syscolumns WHERE tbname='MSCRM_PHONECALLS' AND tbcreator='FED_MSCRM_DEV' AND coltype IN ('VARCHAR','VARGRAPH')
ORDER BY colno;

