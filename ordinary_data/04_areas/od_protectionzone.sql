/*
	qWat - QGIS Water Module
	
	SQL file :: protection zone
*/



/* CREATE TABLE */
DROP TABLE IF EXISTS qwat_od.protectionzone CASCADE;
CREATE TABLE qwat_od.protectionzone (id serial, CONSTRAINT "protectionzone_pk" PRIMARY KEY (id) );
COMMENT ON TABLE qwat_od.protectionzone IS 'protectionzones.';

/* columns */
ALTER TABLE qwat_od.protectionzone ADD COLUMN id_type   integer;
ALTER TABLE qwat_od.protectionzone ADD COLUMN name      varchar(40) default '';
ALTER TABLE qwat_od.protectionzone ADD COLUMN validated boolean     default True;
ALTER TABLE qwat_od.protectionzone ADD COLUMN date      date;
ALTER TABLE qwat_od.protectionzone ADD COLUMN agent     varchar(40) default '';

/* geometry */
SELECT AddGeometryColumn('qwat_od', 'protectionzone', 'geometry', 21781, 'MULTIPOLYGON', 2);
CREATE INDEX protectionzone_geoidx ON qwat_od.protectionzone USING GIST ( geometry );

/* contraints */
ALTER TABLE qwat_od.protectionzone ADD CONSTRAINT protectionzone_name UNIQUE (name);
ALTER TABLE qwat_od.protectionzone ADD CONSTRAINT protectionzone_id_type FOREIGN KEY (id_type) REFERENCES qwat_vl.protectionzone_type (id) MATCH FULL ; CREATE INDEX fki_protectionzone_id_type ON qwat_od.protectionzone(id_type);


