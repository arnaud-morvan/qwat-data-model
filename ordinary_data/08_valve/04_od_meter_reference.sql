/*
	qWat - QGIS Water Module

	SQL file :: subscriber reference
*/


DROP TABLE IF EXISTS qwat_od.meter_reference CASCADE;
CREATE TABLE qwat_od.meter_reference (id serial PRIMARY KEY);
COMMENT ON TABLE qwat_od.meter_reference IS 'Table for meter references. These are used to place references to meters if they rely far away from their pipe (i.e. on another printed map). Hence, the reference is printed on the same map than the pipe.';

ALTER TABLE qwat_od.meter_reference ADD COLUMN id_meter integer ;

/* GEOMETRY */
SELECT addGeometryColumn('qwat_od', 'meter_reference', 'geometry', 21781, 'POINT', 2);
CREATE INDEX meter_reference_geoidx_sch ON qwat_od.meter_reference USING GIST ( geometry );
			
/* CONSTRAINTS */
ALTER TABLE qwat_od.meter_reference ADD CONSTRAINT meter_reference_id_meter FOREIGN KEY (id_meter) REFERENCES qwat_od.meter (id) MATCH FULL; CREATE INDEX fki_meter_reference_id_meter ON qwat_od.meter_reference(id_meter);

