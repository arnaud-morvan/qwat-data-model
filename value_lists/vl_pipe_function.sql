/*
	qWat - QGIS Water Module
	
	SQL file :: pipe_function table
*/

/* CREATE */
DROP TABLE IF EXISTS qwat_vl.pipe_function CASCADE;
CREATE TABLE qwat_vl.pipe_function ( id integer not null, CONSTRAINT "pipe_function_pk" PRIMARY KEY (id) );
COMMENT ON TABLE qwat_vl.pipe_function IS 'Function for pipe. Here is determined if pipe should be visible or not in the schematic view, but this can be overidden by the pipe attribute schema_force_view.';

/* COLUMNS*/
ALTER TABLE qwat_vl.pipe_function ADD COLUMN vl_active boolean default true;
ALTER TABLE qwat_vl.pipe_function ADD COLUMN value_fr varchar(30) default '';
ALTER TABLE qwat_vl.pipe_function ADD COLUMN value_en varchar(30) default '';
ALTER TABLE qwat_vl.pipe_function ADD COLUMN value_ro varchar(30) default '';
ALTER TABLE qwat_vl.pipe_function ADD COLUMN schema_visible boolean not null default true;
ALTER TABLE qwat_vl.pipe_function ADD COLUMN code_sire smallint;

/* VALUES */
INSERT INTO qwat_vl.pipe_function (id,value_fr,value_ro,schema_visible,code_sire) VALUES (4101, 'Conduite de transport',	'Conductă de transport',	true, 2);
INSERT INTO qwat_vl.pipe_function (id,value_fr,value_ro,schema_visible,code_sire) VALUES (4102, 'Conduite d''hydrant',		'Conductă de hidrant',		true, 0);
INSERT INTO qwat_vl.pipe_function (id,value_fr,value_ro,schema_visible,code_sire) VALUES (4103, 'Conduite de vidange',		'Conductă de golire',		false, 4);
INSERT INTO qwat_vl.pipe_function (id,value_fr,value_ro,schema_visible,code_sire) VALUES (4104, 'Inconnu',			'Necunoscută',			false, 4);
INSERT INTO qwat_vl.pipe_function (id,value_fr,value_ro,schema_visible,code_sire) VALUES (4105, 'Conduite de distribution',	'Conductă de distribuţie',	true, 2);
INSERT INTO qwat_vl.pipe_function (id,value_fr,value_ro,schema_visible,code_sire) VALUES (4106, 'Branchement commun',		'Branşament comun',		false, 3);
INSERT INTO qwat_vl.pipe_function (id,value_fr,value_ro,schema_visible,code_sire) VALUES (4107, 'By-pass',			'By-pass',			false, 2);
INSERT INTO qwat_vl.pipe_function (id,value_fr,value_ro,schema_visible,code_sire) VALUES (4108, 'Branchement privé',		'Branşament privat',	       	false, 3);
INSERT INTO qwat_vl.pipe_function (id,value_fr,value_ro,schema_visible,code_sire) VALUES (4109, 'Conduite de haute pression',	'Conductă de înaltă presiune',	true , 2);
INSERT INTO qwat_vl.pipe_function (id,value_fr,value_ro,schema_visible,code_sire) VALUES (4110, 'Drain captant',		'Captare dren',             	false, 1);
INSERT INTO qwat_vl.pipe_function (id,value_fr,value_ro,schema_visible,code_sire) VALUES (4111, 'Trop plein',			'Prea plin',			true , 4);
INSERT INTO qwat_vl.pipe_function (id,value_fr,value_ro,schema_visible,code_sire) VALUES (4112, 'Ventilation',			'Aerisire', 			false, 4);



