## Event Selection Properties for Jiggle Event Catalog

The user's event selection properties filename is specified by the value of property `eventSelectionProps` and the program's default properties filename is specified by the value of property `eventSelectionDefaultProps`. 
A user's property file property value overrides any default value. 
These files are expected to be respectively found in the default and user home directories which are specified on the command line by using "-D" environmental variables.

Example for Windows:
```
-DJIGGLE_HOME="C:\Program Files\Jiggle" -DJIGGLE_USER_HOMEDIR="C:\Documents and Settings\%USERNAME%\.jiggle\scedc"
```
A properties file can be empty, but at startup the Jiggle program will notify the user if either file is missing.
Specify the minimal set of property constraints necessary for event selection because each constraint adds to the database query processing time. 
The values below labelled "default" are the values set when the property is not specified.

| Property                      | Description                                                                                         | Example value                                                       |
|-------------------------------|-----------------------------------------------------------------------------------------------------|---------------------------------------------------------------------|
| catalogMaxRows=               | maximum number of events returned, a row limit on the query.                                        | 999 (default)                                                       |
| catalogOriginEndTime=         | maximum origin time.                                                                                | 2006-01-13 21\:51\:20.000                                           |
| catalogOriginStartTime=       | minimum origin time.                                                                                | 2006-01-10 00\:00\:00.000                                           |
| catalogRelativeTimeUnits=     | Years, Months, Days, Hours, Minutes back from current time.                                         | Hours (default)                                                     |
| catalogRelativeTimeValue=     | relative time span.                                                                                 | 24 (default)                                                        |
| catalogTimeMode=              | absolute or relative origin time span.                                                              | relative (default)                                                  |
| eventAuth=                    | event authority                                                                                     | CI                                                                  |
| eventTypesExcluded=           | list of event.etype to exclude                                                                      | teleseism (default is exclude none, include all types)              |
| eventTypesIncluded=           | list of event.etype to include                                                                      | local regional quarry (default is include all types, exclude none)  |
| eventSubsource=               | event subsource                                                                                     | RT1                                                                 |
| eventValidFlag=               | Primary RT system, event.selectflag = 1)                                                            | true                                                                |
| localNetCode=                 | user's network code                                                                                 | CI                                                                  |
| magAlgo=                      | prefmag algorithm                                                                                   | SoCalML                                                             |
| magAuth=                      | prefmag authority                                                                                   | CI                                                                  |
| magDistRange=                 | prefmag closest station range km                                                                    | 0.,50.                                                              |
| magErrRange=                  | prefmag rms range                                                                                   | 0.0,1.0                                                             |
| magGapRange=                  | prefmag gap range                                                                                   | 0,90                                                                |
| magPrefNull=                  | true = load only events without a preferred magnitude                                               | false (default)                                                     |
| magPrefType=                  | prefmag magtype (l,d,w, etc.)                                                                       | l                                                                   |
| magQualityRange=              | prefmag quality range                                                                               | 0.0,1.0                                                             |
| magStaRange=                  | prefmag station count used, nsta                                                                    | 5,2000                                                              |
| magObsRange=                  | prefmag channel count used, nobs                                                                    | 5,2000                                                              |
| magSubsource=                 | prefmag subsource                                                                                   | Jiggle                                                              |
| magValueRange=                | prefmag value (magnitude) range                                                                     | 0.0,5.0                                                             |
| originAlgo=                   | prefor algorithm                                                                                    | HYP2000                                                             |
| originAmpCountRange=          | prefor associated amplitudes                                                                        | 5,2000                                                              |
| originAuth=                   | prefor auth                                                                                         | CI                                                                  |
| originDepthRange=             | prefor depth range                                                                                  | 0.0,20.0                                                            |
| originDistRange=              | prefor distance range                                                                               | 0.0,50.0                                                            |
| originDummyFlag=              | prefor bogus flag                                                                                   | false                                                               |
| originErrDepthRange=          | prefor depth error range                                                                            | 0.0,3.0                                                             |
| originErrHorizRange=          | prefor epicentral error range                                                                       | 0.0,2.0                                                             |
| originFirstMoRange=           | prefor first motions range                                                                          | 5,2000                                                              |
| originFixDepthFlag=           | prefor depth fixed                                                                                  | true                                                                |
| originFixEpiFlag=             | prefor epicenter fixed                                                                              | true                                                                |
| originGapRange=               | prefor gap range                                                                                    | 0,90                                                                |
| originPhaseCountRange=        | prefor arrival count range                                                                          | 5,2000                                                              |
| originPhaseCountUsedRange=    | prefor arrivals used range                                                                          | 5,2000                                                              |
| originProcTypesExcluded=      | processing state to exclude (default = none)                                                        |                                                                     |
| originProcTypesIncluded=      | processing state to include (default=all)                                                           | automatic human intermediate final unknown                          |
| originQualityRange=           | prefor quality range                                                                                | 0.0,1.0                                                             |
| originRmsRange=               | prefor rms range                                                                                    | 0.0,2.0                                                             |
| originSPhasesRange=           | prefor s-arrival count range                                                                        | 0,2000                                                              |
| originSubsource=              | prefor subsource name                                                                               | Jiggle                                                              |
| originType=                   | origin type (default all type)                                                                      | Jiggle                                                              |
| regionBorderPlaceName=        | prefor within polygon defined by border name in gazetteer_region table                              | Parkfield                                                           |
| regionBoxLat=                 | prefor within box with min,max lat range                                                            | -90.0,90.0                                                          |
| regionBoxLon=                 | prefor within box with min,max lon range                                                            | -180.0,180.0                                                        |
| regionExcluded=               | for regionTypes except anywhere or polylist, include only events NOT found within polygon or radius | false (default)                                                     |
| regionNameList=               | For regionType=polylist, a list of one or more active named polygon regions for filter              | xxx                                                                 |
| regionPolygon=                | prefor within bounds of polygon                                                                     | 32.,-115.,-32.2,-116,33.,-116., 33.2,-115.2                         |
| regionRadiusPlaceName=        | prefor within regionRadiusValue of name in gazetteer_pts table                                      | Coso                                                                |
| regionRadiusPoint=            | prefor within regionRadiusValue of lat and lon.                                                     | 36.0 -118.0                                                         |
| regionRadiusValue=            | prefor within radius km from regionRadiusPoint                                                      | 20.                                                                 |
| regionType=                   | region type: anywhere,border,box,place,point,polygon,polylist                                       | anywhere                                                            |
| region.xxx.includeNullMag=    | include events with no preferred magnitude(regionType=polylist mode)                               | false (default)                                                     |
| region.xxx.include=           | events in region "xxx" are accepted or reject (regionType=polylist mode)                            | -9. 999.                                                            |
| region.xxx.orgDepthRange=     | accepted depth range for named region "xxx" (regionType=polylist mode)                              | -9. 999.                                                            |
| region.xxx.magValueRange=     | accepted magnitude range for named region "xxx" (regionType=polylist mode)                          | -9. 9.                                                              |
| region.xxx.polygon=           | lat,lon pair coordinates defining a closed polygon for named region "xxx" (polylist mode)           | 35.5 -117.8 36.0 -117.8 36.0 -117.50001 35.5 -117.50001 35.5 -117.8 |
| region.default.orgDepthRange= | accepted depth range when outside of any named region (polylist mode)                               | -9. 999.                                                            |
| region.default.magValueRange= | accepted magnitude range when outside of any named polygon region (polylist mode)                   | -9. 9.                                                              |
| enableRegionCreation=         | true, enables button to save regionBorderPlaceName/regionPolygon in gazetteer_region table          | false                                                               |

