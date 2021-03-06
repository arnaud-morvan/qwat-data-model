/*
	qWat - QGIS Water Module

	SQL file :: subscriber table
*/


DROP TABLE IF EXISTS qwat_od.subscriber CASCADE;
CREATE TABLE qwat_od.subscriber (id serial PRIMARY KEY);
COMMENT ON TABLE qwat_od.subscriber IS 'Table for subscriber.';



ALTER TABLE qwat_od.subscriber ADD COLUMN id_type              integer not null;
ALTER TABLE qwat_od.subscriber ADD COLUMN id_status            integer not null default 1301;
ALTER TABLE qwat_od.subscriber ADD COLUMN id_pipe              integer;
ALTER TABLE qwat_od.subscriber ADD COLUMN identification       varchar(12) default '' ;
ALTER TABLE qwat_od.subscriber ADD COLUMN _identification_full varchar(16) default '' ;
ALTER TABLE qwat_od.subscriber ADD COLUMN parcel               varchar(12) default '' ;
ALTER TABLE qwat_od.subscriber ADD COLUMN remark               text default '';

/* GEOMETRY                        (table_name,      is_node, create_node, create_schematic, get_pipe, auto_district, auto_pressurezone)*/
SELECT qwat_od.fn_geom_tool_point('subscriber', false,   false,       false,            false,    false,         true);

/* LABELS */
SELECT qwat_od.fn_label_create_fields('subscriber');

/* CONSTRAINTS */
ALTER TABLE qwat_od.subscriber ADD CONSTRAINT subscriber_id_type  FOREIGN KEY (id_type)   REFERENCES qwat_vl.subscriber_type (id) MATCH FULL  ; CREATE INDEX fki_subscriber_id_type   ON qwat_od.subscriber(id_type)        ;
ALTER TABLE qwat_od.subscriber ADD CONSTRAINT pipe_id_status      FOREIGN KEY (id_status) REFERENCES qwat_vl.status(id)           MATCH FULL  ; CREATE INDEX fki_subscriber_id_status ON qwat_od.subscriber(id_status)	  	;
ALTER TABLE qwat_od.subscriber ADD CONSTRAINT subscriber_id_pipe  FOREIGN KEY (id_pipe)   REFERENCES qwat_od.pipe (id)            MATCH SIMPLE; CREATE INDEX fki_subscriber_id_pipe   ON qwat_od.subscriber(id_pipe)        ;


/* Trigger */
CREATE OR REPLACE FUNCTION qwat_od.ft_subscriber_fullid() RETURNS trigger AS
$BODY$
	BEGIN
		 NEW._identification_full := district.prefix||'_'||NEW.identification FROM qwat_od.district WHERE district.id = NEW.id_district ;
		 RETURN NEW;
	END;
$BODY$
LANGUAGE plpgsql;
COMMENT ON FUNCTION qwat_od.ft_subscriber_fullid() IS 'Fcn/Trigger: updates the full identification (district prefix) of the client.';

CREATE TRIGGER tr_subscriber_fullid
	BEFORE INSERT OR UPDATE OF id_district,identification ON qwat_od.subscriber
	FOR EACH ROW
	EXECUTE PROCEDURE qwat_od.ft_subscriber_fullid();
COMMENT ON TRIGGER tr_subscriber_fullid ON qwat_od.subscriber IS 'Trigger: updates the full identification (district prefix) of the client.';




