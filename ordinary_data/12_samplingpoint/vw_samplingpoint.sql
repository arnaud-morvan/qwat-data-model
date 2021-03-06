/*
	qWat - QGIS Water Module
	
	SQL file :: samplingpoint view
*/

DROP VIEW IF EXISTS qwat_od.vw_samplingpoint CASCADE;
CREATE VIEW qwat_od.vw_samplingpoint AS 
	SELECT  
		samplingpoint.id             ,
		samplingpoint.identification ,
		samplingpoint.id_district    ,
		samplingpoint.id_printmap    ,
		samplingpoint.id_pressurezone,
		samplingpoint._district      ,
		samplingpoint._pressurezone  ,
		samplingpoint._printmaps     ,
		samplingpoint.remark         ,
		samplingpoint.geometry::geometry(Point,21781),
		pressurezone.colorcode     AS _pressurezone_colorcode
		FROM qwat_od.samplingpoint
		LEFT OUTER JOIN qwat_od.district      ON samplingpoint.id_district     = district.id       
		LEFT OUTER JOIN  qwat_od.pressurezone ON samplingpoint.id_pressurezone = pressurezone.id;
/*----------------!!!---!!!----------------*/
/* Comment */
COMMENT ON VIEW qwat_od.vw_samplingpoint IS 'View for samplingpoint. This view is not editable.';
