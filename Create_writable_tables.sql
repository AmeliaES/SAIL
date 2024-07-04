-- Create a writable table for PEDW admissions data
/*CREATE TABLE SAILW1515V.PEDW_ADMISSIONS_20230306_TMP as (
    SELECT * from SAIL1515V.PEDW_ADMISSIONS_20230306)
    with no data
    distribute by hash(ALF_PE);

INSERT INTO SAILW1515V.PEDW_ADMISSIONS_20230306_TMP (
    SELECT * from SAIL1515V.PEDW_ADMISSIONS_20230306);*/
 
-- For ethnicity data in the PEDW admissions:
CREATE TABLE SAILW1515V.PEDW_EPISODE_20230306_TMP as (
    SELECT SPELL_NUM_PE, ETH_GRP_DERIVED_DESC from SAIL1515V.PEDW_EPISODE_20230306)
    with no data
    distribute by hash(SPELL_NUM_PE );

INSERT INTO SAILW1515V.PEDW_EPISODE_20230306_TMP (
    SELECT SPELL_NUM_PE, ETH_GRP_DERIVED_DESC from SAIL1515V.PEDW_EPISODE_20230306);

-- Other PEDW data (for codes for not just first and last diagnoses but all diagnostic positions, and all episodes in each spell) :
CREATE TABLE SAILW1515V.PEDW_SINGLE_DIAG_20230306_TMP as (
    SELECT * from SAIL1515V.PEDW_SINGLE_DIAG_20230306)
    with no data
    distribute by hash(ALF_PE);

INSERT INTO SAILW1515V.PEDW_SINGLE_DIAG_20230306_TMP (
    SELECT * from SAIL1515V.PEDW_SINGLE_DIAG_20230306);
   
SELECT * FROM SAILW1515V.PEDW_SINGLE_DIAG_20230306_TMP;

-- Create a writable table for NCCH data
/*CREATE TABLE SAILW1515V.NCCH_CHILD_BIRTHS_20221101_TMP AS (
	SELECT * FROM SAIL1515V.NCCH_CHILD_BIRTHS_20221101)
	WITH NO DATA
	DISTRIBUTE BY HASH(MAT_ALF_PE);

INSERT INTO SAILW1515V.NCCH_CHILD_BIRTHS_20221101_TMP ( 
	SELECT * FROM SAIL1515V.NCCH_CHILD_BIRTHS_20221101);*/

-- FOR MAT_WOB we need:
DROP TABLE SAILW1515V.NCCH_CHILD_TRUST_20221101_TMP;

CREATE TABLE SAILW1515V.NCCH_CHILD_TRUST_20221101_TMP AS (
	SELECT DISTINCT MAT_ALF_PE, WOB
	FROM SAIL1515V.NCCH_CHILD_TRUST_20221101
	WHERE MAT_ALF_PE IS NOT NULL)
	WITH NO DATA
	DISTRIBUTE BY HASH(MAT_ALF_PE);

INSERT INTO SAILW1515V.NCCH_CHILD_TRUST_20221101_TMP ( 
		SELECT DISTINCT MAT_ALF_PE, WOB
	FROM SAIL1515V.NCCH_CHILD_TRUST_20221101
	WHERE MAT_ALF_PE IS NOT NULL);

-- Create a writable table for WDSD data (Welsh Demographic Service Dataset)
/*CREATE TABLE SAILW1515V.WDSD_SINGLE_CLEAN_GEO_CHAR_LSOA2011_20230306_TMP AS (
	SELECT * FROM SAIL1515V.WDSD_SINGLE_CLEAN_GEO_CHAR_LSOA2011_20230306)
	WITH NO DATA
	DISTRIBUTE BY HASH(ALF_PE);

INSERT INTO SAILW1515V.WDSD_SINGLE_CLEAN_GEO_CHAR_LSOA2011_20230306_TMP ( 
	SELECT * FROM SAIL1515V.WDSD_SINGLE_CLEAN_GEO_CHAR_LSOA2011_20230306);*/

SELECT * FROM SAILW1515V.WDSD_SINGLE_CLEAN_GEO_CHAR_LSOA2011_20230306_TMP WDSD;

-- CREATE a writeable TABLE FOR ADDE DATA
/*CREATE TABLE SAILW1515V.ADDE_DEATHS_20230301_TMP AS (
	SELECT * FROM SAIL1515V.ADDE_DEATHS_20230301)
	WITH NO DATA
	DISTRIBUTE BY HASH(ALF_PE);

INSERT INTO SAILW1515V.ADDE_DEATHS_20230301_TMP ( 
	SELECT * FROM SAIL1515V.ADDE_DEATHS_20230301);*/

SELECT * FROM SAILW1515V.ADDE_DEATHS_20230301_TMP;