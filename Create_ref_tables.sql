-- CREATE reference tables
------------------------------------------------------
-- Suggestion from slides of best practices in SQL:
-- Creates variables where we can declare parameters (eg. ICD-10 codes) by name
-- If you need to change these codes ie. which ICD-10 codes to use for a definition you only have to do this once
-- ie. when defining the variable
-- NOTE. It is important to declare the location of the variable otherwise it will save it to the default space for your login
-- Anyone in the project can call the variable, so we will document these carefully below.

-- Note this option above doesn't work for a long list with LIKE
-- Alternative solutions below:
------------------------------------------------------
-- AES 30/08/23
-- Create a table with ICD-10 codes:
-- KM 07/09/23 edits
---- removed some F53 codes which not necessarily used for psychosis (('F530'), ('F538'), ('F539'), ('F53Z'))
---- removed F24 (F24X) as only one case and arguably not PPP
---- Added F28X, F29X based on reviewing all discharge codes for possible psychosis
---- Note that we excluded: organic psychosis, isolated auditory hallucinations, induced (all n < 5) 
DROP TABLE SAILW1515V.REF_ICD10_PSYCHOSIS;

CREATE TABLE SAILW1515V.REF_ICD10_PSYCHOSIS (
	ICD10_CODE VARCHAR(10)
	);

INSERT INTO SAILW1515V.REF_ICD10_PSYCHOSIS ( ICD10_CODE )
VALUES 
('F105'), ('F107'), 
('F115'), ('F117'),
('F125'), ('F127'),
('F135'), ('F137'),
('F145'), ('F147'),
('F155'), ('F157'),
('F165'), ('F167'),
('F175'), ('F177'),
('F185'), ('F187'),
('F195'), ('F197'),
('F200'),('F201'),('F202'),('F203'),('F204'),('F205'),('F206'),('F207'),('F208'),('F209'),('F20Z'),
('F220'), ('F228'), ('F229'),
('F230'), ('F231'),('F232'), ('F233'),('F238'),('F239'),('F23Z'),    
('F250'), ('F251'), ('F252'),('F258'), ('F28X'),('F259'), 
('F28'), ('F29'),  ('F29X'), 
('F302'), ('F312'), ('F315'), ('F323'), ('F333'),
('F531');


SELECT * FROM SAILW1515V.REF_ICD10_PSYCHOSIS 
ORDER BY ICD10_CODE ;
-- 59 ICD-10 codes , is that correct? Did I miss some codes with Z at the end?
-- KM 07/09/23 edits now give 56 final codes


------------------------------------------------------
-- AES 06/10/23
-- Cluster type of illness, either drug induced, scz like or PPP like:
DROP TABLE SAILW1515V.REF_ICD10_PSYCHOSIS_CLUSTER 

CREATE TABLE SAILW1515V.REF_ICD10_PSYCHOSIS_CLUSTER (
	DRUG_INDUCED VARCHAR(10),
	SCZ_LIKE VARCHAR(10),
	PPP_LIKE VARCHAR(10)
	);

INSERT INTO SAILW1515V.REF_ICD10_PSYCHOSIS_CLUSTER ( DRUG_INDUCED )
VALUES 
('F105'), ('F107'), 
('F115'), ('F117'),
('F125'), ('F127'),
('F135'), ('F137'),
('F145'), ('F147'),
('F155'), ('F157'),
('F165'), ('F167'),
('F175'), ('F177'),
('F185'), ('F187'),
('F195'), ('F197');

INSERT INTO SAILW1515V.REF_ICD10_PSYCHOSIS_CLUSTER ( SCZ_LIKE )
VALUES 
('F200'),('F201'),('F202'),('F203'),('F205'),('F206'),('F207'),('F208'),('F209'),('F20Z'),
('F220'), ('F228'), ('F229');

INSERT INTO SAILW1515V.REF_ICD10_PSYCHOSIS_CLUSTER ( PPP_LIKE )
VALUES 
('F230'), ('F231'),('F232'), ('F233'),('F238'),('F239'),('F23Z'),    
('F250'), ('F251'), ('F252'),('F258'), ('F28X'),('F259'), 
('F28'), ('F29'),  ('F29X'), 
('F302'), ('F312'), ('F315'), ('F323'), ('F333'),
('F531')

SELECT * FROM SAILW1515V.REF_ICD10_PSYCHOSIS_CLUSTER ;

------------------------------------------------------
-- AES 08/01/2024
-- Physical health comorbidities

DROP TABLE SAILW1515V.REF_ICD10_PHYSICAL_HEALTH; 

CREATE TABLE SAILW1515V.REF_ICD10_PHYSICAL_HEALTH ( 
	AUTOIMMUNE VARCHAR(10),
	PRE_ECLAM VARCHAR(10),
	PMS VARCHAR(10),
	PERI_MENO VARCHAR(10),
	PCOS VARCHAR(10),
	ENDOMET VARCHAR(10)
)

-- Note, I checked these codes against the last diagnosis column in PEDW,
--  had to specify all E10x values
-- MS was codes as G35X and G35Z, is that ok?
-- Specified all H20, K50, K51, K73, M05, M06, M33 values
-- There is no M459 in the table, only M45X
INSERT INTO SAILW1515V.REF_ICD10_PHYSICAL_HEALTH ( AUTOIMMUNE )
VALUES ('D510'), ('D591'), ('D693'), ('E050'), ('E063'), ('E100'),
 ('E101'), ('E102'), ('E103'), ('E104'), ('E105'), ('E106'), ('E107'), ('E108'), ('E109'), ('E10Z'),
('E271'), ('G35X'),('G35Z'), 
('G610'), 
('H200'),('H201'),('H202'),('H208'),('H209'),
('K500'),('K501'),('K508'),('K509'),
('K510'), ('K511'),('K512'),('K513'),('K514'),('K515'),('K518'),('K519'),       
('K730'),('K731'),('K732'),('K738'),('K739'),
('K743'), ('K900'), ('L10'), ('L12'), ('L400'),('L401'),
('L403'),('L405'),('L406'),('L407'),('L408'),('L409'),('L63'),
('L809'),
('M050'),('M051'),('M052'),('M054'),('M058'),('M059'),
('M060'),('M061'),('M062'),('M063'),('M064'),('M068'),('M069'),
('M080'),('M081'),('M082'),('M083'),('M084'),('M088'),('M089'),
('M313'),
('M330'),('M331'),('M332'),('M339'),
('M315'),('M316'),
('M353'),('G700'),('M34'),('M321'),('M329'),('M350'),('M45X');

INSERT INTO SAILW1515V.REF_ICD10_PHYSICAL_HEALTH ( PRE_ECLAM )
VALUES ('O13X'),('O13Z'), 
('O140'),('O141'),('O142'),('O149'),('O14Z'),
('O150'),('O151'),('O152'),('O159');

INSERT INTO SAILW1515V.REF_ICD10_PHYSICAL_HEALTH ( PMS )
VALUES ('N943');

INSERT INTO SAILW1515V.REF_ICD10_PHYSICAL_HEALTH ( PERI_MENO )
VALUES ('N951'), ('N958'), ('N059');

INSERT INTO SAILW1515V.REF_ICD10_PHYSICAL_HEALTH ( PCOS )
VALUES ('E282');

INSERT INTO SAILW1515V.REF_ICD10_PHYSICAL_HEALTH ( ENDOMET )
VALUES ('N800'), ('N801'), ('N802'), ('N803'), ('N804'), ('N805'), ('N806'), ('N808'), ('N809');

SELECT * FROM SAILW1515V.REF_ICD10_PHYSICAL_HEALTH;
