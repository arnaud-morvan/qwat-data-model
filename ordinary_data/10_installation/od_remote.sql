/*
	qWat - QGIS Water Module

	SQL file :: meter table
*/


DROP TABLE IF EXISTS qwat_od.remote CASCADE;
CREATE TABLE qwat_od.remote (id serial PRIMARY KEY);
COMMENT ON TABLE qwat_od.remote IS 'Table for installation remotes.';

/* COLUMNS */
ALTER TABLE qwat_od.remote ADD COLUMN id_distributor  integer                 ;
ALTER TABLE qwat_od.remote ADD COLUMN id_status       integer                 ;
ALTER TABLE qwat_od.remote ADD COLUMN id_precision    integer;
ALTER TABLE qwat_od.remote ADD COLUMN id_material     integer;
ALTER TABLE qwat_od.remote ADD COLUMN identification  varchar(15) default ''  ;
ALTER TABLE qwat_od.remote ADD COLUMN year smallint   CHECK (year IS NULL OR year > 1800 AND year < 2100);
ALTER TABLE qwat_od.remote ADD COLUMN origin          varchar(150) default '';
ALTER TABLE qwat_od.remote ADD COLUMN destination     varchar(150) default '';
ALTER TABLE qwat_od.remote ADD COLUMN folder          varchar(50)  default '';
ALTER TABLE qwat_od.remote ADD COLUMN plan            varchar(50) default '';
ALTER TABLE qwat_od.remote ADD COLUMN remark text     default '';

SELECT AddGeometryColumn('qwat_od', 'remote', 'geometry', 21781, 'MULTILINESTRING', 2)  ;
CREATE INDEX remote_geoidx_line ON qwat_od.remote USING GIST ( geometry );

/* LABELS */
SELECT qwat_od.fn_label_create_fields('remote');

/* CONSTRAINTS */
ALTER TABLE qwat_od.remote ADD CONSTRAINT remote_id_distributor  FOREIGN KEY (id_distributor)  REFERENCES qwat_od.distributor(id)      MATCH FULL; CREATE INDEX fki_remote_id_distributor   ON qwat_od.remote(id_distributor) ;
ALTER TABLE qwat_od.remote ADD CONSTRAINT remote_id_status       FOREIGN KEY (id_status)       REFERENCES qwat_vl.status(id)           MATCH FULL; CREATE INDEX fki_remote_id_status        ON qwat_od.remote(id_status)      ;
ALTER TABLE qwat_od.remote ADD CONSTRAINT remote_id_precision    FOREIGN KEY (id_precision)    REFERENCES qwat_vl.precision(id)        MATCH FULL; CREATE INDEX fki_remote_id_precision     ON qwat_od.remote(id_precision);
ALTER TABLE qwat_od.remote ADD CONSTRAINT remote_id_material     FOREIGN KEY (id_material)     REFERENCES qwat_vl.pipe_material(id)    MATCH FULL; CREATE INDEX fki_remote_id_material      ON qwat_od.remote(id_material);