## Catalog Table Column Header 

Specified below are the Jiggle catalog table column header identifier data associations. For a data column to visible in the table its identifier must be included in the list of strings specified for the value of the property catalogColumnList. Table presentation order is the same as the property value order.

| COLUMN HEADER           | DESCRIPTION                                                   |
|-------------------------|---------------------------------------------------------------|
| V                       | event.selectflag event selected for archive                   |
| B                       | origin.bogusflag prefor lat,lon are bogus                     |
| VER                     | event.version event version                                   |
| DATETIME                | origin.datetime prefor origintime                             |
| LAT                     | origin.lat prefor latitude                                    |
| LON                     | origin.lon prefor longitude                                   |
| ERR_T                   | origin.stime prefor datetime uncertainty secs                 |
| ERR_H                   | origin.erhor prefor horizontal uncertainty km                 |
| ERR_Z                   | origin.sdep prefor depth uncertainty km                       |
| Z                       | origin.depth prefor depth km                                  |
| S                       | origin.nbs prefor S arrivals used                             |
| FM                      | origin.nbfm prefor first motions                              |
| Q                       | >origin.quality prefor quality                                |
| ST                      | origin.rflag prefor processing state                          |
| ZF                      | origin.fdepth prefor depth fixed (flag = 1)                   |
| HF                      | origin.fepi prefor lat,lon fixed (flag = 1)                   |
| TF                      | origin.ftime prefor datetime fixed (flag = 1)                 |
| MMETH                   | netmag.magalgo prefmag magnitude algorithm name               |
| MAG                     | netmag.magnitude prefmag value                                |
| MTYP                    | netmag.magtype prefmag magnitude type                         |
| MSTA                    | netmag.nsta prefmag number of stations contributing           |
| MOBS                    | netmag.nobs prefmag number of channels contributing           |
| MERR                    | netmag.uncertainty, like rms error, absolute median deviation |
| "Md","Me","Ml", or "Mw" | the value of the event preferred magnitude of that magtype    |
| "Ml-Md"                 | difference of the event preferred magnitudes of those types   |
| AUTH                    | origin.auth prefmag network authority                         |
| ETYPE                   | event.etype event type e.g. le qb re ts                       |
| SRC                     | origin.subsource prefor system source of origin               |
| GAP                     | origin.gap prefor maximum azimuthal gap                       |
| DIST                    | origin.distance prefor nearest sta km                         |
| RMS                     | origin.wrms prefor error in time residual                    |
| OBS                     | origin.totalarr prefor total number of phases                 |
| AUSE                    | origin.ndef prefor number of automatic pick phases used       |
| USED                    | origin.ndef prefor number of phases used                      |
| Q                       | origin.quality prefor value 0 to 1                            |
| ST                      | origin.rflag prefor processing status A H I F                 |
| CM                      | origin.cmodelid prefor domain of vmodelid                     |
| VM                      | origin.vmodelid prefor velocity model id                      |
| PR                      | priority of EventPriorityModel algorithm                      |
| COMMENT                 | remark.remark event comment                                   |
| OWHO                    | credit.refer for prefor                                       |
| MWHO                    | credit.refer for prefmag                                      |
| WRECS                   | assocwae.wfid count of waveforms associated with evid         |
