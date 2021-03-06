/*
	qWat - QGIS Water Module
	
	SQL file :: print table and function
*/


/* CREATE TABLE */
DROP TABLE IF EXISTS qwat_od.printmap CASCADE;
CREATE TABLE qwat_od.printmap (id serial PRIMARY KEY);
COMMENT ON TABLE qwat_od.printmap IS 'This table is used for polygons for predefined printable maps. shortname would be used as label string, and long_mame would be used in the print composer.';

/* columns */
ALTER TABLE qwat_od.printmap ADD COLUMN name         varchar(20) default '';
ALTER TABLE qwat_od.printmap ADD COLUMN id_district  smallint;
ALTER TABLE qwat_od.printmap ADD COLUMN remark       text default '';
ALTER TABLE qwat_od.printmap ADD COLUMN version_date date;

ALTER TABLE qwat_od.printmap ADD COLUMN x_min double precision;
ALTER TABLE qwat_od.printmap ADD COLUMN y_min double precision;
ALTER TABLE qwat_od.printmap ADD COLUMN x_max double precision;
ALTER TABLE qwat_od.printmap ADD COLUMN y_max double precision;

/* geometry */
SELECT AddGeometryColumn('qwat_od', 'printmap', 'geometry', 21781, 'POLYGON', 2);
CREATE INDEX printmap_geoidx ON qwat_od.printmap USING GIST ( geometry ); 

/* LABELS */
SELECT qwat_od.fn_label_create_fields('printmap');

/* Constraints */
ALTER TABLE qwat_od.printmap ADD CONSTRAINT printmap_id_district FOREIGN KEY (id_district) REFERENCES qwat_od.district (id) MATCH SIMPLE ; CREATE INDEX fki_printmap_id_district ON qwat_od.printmap(id);
