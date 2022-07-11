# Alphabetical list of all Jiggle Properties

<b>NOTE: The table below the values labelled "default" are the values set when the property is not specified.</b><br>
<b>NOTE: xx or XX in a property name element is placeholder for a string, see the property description for details.</b><br>
<b>NOTE: to do: add magnitude props etcetera, aka make this list complete</b><br>

<table style="width: 100%;" border="1" cellpadding="2" cellspacing="2">
  <tbody>
    <tr>
      <th style="vertical-align: top; width: 20%;">Property<br> </th>
      <th style="vertical-align: top; width: 50%;">Description<br> </th>
      <th style="vertical-align: top; width: 30%;">Example value<br> </th>
    </tr>
    <tr>
      <td style="width: 20%;">EventEdit.decimalLatLon=</td>
      <td style="vertical-align: top; width: 50%;">Use decimal lat/lon instead of degrees/minutes in event editor dialog's origin tab<br></td>
      <td style="width: 30%;">true (default)</td>
    </tr>
    <tr>
      <td style="width: 20%;">EventEdit.magTabOnTop=</td>
      <td style="vertical-align: top; width: 50%;">Recalc button for magnitude opens the event editor's magnitude tab<br></td>
      <td style="width: 30%;">false (default)</td>
    </tr>
    <tr>
      <td style="width: 20%;">EventEdit.magTypeList=</td>
      <td style="vertical-align: top; width: 50%;">List of magtype subscripts available for a HAND entered magnitude in event editor dialog<br></td>
      <td style="width: 30%;">h w s e l c d b n (default)</td>
    </tr>
    <tr>
      <td style="width: 20%;">WhereIsEngine=</td>
      <td style="vertical-align: top; width: 50%;">WhereIs engine class<br></td>
      <td style="width: 30%;">org.trinet.util.gazetteer.TN.WheresFrom (default)</td>
    </tr>
    <tr>
      <td style="width: 20%;">alarmDbLinks=</td>
      <td style="vertical-align: top; width: 50%;">lists db link name strings prefixed with @ that are queried for event alarm history<br>
       If undefined, only the connected db is queried.
      </td>
      <td style="width: 30%;">@archdb @rtdb (default, undefined)</td>
    <tr>
    <tr>
      <td style="width: 20%;">ampStripDistance=</td>
      <td style="vertical-align: top; width: 50%;">Strip Picks command will delete amps whose distance &GT; value km<br></td>
      <td style="width: 30%;">1000.0 (default)</td>
    <tr>
      <td style="width: 20%;">ampStripValue=</td>
      <td style="vertical-align: top; width: 50%;">Strip Picks command will delete amps whose residual &GT; value seconds<br></td>
      <td style="width: 30%;">1.0 (default)</td>
    </tr>
    <tr>
    <tr>
      <td style="width: 20%;">antialiasWaveform=</td>
      <td style="vertical-align: top; width: 50%;">Antialias waveform graphics<br></td>
      <td style="width: 30%;">false (default)</td>
    </tr>
    <tr>
      <td style="width: 20%;">authNetCodes=</td>
      <td style="vertical-align: top; width: 50%;">List of 2-char network codes used for local vs regional event type test<br></td>
      <td style="width: 30%;">CI (for most networks same value as localNetCode property)</td>
    </tr>
    <tr>
      <td style="width: 20%;">autoDeleteOldLogs=</td>
      <td style="vertical-align: top; width: 50%;">if fileMessageLogging=true, delete log files older than maxLogAgeDays,
          without confirmation dialog, before opening new log<br></td>
      <td style="width: 30%;">false (default)</td>
    </tr>
    <tr>
      <td style="width: 20%;">autoLoadAfterDelete=</td>
      <td style="vertical-align: top; width: 50%;">Load next qualified catalog event after deleting currently viewed event by menu/toolbar,
          (e.g. catalog of consecutive subnet triggers)<br></td>
      <td style="width: 30%;">false (default)</td>
    </tr>
    <tr>
      <td style="width: 20%;">autoLoadCatalog=</td>
      <td style="vertical-align: top; width: 50%;">Automatically load event catalog at startup,<br>
          if false don't query db using event selection properties<br></td>
      <td style="width: 30%;">true (default)</td>
    </tr>
    <tr>
      <td style="width: 20%;">autoProcessing=</td>
      <td style="vertical-align: top; width: 50%;">false, to flag new event origins, magnitudes, phases, amps, coda "H" human reviewed<br></td>
      <td style="width: 30%;">false</td>
    </tr>
    <tr>
      <td style="width: 20%;">autoRecalcMD=</td>
      <td style="vertical-align: top; width: 50%;">Automatically recalc summary mag upon relocation<br></td>
      <td style="width: 30%;">true (default)</td>
    </tr>
    <tr>
      <td style="width: 20%;">autoRecalcML=</td>
      <td style="vertical-align: top; width: 50%;">Automatically recalc summary mag upon relocation<br></td>
      <td style="width: 30%;">true (default)</td>
    </tr>
    <tr>
      <td style="width: 20%;">autoRefreshChannelList=</td>
      <td style="vertical-align: top; width: 50%;">rebuild cached channel list from datasource after startup<br></td>
      <td style="width: 30%;">false (default)</td>
    </tr>
    <tr>
      <td style="width: 20%;">auxPropFile=</td>
      <td style="vertical-align: top; width: 50%;">load properties from specified file, or use auxPropFileTags, to load from multiple files<br></td>
      <td style="width: 30%;">jiggleGeneric.props</td>
    </tr>
    <tr>
      <td style="width: 20%;">auxPropFileTags=</td>
      <td style="vertical-align: top; width: 50%;">list suffix tags for "auxPropfile." property to declare additional files to load<br></td>
      <td style="width: 30%;">windowmodels (any list of name strings ok, this property is optional)</td>
    </tr>
    <tr>
      <td style="width: 20%;">auxPropFile.windowmodels=</td>
      <td style="vertical-align: top; width: 50%;">defines an additional propertyes file to load<br></td>
      <td style="width: 30%;">ctwModels.props (filenames not ending in ".props have that extension appended)</td>
    </tr>
    <tr>
      <td style="width: 20%;">cacheAbove=</td>
      <td style="vertical-align: top; width: 50%;"># of waveform above the selected one to hold in memory<br></td>
      <td style="width: 30%;">50 (default)</td>
    </tr>
    <tr>
      <td style="width: 20%;">cacheBelow=</td>
      <td style="vertical-align: top; width: 50%;"># of waveform above the selected one to hold in memory</td>
      <td style="width: 30%;">50 (default)</td>
    </tr>
    <tr>
      <td style="width: 20%;"><a href="../configuration/event-selection-prop/#catalog-table-column-header">catalogColumnList</a></td>
      <td style="vertical-align: top; width: 50%;">Names and order of columns in catalog view<br></td>
      <td style="width: 30%;">
      DATETIME LAT LON MAG MTYP MMETH Z AUTH SRC GAP DIST RMS ERR_T ERR_H ERR_Z OBS
      USED S FM Q V B ETYPE ST ZF HF TF WRECS PR COMMENT OWHO MWHO CM VM PM
      </td>
    </tr>
    <tr>
      <td style="width: 20%;">catalog.evidfile=</td>
      <td style="vertical-align: top; width: 50%;">when catalog.loadFromFile=true, event evid for the catalog query are read from this file<br></td>
      <td style="width: 30%;">catalog_evids.txt (default path JIGGLE_USER_HOMEDIR)</td>
    </tr>
    <tr>
      <td style="width: 20%;">catalog.loadFromFile=</td>
      <td style="vertical-align: top; width: 50%;">evids for the event catalog are first tokens parsed from all lines found in the user file
          specified by property "catalog.evidfile", the filename defaults to "catalog_evids.txt".<br></td>
      <td style="width: 30%;">false (default)</td>
    </tr>
    <tr>
      <td style="width: 20%;">catalog.pcsState=</td>
      <td style="vertical-align: top; width: 50%;">for catalog load by state option, the state to which events are posted in PCS_STATE table<br></td>
      <td style="width: 30%;">Jiggle (default)</td>
    </tr>
    <tr>
      <td style="width: 20%;">channelCacheFilename=</td>
      <td style="vertical-align: top; width: 50%;">Name of the channel cache file (absolute or relative to user props dir)<br></td>
      <td style="width: 30%;">channelList.cache (default)</td>
    </tr>
    <tr>
      <td style="width: 20%;">channelCopyOnlySNCL=</td>
      <td style="vertical-align: top; width: 50%;">Don't alter auth,subsource,channelsrc,channel of data<br></td>
      <td style="width: 30%;">false (default)</td>
    </tr>
    <tr>
      <td style="width: 20%;">channelDbLookUp=</td>
      <td style="vertical-align: top; width: 50%;">Lookup missing channels in database<br></td>
      <td style="width: 30%;">true (default)</td>
    </tr>
    <tr>
      <td style="width: 20%;">channelDebugDump=</td>
      <td style="vertical-align: top; width: 50%;">Channel info printed by loc,mag engines doing channel lookup<br></td>
      <td style="width: 30%;">false (default)</td>
    </tr>
    <tr>
      <td style="width: 20%;">channelGroupName=</td>
      <td style="vertical-align: top; width: 50%;"><br>Name associated with progid in AppChannels for a channel cache load from db</td>
      <td style="width: 30%;">RCG-TRINET (default)</td>
    </tr>
    <tr>
      <td style="width: 20%;">channelLabelMode=</td>
      <td style="vertical-align: top; width: 50%;">Channel name label layout on waveform panels<br></td>
      <td style="width: 30%;">0 (default, 0=start,1=leading,2=trailing,3=both,4=none)</td>
    </tr>
    <tr>
      <td style="width: 20%;">channelListAddOnlyDbFound=</td>
      <td style="vertical-align: top; width: 50%;">Add channel to cache only if found in database<br></td>
      <td style="width: 30%;">true (default)</td>
    </tr>
    <tr>
      <td style="width: 20%;">channelListCacheRead=</td>
      <td style="vertical-align: top; width: 50%;"><br>Intialize channel list from cache, not database</td>
      <td style="width: 30%;">true (default)</td>
    </tr>
    <tr>
      <td style="width: 20%;">channelListCacheWrite=</td>
      <td style="vertical-align: top; width: 50%;"><br>Write current channel list to cache on exit</td>
      <td style="width: 30%;">false (default)</td>
    </tr>
    <tr>
      <td style="width: 20%;">channelListReadOnlyLatLonZ=</td>
      <td style="vertical-align: top; width: 50%;"><br>To preserve attributes of the original observation set true</td>
      <td style="width: 30%;">false (default)</td>
    </tr>
    <tr>
      <td style="width: 20%;">channelMatchLocation=</td>
      <td style="vertical-align: top; width: 50%;">Equals test uses location attribute of SNCL<br></td>
      <td style="width: 30%;">true (default)</td>
    </tr>
    <tr>
      <td style="width: 20%;">channelMatchMode=</td>
      <td style="vertical-align: top; width: 50%;">SNCL join level in db queries:  SEEDCHAN, LOCATION, CHANNELSRC, and AUTHSUBSRC<br></td>
      <td style="width: 30%;">LOCATION (default)</td>
    </tr>
    <tr>
      <td style="width: 20%;">channelTimeWindowModelList=</td>
      <td style="vertical-align: top; width: 50%;">List of channel Time/Window models<br></td>
      <td style="width: 30%;">org.trinet.jasi.DataSourceChannelTimeModel,
                              org.trinet.jasi.PowerLawTimeWindowModel,
                              org.trinet.jasi.PicksOnlyChannelTimeModel,
                              org.trinet.jasi.SimpleChannelTimeModel (default)</td>
    </tr>
    <tr>
      <td style="width: 20%;">channelUseFullName=</td>
      <td style="vertical-align: top; width: 50%;">Print detailed channel SNCL<br></td>
      <td style="width: 30%;">false (default)</td>
    </tr>
    <tr>
      <td style="width: 20%;">clippingAmpScalar.analog</td>
      <td style="vertical-align: top; width: 50%;">For analog channel, suspect clipped if peak amp &gt; scalar*maxDigitizerCounts</td>
      <td style="width: 30%;">.8 (default)</td>
    </tr>
    <tr>
      <td style="width: 20%;">clippingAmpScalar.digital.acc</td>
      <td style="vertical-align: top; width: 50%;">For broadband acceleration, suspect clipped if peak amp &gt; scalar*maxDigitizerCounts</td>
      <td style="width: 30%;">.99 (default)</td>
    </tr>
    <tr>
      <td style="width: 20%;">clippingAmpScalar.digital.vel</td>
      <td style="vertical-align: top; width: 50%;">For broadband velocity, suspect clipped if peak amp &gt; scalar*maxDigitizerCounts</td>
      <td style="width: 30%;">.99 (default)</td>
    </tr>
    <tr>
      <td style="width: 20%;">clockQualityThreshold=</td>
      <td style="vertical-align: top; width: 50%;">Clock qualities &lt;= this value will display with a red frame<br></td>
      <td style="width: 30%;">0.50 (default)</td>
    </tr>
    <tr>
      <td style="width: 20%;">codaFlagMode=</td>
      <td style="vertical-align: top; width: 50%;">bar = 0, free = 1, fix = 2, coda fit to display on waveform panels<br></td>
      <td style="width: 30%;">0.50 (default)</td>
    </tr>
    <tr>
      <td style="width: 20%;">codaStripDistance=</td>
      <td style="vertical-align: top; width: 50%;">Strip Picks command will delete codas whose distance &GT; value km<br></td>
      <td style="width: 30%;">1000.0 (default)</td>
    <tr>
      <td style="width: 20%;">codaStripValue=</td>
      <td style="vertical-align: top; width: 50%;">Strip Picks command will delete codas whose residual &GT; value seconds<br></td>
      <td style="width: 30%;">1.0 (default)</td>
    </tr>
    <tr>
      <td style="width: 20%;">colorCatalogByType=</td>
      <td style="vertical-align: top; width: 50%;">catalog row background colored by event attribute type<br></td>
      <td style="width: 30%;">0 (default, uniform), (1= etype , 2= processing state, 3= subsource )</td>
    </tr>
    <tr>
      <td style="width: 20%;">color.catalog.etype.X</td>
      <td style="vertical-align: top; width: 50%;">where "X" is an etype string like:
          "local","quarry","regional",teleseism","sonic" ...<br></td>
      <td style="width: 30%;">ff0000 (a hex RGB color, used if colorCatalogByType = 1)</td>
    </tr>
    <tr>
      <td style="width: 20%;">color.catalog.state.X=</td>
      <td style="vertical-align: top; width: 50%;">where "X" is a processing state string:"A","H","I","F" or "C"<br></td>
      <td style="width: 30%;">ff0000 (a hex RGB color, used if colorCatalogByType = 2)</td>
    </tr>
    <tr>
      <td style="width: 20%;">color.catalog.subsrc.X=</td>
      <td style="vertical-align: top; width: 50%;">where "X" is a subsource string like: 
          "Jiggle","RT1","sedas" ...<br></td>
      <td style="width: 30%;">ff0000 (a hex RGB color, used if colorCatalogByType = 3)</td>
    </tr>
    <tr>
      <td style="width: 20%;">color.catalog.uniform</td>
      <td style="vertical-align: top; width: 50%;">row background color of a uniformly colored catalog<br></td>
      <td style="width: 30%;">ffffb2 (a hex RGB color, pale yellow)</td>
    </tr>
    <tr>
      <td style="width: 20%;">color.pick.deltim=</td>
      <td style="vertical-align: top; width: 50%;">color of deltim/residual bars on pick flag<br></td>
      <td style="width: 30%;">64006633 (default transparent green)</td>
    </tr>
    <tr>
      <td style="width: 20%;">color.pick.sightLine=</td>
      <td style="vertical-align: top; width: 50%;">color of zoom picking panel center line<br></td>
      <td style="width: 30%;">ff08080 (a hex RGB color for gray )</td>
    </tr>
    <tr>
      <td style="width: 20%;">color.pick.unused=</td>
      <td style="vertical-align: top; width: 50%;">color pick flag's interior when pick used weight=0<br></td>
      <td style="width: 30%;"> fff6cece (a hex RGB color for grayed pink)</td>
    </tr>
    <tr>
      <td style="width: 20%;">color.readings.cell.bg=</td>
      <td style="vertical-align: top; width: 50%;"><br>Data observation background</td>
      <td style="width: 30%;">ffffff (a hex RGB color)</td>
    </tr>
    <tr>
      <td style="width: 20%;">color.readings.cell.bg.selected=</td>
      <td style="vertical-align: top; width: 50%;"><br>Data observation selected background</td>
      <td style="width: 30%;">f0f0f0 (a hex RGB color)</td>
    </tr>
    <tr>
      <td style="width: 20%;">color.readings.cell.border=</td>
      <td style="vertical-align: top; width: 50%;"><br>Selected observation border color</td>
      <td style="width: 30%;">0000ff (a hex RGB color)</td>
    </tr>
    <tr>
      <td style="width: 20%;">color.readings.cell.good=</td>
      <td style="vertical-align: top; width: 50%;"><br>Text color for ok data</td>
      <td style="width: 30%;">000000 (a hex RGB color)</td>
    </tr>
    <tr>
      <td style="width: 20%;">color.readings.cell.outlier=</td>
      <td style="vertical-align: top; width: 50%;"><br>Text color for extreme error, outlier</td>
      <td style="width: 30%;">ff0000 (a hex RGB color)</td>
    </tr>
    <tr>
      <td style="width: 20%;">color.readings.cell.notUsed=</td>
      <td style="vertical-align: top; width: 50%;"><br>Text color for unused data</td>
      <td style="width: 30%;">0000ff (a hex RGB color)</td>
    </tr>
    <tr>
      <td style="width: 20%;">color.readings.cell.warn=</td>
      <td style="vertical-align: top; width: 50%;"><br>Text color for large error data</td>
      <td style="width: 30%;">ff9600 (a hex RGB color)</td>
    </tr>
    <tr>
      <td style="width: 20%;">color.readings.list.bg=</td>
      <td style="vertical-align: top; width: 50%;"><br>Data list pane background color</td>
      <td style="width: 30%;">c0c0c0 (a hex RGB color)</td>
    </tr>
    <tr>
      <td style="width: 20%;">color.readings.summary.bg=</td>
      <td style="vertical-align: top; width: 50%;"><br>Data list summary header background color</td>
      <td style="width: 30%;">ffff00 (a hex RGB color)</td>
    </tr>
    <tr>
      <td style="width: 20%;">color.readings.summary.fg=</td>
      <td style="vertical-align: top; width: 50%;"><br>Data list summary header text color</td>
      <td style="width: 30%;">000000 (a hex RGB color)</td>
    </tr>
    <tr>
      <td style="width: 20%;">color.seedchan.XX.panel=</td>
      <td style="vertical-align: top; width: 50%;">where "XX" is first 2 letters of seedchan code<br></td>
      <td style="width: 30%;">ffffffff (a hex RGB color for waveform panel, background)</td>
    </tr>
    <tr>
      <td style="width: 20%;">color.seedchan.XX.wave=</td>
      <td style="vertical-align: top; width: 50%;">where "XX" is first 2 letters of seedchan code<br></td>
      <td style="width: 30%;">ffff0000 (a hex RGB color for waveform trace, foreground)</td>
    </tr>
    <tr>
      <td style="width: 20%;">color.solution.XX=</td>
      <td style="vertical-align: top; width: 50%;">where "XX" is number sequence starting with "00" (leading zero for &LT; 10)<br></td>
      <td style="width: 30%;">ff00ff00 (a hex RGB color for the XXth solution created in the view)</td>
    </tr>
    <tr>
      <td style="width: 20%;">color.tab.text.bg=</td>
      <td style="vertical-align: top; width: 50%;"><br>Message tab pane background color</td>
      <td style="width: 30%;">ffffff (a hex RGB color)</td>
    </tr>
    <tr>
      <td style="width: 20%;">color.tab.text.fg=</td>
      <td style="vertical-align: top; width: 50%;"><br>Text color in message tab pane area</td>
      <td style="width: 30%;">000000 (a hex RGB color)</td>
    </tr>
    <tr>
      <td style="width: 20%;">color.tab.text.selection.bg=</td>
      <td style="vertical-align: top; width: 50%;"><br>Message tab pane selection background color</td>
      <td style="width: 30%;">ffff00 (a hex RGB color)</td>
    </tr>
    <tr>
      <td style="width: 20%;">color.tab.text.selection.fg=</td>
      <td style="vertical-align: top; width: 50%;"><br>Text color in message tab pane selection</td>
      <td style="width: 30%;">ff0000 (a hex RGB color)</td>
    </tr>
    <tr>
       <td style="width: 20%;">color.wfpanel.default.selected=</td>
       <td style="vertical-align: top; width: 50%;">default selected waveform panel color<br></td>
      <td style="width: 30%;">ff00d1d1 (a hex RGB color, default Color.skyBlue)</td>
    </tr>
    <tr>
       <td style="width: 20%;">color.wfpanel.default.highlight=</td>
       <td style="vertical-align: top; width: 50%;">default panel selection box color<br></td>
      <td style="width: 30%;">ffebeb00 (a hex RGB color, default Color.yellow)</td>
    </tr>
    <tr>
       <td style="width: 20%;">color.wfpanel.default.drag=</td>
       <td style="vertical-align: top; width: 50%;">default panel drag box color<br></td>
      <td style="width: 30%;">ffffc800 (a hex RGB color, default Color.orange)</td>
    </tr>
    <tr>
       <td style="width: 20%;">color.wfpanel.default.segment=</td>
       <td style="vertical-align: top; width: 50%;">default panel segment line color<br></td>
      <td style="width: 30%;">ff00ffff (a hex RGB color, default Color.cyan)</td>
    </tr>
    <tr>
       <td style="width: 20%;">color.wfpanel.default.cue=</td>
       <td style="vertical-align: top; width: 50%;">default panel phase cue color<br></td>
      <td style="width: 30%;">ffafffaf (a hex RGB color, default Color.mint)</td>
    </tr>
    <tr>
       <td style="width: 20%;">color.wfpanel.default.bg=</td>
       <td style="vertical-align: top; width: 50%;">default background of unknown seedchan type<br></td>
      <td style="width: 30%;">ffc0c0c0 (a hex RGB color, default Color.white)</td>
    </tr>
    <tr>
      <td style="width: 20%;">color.wfpanel.default.fg=</td>
      <td style="vertical-align: top; width: 50%;">default trace color of unknown seedchan type<br></td>
      <td style="width: 30%;">ff66ff33 (a hex RGB color, default Color.darkGray)</td>
    </tr>
    <tr>
      <td style="width: 20%;">comment.earthquake.regional</td>
      <td style="vertical-align: top; width: 50%;">- Default comment used in <b>Event > Set Event Type > Earthquake - Regional</b> dialog<br>
        - Value can be set from Preference dialog's Misc tab
      </td>
      <td style="width: 30%;"> blank/empty string (default)</td>
    </tr>
    <tr>
      <td style="width: 20%;">confirmFinalOnSave=</td>
      <td style="vertical-align: top; width: 50%;">Confirm by popup whether to preserve F or set I state flag on save<br></td>
      <td style="width: 30%;">false (default)</td>
    </tr>
    <tr>
      <td style="width: 20%;">confirmLocationOnSave=</td>
      <td style="vertical-align: top; width: 50%;">Confirm by popup to save an event without a valid lat,lon<br></td>
      <td style="width: 30%;">true (default)</td>
    </tr>
    <tr>
      <td style="width: 20%;">confirmMenuDeleteAction=</td>
      <td style="vertical-align: top; width: 50%;">Confirm by popup when deleting or stripping readings<br></td>
      <td style="width: 30%;">true (default)</td>
    </tr>
    <tr>
      <td style="width: 20%;">confirmNewSolutionAction=</td>
      <td style="vertical-align: top; width: 50%;">Confirm by popup when creating new solution<br></td>
      <td style="width: 30%;">false (default)</td>
    </tr>
    <tr>
      <td style="width: 20%;">confirmWFPanelDeleteAction=</td>
      <td style="vertical-align: top; width: 50%;">Confirm by popup when deleting or stripping readings<br></td>
      <td style="width: 30%;">true (default)</td>
    </tr>
    <tr>
      <td style="width: 20%;">confirmWFScanForMag=</td>
      <td style="vertical-align: top; width: 50%;">Confirm by popup before doing waveform scan to replace existing mangitude amp/coda readings<br></td>
      <td style="width: 30%;">false (default)</td>
    </tr>
    <tr>
      <td style="width: 20%;">currentChannelTimeWindowModel=</td>
      <td style="vertical-align: top; width: 50%;">Channel Time/Window model currently in use<br></td>
      <td style="width: 30%;">org.trinet.jasi.DataSourceChannelTimeModel (default)</td>
    </tr>
    <tr>
      <td style="width: 20%;">currentWaveServerGroup=</td>
      <td style="vertical-align: top; width: 50%;">Wave server group currently in use <br></td>
      <td style="width: 30%;">rts (default is none)</td>
    </tr>
    <tr>
      <td style="width: 20%;">dbAttributionEnabled=</td>
      <td style="vertical-align: top; width: 50%;">Map new event,origin,netmag rowids to their creator<br></td>
      <td style="width: 30%;">false (default)</td>
    </tr>
    <tr>
      <td style="width: 20%;">dbLastLoginURL=</td>
      <td style="vertical-align: top; width: 50%;">URL of last datasource connection<br></td>
      <td style="width: 30%;">jdbc\:oracle\:thin\:@makalu.gps.caltech.edu\:1521\:makaludb</td>
    </tr>
    <tr>
        <td style="width: 20%;">dbTimeBase=</td>
        <td style="vertical-align: top; width: 50%;">NOMINAL or LEAP secs stored for datetime<br></td>
        <td style="width: 30%;">NOMINAL (default)</td>
    </tr>
    <tr>
      <td style="width: 20%;">dbTrace=</td>
      <td style="vertical-align: top; width: 50%;">Turn on server side tracing of executed SQL<br></td>
      <td style="width: 30%;">false (default)</td>
    </tr>
    <tr>
      <td style="width: 20%;">dbWriteBackEnabled=</td>
      <td style="vertical-align: top; width: 50%;">Allows modification of database via SQL<br></td>
      <td style="width: 30%;">true (default)</td>
    </tr>
    <tr>
      <td style="width: 20%;">dbaseDomain=</td>
      <td style="vertical-align: top; width: 50%;">Data source domain<br></td>
      <td style="width: 30%;">gps.caltech.edu (default)</td>
    </tr>
    <tr>
      <td style="width: 20%;">dbaseDriver=</td>
      <td style="vertical-align: top; width: 50%;">Data source driver<br> </td>
      <td style="width: 30%;">oracle.jdbc.driver.OracleDriver (default)</td>
    </tr>
    <tr>
      <td style="width: 20%;">dbaseEncrypted=</td>
      <td style="vertical-align: top; width: 50%;">dbaseUser and dbasePasswd values are encrypted strings<br></td>
      <td style="width: 30%;">false (default)</td>
    </tr>
    <tr>
      <td style="width: 20%;">dbaseHost=</td>
      <td style="vertical-align: top; width: 50%;">Data source host name<br></td>
      <td style="width: 30%;">mud (default)</td>
    </tr>
    <tr>
      <td style="width: 20%;">dbaseName=</td>
      <td style="vertical-align: top; width: 50%;">Data source database name<br></td>
      <td style="width: 30%;">muddb (default)</td>
    </tr>
    <tr>
      <td style="width: 20%;">dbasePasswd=</td>
      <td style="vertical-align: top; width: 50%;">Data source database user password<br></td>
      <td style="width: 30%;">unknown (default)</td>
    </tr>
    <tr>
      <td style="width: 20%;">dbasePort=</td>
      <td style="vertical-align: top; width: 50%;">Data source port #<br></td>
      <td style="width: 30%;">1521 (default)</td>
    </tr>
    <tr>
      <td style="width: 20%;">dbaseSubprotocol=</td>
      <td style="vertical-align: top; width: 50%;">jdbc subprotocol type, 
          using jdbc:oci subprotocol with dbaseTNSname alias requires an Oracle client installation on client.
          &nbsp;<a href="http://www.oracle.com/technology/tech/oci/instantclient/index.html">See Oracle Instant Client instructions</a>
          </td>
      <td style="width: 30%;">oracle:thin (default) </td>
    </tr>
    <tr>
      <td style="width: 20%;">dbaseTNSname=</td>
      <td style="vertical-align: top; width: 50%;">Oracle TNS name connection alias to use with oracle:oci subprotocol, else blank<br></td>
      <td style="width: 30%;">(blank default)</td>
    </tr>
    <tr>
      <td style="width: 20%;">dbaseUser=</td>
      <td style="vertical-align: top; width: 50%;">Data source database username<br></td>
      <td style="width: 30%;">browser (default)</td>
    </tr>
    <tr>
      <td style="width: 20%;">debug=</td>
      <td style="vertical-align: top; width: 50%;">Debug mode on/off<br></td>
      <td style="width: 30%;">false (default)</td>
    </tr>
    <tr>
      <td style="width: 20%;">debugCommit=</td>
      <td style="vertical-align: top; width: 50%;">Debug print of SQL text and messages about commit processing of event data<br></td>
      <td style="width: 30%;">false (default)</td>
    </tr>
    <tr>
      <td style="width: 20%;">debugSQL=</td>
      <td style="vertical-align: top; width: 50%;">Debug print of SQL statement text<br></td>
      <td style="width: 30%;">false (default)</td>
    </tr>
    <tr>
      <td style="width: 20%;">defaultPreferencesMagMethodType=</td>
      <td style="vertical-align: top; width: 50%;">In preferences popup dialog, magnitude tab load setting for this magnitude type<br></td>
      <td style="width: 30%;">ml (default)</td>
    </tr>
    <tr>
      <td style="width: 20%;">defaultTriggerEventType=</td>
      <td style="vertical-align: top; width: 50%;">Event type to assign to a "trigger" after locating<br></td>
      <td style="width: 30%;">earthquake (default)</td>
    </tr>
    <tr>
      <td style="width: 20%;">defaultWfGroupFilter=</td>
      <td style="vertical-align: top; width: 50%;">When showFilteredWfGroup=true, filter type applied to wfpanel traces in group panel when event is loaded into view.</td>
      <td style="width: 30%;">BANDPASS (default)</td>
    </tr>
    <tr>
      <td style="width: 20%;">defaultWfType=</td>
      <td style="vertical-align: top; width: 50%;">Multi (1) or Single (0) waveform table row format<br></td>
      <td style="width: 30%;">1 (default)</td>
    </tr>
    <tr>
        <td style="width: 20%;">defaultZoomFilterType</td>
      <td style="vertical-align: top; width: 50%;">default waveform filter used in zoom picking panel (see defaultZoomFilterAlways and displayFilteredSeedchan properties)</td>
      <td style="width: 30%;">HIGHPASS (default)</td>
    </tr>
    <tr>
        <td style="width: 20%;">defaultZoomFilterAlway</td>
      <td style="vertical-align: top; width: 50%;">Set filter in zoom picking panel to the default type whenever channel listed by displayFilteredSeedchan property is selected into view</td>
      <td style="width: 30%;">false (default)</td>
    </tr>
    <tr>
      <td style="width: 20%;">delegateDebug=</td>
      <td style="vertical-align: top; width: 50%;">Enables debug output from location/magnitude engines<br></td>
      <td style="width: 30%;">false (default)</td>
    </tr>
    <tr>
      <td style="width: 20%;">delegateLoadArrivalsFromDb=</td>
      <td style="vertical-align: top; width: 50%;">Location engine loads readings from db if list is empty<br></td>
      <td style="width: 30%;">false (default)</td>
    </tr>
    <tr>
      <td style="width: 20%;">delegateLoadMagReadingsFromDb=</td>
      <td style="vertical-align: top; width: 50%;">Magnitude engine loads readings from db if list is empty<br></td>
      <td style="width: 30%;">true (default)</td>
    </tr>
    <tr>
      <td style="width: 20%;">disableQuarryCheck=</td>
      <td style="vertical-align: top; width: 50%;">Disable check/popup for closest quarry location when user changes event type to quarry<br></td>
      <td style="width: 30%;">false (default)</td>
    </tr>
    <tr>
      <td style="width: 20%;">displayFilteredSeedchan=</td>
      <td style="vertical-align: top; width: 50%;">list of seedchan for which the default filter type is toggled "on" in zoom picking panel whenever a channel of that type is selected for loading<br></td>
      <td style="width: 30%;">HHZ HHE HHN BHZ BHE BHN (default is no list)</td>
    </tr>
    <tr>
      <td style="width: 20%;">duplicateCheckDisabled=</td>
      <td style="vertical-align: top; width: 50%;">If true, disables check done for catalog duplicates in db on commit<br></td>
      <td style="width: 30%;">false (default)</td>
    </tr>
    <tr>
      <td style="width: 20%;">editableMagTypes=</td>
      <td style="vertical-align: top; width: 50%;">User can edit the contents of magtype magnitude's list of channel readings<br></td>
      <td style="width: 30%;">Ml Md (default)</td>
    </tr>
    <tr>
      <td style="width: 20%;">enableSwarm=</td>
      <td style="vertical-align: top; width: 50%;">Enable used of Swarm (AVO) interface code to display selected waveforms<br></td>
      <td style="width: 30%;">false (default)</td>
    </tr>
    <tr>
      <td style="width: 20%;">eventTypeCheckDisabled=</td>
      <td style="vertical-align: top; width: 50%;">If true, disable event type checking for quarries on commit<br></td>
      <td style="width: 30%;">false (default)</td>
    </tr>
    <tr>
      <td style="width: 20%;">eventTypeChoices=</td>
      <td style="vertical-align: top; width: 50%;">Event types shown in order from top of etype selection menu in toolbar<br></td>
      <td style="width: 30%;">le re ts qb ex sn ot uk (default)</td>
    </tr>
    <tr>
      <td style="width: 20%;">eventSelectionDefaultProps=</td>
      <td style="vertical-align: top; width: 50%;">Name of event filter properties file in Jiggle jar directory<br></td>
      <td style="width: 30%;">eventSelectionDefault.props (optional, instead of "eventSelectionProps")</td>
    </tr>
    <tr>
      <td style="width: 20%;">eventSelectionProps=</td>
      <td style="vertical-align: top; width: 50%;">User's event filter properties file in user's home directory<br></td>
      <td style="width: 30%;">eventSelection.props</td>
    </tr>
    <tr>
      <td style="width: 20%;">fileChooserDir=</td>
      <td style="vertical-align: top; width: 50%;">File chooser default directory<br></td>
      <td style="width: 30%;">. (default)</td>
    </tr>
    <tr>
      <td style="width: 20%;">fileMessageLogging=</td>
      <td style="vertical-align: top; width: 50%;">Output text to log file in subdirectory below user's home<br></td>
      <td style="width: 30%;">false (default)</td>
    </tr>
    <tr>
      <td style="width: 20%;">firstMoOnHoriz=</td>
      <td style="vertical-align: top; width: 50%;">Calculate 1st motions for horizontal channels<br></td>
      <td style="width: 30%;">false (default)</td>
    </tr>
    <tr>
      <td style="width: 20%;">firstMoOnS=</td>
      <td style="vertical-align: top; width: 50%;">Calculate 1st motions on S-waves<br></td>
      <td style="width: 30%;">false (default)</td>
    </tr>
    <tr>
      <td style="width: 20%;">firstMoQualityMin=</td>
      <td style="vertical-align: top; width: 50%;">Auto calculate 1st motion only if pick quality &gt;= this value<br></td>
      <td style="width: 30%;">0.5 (default)</td>
    </tr>
    <tr>
      <td style="width: 20%;">fixQuarryDepth=</td>
      <td style="vertical-align: top; width: 50%;">Use quarryFixDepth property value, else quarry depth fixed at 0. km<br></td>
      <td style="width: 30%;">true (default)</td>
    </tr>
    <tr>
      <td style="width: 20%;">focmec.URL.filename=</td>
      <td style="vertical-align: top; width: 50%;">regex to use to create focal mechanism image filename found at URL folderr<br></td>
      <td style="width: 30%;">ci%d.cifm%d.jpg (where %d is event evid, and second %d is a focal mec#, should =1, if only one exists</td>
    </tr>
    <tr>
      <td style="width: 20%;">focmec.URL.path=</td>
      <td style="vertical-align: top; width: 50%;">URL path to directory folder containing the focal mechanisn image files<br></td>
      <td style="width: 30%;">http\://rift.gps.caltech.edu/focmec/fmar/</td>
    </tr>
    <tr>
      <td style="width: 20%;">group.horz.blockScrollFactor=</td>
      <td style="vertical-align: top; width: 50%;">Scroll fraction of group panel viewport width<br></td>
      <td style="width: 30%;">0.10 (default)</td>
    </tr>
    <tr>
      <td style="width: 20%;">group.horz.unitScrollPixels=</td>
      <td style="vertical-align: top; width: 50%;">Pixels scrolled by click of group panel's horiz scrollbar arrow button<br></td>
      <td style="width: 30%;">5 (default)</td>
    </tr>
    <tr>
      <td style="width: 20%;">groupPanelFilterButtonLocation=</td>
      <td style="vertical-align: top; width: 50%;"><br>location of the button that activates the popup menu of the group waveform panel</td>
      <td style="width: 30%;">botton (default, for lower-right, else =top, for upper-right)</td>
    </tr>
    <tr>
      <td style="width: 20%;">helpFile=</td>
      <td style="vertical-align: top; width: 50%;">Location of help file give URL or local file<br></td>
      <td style="width: 30%;">http\://pasadena.wr.usgs.gov/jiggle/JiggleProperties.html<br></td>
    </tr>
    <tr>
      <td style="width: 20%;">hypoinvCmdFile.default=</td>
      <td style="vertical-align: top; width: 50%;">Name of the default hypoinverse command file on solserver<br></td>
      <td style="width: 30%;">hypinst. (default)</td>
    </tr>
    <tr>
      <td style="width: 20%;">hypoinvCmdFileEditing=</td>
      <td style="vertical-align: top; width: 50%;">Enable editing of custom hypoinverse command files on solserver<br></td>
      <td style="width: 30%;">false (default)</td>
    </tr>
    <tr>
      <td style="width: 20%;">hypoinvWgt2DeltaTime</td>
      <td style="vertical-align: top; width: 50%;">
          max seconds values mapped to hypoinv weight values 0,1,2,3, and 4<br>
          corresponding to pick uncertainty, arrival.deltim<br>
      </td>
      <td style="width: 30%;">0.02 0.05 0.10 0.20 0.40</td>
    </tr>
    <tr>
      <td style="width: 20%;">iconDir=</td>
      <td style="vertical-align: top; width: 50%;">Location of icon images (relative to jar classpath root)<br></td>
      <td style="width: 30%;">images (default)</td>
    </tr>
    <tr>
      <td style="width: 20%;">jasiUserName=</td>
      <td style="vertical-align: top; width: 50%;">alias to use for attribution reference in Credit table<br></td>
      <td style="width: 30%;">abc</td>
    </tr>
    <tr>
      <td style="width: 20%;">jasiObjectType=</td>
      <td style="vertical-align: top; width: 50%;">Base type of concrete data classes (TRINET, EARTHWORM)<br></td>
      <td style="width: 30%;">TRINET (default)</td>
    </tr>
    <tr>
      <td style="width: 20%;">labelToolBarButtons=</td>
      <td style="vertical-align: top; width: 50%;">Base type of concrete data classes (TRINET, EARTHWORM)<br></td>
      <td style="width: 30%;">false (default)</td>
    </tr>
    <tr>
      <td style="width: 20%;">listMatchMode=</td>
      <td style="vertical-align: top; width: 50%;">Find objects in lists by EQUIVALENT or same ID test<br></td>
      <td style="width: 30%;">EQUIVALENT (default)</td>
    </tr>
    <tr>
      <td style="width: 20%;">localNetCode=</td>
      <td style="vertical-align: top; width: 50%;">Default Net code (default is EnvironmentInfo.class setting)<br></td>
      <td style="width: 30%;">CI</td>
    </tr>
    <tr>
      <td style="width: 20%;">locationCodeSpace2Dash=</td>
      <td style="vertical-align: top; width: 50%;">replace all " " with "-" in location code strings exchanged with solution server.<br></td>
      <td style="width: 30%;">false (default, preserve spaces))</td>
    </tr>
    <tr>
      <td style="width: 20%;">locationEngine=</td>
      <td style="vertical-align: top; width: 50%;">Location engine class<br></td>
      <td style="width: 30%;">org.trinet.util.locationengines.LocationEngineHypoInverse (default)</td>
    </tr>
    <tr>
      <td style="width: 20%;">locationEngineAddress=</td>
      <td style="vertical-align: top; width: 50%;">Location engine URL<br></td>
      <td style="width: 30%;">bogus.gps.caltech.edu (default)</td>
    </tr>
    <tr>
      <td style="width: 20%;">locationEnginePRT=</td>
      <td style="vertical-align: top; width: 50%;">After locating dump HYP2000 PRT style output text to message tabpane<br></td>
      <td style="width: 30%;">true (default)</td>
    </tr>
    <tr>
      <td style="width: 20%;">locationEnginePort=</td>
      <td style="vertical-align: top; width: 50%;">Location engine port #<br></td>
      <td style="width: 30%;">6650 (default)</td>
    </tr>
    <tr>
      <td style="width: 20%;">locationEngineTimeoutMillis=</td>
      <td style="vertical-align: top; width: 50%;">Location engine timeout (milliseconds)<br></td>
      <td style="width: 30%;">5000 (default)</td>
    </tr>
    <tr>
      <td style="width: 20%;">locationEngineType=</td>
      <td style="vertical-align: top; width: 50%;">Location engine type<br></td>
      <td style="width: 30%;">HYPO2000 (default)</td>
    </tr>
    <tr>
      <td style="width: 20%;">locationServerSelected=</td>
      <td style="vertical-align: top; width: 50%;">Name of selected location server in the server group list<br></td>
      <td style="width: 30%;">std</td>
    </tr>
    <tr>
      <td style="width: 20%;">locationServerGroupList=</td>
      <td style="vertical-align: top; width: 50%;">
          List of location server configurations <br>
          format /name+type+timeout+ipaddress:port
          ("\" at EOL continues property string value to next line)
      </td>
      <td style="width: 30%;">
          /std1+HYP2000+20000+loc1.cit.edu\:6501\<br>
          /std2+HYP2000+20000+loc2.cit.edu\:6502
      (default is named default with specified locationEngine properties)
      </td>
    </tr>
    <tr>
      <td style="width: 20%;">magDataLoadClearsSolution=</td>
      <td style="vertical-align: top; width: 50%;">Delete mag reading from Solution before loading from db<br></td>
      <td style="width: 30%;">true (default)</td>
    </tr>
    <tr>
      <td style="width: 20%;">magDataLoadClonesReadings=</td>
      <td style="vertical-align: top; width: 50%;">Clone readings for each new magnitude<br></td>
      <td style="width: 30%;">false (default)</td>
    </tr>
    <tr>
      <td style="width: 20%;">magDataLoadOption=</td>
      <td style="vertical-align: top; width: 50%;">Order to lookup associated data in db: input mag, preferred mag, solution<br></td>
      <td style="width: 30%;">mps (default = m)</td>
    </tr>
    <tr>
      <td style="width: 20%;">magEngine=</td>
      <td style="vertical-align: top; width: 50%;">Magnitude engine type<br></td>
      <td style="width: 30%;">org.trinet.jasi.engines.TN.MagnitudeEngineTN</td>
    </tr>
    <tr>
      <td style="width: 20%;">magStaleCommitNoop=</td>
      <td style="vertical-align: top; width: 50%;">true and stale preserves existing prefmag; false and stale writes new magid<br></td>
      <td style="width: 30%;">false (default)</td>
    </tr>
    <tr>
      <td style="width: 20%;">magStaleCommitOk=</td>
      <td style="vertical-align: top; width: 50%;">true and stale writes; false and stale aborts<br></td>
      <td style="width: 30%;">true (default)</td>
    </tr>
    <tr>
      <td style="width: 20%;">mainSplitOrientation=</td>
      <td style="vertical-align: top; width: 50%;">Split the main window; 1 = vertical, 0 = horizontal<br></td>
      <td style="width: 30%;">0 (default)</td>
    </tr>
    <tr>
      <td style="width: 20%;">mainframeHeight=</td>
      <td style="vertical-align: top; width: 50%;">Height of main window (pixels)<br></td>
      <td style="width: 30%;">480 (default)</td>
    </tr>
    <tr>
      <td style="width: 20%;">mainframeWidth=</td>
      <td style="vertical-align: top; width: 50%;">Width of main window (pixels)<br></td>
      <td style="width: 30%;">640 (default)</td>
    </tr>
    <tr>
      <td style="width: 20%;">mainframeX=</td>
      <td style="vertical-align: top; width: 50%;">X-location of main window on screen<br></td>
      <td style="width: 30%;">1 (default)</td>
    </tr>
    <tr>
      <td style="width: 20%;">mainframeY=</td>
      <td style="vertical-align: top; width: 50%;">Y-location of window on screen<br></td>
      <td style="width: 30%;">1 (default)</td>
    </tr>
    <tr>
      <td style="width: 20%;">mapInSplit=</td>
      <td style="vertical-align: top; width: 50%;">true, map panel in catalog tab split; false, stand alone frame<br></td>
      <td style="width: 30%;">true (default)</td>
    </tr>
    <tr>
      <td style="width: 20%;">mapPropFilename=</td>
      <td style="vertical-align: top; width: 50%;">User's directory file containing map configuration properties<br></td>
      <td style="width: 30%;">openmap.properties (default)</td>
    </tr>
    <tr>
      <td style="width: 20%;">mapSplitOrientation=</td>
      <td style="vertical-align: top; width: 50%;">Split the catalog/map window; 0 = vertical, 1 = horizontal<br></td>
      <td style="width: 30%;">0 (default)</td>
    </tr>
    <tr>
      <td style="width: 20%;">masterViewLoadPeakGroundAmps=</td>
      <td style="vertical-align: top; width: 50%;">if true, load and display origin associated PGA,PGV,PGD amps<br></td>
      <td style="width: 30%;">false (default)</td>
    </tr>
    <tr>
      <td style="width: 20%;">masterViewLoadSpectralAmps=</td>
      <td style="vertical-align: top; width: 50%;">if true, load and display origin associated SP.3,SP1.0,SP3.0 amps<br></td>
      <td style="width: 30%;">false (default)</td>
    </tr>
    <tr>
      <td style="width: 20%;">masterViewReplacePhasesByStaType=</td>
      <td style="vertical-align: top; width: 50%;">if true, allow only one Phase of a type per channel<br></td>
      <td style="width: 30%;">false (default)</td>
    </tr>
    <tr>
      <td style="width: 20%;">masterViewRetreiveAmps=</td>
      <td style="vertical-align: top; width: 50%;">if true, load and display magnitude associated amps<br></td>
      <td style="width: 30%;">true (default)</td>
    </tr>
    <tr>
      <td style="width: 20%;">masterViewRetreiveCodas=</td>
      <td style="vertical-align: top; width: 50%;">if true, load and display magnitude associated codas<br></td>
      <td style="width: 30%;">true (default)</td>
    </tr>
    <tr>
      <td style="width: 20%;">masterViewRetreivePhases=</td>
      <td style="vertical-align: top; width: 50%;">if true, load and display origin associated phases<br></td>
      <td style="width: 30%;">true (default)</td>
    </tr>
    <tr>
      <td style="width: 20%;">masterViewWaveformAlignMode=</td>
      <td style="vertical-align: top; width: 50%;">0=absolute time, 1=p-traveltime, 2=s-traveltime, 3=reduction velocity<br></td>
      <td style="width: 30%;">0 (default)</td>
    </tr>
    <tr>
      <td style="width: 20%;">masterViewWaveformAlignVel=</td>
      <td style="vertical-align: top; width: 50%;">if masterViewAlignMode=3 the reduction velocity<br></td>
      <td style="width: 30%;">6. (default)</td>
    </tr>
    <tr>
      <td style="width: 20%;">maxLogAgeDays=</td>
      <td style="vertical-align: top; width: 50%;">if fileMessageLogging=true, log files older than max days are eligible for deletion<br>
          if autoDeleteOldLogs=false, confirm dialog prompts for each file deletion.
      </td>
      <td style="width: 30%;">14 (default)</td>
    </tr>
    <tr>
      <td style="width: 20%;">maxWaveletCount=</td>
      <td style="vertical-align: top; width: 50%;">Maximum number of waveforms rows returned per channel<br></td>
      <td style="width: 30%;">200 (default)</td>
    </tr>
    <tr>
      <td style="width: 20%;">mdTauOptionEnabled=</td>
      <td style="vertical-align: top; width: 50%;">Ask for coda value reset to extrapolated tau values. <br></td>
      <td style="width: 30%;">false (default)</td>
    </tr>
    <tr>
      <td style="width: 20%;">masterViewWaveformLoadMode=</td>
      <td style="vertical-align: top; width: 50%;"> =0 foreground, =1 background, =2 none, =3 cache<br></td>
      <td style="width: 30%;">3 (default)</td>
    </tr>
    <tr>
      <td style="width: 20%;">minDragTime=</td>
      <td style="vertical-align: top; width: 50%;">Smallest window that selectable by dragging in waveform view<br></td>
      <td style="width: 30%;">1.0 (default)</td>
    </tr>
    <tr>
    <td style="width: 20%;">miniButtonWidth=</td>
    <td style="vertical-align: top; width: 50%;">toolbar mini button width value between 16 and 38 pixels</td>
    <td style="width: 30%;">24 (default)</td>
    </tr>
    <tr>
      <td style="width: 20%;">miniToolBarButtons=</td>
      <td style="vertical-align: top; width: 50%;">If true use small image buttons in toolbar<br></td>
      <td style="width: 30%;">false (default)</td>
    </tr>
    <tr>
      <td style="width: 20%;">mlrMagOptionEnabled=</td>
      <td style="vertical-align: top; width: 50%;">true, enables calculation of Mlr adjusted magnitude from Ml<br></td>
      <td style="width: 30%;">false (default)</td>
    </tr>
    <tr>
      <td style="width: 20%;">xxDisable=</td>
      <td style="vertical-align: top; width: 50%;">Disable calculation of magnitudes of type xx<br></td>
      <td style="width: 30%;">false (default)</td>
    </tr>
    <tr>
      <td style="width: 20%;">xxMagEngineProps=</td>
      <td style="vertical-align: top; width: 50%;">User's directory file containing xx magnitude method engine properties<br></td>
      <td style="width: 30%;">xxMagEng.props</td>
    </tr>
    <tr>
      <td style="width: 20%;">xxMagMethod=</td>
      <td style="vertical-align: top; width: 50%;">name of java class pertaining to xx method<br>md=org.trinet.jasi.magmethods.HypoinvMdMagMethod<br>
          ml=org.trinet.jasi.magmethods.TN.CISNml2MagMethod</td>
      <td style="width: 30%;">org.trinet.jasi.magmethods.MyFavoriteMagMethod<a name="xxMagMethod"></a></td>
    </tr>
    <tr>
      <td style="width: 20%;">xxMagMethodProps=</td>
      <td style="vertical-align: top; width: 50%;">User's directory file containing the xx magnitude method properties<br></td>
      <td style="width: 30%;">xxMagMeth.props</td>
    </tr>
    <tr>
        <td style="width: 20%;">networkModeWAN=</td>
        <td style="vertical-align: top; width: 50%;">if true, fewer db queries done to check data on load/save, catalog row refresh limited<br></td>
      <td style="width: 30%;">false (default)</td>
    </tr>
    <tr>
        <td><a href="../configuration/origin-type/">origin.type.XX</a></td>
        <td>
            - Where "XX" is one or two character origin type defined in "origin" database table.<br>
            - Defaults are always loaded in by Jiggle when missing unless description is set to an empty string. 
        </td>
        <td>
            (defaults)<br>
            origin.type.a=Amplitude<br>
            origin.type.c=Centroid<br>
            origin.type.d=Double Difference<br>
            origin.type.h=Hypocenter<br>
            origin.type.n=Non Locatable<br>
            origin.type.u=Unknown<br>
        </td>
    </tr>
    <tr>
    <td style="width: 20%;">org.trinet.jasi.xxCTM.debug=</td>
      <td style="vertical-align: top; width: 50%;"><i>where xxCTM is name of a ChannelTimeModel Java subclass</i><br>
          Print channel time window model debug output<br></td>
      <td style="width: 30%;"><a href="channeltimemodel.html">false</a></td>
    </tr>
    <tr>
    <td style="width: 20%;">org.trinet.jasi.xxCTM.candidateListName=</td>
      <td style="vertical-align: top; width: 50%;"><i>where xxCTM is name of a ChannelTimeModel Java subclass</i><br>
          A name associated with set of channels in JASI_CONFIG_VIEW<br></td>
      <td style="width: 30%;"><a href="channeltimemodel.html">RCG-TRINET</a></td>
    </tr>
    <tr>
    <td style="width: 20%;">org.trinet.jasi.xxCTM.synchCandidateListBySolution=</td>
      <td style="vertical-align: top; width: 50%;"><i>where xxCTM is name of a ChannelTimeModel Java subclass</i><br>
          Upon event waveform load, update candidate list with channels active on origin date<br></td>
      <td style="width: 30%;"><a href="channeltimemodel.html">true</a></td>
    </tr>
    <tr>
    <td style="width: 20%;">org.trinet.jasi.xxCTM.filterWfListByChannelList=</td>
      <td style="vertical-align: top; width: 50%;"><i>where xxCTM is name of a ChannelTimeModel Java subclass</i><br>
          Show waveform panels only for channels which are in the named candidate list<br></td>
      <td style="width: 30%;"><a href="channeltimemodel.html">true</a></td>
    </tr>
    <tr>
        <td style="width: 20%;">org.trinet.jasi.xxCTM.includeDataSourceWf=</td>
      <td style="vertical-align: top; width: 50%;"><i>where xxCTM is name of the model subclass</i><br>
      Include data times for waveforms associated in datasource<br></td>
      <td style="width: 30%;"><a href="channeltimemodel.html">true</a></td>
    </tr>
    <tr>
    <td style="width: 20%;">org.trinet.jasi.xxCTM.includePhases=</td>
      <td style="vertical-align: top; width: 50%;"><i>where xxCTM is name of a ChannelTimeModel Java subclass</i><br>
          Create waveform panels for channels with phases associated with the solution<br></td>
      <td style="width: 30%;"><a href="channeltimemodel.html">false</a></td>
    </tr>
    <tr>
    <td style="width: 20%;">org.trinet.jasi.xxCTM.includeMagAmps=</td>
      <td style="vertical-align: top; width: 50%;"><i>where xxCTM is name of a ChannelTimeModel Java subclass</i><br>
          Create waveform panels for channels with amps associated with the preferred magnitude<br></td>
      <td style="width: 30%;"><a href="channeltimemodel.html">false</a></td>
    </tr>
    <tr>
    <td style="width: 20%;">org.trinet.jasi.xxCTM.includePeakAmps=</td>
      <td style="vertical-align: top; width: 50%;"><i>where xxCTM is name of a ChannelTimeModel Java subclass</i><br>
          Create waveform panels for channels with amps associated with the preferred origin<br></td>
      <td style="width: 30%;"><a href="channeltimemodel.html">false</a></td>
    </tr>
    <tr>
    <td style="width: 20%;">org.trinet.jasi.xxCTM.includeCodas=</td>
      <td style="vertical-align: top; width: 50%;"><i>where xxCTM is name of a ChannelTimeModel Java subclass</i><br>
          Create waveform panels for channels with codas associated with the preferred magnitude<br></td>
      <td style="width: 30%;"><a href="channeltimemodel.html">false</a></td>
    </tr>
    <tr>
        <td style="width: 20%;">org.trinet.jasi.xxCTM.includeAllComponents=</td>
      <td style="vertical-align: top; width: 50%;"><i>where xxCTM is name of a ChannelTimeModel Java subclass</i><br>
       If one triaxial component of a station is selected, select them all<br></td>
      <td style="width: 30%;"><a href="channeltimemodel.html">false</a></td>
    </tr>
    <tr>
        <td style="width: 20%;">org.trinet.jasi.xxCTM.includeAllMag=</td>
      <td style="vertical-align: top; width: 50%;"><i>where xxCTM is name of the model subclass</i><br>
      If mag is &gt;= this value include ALL channels<br></td>
      <td style="width: 30%;"><a href="channeltimemodel.html">3.5</a></td>
    </tr>
    <tr>
    <td style="width: 20%;">org.trinet.jasi.xxCTM.allowedNetTypes=</td>
      <td style="vertical-align: top; width: 50%;"><i>where xxCTM is name of a ChannelTimeModel Java subclass</i><br>
       Display only waveform panels for channels whose net code is in this list<br></td>
      <td style="width: 30%;"><a href="channeltimemodel.html">CI NC BK NN</a></td>
    </tr>
    <tr>
    <td style="width: 20%;">org.trinet.jasi.xxCTM.allowedSeedChanTypes=</td>
      <td style="vertical-align: top; width: 50%;"><i>where xxCTM is name of a ChannelTimeModel Java subclass</i><br>
       Display only waveform panels for channels whose seedchan type is in this list<br></td>
      <td style="width: 30%;"><a href="channeltimemodel.html">HHZ HHE HHN</a></td>
    </tr>
    <tr>
    <td style="width: 20%;">org.trinet.jasi.xxCTM.allowedStaTypes=</td>
      <td style="vertical-align: top; width: 50%;"><i>where xxCTM is name of a ChannelTimeModel Java subclass</i><br>
       Display only waveform panels for stations whose name is in this list<br></td>
      <td style="width: 30%;"><a href="channeltimemodel.html">PAS PLM RVR</a></td>
    </tr>
    <tr>
    <td style="width: 20%;">org.trinet.jasi.xxCTM.rejectedNetTypes=</td>
      <td style="vertical-align: top; width: 50%;"><i>where xxCTM is name of a ChannelTimeModel Java subclass</i><br>
          Reject from display in waveform panel channels whose net code is in this list<br></td>
      <td style="width: 30%;"><a href="channeltimemodel.html">BK</a></td>
    </tr>
    <tr>
    <td style="width: 20%;">org.trinet.jasi.xxCTM.rejectedSeedChanTypes=</td>
      <td style="vertical-align: top; width: 50%;"><i>where xxCTM is name of a ChannelTimeModel Java subclass</i><br>
          Reject from display in waveform panel channels whose seedchan type is in this list<br></td>
      <td style="width: 30%;"><a href="channeltimemodel.html">BHZ BHE BHN</a></td>
    </tr>
    <tr>
    <td style="width: 20%;">org.trinet.jasi.xxCTM.rejectedStaTypes=</td>
      <td style="vertical-align: top; width: 50%;"><i>where xxCTM is name of a ChannelTimeModel Java subclass</i><br>
          Reject from display in waveform panel stations whose name is in this list<br></td>
      <td style="width: 30%;"><a href="channeltimemodel.html">PAS PLM RVR</a></td>
    </tr>
    <tr>
        <td style="width: 20%;">org.trinet.jasi.xxCTM.maxDistance=</td>
      <td style="vertical-align: top; width: 50%;"><i>where xxCTM is name of the model subclass</i><br>
      Exclude channels beyond this distance (km)<br></td>
      <td style="width: 30%;"><a href="channeltimemodel.html">999</a></td>
    </tr>
    <tr>
        <td style="width: 20%;">org.trinet.jasi.xxCTM.minDistance=</td>
      <td style="vertical-align: top; width: 50%;"><i>where xxCTM is name of the model subclass</i><br>
      Include all channels withing this distance (km)<br></td>
      <td style="width: 30%;"><a href="channeltimemodel.html">30</a></td>
    </tr>
    <tr>
      <td style="width: 20%;">org.trinet.jasi.xxCTM.maxWindowSize=</td>
      <td style="vertical-align: top; width: 50%;"><i>where xxCTM is name of the model subclass</i><br>
      Do not allow algorithm to specify a window longer than this (seconds)<br></td>
      <td style="width: 30%;"><a href="channeltimemodel.html">300</a></td>
    </tr>
    <tr>
        <td style="width: 20%;">org.trinet.jasi.xxCTM.minWindowSize=</td>
      <td style="vertical-align: top; width: 50%;"><i>where xxCTM is name of the model subclass</i><br>
      Minimum window length (sec)<br></td>
      <td style="width: 30%;"><a href="channeltimemodel.html">60</a></td>
    </tr>
    <tr>
    <td style="width: 20%;">org.trinet.jasi.xxCTM.maxChannels=</td>
      <td style="vertical-align: top; width: 50%;"><i>where xxCTM is name of a ChannelTimeModel Java subclass</i><br>
          Maximum number of channels sorted by distance to display in waveform view<br></td>
      <td style="width: 30%;"><a href="channeltimemodel.html">9999</a></td>
    </tr>
    <tr>
    <td style="width: 20%;">org.trinet.jasi.xxCTM.preEventSize=</td>
      <td style="vertical-align: top; width: 50%;"><i>where xxCTM is name of a ChannelTimeModel Java subclass</i><br>
          Number of seconds to prepend to the smallest channel on time<br></td>
      <td style="width: 30%;"><a href="channeltimemodel.html">20</a></td>
    </tr>
    <tr>
    <td style="width: 20%;">org.trinet.jasi.xxCTM.postEventSize=</td>
      <td style="vertical-align: top; width: 50%;"><i>where xxCTM is name of a ChannelTimeModel Java subclass</i><br>
          Number of seconds to append to the largest channel off time<br></td>
      <td style="width: 30%;"><a href="channeltimemodel.html">20</a></td>
    </tr>
    <tr>
      <td style="width: 20%;">pcsPostingEnabled</td>
      <td style="vertical-align: top; width: 50%;">enable Event menu item allowing the posting of a loaded event for state processing</td>
      <td style="width: 30%;">false (default)</td>
    </tr>
    <tr>
      <td style="width: 20%;">pcsPostingState</td>
      <td style="vertical-align: top; width: 50%;">5 token posting state description consisting of Group SrcTab State Rank Result</td>
      <td style="width: 30%;">PostProc Jiggle Selected 100 0 (default)</td>
    </tr>
    <tr>
      <td style="width: 20%;">pcsPosting.menuItem.labels=</td>
      <td style="vertical-align: top; width: 50%;">listed text strings are mapped to state postings defined by properties of the form:<br>
          "pcsPosting.XXX.state" where XXX is a item name parsed from list
      </td>
      <td style="width: 30%;">Distribute (example label)</td>
    </tr>
    <tr>
      <td style="width: 20%;">pcsPosting.XXX.state=</td>
      <td style="vertical-align: top; width: 50%;">5 token posting state description consisting of Group SrcTab State Rank Result</td>
      <td style="width: 30%;">TPP TPP DISTRIBUTE 100 1</td>
    </tr>
    <tr>
      <td style="width: 20%;">phasePopupMenuFlat=</td>
      <td style="vertical-align: top; width: 50%;">Phase pick  popup descriptors listed in top level menu, not nested<br></td>
      <td style="width: 30%;">false (default)</td>
    </tr>
    <tr>
      <td style="width: 20%;">phasePopupMenu.alwaysResetLowQualFm=</td>
      <td style="vertical-align: top; width: 50%;">
          If true, always remove first motion if its removal confirmation is not enabled by 
          phasePopupMenu.phaseDescWtCheck, set false to leave first motion unchanged
      </td>
      <td style="width: 30%;">false (default)</td>
    </tr>
    <tr>
      <td style="width: 20%;">phasePopupMenu.maxWt4HumanFm=</td>
      <td style="vertical-align: top; width: 50%;">Do not include phase descriptors in popup menu with a first motion and greater weight</td>
      <td style="width: 30%;">1 (default)</td>
    </tr>
    <tr>
      <td style="width: 20%;">phasePopupMenu.phaseDescWtCheck=</td>
      <td style="vertical-align: top; width: 50%;">
          Confirmation popup to remove first motion when wt &gt; cutoff for the quality threshold property (firstMoQualityMin)
      </td>
      <td style="width: 30%;">true (default)</td>
    </tr>
    <tr>
      <td style="width: 20%;">phasePopupMenu.P.desc=</td>
      <td style="vertical-align: top; width: 50%;">List of P-phase descriptors for popup menu items (case-sensitive)<br></td>
      <td style="width: 30%;">iP0 iP1 eP2 eP3 eP4 (defaults)</td>
    </tr>
    <tr>
      <td style="width: 20%;">phasePopupMenu.S.desc=</td>
      <td style="vertical-align: top; width: 50%;">List of S-phase descriptors for popup menu items (case-sensitive)<br></td>
      <td style="width: 30%;">iS0 iS1 eS2 eS3 (defaults)</td>
    </tr>
    <tr>
      <td style="width: 20%;">phasePopupMenu.S.minWgt=</td>
      <td style="vertical-align: top; width: 50%;">Minimum (0-4) weight to show in popup menu items for contructing S phase descriptors</td>
      <td style="width: 30%;">2</td>
    </tr>
    <tr>
      <td style="width: 20%;">pickFlagFont=</td>
      <td style="vertical-align: top; width: 50%;">BIG (large bold text in trace pick flag)</td>
      <td style="width: 30%;">SMALL (default)</td>
    </tr>
    <tr>
      <td style="width: 20%;">pickFlag.colorByPhase=</td>
      <td style="vertical-align: top; width: 50%;">for P and S pick flags, do phase coloring, instead of event clone# coloring</td>
      <td style="width: 30%;">false (default)</td>
    </tr>
    <tr>
      <td style="width: 20%;">pickFlag.colorP=</td>
      <td style="vertical-align: top; width: 50%;">P pick flag color, when pickFlag.colorByPhase=true</td>
      <td style="width: 30%;">FFFF0000 (red default)</td>
    </tr>
    <tr>
      <td style="width: 20%;">pickFlag.colorP.text=</td>
      <td style="vertical-align: top; width: 50%;">P pick descriptor text color, when pickFlag.colorByPhase=true</td>
      <td style="width: 30%;">FF000000 (black default)</td>
    </tr>
    <tr>
      <td style="width: 20%;">pickFlag.colorS=</td>
      <td style="vertical-align: top; width: 50%;">S pick flag color, when pickFlag.colorByPhase=true</td>
      <td style="width: 30%;">FFFF00F0 (fuschia default)</td>
    </tr>
    <tr>
      <td style="width: 20%;">pickFlag.colorS.text=</td>
      <td style="vertical-align: top; width: 50%;">S pick descriptor text color, when pickFlag.colorByPhase=true</td>
      <td style="width: 30%;">FF000000 (black default)</td>
    </tr>
    <tr>
      <td style="width: 20%;">pickStripDistance=</td>
      <td style="vertical-align: top; width: 50%;">Strip Picks command will delete picks whose distance &GT; value km<br></td>
      <td style="width: 30%;">1000.0 (default)</td>
    <tr>
      <td style="width: 20%;">pickStripValue=</td>
      <td style="vertical-align: top; width: 50%;">Strip Picks command will delete picks whose residual &GT; value seconds<br></td>
      <td style="width: 30%;">1.0 (default)</td>
    </tr>
    <tr>
      <td style="width: 20%;">picker.class.PickEW=</td>
      <td style="vertical-align: top; width: 50%;">Named selected picker's class file<br></td>
      <td style="width: 30%;">org.trinet.jasi.picker.PickEW</td>
    </tr>
    <tr>
      <td style="width: 20%;">picker.props.PickEW=</td>
      <td style="vertical-align: top; width: 50%;">Named selected picker's properties file<br></td>
      <td style="width: 30%;">pickEW.props</td>
    </tr>
    <tr>
      <td style="width: 20%;">picker.selected.name=</td>
      <td style="vertical-align: top; width: 50%;">Name of the selected picker, used above for property suffix<br></td>
      <td style="width: 30%;">PickEW</td>
    </tr>
    <tr>
        <td style="width: 20%;">pickingPanelArrowLayout=</td>
        <td style="vertical-align: top; width: 50%;">Layout position of waveform scroller arrow buttons (E,W,S)<br></td>
      <td style="width: 30%;">E (default)</td>
    </tr>
    <tr>
        <td style="width: 20%;">pickingPanelHotKeyNum2Wt=</td>
        <td style="vertical-align: top; width: 50%;">If true, hotkeys 0-4 only change phase wt,<br>false, keys set iP0,iP1,eP2,eP3,eP4 with auto fm</td>
      <td style="width: 30%;">false (default)</td>
    </tr>
    <tr>
        <td style="width: 20%;">postInterimCommit=</td>
        <td style="vertical-align: top; width: 50%;">If true, interim save to db, posts id to "TPP TPP INTERIM 100 0"<br>otherwise, no post upon save.</td>
      <td style="width: 30%;">false (default)</td>
    </tr>
    <tr>
        <td style="width: 20%;">postInterimRank=</td>
        <td style="vertical-align: top; width: 50%;">rank value used for a "TPP TPP INTERIM" post, default=100.</td>
      <td style="width: 30%;">95</td>
    </tr>
    <tr>
        <td style="width: 20%;">postInterimResult=</td>
        <td style="vertical-align: top; width: 50%;">result value used for a TPP TPP INTERIM" post, default=0.</td>        
        <td style="width: 30%;">1 </td>
    </tr>
    <tr>
        <td style="width: 20%;">prefmagCheckValue=</td>
        <td style="vertical-align: top; width: 50%;">Confirm commit if a magnitude is greater &GT;= to value<br></td>
      <td style="width: 30%;">3 (default)</td>
    </tr>
    <tr>
        <td style="width: 20%;">prefmagCheckDisabled=</td>
        <td style="vertical-align: top; width: 50%;">If true, don't check event's preferred magnitude priority on commit<br></td>
      <td style="width: 30%;">false (default)</td>
    </tr>
        <tr>
      <td style="width: 20%;">printHypoMagHeaders=</td>
      <td style="vertical-align: top; width: 50%;">Print Magnitude header after calculation.<br></td>
      <td style="width: 30%;">false (default)</td>
    <tr>
      <td style="width: 20%;">printLocEngPhaseList=</td>
      <td style="vertical-align: top; width: 50%;">Print Hypoinverse format phase listing.<br></td>
      <td style="width: 30%;">false (default)</td>
    </tr>
    <tr>
      <td style="width: 20%;">printMagEngReadingList=</td>
      <td style="vertical-align: top; width: 50%;">Print data used by magnitude engine for summary calculation.<br></td>
      <td style="width: 30%;">false (default)</td>
    </tr>
    <tr>
      <td style="width: 20%;">printMagnitudes=</td>
      <td style="vertical-align: top; width: 50%;">Print before/after summary magnitudes.<br></td>
      <td style="width: 30%;">false (default)</td>
    </tr>
    <tr>
      <td style="width: 20%;">printSolutionPhaseList=</td>
      <td style="vertical-align: top; width: 50%;">Print internal Solution's java class phase list.<br></td>
      <td style="width: 30%;">false (default)</td>
    </tr>
    <tr>
      <td style="width: 20%;">printSolutions=</td>
      <td style="vertical-align: top; width: 50%;">Print Solution before/after calculation.<br></td>
      <td style="width: 30%;">false (default)</td>
    </tr>
    <tr>
      <td style="width: 20%;">quarryFixDepth=</td>
      <td style="vertical-align: top; width: 50%;">Value (km) at which to set quarry depths<br></td>
      <td style="width: 30%;">0.0 (default)</td>
    </tr>
    <tr>
      <td style="width: 20%;">rcgMenuOptionEnabled=</td>
      <td style="vertical-align: top; width: 50%;">If true, show the RCG... option in Event menu<br></td>
      <td style="width: 30%;">false (default)</td>
    <tr>
      <td style="width: 20%;">rcgStaAuth=</td>
      <td style="vertical-align: top; width: 50%;">Archive station authority for waveform request<br></td>
      <td style="width: 30%;">SCEDC (if unspecified, defaults to the localNetCode)</td>
    </tr>
    <tr>
      <td style="width: 20%;">rcgAuth=</td>
      <td style="vertical-align: top; width: 50%;">Authority for waveform request<br></td>
      <td style="width: 30%;">CI (if unspecified, defaults to the localNetCode</td>
    </tr>
    <tr>
      <td style="width: 20%;">rcgSubsource=</td>
      <td style="vertical-align: top; width: 50%;">Subsource for waveform request<br></td>
      <td style="width: 30%;">Jiggle (default)</td>
    </tr>
    <tr>
      <td style="width: 20%;">savePropsOnExit=</td>
      <td style="vertical-align: top; width: 50%;">Write properties to user's properties file upon exit</td>
      <td style="width: 30%;">true (default)</td>
    </tr>
    <tr>
      <td style="width: 20%;">scope.finalRequireNewEvent</td>
       <td style="vertical-align: top; width: 50%;">Requires "NEW" button to create a new event when an event is finalized in Scope mode. 
            This prevents a user from re-picking on the finalized event in Scope mode</td>
      <td style="width: 30%;">true (default)</td>
    </tr>
    <tr>
      <td style="width: 20%;">scope.useStartTime</td>
       <td style="vertical-align: top; width: 50%;">Controls whether Scope mode uses start time or end time when defining scope view window. True=start time and false=end time</td>
      <td style="width: 30%;">false (default)</td>
    </tr>
    <tr>
      <td style="width: 20%;">scopeMode=</td>
       <td style="vertical-align: top; width: 50%;">Load waveforms views using waveserver group</td>
      <td style="width: 30%;">false (default)</td>
    </tr>
    <tr>
        <td style="width: 20%;">scopeModeChannelFile=</td>
        <td style="vertical-align: top; width: 50%;">Name of file containing channelname list to load from waveservers when in scope mode</td>
      <td style="width: 30%;">scopeChannelList.txt</td>
    </tr>
    <tr>
        <td style="width: 20%;">scopeDuration=</td>
        <td style="vertical-align: top; width: 50%;">number of seconds of waveform timeseries loaded from waveservers</td>
      <td style="width: 30%;">90. (default)</td>
    </tr>
    <tr>
        <td style="width: 20%;">scopeRefreshEndTime=</td>
        <td style="vertical-align: top; width: 50%;">in scope mode set view endtime to current clock time for each "Next" toolbar button click</td>
      <td style="width: 30%;">true (default)</td>
    </tr>
    <tr>
      <td style="width: 20%;">scanNoiseType=</td>
      <td style="vertical-align: top; width: 50%;">Noise scan type, bias removed:<br>
          AVG avg only absolute peaks, RMS samples, AAA avg absolute all samples)</td>
      <td style="width: 30%;">0 (default, AVG=0, RMS=1, AAA=2)</td>
    <tr>
      <td style="width: 20%;">secsPerPage=</td>
      <td style="vertical-align: top; width: 50%;">Seconds to display on the waveform view pages<br>(-1 = show full time)<br></td>
      <td style="width: 30%;">90.0</td>
    </tr>
    <tr>
      <td style="width: 20%;">seedReaderDebug=</td>
      <td style="vertical-align: top; width: 50%;">log values parsed for each miniseed packet header<br></td>
      <td style="width: 30%;">false (default)</td>
    </tr>
    <tr>
      <td style="width: 20%;">seedReaderVerbose=</td>
      <td style="vertical-align: top; width: 50%;">log text message when wave data source has no timeseries for channel<br></td>
      <td style="width: 30%;">false (default)</td>
    </tr>
    <tr>
      <td style="width: 20%;">showCursorAmpAsLine</td>
      <td style="vertical-align: top; width: 50%;">paint horizontal line across panel at the current mouse position</td>
      <td style="width: 30%;">false (default)</td>
    </tr>
    <tr>
      <td style="width: 20%;">showCursorTimeAsLine=</td>
      <td style="vertical-align: top; width: 50%;">Display vertical timing line across picking panel as cursor moves</td>
      <td style="width: 30%;">true (default)</td>
    </tr>
    <tr>
      <td style="width: 20%;">showDeltimes=</td>
      <td style="vertical-align: top; width: 50%;">Show pick weight deltim line plotted on pick flags in waveform panels<br></td>
      <td style="width: 30%;">true (default)</td>
    </tr>
    <tr>
      <td style="width: 20%;">showFilteredWfGroup=</td>
      <td style="vertical-align: top; width: 50%;">When true, apply "defaultWfGroupFilter" to waveforms in group waveform panels<br></td>
      <td style="width: 30%;">false (default)</td>
    </tr>
    <tr>
      <td style="width: 20%;">showHideTraceMenu=</td>
      <td style="vertical-align: top; width: 50%;">Enable button in lower right WF scrollpane to show menu of seedchan patterns to hide<br></td>
      <td style="width: 30%;">false (default)</td>
    </tr>
    <tr>
      <td style="width: 20%;">showPhaseCues=</td>
      <td style="vertical-align: top; width: 50%;">Should green striped cues (hints) show calculated P &amp; S locations<br></td>
      <td style="width: 30%;">false (default)</td>
    </tr>
    <tr>
      <td style="width: 20%;">showResiduals=</td>
      <td style="vertical-align: top; width: 50%;">Show pick residual line plotted on pick flags in waveform panels<br></td>
      <td style="width: 30%;">true (default)</td>
    </tr>
    <tr>
      <td style="width: 20%;">showRowHeaders=</td>
      <td style="vertical-align: top; width: 50%;">Show waveform view panel headers<br></td>
      <td style="width: 30%;">false (default)</td>
    </tr>
    <tr>
      <td style="width: 20%;">showSamples=</td>
      <td style="vertical-align: top; width: 50%;">Show individual timeseries samples when zoomed in<br></td>
      <td style="width: 30%;">true (default)</td>
    </tr>
    <tr>
      <td style="width: 20%;">showSegments=</td>
      <td style="vertical-align: top; width: 50%;">Show waveform data packet bounds (cyan lines)<br></td>
      <td style="width: 30%;">false (default)</td>
    </tr>
    <tr>
      <td style="width: 20%;">solCommitAllMags=</td>
      <td style="vertical-align: top; width: 50%;">Commit all prefmag of magtypes<br></td>
      <td style="width: 30%;">false (default)</td>
    </tr>
    <tr>
      <td style="width: 20%;">solCommitOriginError=</td>
      <td style="vertical-align: top; width: 50%;">Commit HYP2000 error axes to Origin_Error table<br></td>
      <td style="width: 30%;">false (default)</td>
    </tr>
    <tr>
      <td style="width: 20%;">solCommitResetsAttrib=</td>
      <td style="vertical-align: top; width: 50%;">when false credit table attribution is inherited from 
          the previously preferred orid, if none, the committing user's id is used for credit.<br></td>
      <td style="width: 30%;">true (default)</td>
    </tr>
    <tr>
      <td style="width: 20%;">solCommitResetsRflag=</td>
      <td style="vertical-align: top; width: 50%;">when false a commit does not update origin rflag<br></td>
      <td style="width: 30%;">true (default)</td>
    </tr>
    <tr>
      <td style="width: 20%;">solLockingDisabled=</td>
      <td style="vertical-align: top; width: 50%;">Override to bypass handling of solution locks<br></td>
      <td style="width: 30%;">false (default)</td>
    </tr>
    <tr>
      <td style="width: 20%;">solNextProcStateMask=</td>
      <td style="vertical-align: top; width: 50%;">String of acceptable processing state tags<br></td>
      <td style="width: 30%;">AHF (default)</td>
    </tr>
    <tr>
      <td style="width: 20%;">solPreferredRollbackEnabled=</td>
      <td style="vertical-align: top; width: 50%;">Create toolbar button for resetting prefor,prefmag after save failure<br></td>
      <td style="width: 30%;">false (default)</td>
    </tr>
    <tr>
      <td style="width: 20%;">solStaleCommitOk=</td>
      <td style="vertical-align: top; width: 50%;">Allow commit of stale origin to db<br></td>
      <td style="width: 30%;">true (default)</td>
    </tr>
    <tr>
        <td style="width: 20%;">stackPickingPanelButtons=</td>
        <td style="vertical-align: top; width: 50%;">False, shows button in one horizontal line<br></td>
      <td style="width: 30%;">false (default)</td>
    </tr>
    <tr>
        <td style="width: 20%;">swarmInWaveformTabPane=</td>
        <td style="vertical-align: top; width: 50%;">true, Swarm panel at bottom of waveform tab pane, false standalone window<br></td>
      <td style="width: 30%;">false (default)</td>
    </tr>
    <tr>
      <td style="width: 20%;">testConnection=</td>
      <td style="vertical-align: top; width: 50%;">if true, test query db to validate connection, before doing a transaction<br></td>
      <td style="width: 30%;">false (default)</td>
    </tr>
    <tr>
      <td style="width: 20%;">threshold.out.magResidual=</td>
      <td style="vertical-align: top; width: 50%;">Use outlier color when magnitude residual is greater<br></td>
      <td style="width: 30%;">.5 (default)</td>
    </tr>
    <tr>
      <td style="width: 20%;">threshold.out.ttResidual=</td>
      <td style="vertical-align: top; width: 50%;">Use outlier color when traveltime residual is greater<br></td>
      <td style="width: 30%;">.5 (default)</td>
    </tr>
    <tr>
        <td style="width: 20%;">threshold.warn.magResidual=</td>
        <td style="vertical-align: top; width: 50%;">Use warning color when magnitude residual is greater, but less than outlier threshold<br></td>
      <td style="width: 30%;">.25 (default)</td>
    </tr>
    <tr>
        <td style="width: 20%;">threshold.warn.ttResidual=</td>
        <td style="vertical-align: top; width: 50%;">Use warning color when traveltime residuals greater, but less than outlier threshold<br></td>
      <td style="width: 30%;">.25 (default)</td>
    </tr>
    <tr>
      <td style="width: 20%;">tracesPerPage=</td>
      <td style="vertical-align: top; width: 50%;">Show this many traces per page<br></td>
      <td style="width: 30%;">10 (default)</td>
    </tr>
    <tr>
      <td style="width: 20%;">triaxialScrollZoomWithGroup=</td>
      <td style="vertical-align: top; width: 50%;">triaxial mode time scroll of group panel scrolls picking panel window times<br></td>
      <td style="width: 30%;">true (default)</td>
    </tr>
    <tr>
        <td style="width: 20%;">triaxialSelectionLocked=</td>
        <td style="vertical-align: top; width: 50%;">If true and zoom panel has triaxial display selected, station change does not reset toggle<br></td>
      <td style="width: 30%;">false (default)</td>
    </tr>
    <tr>
      <td style="width: 20%;">triaxialZonH=</td>
      <td style="vertical-align: top; width: 50%;">If true, and zoom panel as triaxial display selected, show vertical on horizontal views<br></td>
      <td style="width: 30%;">true (default)</td>
    </tr>
    <tr>
      <td style="width: 20%;">unfixEqDepth=</td>
      <td style="vertical-align: top; width: 50%;">if true and event is eq depth is fixed, unfix depth when using trial depth<br></td>
      <td style="width: 30%;">false (default)</td>
    </tr>
    <tr>
      <td style="width: 20%;">useCalcOriginDatum=</td>
      <td style="vertical-align: top; width: 50%;">For H,T hypoinverse models usage only, when setting fix depth, if true,<br>
         calculate a datum from closest arrivals and set geoid depth to depth-datum ; otherwise geoid depth is set to fix depth</td>
      <td style="width: 30%;">false (default)</td>
    </tr>
    <tr>
      <td style="width: 20%;">useEventPreforTable=</td>
      <td style="vertical-align: top; width: 50%;">update the preferred origin of type when the database has an EVENTPREFOR table<br></td>
      <td style="width: 30%;">false (default)</td>
    </tr>
    <tr>
      <td style="width: 20%;">useLoginDialog=</td>
      <td style="vertical-align: top; width: 50%;">Instead of using dbaseUser,dbasePasswd, prompt user with dialog<br></td>
      <td style="width: 30%;">false (default)</td>
    </tr>
    <tr>
      <td style="width: 20%;">useTrialLocation=</td>
      <td style="vertical-align: top; width: 50%;">On relocation, use the current location as the trial start<br></td>
      <td style="width: 30%;">false (default)</td>
    </tr>
    <tr>
      <td style="width: 20%;">versionCheckDisabled=</td>
      <td style="vertical-align: top; width: 50%;">On startup, or GUI reset do not check web URL for new Jiggle version.<br></td>
      <td style="width: 30%;">false (default)</td>
    </tr>
    <tr>
      <td style="width: 20%;">useTrialOriginTime=</td>
      <td style="vertical-align: top; width: 50%;">On relocation, use the current origintime as the trial start<br></td>
      <td style="width: 30%;">false (default)</td>
    </tr>
    <tr>
      <td style="width: 20%;">velocityModelClassName=</td>
      <td style="vertical-align: top; width: 50%;">Name of java class implementing velocity model used for traveltimes<br>
          (e.g. org.trinet.util.velocitymodel.USGS_NC_VelocityModel)<br></td>
      <td style="width: 30%;">org.trinet.util.velocitymodel.HK_SoCalVelocityModel (CI default) <br>
                              org.trinet.util.velocitymodel.USGS_NC_VelocityModel (NC default) <br></td>
    </tr>
    <tr>
        <td style="width: 20%;">velocityModel.DEFAULT.modelName</td>
        <td style="vertical-align: top; width: 50%;">Name of velocity model to use if model list has more than one model</td>
        <td style="width: 30%;">abc123</td>
    </tr>
    <tr>
        <td style="width: 20%;">velocityModel.abc123.psRatio</td>
        <td style="vertical-align: top; width: 50%;">Vp/Vs ratio of velocity model</td>
        <td style="width: 30%;">1.75</td>
    </tr>
    <tr>
        <td style="width: 20%;">velocityModel.abc123.depths</td>
        <td style="vertical-align: top; width: 50%;">List top of model layer depths</td>
        <td style="width: 30%;">0. 5. 15. 30.</td>
    </tr>
    <tr>
        <td style="width: 20%;">velocityModel.abc123.velocities</td>
        <td style="vertical-align: top; width: 50%;">List of model layer velocities</td>
        <td style="width: 30%;">4.0 6.0 6.5 7.9</td>
    </tr>
    <tr>
        <td style="width: 20%;">velocityModelList</td>
        <td style="vertical-align: top; width: 50%;">List defined velocity model names</td>
        <td style="width: 30%;">abc123 nocal</td>
    </tr>
    <tr>
      <td style="width: 20%;">verbose=</td>
      <td style="vertical-align: top; width: 50%;">User verbose output<br></td>
      <td style="width: 30%;">false (default)</td>
    </tr>
    <tr>
      <td style="width: 20%;">waveServerConnectTimeout=</td>
      <td style="vertical-align: top; width: 50%;">a new client connection timeout millisecs</td>
      <td style="width: 30%;">10000 (default)</td>
    </tr>
    <tr>
      <td style="width: 20%;">waveServerGroupDefaultClient=</td>
      <td style="vertical-align: top; width: 50%;">Name of java class that implements WaveClient API<br></td>
      <td style="width: 30%;">org.trinet.waveserver.rt.WaveClientNew (default)</td>
    </tr>
    <tr>
      <td style="width: 20%;">waveServerGroupList=</td>
      <td style="vertical-align: top; width: 50%;">List of waveserver groups (default is none)</td>
      <td style="width: 30%;">
          rts+1+0+false+false+w1.cit.edu\:6509+w2.cit.edu\:6509
      </td>
    </tr>
    <tr>
      <td style="width: 20%;">waveServerPopupOnAddServerError=</td>
      <td style="vertical-align: top; width: 50%;">Popup alert message when unable to connect to a waveserver client</td>
      <td style="width: 30%;">false (default)</td>
    </tr>
    <tr>
      <td style="width: 20%;">waveformCommitOk=</td>
      <td style="vertical-align: top; width: 50%;">Copy waveform associations in db when cloned event is committed<br></td>
      <td style="width: 30%;">true (default)</td>
    </tr>
    <tr>
      <td style="width: 20%;">waveformInTab=</td>
      <td style="vertical-align: top; width: 50%;">Show waveforms in a tab rather than a split pane<br></td>
      <td style="width: 30%;">false (default)</td>
    </tr>
    <tr>
      <td style="width: 20%;">waveformReadMode=</td>
      <td style="vertical-align: top; width: 50%;">Where waveforms should be read from: 0 = datasource, 1= waveserver<br></td>
      <td style="width: 30%;">0  (default)</td>
    </tr>
    <tr>
      <td style="width: 20%;">waverootsCopy=</td>
      <td style="vertical-align: top; width: 50%;">Database waveform file archive path copy from waveroots table<br></td>
      <td style="width: 30%;">1  (default)</td>
    </tr>
    <tr>
      <td style="width: 20%;">webSite=</td>
      <td style="vertical-align: top; width: 50%;">URL of website for latest Jiggle version check, helpfiles<br></td>
      <td style="width: 30%;">http\://pasadena.wr.usgs.gov/jiggle/<br></td>
    </tr>
    <tr>
      <td style="width: 20%;">wfCache2File=</td>
      <td style="vertical-align: top; width: 50%;">Write unloaded wf to disk files<br></td>
      <td style="width: 30%;">false (default)<br></td>
    </tr>
    <tr>
      <td style="width: 20%;">wfCache2FileDir=</td>
      <td style="vertical-align: top; width: 50%;">Write unloaded wf to disk files in specified directory<br></td>
      <td style="width: 30%;">(undefined default is current directory)<br></td>
    </tr>
    <tr>
      <td style="width: 20%;">wfCache2FilePurged=</td>
      <td style="vertical-align: top; width: 50%;">if true, delete cached wf disk files when the selected event changes or upon program exit<br></td>
      <td style="width: 30%;">false (default)<br></td>
    </tr>
    <tr>
      <td style="width: 20%;">wfpPopupMenuFlat=</td>
      <td style="vertical-align: top; width: 50%;">strip,reject,delete menu option are in nested submenus or not<br></td>
      <td style="width: 30%;">false (default, true = not nested)<br></td>
    </tr>
    <tr>
      <td style="width: 20%;">wfpanel.ampScaleFactor=</td>
      <td style="vertical-align: top; width: 50%;">Scale all panels in group panel up (&GT; 1 or down (&LT; 1) by factor</td>
      <td style="width: 30%;">1. (default)</td>
    </tr>
    <tr>
      <td style="width: 20%;">wfpanel.channelLabel.font.name=</td>
      <td style="vertical-align: top; width: 50%;">
            Java logical font names are: Dialog, DialogInput, Monospaced, SansSerif, Serif (map to specific system fonts).<br>
            These or any scalable (i.e. OpenType, PostScript or TrueType) font face names on system.
      </td>
      <td style="width: 30%;">Dialog</td>
    </tr>
    <tr>
      <td style="width: 20%;">wfpanel.channelLabel.font.style=</td>
      <td style="vertical-align: top; width: 50%;">Waveform panel channel label font style (plain,bold,italic)</td>
      <td style="width: 30%;">plain (default)</td>
    </tr>
    <tr>
      <td style="width: 20%;">wfpanel.channelLabel.font.size=</td>
      <td style="vertical-align: top; width: 50%;">Waveform panel channel label font point size</td>
      <td style="width: 30%;">12 (default)</td>
    </tr>
    <tr>
      <td style="width: 20%;">wfpanel.channelLabel.font.fg=</td>
      <td style="vertical-align: top; width: 50%;">Waveform panel channel label font color</td>
      <td style="width: 30%;">ff000000 (default=black)</td>
    </tr>
    <tr>
      <td style="width: 20%;">wfpanel.channelLabel.form=</td>
      <td style="vertical-align: top; width: 50%;">
            Elements included in channel label text string shown in waveform panels<br>
            =SNCL (only), =dist (SNCL+distance), =filter (SNCL+filter-description)
      </td>
      <td style="width: 30%;">filter (default)</td>
    </tr>
    <tr>
      <td style="width: 20%;">wfpanel.maxAccGainScale=</td>
      <td style="vertical-align: top; width: 50%;">If scaleBy=gain, min,max range of panel is +/- counts/cm/sec2*scale</td>
      <td style="width: 30%;">0.1 (default)</td>
    </tr>
    <tr>
      <td style="width: 20%;">wfpanel.maxVelGainScale=</td>
      <td style="vertical-align: top; width: 50%;">If scaleBy=gain, min,max range of panel is +/- counts/cm/sec*scale</td>
      <td style="width: 30%;">0.001 (default)</td>
    </tr>
    <tr>
      <td style="width: 20%;">wfpanel.maxAccUnitsScale=</td>
      <td style="vertical-align: top; width: 50%;">If scaleBy=units, for acc min,max range of panel is +/- scale</td>
      <td style="width: 30%;">0.1 (default)</td>
    </tr>
    <tr>
      <td style="width: 20%;">wfpanel.maxCntUnitsScale=</td>
      <td style="vertical-align: top; width: 50%;">If scaleBy=units, for cnts min,max range of panel is +/- scale</td>
      <td style="width: 30%;">0.001 (default)</td>
    </tr>
    <tr>
      <td style="width: 20%;">wfpanel.maxDisUnitsScale=</td>
      <td style="vertical-align: top; width: 50%;">If scaleBy=units, for dis min,max range of panel is +/- scale</td>
      <td style="width: 30%;">0.001 (default)</td>
    </tr>
    <tr>
      <td style="width: 20%;">wfpanel.maxUnkUnitsScale=</td>
      <td style="vertical-align: top; width: 50%;">If scaleBy=units, and unk min,max range of panel is +/- scale</td>
      <td style="width: 30%;">0.001 (default)</td>
    </tr>
    <tr>
      <td style="width: 20%;">wfpanel.maxVelUnitsScale=</td>
      <td style="vertical-align: top; width: 50%;">If scaleBy=units, for vel min,max range of panel is +/- scale</td>
      <td style="width: 30%;">0.001 (default)</td>
    </tr>
    <tr>
      <td style="width: 20%;">wfpanel.noiseScalar= </td>
      <td style="vertical-align: top; width: 50%;">If scaleBy=noise, min,max range of panel is +/- noiseScalar*noiseLevel</td>
      <td style="width: 30%;">10. (default)</td>
    </tr>
    <tr>
      <td style="width: 20%;">wfpanel.noiseScanSecs=</td>
      <td style="vertical-align: top; width: 50%;">If scaleBy=noise, seconds of noise to average from start of wavefrom timeseries</td>
      <td style="width: 30%;">6. (default)</td>
    </tr>
    <tr>
      <td style="width: 20%;">wfpanel.scaleBy=</td>
      <td style="vertical-align: top; width: 50%;"> Scale min,max amp range in waveform group panels choices are: data, noise, gain, or units</td>
      <td style="width: 30%;">data (default)</td>
    </tr>
    <tr>
      <td style="width: 20%;">wfpanel.showTimeScaleLabel=</td>
      <td style="vertical-align: top; width: 50%;">Display of time hr:mn labels along panel time scale ticks in panels</td>
      <td style="width: 30%;">true (default)</td>
    </tr>
    <tr>
      <td style="width: 20%;">wfpanel.timeTicksFlag= </td>
      <td style="vertical-align: top; width: 50%;">Paint time scale ticks on panels, =0 both top/bottom, =1 top only, =2 bottom only</td>
      <td style="width: 30%;">0 (default) </td>
    </tr>
    <tr>
      <td style="width: 20%;">wfSmPWindowMultiplier=</td>
      <td style="vertical-align: top; width: 50%;">End time of window scanned for peak amp is multiplier*S-P time added to P-time<br></td>
      <td style="width: 30%;">2. (default)<br></td>
    </tr>
    <tr>
      <td style="width: 20%;">whereUnits=</td>
      <td style="vertical-align: top; width: 50%;">Units for 'where' output (miles, km)<br></td>
      <td style="width: 30%;">km (default)</td>
    </tr>
    <tr>
      <td style="width: 20%;">zoomBiasButtonOn</td>
      <td style="vertical-align: top; width: 50%;">zoom panel upper right corner bias button (B) is toggled on when event is loaded</td>
      <td style="width: 30%;">false (default)</td>
    </tr>
    <tr>
      <td style="width: 20%;">zoomScaleList=</td>
      <td style="vertical-align: top; width: 50%;">List of zoom scales displayed in Zoom Panel chooser<br></td>
      <td style="width: 30%;">1.00 2.00 5.00 10.00 20.00 30.00 60.00 90.00 (default)</td>
    </tr>
    <tr>
      <td style="width: 20%;">zoom.cursorShowsPhyUnits=</td>
      <td style="vertical-align: top; width: 50%;">Include field to show mouse cursor amp position in cgs units<br></td>
      <td style="width: 30%;">true (default)</td>
    </tr>
    <tr>
      <td style="width: 20%;">zoom.horz.blockScrollFactor=</td>
      <td style="vertical-align: top; width: 50%;">Scroll fraction of zoom panel viewport width<br></td>
      <td style="width: 30%;">0.05 (default)</td>
    </tr>
    <tr>
      <td style="width: 20%;">zoom.vert.blockScrollFactor=</td>
      <td style="vertical-align: top; width: 50%;">Scroll fraction of zoom panel viewport height<br></td>
      <td style="width: 30%;">0.10 (default)</td>
    </tr>
  </tbody>
</table>
