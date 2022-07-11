# Getting Started with Jiggle

This section of the guide summarizes the typical post-processing workflow for
improving a single event solution within Jiggle.  This section is simply a
general overview and intended to provide a first introduction to the GUI; 
please refer to the individual pages about each main Jiggle tab view
for a thorough reference.

<!--
1. [Start Jiggle and load catalog view](#step-1-startup)
2. [Load single event from database (Catalog View)](#step-2-load-single-event-from-database-catalog-view)
3. [Modify picks and amplitudes on event waveform channels (Waveform
View)](#step-3-modify-picks-and-amplitudes-on-event-waveform-channels-waveform-view)
4. [Recalculate event location and origin time (Location
View)](#step-4-recalculate-event-location-and-origin-time-location-view) 
5. [Recalculate event magnitude (Magnitude
View)](#step-5-recalculate-event-magnitude-magnitude-view)
6. [Save and finalize improved earthquake solution to
database](#step-6-save-and-finalize-improved-earthquake-solution-to-database)
7. [Preview and load next event to process](#step-7-preview-and-load-next-event-to-process)
-->

## Jiggle GUI Five Main Views

Jiggle has five main "tab" views. In the screenshot below, the <span style="color:red">Tab
views</span> navigation icons are labeled. From left to right, the tab views can be accessed by either clicking on
the appropriate Tab view icon (below) or pressing a key (all keys below are
capital letters, so the Shift key must be held down):

1. [Location View](../locationview)&nbsp;&nbsp;![locate](img/locate.gif), or
press '<b>L</b>', to review and refine location estimates.
2. [Magnitude
View](../magnitudeview)&nbsp;&nbsp;![mini-m-blk-script](img/mini-m-blk-script.gif),
or press '<b>M</b>', to review and refine magnitude estimates.
3. Message View&nbsp;&nbsp;![file](img/file.gif), or press '<b>T</b>', for displaying miscellaneous information.
4. [Catalog
View](../catalogview)&nbsp;&nbsp;![mini-zagscroll](img/mini-zagscroll.gif), or
press '<b>C</b>', for showing event catalog.
5. [Waveform View](../waveformview)&nbsp;&nbsp;![sinewave2](img/sinewave2.gif),
or press '<b>W</b>', for picking arrival times, amplitudes, and codas.

![Figure](img/Jiggle_Production_Example2_CatalogViewS.png)

The Jiggle GUI is currently in the [Catalog View](../catalogview) (the
![mini-zagscroll](img/mini-zagscroll.gif) icon tab has a gray background).  The
icons in the "<span style="color:red">Catalog view actions</span>" red box under
the "<span style="color:red">Tab views</span>" icons are specific to the Catalog
View, and are not found in the other 4 tab views.  See the [Catalog
View](../catalogview) section for a full description of the possible "<span
style="color:red">Catalog view actions</span>"; some of these actions apply only
to the selected catalog event (white row with event ID 38466968 in the
screenshot).

Some Jiggle GUI elements are seen in all 5 tab views.  The GUI has a "<span
style="color:red">Menu bar</span>" (<b>File</b>, <b>View</b>, ... , <b>Help</b>
in the red box) at the top to take various actions, a toolbar row of icons just
under the menu bar (starting with the "<span style="color:red">Map</span>" red
box), and a "<span style="color:red">Status bar</span>" in the red box at the
bottom right with database information. 

## Step 1, start Jiggle and load catalog view

Let's run Jiggle from the command line, with input parameters from
`jiggle_waves.props`:

    $ ./run_jiggle.sh ../prop/jiggle_waves.props

<br>
The "<b>Event Selection Properties</b>" dialog box (below) appears.  The "<b>User</b>"
input properties file status should be "<b>exists: true</b>".  It is ok if the
"<b>Default</b>" properties files has "<b>exists: false</b>". Click the <b>OK</b>
button.

<p align="center">
<img src="../img/event_selection.png" width="500" align="middle">
</p>

<br>
Next, the "<b>Database Connection Info</b>" dialog box (below) appears.  These
values are pre-populated by the [properties files](../properties). They are
required to connect to the Oracle or Postgres database containing earthquake
information through the JDBC API. SCSN-specific inputs are shown below: the name
of the server hosting the database is `blanchard.gps.caltech.edu`, and the database
name is `archdbe`.  The JDBC connection is through a 4-digit port number, which
should replace the `PORT` placeholder.  Database credentials would be indicated
next to "<b>User:</b>", where the username would replace the `USERNAME`
placeholder, and the password next to "<b>Password:</b>". Click the <b>OK</b>
button to proceed.

<p align="center">
<img src="../img/db_connection.png" width="500" height="250" align="middle">
</p>

<br>
Jiggle connects to the database, retrieves earthquake event data from it, and
displays the catalog in tabular form (screenshot below). Which events are shown is controlled
by the properties in the eventSelection.props file. The columns of the catalog, as well as the
colors of the catalog rows can be customized by changing property values. The first catalog view example 
is from SCSN and is described in more detail below. The second catalog view is from PNSN and has a 
color scheme based on the geographic type instead of event review status.

*  No events have been loaded yet, so many of the icons in the top row of the
   GUI, as well as the “Event” in the menu bar, are grayed out and inaccessible.
   In the <span style="color:red">Status bar</span> (lower right corner), the
   event-specific statistics all have zero values.
    *  The third entry in the <span style="color:red">Status bar</span> shows
       the database name @ server name (e.g. <b>archdbe@blanchard</b>).
*  The number of events (rows) displayed is shown in the bottom left corner
   ("<span style="color:red">Table has 157 rows</span>").
*  Events in the "<span style="background-color:#ADFF2F">green</span>" rows have
   been inspected and finalized by human analysts. These have a value of
   "<b>F</b>" in the "<span style="color:red">ST</span>" column.
*  Events in the "<span style="background-color:yellow">yellow</span>" rows have
   been accepted for further review by analysts. These have a value of "<b>H</b>"
   in the "<span style="color:red">ST</span>" column.
*  Events in the "<span style="background-color:plum">pink</span>" rows are
   automatic solutions that have not yet been checked by analysts. These have a
   value of "<b>A</b>" in the "<span style="color:red">ST</span>" column.
![Figure](img/Jiggle_Production_Example2_CatalogViewS.png)
![Figure](img/PNSN_catalog_view.png)

See the [Catalog View](../catalogview) section for further details.

<br>
Clicking on the <span style="color:red">Map</span> icon
![Image](img/greenGlobe.gif) in the catalog view above will open a new window
with locations of catalog events from the database (cyan circles sized by
magnitude) in map view (below).  The map also displays locations of seismic stations
(light green triangles), cities (red squares with green lettering), historic
earthquakes (red stars), quarries (purple X's), and faults (orange lines), which
are are each a separate map layer that can be toggled on and off.  Pan and zoom
in/out are possible.  As with the catalog view, colors and other features of the map
can be customized.  See the [Map Layer View](../maplayerview) section for more
detail about viewing catalog events on the map.

![Figure](img/Map_37536154.png)

<br>

## Step 2: Load single event from database (Catalog View)

In the screenshot in the [Jiggle GUI Five Main Views](#jiggle-gui-five-main-views)
section, many of the icons in the top toolbar row of the GUI, as well as the
"<b>Event</b>" in the "<span style="color:red">Menu bar</span>", are currently
grayed out and inaccessible, because an event has not yet been selected and
loaded into Jiggle.  To activate these icons, we need to select and load a
specific event (row in the table) by taking one of the following actions:

*  In Catalog View, double-click on the event row 
*  In Catalog View, select the event row (highlighted in white) and click the
   green arrow &nbsp;![inputarrowsmall](img/inputarrowsmall.gif)&nbsp;
   (right-most icon in "<span style="color:red">Catalog view actions</span>")  
*  In Catalog View, select the event row (highlighted in white), right-click to
   open a popup menu, and click on "<b>Load</b>"
*  In Catalog View, select the event row (highlighted in white) and click on
   "<span style="color:red">Menu bar</span>": <b>File</b> &rarr; <b>Open Catalog
   Selection</b>
*  In Map Layer View, double-click on the event location (cyan circle)
*  In "<span style="color:red">Menu bar</span>": <b>File</b> &rarr; <b>Open
   event by id...</b>, type in 8-digit event ID number (e.g. 37536154) 

<br>
The screenshot below shows the Jiggle GUI, still in [Catalog
View](../catalogview), after an earthquake event (with ID 37536154) has been
selected and loaded.  The event ID 37536154 next to an orange square now appears
in the "<b>Selected Solution</b>" box.  Information for the loaded event also
appears in the title bar.  Most of the icons in the top row of the GUI including
those in the "<span style="color:red">Event Editing</span>" box, as well as the
"<b>Event</b>" in the "<span style="color:red">Menu bar</span>", are now
accessible. The <span style="color:red">Status bar</span> (lower right corner)
now displays statistics for this event.

![Figure](img/Jiggle_Production_Example3_EventLoadedS.png)

<br>
Clicking on the "<span style="color:red">Gazetteer</span>" icon &nbsp;
![Figure](img/question_blue.gif) &nbsp; in the top toolbar displays the distance
and direction from the loaded event (ID 37536154) to nearby cities and other
locations of interest (screenshot below).

<p align="center">
<img src="../img/gazetteer_37536154.png" width="500" height="250" align="middle">
</p>

<br>
In the [Map Layer View](../maplayerview) (screenshot below), a pink arrow points
to the location of the loaded event, and the information for the loaded event
with ID 37536154 appears in the title bar.

![Figure](img/Map_37536154.png)


## Step 3: Modify picks and amplitudes on event waveform channels (Waveform View)

The [Waveform View](../waveformview) can then be selected to view waveforms for
the loaded earthquake event (ID 37536154, seen in the "<b>Selected Solution</b>"
box).  Notice that the Waveform View ![sinewave2](img/sinewave2.gif) icon now is
highlighted with a blue background within the "<span style="color:red">Tab views
</span>" red box.  The "<span style="color:red">Status bar</span>" (red box,
bottom right) shows statistics for this loaded event: 3738 channels at 660
stations, 30 arrival time picks, 62 peak amplitudes (amps), and 0 coda estimates. 

![Figure](img/Jiggle_Production_WaveformViewS.png)

Various categories of tools available only in the Waveform View are grouped into
red boxes within the screenshot:

*  <span style="color:red">Time zoom</span>
*  <span style="color:red">Pick tools</span>
*  <span style="color:red">Amplitude zoom</span>
*  <span style="color:red">Filter single channel</span>
*  <span style="color:red">Triaxial display</span>
*  <span style="color:red">Manual time zoom</span>
*  <span style="color:red">Waveform scroll and selection</span>
*  <span style="color:red">Filter all waveforms</span>

Icons in the main toolbar for relevant actions within the Waveform View are also
grouped into red boxes within the screenshot:

*  <span style="color:red">New event</span>
*  <span style="color:red">Waveform views</span>
*  <span style="color:red">Auto-picker</span>
*  <span style="color:red">Show only certain waveforms</span>
*  [Scope Mode](../scopemode)

The channels are read in from a cache file for faster loading, which is
refreshed every time Jiggle starts up (click the <b>YES</b> button in the
screenshot below to reload the channel list). (TODO check for accuracy)

<p align="center">
<img src="../img/cache_refresh.png" width="400" height="20" align="middle">
</p>

The "<span style="color:red">All event waveforms</span>" bottom window in the
Waveform View screenshot displays the 3-minute-duration event waveforms for all
3738 channels at 660 seismic stations, ordered by increasing distance from the
event location to each station.  To view waveforms from all of the channels, use
the scrollbar or the tools in the "<span style="color:red">Waveform scroll and
selection</span>" red box.  Waveforms from some channels may not always appear
due to gaps in the data.  The event waveforms can be read from a database
containing either triggered or continuous waveforms.

Each waveform is named with the `${NETWORK}.${STATION}.${CHANNEL}` convention,
e.g. for `CI.TUQ.HHZ`, the network code is `CI`, the station name is `TUQ`, and
the channel name is `HHZ`.  See the [Station Naming Convention SCSN Wiki
Page](http://scsnwiki.gps.caltech.edu/doku.php?id=stations:station_naming) or
[SCEDC SEED Channel Descriptions](http://scedc.caltech.edu/station/seed.html)
for more details.

A single station usually has multiple channels, which can record the ground
motion from the earthquake in three different directions:

*  `HHZ`: vertical
*  `HHN`: horizontal, north-south
*  `HHE`: horizontal, east-west

In addition, a single station usually has differences in sampling rate,
frequency range, or gain, which are reflected in different colors for the
waveforms in the Waveform View.

*  `HHZ`, `HHN`, `HHE`: high sample-rate broadband (black)
*  `HNZ`, `HNN`, `HNE`: high sample-rate accelerometer (<span
   style="color:olive">olive</span>)
*  `BHZ`, `BHN`, `BHE`: low sample-rate broadband (<span
   style="color:DarkCyan">cyan</span>)
*  `EHZ`: extremely short period (<span style="color:blue">blue</span>)

The "<span style="color:red">Single channel event waveform</span>" top window in
Waveform View shows a waveform from one channel at a time.  In the "<span 
style="color:red">All event waveforms</span>" window, the selected channel
`CI.TUQ.HHZ` is shown as a <span style="background-color:LightSkyBlue">light
blue</span> row, and the <span style="background-color:yellow">yellow box</span>
indicates the section of the waveform displayed in the "<span style="color:red">
Single channel event waveform</span>" window.  The tools in the "<span
style="color:red">Time zoom</span>" and "<span style="color:red">Manual time
zoom</span>" red boxes allow zooming in and out along the time axis for this
channel, while the tools in the "<span style="color:red">Amplitude zoom</span>
red box allow zooming in and out in the amplitude dimension; the <span
style="background-color:yellow">yellow box</span> changes shape accordingly. 

The Waveform View also provides an alternative triaxial view (TODO place link),
which displays 3 channels of event waveforms (vertical, north-south, east-west)
at a time, all from the same station.  In the "<span style="color:red">All event
waveforms</span>" window, this can be accomplished with the "<span
style="color:red">Waveform views</span>" tools (red box in the main toolbar),
but requires several setup steps (TODO place link).  In the "<span
style="color:red">Single channel event waveform</span>" window, the "<span
style="color:red">Triaxial display</span>"
![mini-triaxialgray](img/mini-triaxialgray.png) tool overlays these 3 channels
on top of each other.

Users can apply different types of filters (e.g. bandpass, highpass, lowpass) to
the event waveforms. The "<span style="color:red">Filter all waveforms</span>"
![filter_yellow](img/filter_yellow.gif) tool in the bottom right corner applies
the selected filter to all channels in the "<span style="color:red">All event
waveforms</span>" window.  The "<span style="color:red">Filter single
channel</span>" ![filter_yellow](img/filter_yellow.gif) tool filters only the
data in the "<span style="color:red">Single channel event waveform</span>"
window.

Within the Waveform View, users can modify arrival time picks (e.g. <span
style="background-color:red"><b>iPc0</b></span>, <span
style="background-color:magenta"><b>eS 2</b></span>), and peak amplitude
estimates, often called "amps" (small orange triangles on HHN and HHE channels),
to improve their quality.  Changing the picks will change the earthquake origin
(location and origin time), and changing the amps will change the earthquake
magnitude.

*  These picks and amps, initially obtained from the AQMS real-time (RT) system,
   are loaded from the database. The "<span style="color:red">Status bar</span>"
   (bottom right) shows a total of 30 arrival picks and 62 amps.
*  The "<span style="color:red">Show only certain waveforms</span>" tools (red
   box, top right) displays only the waveforms with an existing pick (P) or amp
   (A) in the "<span style="color:red">All event waveforms</span>" window (TODO:
   explain C).
*  <span style="background-color:LightGreen">Green vertical bars</span> in the
   "<span style="color:red">Single channel event waveform</span>" and "<span
   style="color:red">All event waveforms</span>" windows indicate approximate
   expected P (earlier) and S (later) arrival times at each station. If the
   actual phase picks deviate significantly from the green bars, then the event
   is mislocated.
*  The "<span style="color:red">Auto-picker</span>" ![autopick](img/autopick.png)
   in the tool bar can be used to automatically pick P and S arrival times.
   Parameters for the Auto-picker are in the `pickEW.props` [properties
   file](../properties).
*  Users can also manually pick arrivals within the "<span
   style="color:red">Single channel event waveform</span>" window using the
   "<span style="color:red">Pick tools</span>", aided by the zoom features.
   Users can add new manual picks at channels on stations without picks, and
   delete poor quality automatic picks.
*  Picking is usually done on channels with higher sample rate; P phases are
   usually picked on the vertical channel and S phases on the horizontal
   channels.
*  Picking is done on stations out to a distance of about 120 km; further
   stations are probably too noisy to reliably determine picks.
*  Amps determined by the RT system can be rejected if manual inspection shows
   that they are incorrect.
*  Right-click in either the "<span style="color:red">All event
   waveforms</span>" or "<span style="color:red">Single channel event
   waveform</span>" window to bring up a menu with many options.

Sometimes the "<span style="color:red">All event waveforms</span>" window might
show two (or more) earthquake waveforms, which happened close together in time,
for a single catalog event. In this case, one can use the "<span
style="color:red">New event</span>" ![new-blue](img/new-blue.gif) tool to clone
the waveforms from the catalog event into a new event (TODO link).  Then users
can pick arrivals and estimate amplitudes on the second event waveform (that was
originally not in the catalog), determine its origin and magnitude, and save it
to the database.

In addition to viewing event waveform data, users can also view continuous
seismic waveform data within Jiggle by turning on [Scope mode](../scopemode)
![oscilloscope](img/oscilloscope.gif).


## Step 4: Recalculate event location and origin time (Location View)

The [Location View](../locationview) can be selected to view the origin
(location and origin time) information for the loaded earthquake event (with ID
37536154, "<b>Selected Solution</b>" box).  Notice that the Location View
![locate](img/locate.gif) icon now is highlighted with a gray background within
the "<span style="color:red">Tab views</span>" red box.

![Figure](img/Jiggle_Production_LocationViewS.png)

The event origin is calculated using the
[HYPOINVERSE](https://www.usgs.gov/software/hypoinverse-earthquake-location)
earthquake location program.  At the SCSN, HYPOINVERSE runs on a separate
server, called the "solution server" or "solserver".  HYPOINVERSE uses the P and
S arrival time picks at different stations, along with a 1D flat-layer velocity
model, to solve for the best-fit event origin (latitude, longitude, depth,
origin time). The SCSN uses the <kbd>HK_SOCAL</kbd> velocity model (<i>Hadley
and Kanamori, 1977</i>), available as Table 5 in [(<i>Hutton et al.,
2010</i>)](http://scedc.caltech.edu/about/BSSA_2010_Hutton_SCSN_cat.pdf).

*  Initially, users see the event origin calculated by HYPOINVERSE using picks
   from the RT AQMS system as input.
*  The yellow window with "<span style="color:red">Event origin
   solutions</span>" contains the event origin (location and origin time) and
   other parameters output from running HYPOINVERSE.
*  The "<span style="color:red">Pick information</span>" window shows the picks
   on each channel that were used to calculate the event origin.
*  Clicking the "<span style="color:red">Calculate Location</span>"
   ![bullseye](img/bullseye.gif) tool runs HYPOINVERSE again, this time using
   improved (automatic and/or manual) pick estimates from the [Waveform
   View](../waveformview) for this event.


## Step 5: Recalculate event magnitude (Magnitude View)

The [Magnitude View](../magnitudeview) can be selected to view the magnitude
information for the loaded earthquake event (with ID 37536154, "<b>Selected
Solution</b>" box).  Notice that the Magnitude View 
![mini-m](img/mini-m-blk-script.gif) icon now is highlighted with a gray
background within the "<span style="color:red">Tab views</span>" red box.

![Figure](img/Jiggle_Production_MagnitudeViewS.png)

Magnitudes depend on peak amplitude estimates that were initially determined by
AQMS RT, but can be modified in the [Waveform View](../waveformview) (small
orange triangles) for the loaded event.  Magnitudes also depend indirectly on
the event location, since the distance from the event to each station with an
amplitude estimate is used to calibrate the magnitude; therefore, after
recalculating the event location with HYPOINVERSE, magnitude should also be
updated.

There are different algorithms for calculating the magnitude of an earthquake in
Jiggle, which can be done with the "<span style="color:red">Calculate
Magnitude</span>" ![mini-m](img/mini-m.gif) ![pm-script](img/pm-script.gif)
tools: 

*  M<sub>L</sub>: Local magnitude
    *  Generally used as "prefmag" (preferred magnitude) for small (M < 3) local
       earthquakes?
    *  Calculated with the peak amplitude on the horizontal (north-south,
       east-west) channels, and amplitudes are calibrated to magnitude by using
       the distance from event to each station.
*  M<sub>d</sub>: Duration magnitude
    *  TODO: when/how used?  Generally used for small earthquakes.
    *  Calculated using the time duration of the coda after the S-wave.

Jiggle currently does not have functionality to calculate the following
magnitude types, which are commonly used for larger (M > 6) earthquakes.  These
types may be visible in the database, as they might be imported from AQMS RT or
from other seismic networks.

*  M<sub>e</sub>: Energy magnitude
    *  First available magnitude for large (M > 6) earthquakes, before
       M<sub>w</sub>
*  M<sub>w</sub>: Moment magnitude
    *  Most reliable magnitude estimate for large (M > 6) earthquakes
    *  Reflects dimensions of the earthquake, without saturating for the largest
       earthquakes.
    *  Calculated with a moment tensor fit.
*  M<sub>h</sub>: Human-edited magnitude
    *  This magnitude type can be set in DRP
    *  Usually seen for exotic events (e.g. chemical blast)
    *  Sometimes saved as "Intermediate" processing state events, flagged for
       further analysis later
*  M<sub>un</sub>: Unknown magnitude
    *  Usually seen for regional or teleseismic earthquakes outside network
       boundaries, with catalog solution imported from other networks

The "<span style="color:red">Magnitude type views</span>" tabs, available only
within the Magnitude View, allow toggling between these different magnitude
estimates.  In the screenshot above, only M<sub>L</sub> is available for event
ID 37536154, but additional entries for other magnitude types (e.g.
M<sub>d</sub>, M<sub>e</sub>) are possible.  One of these magnitude types should
be set as the preferred type, which will then appear as "EVENT PREFERRED" in the
top left corner within the selected Magnitude type view.

In each Magnitude type view, the yellow window with "<span
style="color:red">Event magnitude solution</span>" contains the event magnitude
and other relevant parameters, while the "<span style="color:red">Amp
information</span>" window shows the peak amplitude estimates on each channel
that were used to calculate the event magnitude.


## Step 6: Save and finalize improved earthquake solution to database

At this point, the user has manually inspected picks and amps on event
waveforms, and calculated an improved event origin (location and origin
time) and magnitude within Jiggle.  In order to save this improved solution to
the database, click on the "Save event" ![save](img/save.gif) tool. 

In the Catalog View (screenshot below), the saved event appears as an <span
style="background-color:gold">orange row</span>, the "<span
style="color:red">ST</span>" column has the letter "<b>I</b>" indicating
that the intermediate solution was saved, the "<span
style="color:red">SRC</span>" column says "<b>Jiggle</b>" indicating that the
solution was modified within Jiggle, and the "<span
style="color:red">OWHO</span>" column has the string "<b>cyoon</b>" indicating
the name of the user who changed the solution.

![Figure](img/70267551_example_save.png)

To permanently save the improved solution to the database, without allowing any
further edits, the user can finalize the event solution within the database by
clicking on the "Finalize event" ![finalize](img/gavel.gif) tool.

In the Catalog View (screenshot below), the finalized event appears as a <span
style="background-color:LightGreen">green row</span>, the "<span
style="color:red">ST</span>" column has the letter "<b>F</b>" indicating
that the solution was finalized, the "<span style="color:red">SRC</span>" column
says "<b>Jiggle</b>" indicating that the solution was modified within Jiggle,
and the "<span style="color:red">OWHO</span>" column has the string
"<b>cyoon</b>" indicating the name of the user who changed the solution.

![Figure](img/70267551_example_finalize.png)

The [Database Actions](../databaseactions) section has more information about
how to save ![save](img/save.gif) or finalize ![finalize](img/gavel.gif) an
event.  This section also describes how to delete an event
![dynamite](img/dynamite.gif) that is not an earthquake, or to clone a new event
![new-blue](img/new-blue.gif) if an existing catalog event window has more than
one earthquake waveform.

## Step 7: Preview and load next event to process

At this time, the user can select and load the next event to process in Jiggle.
The user can choose to load the next event by following instructions in [Step
1](!#step-1-load-single-event-from-database-catalog-view), then repeat Steps
2-5. 

Alternatively, the user can preview the next event to load and process in
Jiggle. In the screenshot below, the current loaded event has ID <span
style="color:red">37536154</span> (red boxes, pink arrow with red text on map).
Users can click on another location in the map (white arrow) to display the ID
<span style="color:blue">37536154</span> (blue text and boxes) of the next event
to potentially select, which can be seen in the bottom status bar on the map,
and the row within the Catalog View highlighted in <span
style="color:red">red</span> on white background. The user can then repeat Steps
1-5 on the previewed event.

![Figure](img/Jiggle_Production_Preview_37536226_SS.png)

Another way to select the next event to load and process in Jiggle is to choose
the next event (next row down) in the table under Catalog View, clicking on the
"Next Event" ![forward](img/forward.gif) icon, then repeat Steps 2-5 on the
newly loaded event. The user can choose to sort the events within the catalog
table in a different order, according to different columns (more details in
[Catalog View](../catalogview)).

The user can also choose to close the current event ("<span
style="color:red">Menu bar</span>": <b>File</b> &rarr; <b>Close Event</b>), which
would return to the status in [Jiggle GUI Five Main Views](#jiggle-gui-five-main-views)
where no events are loaded.

## Jiggle Log Files

If property fileMessageLogging is set to true, for every Jiggle run, a log file is written to a 
`logs/` subdirectory in the props directory, named with the date and time that
Jiggle was started: `jiggle_YYYY-MM-DD(HHMMSS).log`.

These log files facilitate debugging for the Jiggle developer, but can take up
extra disk space.  Various "<kbd>debug</kbd>" and "<kbd>verbose</kbd>" flags in
the properties files can be set to increase the level of detailed logging (TODO
list these flags)

If autoDeleteOldLogs=false, on starting Jiggle, a dialog box pops up with the option to remove log files
older than 14 days (screenshot below). 

The length of time that the logfiles are retained can be changed from the default 14 days by setting the maxLogAgeDays property.

<p align="center">
<img src="../img/log_cleanup.png" width="300" height="100" align="middle">
</p>


## Exit Jiggle

To exit Jiggle, click "<b>File</b> &rarr; <b>Exit</b>" on the "<span
style="color:red">Menu bar</span>", and a dialog box asks to confirm if the user
really wants to exit (screenshot below).

<p align="center">
<img src="../img/exit_jiggle.png" width="300" height="100" align="middle">
</p>




