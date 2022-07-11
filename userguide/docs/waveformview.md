# Waveform View Introduction

First, users should read the [Step 2: Modify picks and amplitudes on event
waveform channels (Waveform
View)](../tabviews/#step-2-modify-picks-and-amplitudes-on-event-waveform-channels-waveform-view)
section for an introduction to the Waveform View with an event loaded into
Jiggle. The Waveform View screenshot from this section, with a loaded event, is
reproduced below.

![Figure](img/Jiggle_Production_WaveformViewS.png){ class="big-figure" }

If an event is not loaded into Jiggle, the Waveform View is empty (screenshot
below). 

![Figure](img/waveform_view_empty.png){ class="big-figure" }

TODO Section

Load waveforms for a single event – time series

"Selected Solution" with event ID snapshot

Sort by distance to each station / channel

For the SCSN, Waveforms are not only from the CI network, but are also imported from
neighboring networks such as AZ, NC, NN.

"Model..." menu

"Event..." menu

# Waveform Data Source

The event waveforms need to be read into Jiggle from a database, before
displaying them and picking phases/amps/codas in Waveform View. Different
settings need to be applied in Jiggle, depending on the following conditions:

*  Is the origin event type (<span style="color:red">ETYPE</span> in Catalog
   View) an [earthquake](../eventtypes/#earthquake-local) or
   [trigger](../eventtypes/#trigger)?
*  If the event is an [earthquake](../eventtypes/#earthquake-local), do we want
   to read in and display triggered waveforms or continuous waveforms in
   Waveform View?

## Waveform Data Source: Trigger

If <span style="color:red">ETYPE</span> is "trigger", then it is necessary to
select from the top menu bar: "<b>Model</b> &rarr; <b>Waveform
source/model...</b> &rarr; <b>WS Trigger</b>" (screenshot below) in order to
view the waveforms.  Notice that in the Status Bar in the bottom right corner,
the first box says "Trigger" and the second box says "pwsgibbes" which is the
source of the continuous waveforms that are displayed. 

![Figure](img/example_waveforms_WSTrigger_70293783.png){ class="big-figure" }

If the settings are different from the ones that are currently set, the dialog
boxes below will appear before the waveforms are displayed. First, Jiggle should
reload all data for the selected event from database tables (left). Second,
the event should be reloaded into Jiggle (right). Click "YES" to proceed in both
boxes.
<p align="center">
<img src="../img/channeltimewindow_Changed.png" width="340" height="250" align="middle">
<img src="../img/reload_event_70293783.png" width="340" height="250" align="middle">
</p>

An alternate, more time-consuming, way to selecting "<b>Model</b> &rarr; <b>Waveform
source/model...</b> &rarr; <b>WS Trigger</b>" to display "trigger" events is to
[edit the Jiggle properties](../properties/#modify-properties-within-jiggle).
From the top menu bar, select "<b>Properties</b> &rarr; <b>Load
properties...</b>".  

First go to the "<b>TimeWindow Model</b>" tab, select
"<b>Trigger</b>" for the "Model Name:" from the drop-down menu, and click the
"Set" button (screenshot below):
![Figure](img/Preferences_TimeWindowModel_Trigger.png){ class="big-figure" }

Next click the "<b>Wave DataSource</b>" tab, and select the "<b>WaveServer</b>"
button under the "Waveforms Read From" section, with the source of continuous
waveforms set as "pwsgibbes" (screenshot below).  These settings apply to the
SCSN; other RSNs would need to click the "Edit WaveServers" button to modify
their database settings, including the group name, server name, and port, and
test their database connection.
![Figure](img/Preferences_WaveDataSource_WaveServer.png){ class="big-figure" }

The dialog box with the following message may appear, go ahead and click "OK".
<p align="center">
<img src="../img/message_change_WaveTrigger.png" width="400" height="250" align="middle">
</p>

If the settings are different from the ones that are currently set, the dialog
boxes below will appear before the waveforms are displayed. Click "YES" to
proceed in both boxes.
<p align="center">
<img src="../img/channeltimewindow_wavesource_Changed.png" width="340" height="250" align="middle">
<img src="../img/reload_event_70293783.png" width="340" height="250" align="middle">
</p>

## Waveform Data Source: Earthquake with Continuous Waveforms

If <span style="color:red">ETYPE</span> is "earthquake", the user has an option
to read in either continuous or triggered waveforms from the database. (Recall
from the previous section that only continuous waveforms can be used to display
"trigger" event types in Jiggle.)

This section explains how to read continuous waveforms from the database near
the time of the earthquake, although this is not standard practice in the SCSN.

The easiest way is to select from the top menu bar: "<b>Model</b> &rarr; <b>Waveform
source/model...</b> &rarr; <b>WS Power Law</b>" (screenshot below) in order to
view the waveforms (for an example event with ID 38422815).  Notice that in the
Status Bar in the bottom right corner, the first box says "Power Law" and the
second box says "pwsgibbes" which is the source of the continuous waveforms that
are displayed. There are a total of 3743 channels from 659 stations, although
some channels (such as NP.5232.HNZ, PB.B081.HNZ, PB.B081.HN1, PB.B081.HN2) do
not have any waveform data available. 

![Figure](img/example_waveforms_WSPowerLaw_38422815.png){ class="big-figure" }

If the settings are different from the ones that are currently set, the dialog
boxes below will appear before the waveforms are displayed. First, Jiggle should
reload all data for the selected event from database tables (left). Second,
the event should be reloaded into Jiggle (right). Click "YES" to proceed in both
boxes.
<p align="center">
<img src="../img/channeltimewindow_Changed.png" width="340" height="250" align="middle">
<img src="../img/reload_event_38422815.png" width="340" height="250" align="middle">
</p>

An alternate, more time-consuming, way to selecting "<b>Model</b> &rarr; <b>Waveform
source/model...</b> &rarr; <b>WS Power Law</b>" to display "earthquake" events
with continuous waveforms is to [edit the Jiggle properties](../properties/#modify-properties-within-jiggle).
From the top menu bar, select "<b>Properties</b> &rarr; <b>Load properties...</b>".  

First go to the "<b>TimeWindow Model</b>" tab, select
"<b>PowerLaw</b>" for the "Model Name:" from the drop-down menu, and click the
"Set" button (screenshot below):
![Figure](img/Preferences_TimeWindowModel_PowerLaw.png){ class="big-figure" }

Next click the "<b>Wave DataSource</b>" tab, and select the "<b>WaveServer</b>"
button under the "Waveforms Read From" section, with the source of continuous
waveforms set as "pwsgibbes" (screenshot below).  These settings apply to the
SCSN; other RSNs would need to click the "Edit WaveServers" button to modify
their database settings, including the group name, server name, and port, and
test their database connection.
![Figure](img/Preferences_WaveDataSource_WaveServer.png){ class="big-figure" }

The dialog box with the following message may appear, go ahead and click "OK".
<p align="center">
<img src="../img/message_change_WavePowerLaw.png" width="400" height="250" align="middle">
</p>

If the settings are different from the ones that are currently set, the dialog
boxes below will appear before the waveforms are displayed. Click "YES" to
proceed in both boxes.
<p align="center">
<img src="../img/channeltimewindow_wavesource_Changed.png" width="340" height="250" align="middle">
<img src="../img/reload_event_38422815.png" width="340" height="250" align="middle">
</p>

## Waveform Data Source: Earthquake with Triggered Waveforms

If <span style="color:red">ETYPE</span> is "earthquake", the user has an option
to read in either continuous or triggered waveforms from the database.

This section explains how to read triggered waveforms from the database for this
earthquake.  Some seismic stations only record waveforms when they are triggered
by an earthquake signal above the threshold; these stations do not record
continuous waveform data.  

For "earthquake" events, SCSN standard practice is to read triggered waveforms
from the database into Jiggle Waveform View for picking phases.

The easiest way to read triggered waveforms for an "earthquake" event is to
select from the top menu bar: "<b>Model</b> &rarr; <b>Waveform
source/model...</b> &rarr; <b>DB Event</b>" (screenshot below) in order to
view the waveforms (for an example event with ID 38422815).  Notice that in the
Status Bar in the bottom right corner, the first box says "DataSource" and the
second box says "archdbe@blanchard" which is the source of the triggered
waveforms that are displayed (database name @ server name). There are a total of
2760 channels from 433 stations, which is different from the numbers for the
continuous waveforms (3743 channels from 659 stations).

![Figure](img/example_waveforms_DBevent_38422815.png){ class="big-figure" }

If the settings are different from the ones that are currently set, the dialog
boxes below will appear before the waveforms are displayed. First, Jiggle should
reload all data for the selected event from database tables (left). Second,
the event should be reloaded into Jiggle (right). Click "YES" to proceed in both
boxes.
<p align="center">
<img src="../img/channeltimewindow_Changed.png" width="340" height="250" align="middle">
<img src="../img/reload_event_38422815.png" width="340" height="250" align="middle">
</p>

An alternate, more time-consuming, way to selecting "<b>Model</b> &rarr; <b>Waveform
source/model...</b> &rarr; <b>DB Event</b>" to display "earthquake" events
with triggered waveforms is to [edit the Jiggle properties](../properties/#modify-properties-within-jiggle).
From the top menu bar, select "<b>Properties</b> &rarr; <b>Load properties...</b>".  

First go to the "<b>TimeWindow Model</b>" tab, select
"<b>DataSource</b>" for the "Model Name:" from the drop-down menu, and click the
"Set" button (screenshot below):
![Figure](img/Preferences_TimeWindowModel_DataSource.png){ class="big-figure" }

Next click the "<b>Wave DataSource</b>" tab, and select the "<b>Database</b>"
button under the "Waveforms Read From" section, with the "waveform archive copy"
value set to 1 (screenshot below).
![Figure](img/Preferences_WaveDataSource_Database.png){ class="big-figure" }

The dialog box with the following message may appear, go ahead and click "OK".
<p align="center">
<img src="../img/message_change_WaveDataSource.png" width="400" height="250" align="middle">
</p>

If the settings are different from the ones that are currently set, the dialog
boxes below will appear before the waveforms are displayed. Click "YES" to
proceed in both boxes.
<p align="center">
<img src="../img/channeltimewindow_wavesource_Changed.png" width="340" height="250" align="middle">
<img src="../img/reload_event_38422815.png" width="340" height="250" align="middle">
</p>

## Waveform Data Source: Other Options

TODO Explain all options under "<b>Model</b> &rarr; <b>Waveform source/model...</b>

## Waveform Data Source: Technical Information

Request Card Generator (RCG) determines which channel time windows (which
waveforms) to archive for an event, using a ChannelTimeWindowModel for the
distance at which an earthquake of a certain magnitude expects to have energy
above the noise level.  A waveform request is a time window for a single data
channel, which is written as a row in the database.  The actual waveforms are
retrieved and archived by another process, called the WaveArchiver (WA).  The
waveforms are retrieved from WaveServers, which are port-based services that
allow remote clients to request and retrieve chunks of waveform time-series.

SCSN Wiki Pages:

*   [RCG](http://scsnwiki.gps.caltech.edu/doku.php?id=postproc:requestgenerator:rcg)
*   [ChannelTimeWindowModel](http://scsnwiki.gps.caltech.edu/doku.php?id=postproc:channel_time_window_model)
*   [WaveArchiver](http://scsnwiki.gps.caltech.edu/doku.php?id=datacenter:wavearchiver)
*   [WaveServer](http://scsnwiki.gps.caltech.edu/doku.php?id=rtem:wave_servers)

AQMS Trac Pages (with more software details):

*   [RCG](https://vault.gps.caltech.edu/trac/cisn/wiki/javarcg_man)
*   [ChannelTimeWindowModel](https://vault.gps.caltech.edu/trac/cisn/wiki/jasi_time_window_models) 
*   [WaveArchiver](https://vault.gps.caltech.edu/trac/cisn/wiki/wa_man)

TODO Explain ChannelTimeWindowModel







# Waveform Viewing: Scroll, Zoom, Filter

TODO Section

Waveform snapshot, view/scroll

Default order by distance from event to station (exception: subnet triggers,
which show all stations within the subnet)

Display stations with waveforms on map
Picks/amps: stations colored red or orange (TODO figure this out)

Zoom in/out in time

Zoom in/out in amplitude

Apply filter

SCSN standard practice - do not filter before picking, unless the event is
really small and filtering is required to properly pick arrivals.

SWARM frame - frequencies

# Phase Picking: Arrival Times

TODO Section

P and S, how many, how far?

Pick Description: 4 characters

*  TODO use hotkeys
*  1) impulsive (i) or emergent (e)?  Example screenshots
*  2) type of phase: compressional (P) or transverse (S)?  Example screenshots
*  3) first motion polarity - compression (c) or dilatation (d)?  This can be
   left blank if the polarity is not obvious.  c is first motion up, d is first
   motion down.
*  4) Pick quality weight (USGS Standard). Options: 0,1,2,3,4. 0 is best, 4 is worst. 
    *  Pick quality 0: Full weight of 1. On the obviously correct sample and has
       a significant rise (very impulsive arrival).
    *  Pick quality 1: 3/4 weight.  Not certain of the exact sample to place the
       pick, but has impulsive arrival.
    *  Pick quality 2: 1/2 weight. Reasonably certain which half wave the
       arrival starts on.  Arrival is emergent, not impulsive.  
    *  Pick quality 3: 1/4 weight.  Not certain where to place the pick, but the
       pick is necessary for a good location (e.g. it closes an azimuth gap).
       Arrival is definitely emergent.
    *  Pick quality 4: Weight is 0. Pick quality is very poor, so it is not used
       for location, but the pick may be used for magnitude calculation.
*  The first and last pick characters are linked.  i0,i1,e2,e3,e4.  Must have an
   impulsive arrival to have a pick quality of 0 or 1.  See hotkeys.
*  TODO what are weights for trigger? wP.4
*  TODO what do the stars before picks mean?

Picks from AQMS RT -> used to get initial RT location with Earthworm

Expected P and S arrival times (green)

Each station (not channel) should have no more than one P and one S pick.

All automatic picks from RT AQMS must be inspected.  The automatic pick must be
within one or two samples (for HH channels) of the correct time, so that the
first motion is correct. 

Any picks retained or inserted on BH or other low data rate channels must be on
the correct sample & be assigned a weight lower than 0. 

Correct automatic picks occur after the beginning of the seismic energy by at
least one sample, sometimes two samples for high sample rate stations.

Auto-picker in Jiggle

Manual picks - should go on the last sample that contains no earthquake energy.

Explain how to do manual pick in Jiggle

Picks have changed -> location will change

View only channels with picks (P)

*   ‘P’ show only waveforms with picks -> good way to delete bad picks at faraway stations

Which channels used for picks?  Each pick should be on the channel that shows
the phase most clearly & accurately.  Generally this will be the vertical
channel (HHZ) for the P pick, and a horizontal channel (either HHN or HHE) for
the S pick, although there may be exceptions.

Distance 120 km limit? - beyond that, location not likely to change much, at
least for SCSN which has a large network

Analyst preferences - some will keep RT picks, others will delete all RT picks
and use combination of Jiggle auto-picker with manual picks.  Different settings
in properties files as well.

First motions are saved for later use in focal mechanism calculation (TODO which
software does this? - not done in Jiggle)  This is generally done for events with M > 3 inside the
network, or M > 2.5 if a significant number of first motions are available.

# Amps: Peak Amplitudes

TODO Section

View only channels with amps (A)

Amps have changed -> magnitude will change

Which channels used for amps?

Automatic amp selection (solid orange triangles) from RT

Reject amps (hollow orange triangles) - how and why?

# Coda

View only channels with coda measures? (C)
