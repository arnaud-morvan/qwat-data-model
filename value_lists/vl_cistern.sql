/*
	qWat - QGIS Water Module
	
	SQL file :: installation tank auxiliary tables
*/

/* Cistern types */
DROP TABLE IF EXISTS qwat_vl.cistern CASCADE;
CREATE TABLE qwat_vl.cistern (id integer not null, CONSTRAINT "cistern_pk" PRIMARY KEY (id) );

ALTER TABLE qwat_vl.cistern ADD COLUMN vl_active boolean default true;
ALTER TABLE qwat_vl.cistern ADD COLUMN value_en varchar(30) default '' ;
ALTER TABLE qwat_vl.cistern ADD COLUMN value_fr varchar(30) default '' ;
ALTER TABLE qwat_vl.cistern ADD COLUMN value_ro varchar(30) default '' ;

/* content */
INSERT INTO qwat_vl.cistern (id, value_en, value_fr, value_ro) VALUES (2101,'circular','circulaire','circulară');
INSERT INTO qwat_vl.cistern (id, value_en, value_fr, value_ro) VALUES (2102,'rectangular','rectangulaire','dreptunghiulară');
