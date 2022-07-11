# Minimal Customization
Almost all properties have a default value that can be used. However, there are a 
number of properties that *have to* be customized per Regional Seismic Network.
<mark>These are typically specified in the main jiggle.props properties file.</mark>
These properties can set either by hand-editing the user's properties file in the user's directory
or by using the Jiggle application's menubar Properties dialog.

* local network code
* database connection properties
* hypoinverse location server properties
* waveserver properties

## Default Authoritative Network

**Table 1**: Specifying the default authoritative network code

| Parameter | Description | Default Value |
|-----------|-------------|---------------|
| authNetCodes | List of 2-char network codes used for local vs regional event type test | ?? (for most RSN's set to the same as localNetCode) |
| localNetCode | Default Network code (default is EnvironmentInfo.class setting)   | ?? |

It is also possible to set (or reset) the network code via
<b>Properties</b> &rarr; <b>Edit properties</b> &rarr; <b>Misc</b> from the top menu bar.
![Miscellaneous](img/DPMisc.png)

## Database Connection Properties

Jiggle was intially only able to connect to Oracle databases, and will use
default values for some database parameters if they are not explicitly specified
in the properties file. For Jiggle to work correctly with PostgreSQL it
is important to explicitely specify the dbaseDriver
(org.postgreSQL.Driver), dbaseSubprotocol (postgresql), and the dbasePort.
See Table 1 below for the parameters that need to be set in your Jiggle
properties file to successfully connect to an Oracle or PostgreSQL AQMS database.

**Table 2**: Jiggle database connection properties

| Parameter | Description | AQMS Oracle | AQMS PostgreSQL |
|-----------|-------------|--------|------------|
| jasiObjectType | schema type | TRINET (optional, default=TRINET) | TRINET (optional, default=TRINET) |
| useLoginDialog | show dialog box for user to log in when set to true | optional (default=false) | optional (default=false)
| dbaseHost | hostname | **required** | **required** |
| dbaseDomain | domain name, e.g. ess.washington.edu | optional | optional |
| dbaseName | database name, e.g. archdb | **required** | **required** |
| dbasePort | database server port number |optional (default=1521)| **required** |
| dbaseDriver | name of JDBC database driver | **required: *oracle.jdbc.driver.OracleDriver*** | **required: *org.postgreSQL.Driver*** |
| dbaseUser  | database user with read/write/execute privileges for full functionality | **required** | **required** |
| dbasePasswd | database password of database user |  **required** | **required** |
| dbaseSubprotocol  | type of JDBC subprotocol | optional (default is *oracle:thin*, other option is *oracle:oci* if the server where you run Jiggle has Oracle libraries on it) | **required: *postgresql*** |
| dbaseTNSName | usually the same as dbaseName, should match TNSNames.ora entry when using *oracle:oci* subprotocol | optional (required when using *oracle:oci*) | optional |
| dbLastLoginURL | is updated automatically | optional | optional |
| dbAttributionEnabled | Jiggle user name saved in database when set to true | optional (default=true)| optional (default=true) |
| dbWriteBackEnabled | Jiggle will write and commit changes to the database when set to true, read-only when not | optional (default=true) | optional (default=true) |
| debugSQL | verbose SQL output to screen or logfile when set to true| optional (default=false) | optional (default=false) |
| debugCommit | verbose messages regarding commit status when set to true | optional (default=false) | optional (default=false) |

### Changing Data Source via the GUI
It is also possible to set (or reset) the database connection parameters via
the "<b>Properties</b> &rarr; <b>Edit properties</b> &rarr; <b>Event
DataSource</b>" from the top menu bar (see screenshot below). For PostgreSQL
systems it is important to specify all required settings. dbWriteBackEnabled and dbAttributionEnabled can be edited via the <b>DB Save</b> menu item.

![Screenshot](img/properties_event_datasource.png)

## Hypoinverse Location Server Properties

Jiggle itself does not actually run an earthquake locator, instead it passes phase information to 
an AQMS Solution Server, aka "solservers". The solution servers that are available need to be listed
in the Jiggle properties file.
Using the 'Location Server' preferences tab configure the HYP2000 location server setup,
the name the selected server to use:
locationServerSelected=ls2
and in this configure a list of HYP2000 location servers, specified by the abstraction:
      'servername+type+timeoutmillis+ip_address:port'
A properties file example specifying 3 services is shown below:
locationServerGroupList=/ls1+HYP2000+40000+locserver.gps.caltech.edu\\:6501\\ 
                        /ls2+HYP2000+40000+locserver.gps.caltech.edu\\:6502\\ 
                        /ls3+HYP2000+40000+locserver.gps.caltech.edu\\:6503

**Table 3**: Hypoinverse Location Server Properties

| Parameter | Description | Default |
|-----------|-------------|---------|
| locationEngine | location engine class | org.trinet.util.locationengines.LocationEngineHypoInverse (default)
| locationEngineAddress | Location engine URL | bogus.gps.caltech.edu (default) |
| locationEnginePRT | Dump HYP2000 PRT style output text to message tabpane | true (default) |
| locationEnginePort | Solution server port number | 6650 (default) |
| locationEngineTimeoutMillis | Timeout in milliseconds | 5000 (default) |
| locationEngineType | Location engine type | HYPO2000 (default) |
| locationServerSelected | Name of selected location server in the server group list | default | 
| locationServerGroupList | List of location server configurations format /name+type+timeout+ipaddress:port ("\" at EOL continues property string value to next line) | /std1+HYP2000+20000+loc1.cit.edu\:6501\ /std2+HYP2000+20000+loc2.cit.edu\:6502 (default is named default with specified locationEngine properties) |
| unfixEqDepth | if true and event is eq depth is fixed, unfix depth when using trial depth | false (default) |
| useCalcOriginDatum | For H,T hypoinverse models usage only, when setting fix depth, if true, calculate a datum from closest arrivals and set geoid depth to depth-datum ; otherwise geoid depth is set to fix depth | false (default) |
| useTrialLocation | On relocation, use the current location as the trial start | false (default)|
| useTrialOriginTime | On relocation, use the current origintime as the trial start | false (default) |
| useEventPreforTable | update the preferred origin of type when the database has an EVENTPREFOR table | false (default) |

![location_engine](img/properties_location_server.png)

Using the 'Velocity Model' preferences tab configure a flat layer velocity model used to predict phase times.
An example of the velocity model properties syntax is shown below:
velocityModel.DEFAULT.modelName=my_model
velocityModel.my_model.depths=0.0 5.5 16. 32.
velocityModel.my_model.psRatio=1.73
velocityModel.my_model.velocities=5.5 6.3 6.7 7.8
velocityModelList=my_model

## Waveform Data Source Properties

Jiggle can get waveforms via the database (waveforms archived by the AQMS waveform archiver)  or via a Proxy Wave Server (wave server). The latter can be used when the request card generator missed channels, or cut out the wrong event time window. Or if you are dealing with a subnet trigger and want to pick more channels than are available in the original trigger.

Using the 'Wave Datasource' preferences tab configure your selected realtime waveserver group name:
currentWaveServerGroup=rts1
Then define the list of servers specified by :
   groupname+maxRetries+maxTimeoutMilliSecs+verifyWaveforms+truncateAtTimeGap
followed by a list of services of the form 'ip_address:port'
A properties file example is shown below for two groups with two services:
rapid waveserver on port 6500 and a disk waveserver on port 6501

waveServerGroupList=/rts1+1+0+false+false+rt1.gps.caltech.edu\\:6500+rt1.gps.caltech.edu\\:6501\\ 
                    /rts2+1+0+false+false+rt2.gps.caltech.edu\\:6500+rt2.gps.caltech.edu\\:6501


| Parameter | Description | Example Value |
|-----------|-------------|---------------|
| waveServerGroupList | List of waveserver groups (default is none) | rts+1+0+false+false+w1.cit.edu\:6509+w2.cit.edu\:6509 |
|currentWaveServerGroup | Wave server group currently in use | rts (default is none)|
| waveServerConnectTimeout | a new client connection timeout millisecs | 10000 (default) |
| waveServerGroupDefaultClient | Name of java class that implements WaveClient API | org.trinet.waveserver.rt.WaveClientNew (default) |
| waveServerPopupOnAddServerError | Popup alert message when unable to connect to a waveserver client | false (default)|
| waveformReadMode | Where waveforms should be read from: 0 = datasource, 1= waveserver | 0 (default)|

