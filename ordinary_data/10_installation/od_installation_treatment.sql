/*
	qWat - QGIS Water Module
	
	SQL file :: installation treatment
*/

/* CREATE TABLE */
DROP TABLE IF EXISTS qwat_od.installation_treatment CASCADE;
CREATE TABLE qwat_od.installation_treatment (id serial PRIMARY KEY);

COMMENT ON TABLE qwat_od.installation_treatment IS 'storage treatments. These are related to installations and are made of cisterns';

/* common columns to all installations*/
ALTER TABLE qwat_od.installation_treatment ADD COLUMN name               varchar(40) default '' ;
ALTER TABLE qwat_od.installation_treatment ADD COLUMN identification     varchar(25) default '' ;
ALTER TABLE qwat_od.installation_treatment ADD COLUMN id_installation    integer                ;
ALTER TABLE qwat_od.installation_treatment ADD COLUMN id_status          integer not null       ;
ALTER TABLE qwat_od.installation_treatment ADD COLUMN id_distributor     integer not null       ;
ALTER TABLE qwat_od.installation_treatment ADD COLUMN id_remote          integer                ;
ALTER TABLE qwat_od.installation_treatment ADD COLUMN id_watertype       integer not null       ;
ALTER TABLE qwat_od.installation_treatment ADD COLUMN schema_visible     boolean not null default true ;
ALTER TABLE qwat_od.installation_treatment ADD COLUMN altitude_real      decimal(10,3)          ;
ALTER TABLE qwat_od.installation_treatment ADD COLUMN remark             text        default '' ;
ALTER TABLE qwat_od.installation_treatment ADD COLUMN year               smallint CHECK (year IS NULL OR year > 1800 AND year < 2100);
ALTER TABLE qwat_od.installation_treatment ADD COLUMN open_water_surface boolean default False  ;
ALTER TABLE qwat_od.installation_treatment ADD COLUMN parcel             varchar(30) default '' ;
ALTER TABLE qwat_od.installation_treatment ADD COLUMN eca                varchar(30) default '' ;

/* LABELS */
SELECT qwat_od.fn_label_create_fields('installation_treatment');

/* specific to treatment */
ALTER TABLE qwat_od.installation_treatment ADD COLUMN sanitization_uv               boolean      ;
ALTER TABLE qwat_od.installation_treatment ADD COLUMN sanitization_chlorine_liquid  boolean      ;
ALTER TABLE qwat_od.installation_treatment ADD COLUMN sanitization_chlorine_gazeous boolean      ;
ALTER TABLE qwat_od.installation_treatment ADD COLUMN sanitization_ozone            boolean      ;
ALTER TABLE qwat_od.installation_treatment ADD COLUMN filtration_membrane           boolean      ;
ALTER TABLE qwat_od.installation_treatment ADD COLUMN filtration_sandorgravel       boolean      ;
ALTER TABLE qwat_od.installation_treatment ADD COLUMN flocculation                  boolean      ;
ALTER TABLE qwat_od.installation_treatment ADD COLUMN activatedcharcoal             boolean      ;
ALTER TABLE qwat_od.installation_treatment ADD COLUMN settling                      boolean      ;
ALTER TABLE qwat_od.installation_treatment ADD COLUMN treatment_capacity            decimal(10,2);

/* geometry */
/*                                 ( table_name,        is_node, create_node, create_schematic, get_pipe, auto_district, auto_pressurezone)*/
SELECT qwat_od.fn_geom_tool_point('installation_treatment',true,    true,        true,            false,    true,          false);

/* Constraints */
ALTER TABLE qwat_od.installation_treatment ADD CONSTRAINT installation_treatment_id_installation FOREIGN KEY (id_installation) REFERENCES qwat_od.installation_building(id) MATCH SIMPLE; CREATE INDEX fki_installation_treatment_id_installation ON qwat_od.installation_treatment(id_installation);
ALTER TABLE qwat_od.installation_treatment ADD CONSTRAINT installation_treatment_id_status       FOREIGN KEY (id_status)       REFERENCES qwat_vl.status(id)                MATCH FULL;   CREATE INDEX fki_installation_treatment_id_status       ON qwat_od.installation_treatment(id_status)      ;
ALTER TABLE qwat_od.installation_treatment ADD CONSTRAINT installation_treatment_id_distributor  FOREIGN KEY (id_distributor)  REFERENCES qwat_od.distributor(id)           MATCH FULL;   CREATE INDEX fki_installation_treatment_id_distributor  ON qwat_od.installation_treatment(id_distributor) ;
ALTER TABLE qwat_od.installation_treatment ADD CONSTRAINT installation_treatment_id_remote       FOREIGN KEY (id_remote)       REFERENCES qwat_vl.remote_type(id)           MATCH SIMPLE; CREATE INDEX fki_installation_treatment_id_remote       ON qwat_od.installation_treatment(id_remote)      ;
ALTER TABLE qwat_od.installation_treatment ADD CONSTRAINT installation_treatment_id_watertype    FOREIGN KEY (id_watertype)    REFERENCES qwat_vl.watertype(id)             MATCH FULL;   CREATE INDEX fki_installation_treatment_watertype    ON qwat_od.installation_treatment(id_watertype)   ;

/* VIEW */
CREATE OR REPLACE VIEW qwat_od.vw_installation_treatment_fr AS
SELECT
	installation_treatment.*,
	status.value_fr AS status,
	status.active AS active,
	distributor.name AS distributor,
	remote_type.value_fr AS remote,
	watertype.value_fr AS watertype
	FROM qwat_od.installation_treatment
	INNER JOIN      qwat_vl.status          ON status.id          = installation_treatment.id_status
	INNER JOIN      qwat_od.distributor     ON distributor.id     = installation_treatment.id_distributor
	LEFT OUTER JOIN qwat_vl.remote_type     ON remote_type.id     = installation_treatment.id_remote
	INNER JOIN      qwat_vl.watertype       ON watertype.id       = installation_treatment.id_watertype;
