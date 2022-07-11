# Catalog View Introduction

Jiggle connects to a relational database (Oracle or Postgres), retrieves
earthquake event data from it, and displays the event catalog from the last 72
hours as a table, in Catalog View.

First, users should read over the [Getting Started with Jiggle: Database
Connection, Events in Catalog and
Map](../tabviews/#getting-started-with-jiggle-database-connection-events-in-catalog-and-map)
and [Jiggle GUI 5 Tab Views](../tabviews/#jiggle-gui-5-tab-views) sections for
an overview of the Catalog View without any events loaded into Jiggle. The
Catalog View screenshots from these sections, without any loaded events, is
reproduced below.
![Figure](img/Jiggle_Production_Example2_CatalogViewS.png){ class="big-figure" }

Users should also read over the [Step 1: Load single event from database
(Catalog
View)](../tabviews/#step-1-load-single-event-from-database-catalog-view) section
for an introduction to the Catalog View with an event loaded into Jiggle. The
Catalog View screenshot from this section, with a loaded event, is reproduced
below. 
![Figure](img/Jiggle_Production_Example3_EventLoadedS.png){ class="big-figure" }


## Catalog Table: Contents and Navigation

The user can preview an event to analyze by either scrolling through the catalog
and clicking on a specific event row (white row, with event ID in red), or by
clicking on a specific event location (cyan circle with white arrow) on the map.
See screenshot in this section: [Step 6: Preview and load next event to
process](../tabviews/#step-6-preview-and-load-next-event-to-process).

The table below describes the contents of each column in the table within
Catalog View.

| Header      | Definition  |
| ----------- | ----------- |
| <span style="color:red">ID</span>       | Unique event ID number (8-digit integer for SCSN)       |
| <span style="color:red">OWHO</span>     | Origin attribution identifier, e.g. "<b>aqms</b>" for an automatic solution, or username for the analyst who last saved the event solution: "<b>jrand</b>", "<b>njs</b>", "<b>ztn</b>" |
| <span style="color:red">DATETIME</span> | Preferred origin time of event, in format `YYYY-MM-DD HH:MM:SS.SSS` UTC |
| <span style="color:red">LAT</span>      | Preferred origin latitude (degrees) |
| <span style="color:red">LON</span>      | Preferred origin longitude (degrees) |
| <span style="color:red">MZ</span>       | Origin depth (km), positive and increasing with deeper depth, never negative |
| <span style="color:red">Z</span>        | Preferred origin depth (km), positive and increasing with deeper depth, but sometimes this value can be negative (for ground elevations high above sea level). These depths are relative to the WGS84 reference ellipsoid. |
| <span style="color:red">MAG</span>      | Preferred event magnitude. Calculated using magnitude algorithm in <span style="color:red">MTYP</span> column. |
| <span style="color:red">MTYP</span>     | Magnitude type, e.g. M<sub>L</sub>, M<sub>d</sub>, M<sub>e</sub>, M<sub>w</sub>, for magnitude value in <span style="color:red">MAG</span> column. |
| <span style="color:red">AUTH</span>     | Origin authority. This should be a two-letter seismic network code. For most local events in the SCSN, AUTH will be "<b>CI</b>". |
| <span style="color:red">ETYPE</span>    | Origin event type. All events from the RT system are "<b>earthquake</b>" or "<b>trigger</b>". Upon further analysis, "<b>earthquake</b>" is the most common type, but this might also be set to "<b>quarry</b>", "<b>explosion</b>", or other types. |
| <span style="color:red">GT</span>       | Origin geographic type. "<b>L</b>" = local (within seismic network boundaries). "<b>R</b>" = regional.  "<b>T</b>" = teleseismic. |
| <span style="color:red">SRC</span>      | Origin subsource, e.g. "<b>RT3</b>" and "<b>RT9</b>" are automatic solutions from the RT system, "<b>hypomag</b>" is from the automatic RT system for small (M < 2.8) earthquakes, and "<b>Jiggle</b>" has been reviewed by an analyst with Jiggle. |
| <span style="color:red">GAP</span>      | Origin azimuthal gap (degrees): largest angle between azimuthally adjacent stations. Number between 0 and 360.  Smaller azimuthal gaps &rarr; more reliable event epicenter. |
| <span style="color:red">DIST</span>     | Origin smallest epicentral distance (km). Ideally this value is less than the event depth, in order to have a reliable event depth estimate. |
| <span style="color:red">RMS</span>      | Origin root-mean-squared (rms) residual travel time (seconds); the lower the better. The residual is the difference between the observed and predicted arrival times. Predicted arrival times are calculated by propagating seismic waves (ray tracing) from the event location through the velocity model. |
| <span style="color:red">ERR_H</span>    | Origin horizontal location uncertainty (km); the lower the better. |
| <span style="color:red">ERR_Z</span>    | Origin depth uncertainty (km); the lower the better; usually greater than <span style="color:red">ERR_H</span> |
| <span style="color:red">OBS</span>      | Number of available associated arrival time estimate; the higher the better |
| <span style="color:red">USED</span>     | Number of associated arrival time estimates used to calculate origin (non-zero weights); the higher the better |
| <span style="color:red">Q</span>        | Origin quality; number between 0 and 1; the higher the better |
| <span style="color:red">ST</span>       | [Origin processing state](../databaseactions/#summary-of-processing-states-in-database-a-c-h-i-f). <b>A</b> = automatic, <b>C</b> = cancel, <b>H</b> = accept, <b>I</b> = intermediate, <b>F</b> = finalize |
| <span style="color:red">PR</span>       | Event processing priority. TODO: what does this mean? |
| <span style="color:red">V</span>        | Event select flag (1 = valid event), 1 = primary, 0 = shadow|
| <span style="color:red">COMMENT</span>  | Comment from analyst, e.g. Quarry location; ignore small aftershock; other unusual observations |


![Figure](img/catalogview_menu.png){ class="big-figure" }

For easy navigation within the catalog table:

*  Right-click (or Control+left-click) within the table to display a popup menu
   with various possible
   actions (screenshot above)
*  Click ![dot_red](img/dot_red.gif) (lower left corner) to scroll back to the
   currently selected event (white row).  Right-click and select "<b>Scroll to
   currently selected id</b>" in the popup menu (screenshot above) has the same
   effect. 
*  Click ![RedUp](img/RedUp.gif) (upper right corner) to scroll to top of catalog
*  Click ![RedDown](img/RedDown.gif) (lower right corner) to scroll to bottom of
   catalog
*  Users can move entire columns to the left or right: click and drag the column
   header to the desired position
    * e.g. move <span style="color:red">DATETIME</span> column to immediately after
      the <span style="color:red">MAG</span> column 
    * Only exception: <span style="color:red">ID</span> must always be first
      (leftmost) column
*  Events are displayed in increasing order of <span
   style="color:red">DATETIME</span> by default, but the user can sort events
   by values in other columns
    * Double-click any column header to sort events in increasing order of
      values in column
        * e.g. double-click the <span style="color:red">MAG</span> column to
	  sort events by magnitude from lowest to highest 
    * Shift+Double-click (hold down Shift key while double-clicking) on any
      column header to sort events in decreasing order of values in column
    * <span style="color:red">ID</span> generally increases monotonically with
      increasing <span style="color:red">DATETIME</span>, but not always,
      especially when two events occur close together in time.
        * e.g. event 38474656 occurred ~30 seconds before event 38474640 in the
	  screenshot above.

###  Catalog Table: Selecting Multiple Events

It is possible to select multiple events in the catalog. To select all rows
currently loaded into the catalog, right-click within the table and go to
"<b>Select all</b>" at the bottom of the popup menu, which results in all rows
being white with <span style="color:red">red text</span> (screenshot below).
![Figure](img/catalog_select_all.png){ class="big-figure" }
After selecting all events, the user has the option to click on "<b>Quarry
check...</b>" to determine which catalog events are likely to be [quarry
blasts](../eventtypes/#quarry-blast).

Notice that the "<b>Where</b>" and "<b>Load</b>" popup menu items are grayed out
in the screenshot above. This is because these items are applicable only for a
single event, not for multiple events.  In addition, the user should note that
selecting multiple events in Catalog View does not select multiple events on the
map; only the first selected event appears with a white arrow on the map.

To select a subset of consecutive rows in the catalog, click on the first event
to select it, then press Shift while clicking on the last event to select,
which automatically selects all events in between the first and last selected
events (screenshot below).
![Figure](img/catalog_select_subset.png){class="big-figure"}

One can also select a subset of non-consecutive rows in the catalog, by pressing
Command (on a Mac) or Control (on a PC) while clicking on each event to select
(screenshot below).
![Figure](img/catalog_select_subset_nonconsec.png){class="big-figure"}

If the user selects "<b>Copy id(s)</b>" on the right-click popup menu for the
selected events in the screenshot above, and then pastes into a text file, the
event IDs appear in a single column:
```
38643312
38643360
38643392
38643408
38643432
38643448
38643464
38643480
38643504
38643520
38643544
```
These event IDs could be saved in an ASCII text file, which can then be read
using the ![read](img/read.gif) "Import events from text file" tool from
[Catalog View Actions](#catalog-view-actions) to filter the event catalog.


If the user selects "<b>Copy summary(s)</b>" on the right-click popup menu for
the selected events in the screenshot above, and then pastes into a text file,
the event summary information appears as formatted columns:
```
  38643312 CI 2019-06-15 07:31:21.18   34.0463 -117.5095   4.35  1.29 Ml  eq  L aqms     CI 02  H   5  -  H 03E   4.04  0.31
  38643360 CI 2019-06-15 08:27:44.86   34.0305 -116.3148  11.91  0.57 Ml  eq  L aqms     CI 02  H   3  -  H 03E  10.91  1.00
  38643392 CI 2019-06-15 08:46:02.41   36.1020 -117.5927   5.16  0.60 Ml  eq  L njs      CI 02  H   2  -  H 03E   3.73  1.43
  38643408 CI 2019-06-15 08:54:18.43   33.2347 -116.7678  16.16  0.72 Ml  eq  L aqms     CI 02  H   3  -  H 03E  14.88  1.28
  38643432 CI 2019-06-15 09:21:12.01   34.0490 -117.5078   3.85  1.27 Ml  eq  L aqms     CI 02  H   5  -  H 03E   3.53  0.32
  38643448 CI 2019-06-15 09:25:07.65   34.0367 -117.5102   3.10  0.65 Ml  eq  L aqms     CI 02  H   3  -  H 03E   2.80  0.31
  38643464 CI 2019-06-15 09:30:55.43   34.0498 -117.5085   3.75  0.95 Ml  eq  L aqms     CI 02  H   3  -  H 03E   3.43  0.32
  38643480 CI 2019-06-15 09:32:53.84   33.8460 -116.8242  12.84  0.50 Ml  eq  L aqms     CI 02  H   3  -  H 03E  11.59  1.25
  38643504 CI 2019-06-15 09:50:36.94   33.7950 -116.6965  17.34  1.07 Ml  eq  L aqms     CI 02  H   5  -  H 03E  16.05  1.29
  38643520 CI 2019-06-15 10:08:33.64   35.9363 -117.7322   3.00  1.00 Mh  eq  L njs      CI 02  H   1  -  H 03E   1.86  1.14
  38643544 CI 2019-06-15 10:54:30.10   34.0480 -117.5087   3.85  1.41 Ml  eq  L aqms     CI 02  H   5  -  H 03E   3.53  0.32
```

If the user selects "<b>Copy row(s)</b>" on the right-click popup menu for
the selected events in the screenshot above, and then pastes into a text file,
all of the event information appears in comma separated format:
```
38643312,aqms,2019-06-15 07:31:21.180,34.0463333,-117.5095,4.35,4.04,1.29,Ml,CI,earthquake,L,hypomag,42.0,4.0,0.16,0.2,0.48,58,58,1.0,F,8.660647801329542,1,NULL
38643360,aqms,2019-06-15 08:27:44.860,34.0305,-116.3148333,11.908,10.91,0.57,Ml,CI,earthquake,L,hypomag,129.0,8.0,0.15,0.4,0.66,13,13,1.0,A,5.066774214968209,1,NULL
38643392,njs,2019-06-15 08:46:02.410,36.102,-117.5926667,5.16,3.73,0.6,Ml,CI,earthquake,L,Jiggle,151.0,11.0,0.08,0.24,0.72,14,14,1.0,I,5.218802704511524,1,NULL
38643408,aqms,2019-06-15 08:54:18.430,33.2346667,-116.7678333,16.155,14.88,0.72,Ml,CI,earthquake,L,hypomag,27.0,1.0,0.19,0.26,0.59,41,41,1.0,A,5.819726234225351,1,NULL
38643432,aqms,2019-06-15 09:21:12.010,34.049,-117.5078333,3.851,3.53,1.27,Ml,CI,earthquake,L,hypomag,26.0,4.0,0.19,0.21,0.31,53,53,1.0,F,8.572760212724928,1,NULL
38643448,aqms,2019-06-15 09:25:07.650,34.0366667,-117.5101667,3.105,2.8,0.65,Ml,CI,earthquake,L,hypomag,85.0,5.0,0.22,0.53,0.57,20,20,1.0,A,5.4732071208713675,1,NULL
38643464,aqms,2019-06-15 09:30:55.430,34.0498333,-117.5085,3.751,3.43,0.95,Ml,CI,earthquake,L,hypomag,38.0,4.0,0.19,0.26,0.36,40,40,1.0,A,6.9738685183546885,1,NULL
38643480,aqms,2019-06-15 09:32:53.840,33.846,-116.8241667,12.842,11.59,0.5,Ml,CI,earthquake,L,hypomag,188.0,3.0,0.14,0.5,0.89,14,14,1.0,A,4.724094198856451,1,NULL
38643504,aqms,2019-06-15 09:50:36.940,33.795,-116.6965,17.339,16.05,1.07,Ml,CI,earthquake,L,hypomag,42.0,6.0,0.19,0.23,0.56,64,64,1.0,F,7.576131705728461,1,NULL
38643520,njs,2019-06-15 10:08:33.640,35.9363333,-117.7321667,2.999,1.86,1.0,Mh,CI,earthquake,L,Jiggle,111.0,7.0,0.14,0.56,31.61,11,11,0.5,I,8.743367746751623,1,NULL
38643544,aqms,2019-06-15 10:54:30.100,34.048,-117.5086667,3.851,3.53,1.41,Ml,CI,earthquake,L,hypomag,26.0,4.0,0.18,0.19,0.32,76,76,1.0,F,9.283651199304165,1,NULL
```
If the user selects "<b>Copy data cell</b>" on the right-click popup menu, the
value in the data cell closest to the mouse pointer is copied. "<span
style="color:red">DATETIME</span>" entries should not be copied.  Some floating
point values, such as "<span style="color:red">LAT</span>" and "<span
style="color:red">LON</span>", may have more decimal places than displayed in
the table. Blank entries, especially for trigger events, may have `NaN` for
numbers or `NULL` for strings. 


## Catalog View Actions

The icons in the "<span style="color:red">Catalog view actions</span>" red box
under the "<span style="color:red">Tab views</span>" icons are found only in
Catalog View; they are available for use whether or not an event is loaded into
Jiggle (see screenshots in [Catalog View
Introduction](#catalog-view-introduction). Some of these actions apply only to
the selected event in the catalog (white row in table, event ID highlighted in
red).

Here is a description of each icon in "<span style="color:red">Catalog view
actions</span>":

*  ![view](img/view.gif) Search for an event with the user-specified ID in the
   catalog. The user can enter the desired ID in the popup window (screenshot
   below):
<p align="center">
   <img src="../img/enter_catalog_id.png" width="200" height="70" align="middle">
</p>

    If an event with the user-input ID is present in the catalog, Jiggle will
    display this selected event (highlighted as a white row, with event ID in
    red). However, if the user-input ID does not match that of any catalog event
    (left screenshot below), the following message is returned (right screenshot
    below):
<p align="center">
   <img src="../img/enter_catalog_id_nf.png" width="200" height="70" align="middle">
   <img src="../img/enter_catalog_id_notfound.png" width="350" height="100" align="middle">
</p>
    All 8 digits of the user-input ID must match the event ID exactly; partial
    matches (e.g. 6 out of the 8 digits) are not returned.

<br>
*  ![file](img/file.gif) Save catalog table contents to ASCII output file. A
   file dialog box opens up, and the user should specify the file directory and
   name, ideally with a `.txt` extension. Another box opens up with the option
   to output the table in different formats (screenshot below): delimited by
   tab, comma, or space, and with or without the headers. Within the ASCII file,
   strings are surrounded by single quotes ' ', and some values may be NULL. For
   example, if the output file is named `ascii_out_comma.txt` with the "<b>Comma
   delimited</b>" and "<b>Include header row</b>" options selected (screenshot
   below):
<p align="center">
   <img src="../img/table_to_ascii_file.png" width="150" height="50" align="middle">
</p>
   then the resulting `ascii_out_comma.txt` file looks like this, with a header
   row followed by a row for each catalog event loaded in the table:
```   
ID,OWHO,DATETIME,LAT,LON,MZ,Z,MAG,MTYP,AUTH,ETYPE,GT,SRC,GAP,DIST,RMS,ERR_H,ERR_Z,OBS,USED,Q,ST,PR,V,COMMENT
70284735,'---',2019-06-14,13:38:12.000,0.0,0.0,NULL,0.0,NULL,'M ','CI','trigger',NULL,'RT10',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'A',2.1908712433169106,1,NULL
70284743,'---',2019-06-14,13:44:26.000,0.0,0.0,NULL,0.0,NULL,'M ','CI','trigger',NULL,'RT10',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'A',2.1913226150776457,1,NULL
70284751,'---',2019-06-14,13:45:41.000,0.0,0.0,NULL,0.0,NULL,'M ','CI','trigger',NULL,'RT10',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'A',2.1914132828494117,1,NULL
70284759,'---',2019-06-14,14:01:55.000,0.0,0.0,NULL,0.0,NULL,'M ','CI','trigger',NULL,'RT10',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'A',2.1925953927721684,1,NULL
70284767,'---',2019-06-14,14:06:22.000,0.0,0.0,NULL,0.0,NULL,'M ','CI','trigger',NULL,'RT10',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'A',2.1929209528669893,1,NULL
70284775,'---',2019-06-14,14:15:10.230,36.1101685,-117.6689987,1.95,0.49,1.41,'Ml','CI','earthquake','L','RT10',83.0,9.0,0.16,0.27,0.5,32,31,0.0,'A',27.37538514830706,1,NULL
70284783,'---',2019-06-14,14:22:13.000,0.0,0.0,NULL,0.0,NULL,'M ','CI','trigger',NULL,'RT10',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'A',2.1940858595842583,1,NULL
70284791,'---',2019-06-14,14:23:14.000,0.0,0.0,NULL,0.0,NULL,'M ','CI','trigger',NULL,'RT10',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'A',2.1941608655012144,1,NULL
70284799,'---',2019-06-14,14:24:52.000,0.0,0.0,NULL,0.0,NULL,'M ','CI','trigger',NULL,'RT10',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'A',2.1942814391249303,1,NULL
70284807,'---',2019-06-14,14:27:59.530,34.2606659,-118.2043304,15.23,14.84,1.91,'Ml','CI','earthquake','L','RT10',140.0,12.0,0.2,0.85,1.65,22,10,0.0,'A',29.876330596008756,1,NULL
    ...
```
   If the user wishes to output only a subset of the loaded catalog events to
   file, it is necessary to first filter the events loaded into the table, since
   this action outputs all catalog events currently loaded into the Catalog View
   table.
   TODO filter strategies.

*  ![questionmark](img/questionmark.gif) Show gazetteer info for highlighted
   event (white row, red ID) in catalog table. This displays the distance and
   direction from the event to nearby cities and other locations of interest, in
   a dialog box (screenshot below) just like the one in the screenshot from
   [Step 1: Load single event from database (Catalog
   View)](../tabviews/#step-1-load-single-event-from-database-catalog-view),
   which was for a loaded event. Another way to show the gazetteer info is to
   right-click within the table and select "<b>Where</b>" in the popup menu.
<p align="center">
<img src="../img/gazetteer_37536154.png" width="500" height="250" align="middle">
</p>
    *  The gazetteer should only be used for a single selected event. If this
       button is clicked while multiple events are selected, the gazetteer
       information for only the first event is displayed.
    *  The gazetteer should only be used for earthquake events.  If this button
       is clicked for a trigger event (which does not yet have a location), the
       gazetteer information is not useful (screenshot below).
<p align="center">
<img src="../img/trigger_gazetteer.png" width="500" height="250" align="middle">
</p>
<br>

*  ![delete_xbold_red](img/delete_xbold_red.gif) Delete highlighted event (white
   row, red ID) in catalog table from the database. A dialog box appears to
   confirm if the user really wants to delete this event (screenshot below,
   click "<b>Yes</b>" to delete, or "<b>No</b>" to keep the event):
<p align="center">
   <img src="../img/catalog_delete_warning.png" width="400" height="200" align="middle">
</p>
    Clicking "<b>Yes</b>" will permanently delete this event, and Jiggle does
    not have any functionality to undo this delete, so proceed with caution!

       * If this button is clicked after selecting multiple events, a separate
         warning dialog box appears for each event, one after another.
       * Another way to delete selected events is to right-click within the
         table and select "<b>Delete id(s)</b>" in the popup menu. 

<br>
*  ![refresh](img/refresh.gif) Refresh event catalog. The earthquake catalog may
   have changed since Jiggle was first opened or since the last time the catalog
   was refreshed, so clicking this “refresh” button will add these events to the
   catalog table.

       * New earthquakes may have occurred and been saved to the database.
       * Some earthquakes may have occurred over 72 hours ago, which is the time
         cutoff for displaying catalog events.
       * Some earthquakes may have been deleted from the database.
       * Earthquake origin and magnitude values, and their processing state in
         the database, may have been changed by other timers using Jiggle.
       * Another way to refresh events is to right-click within the table and
         select "<b>Refresh id(s)</b>" on the popup menu.  This can be used on a
	 single event or on a subset of selected events, rather than on the
	 entire loaded catalog.


*  ![read](img/read.gif) Import events with IDs listed in an ASCII input file.
   This tool is used to display only a subset of catalog events with known event
   IDs. Select the input file from the dialog box that opens upon clicking this
   button.  For example, the input file `input_jiggle_id.txt` contains 3 event IDs:
```
   70286703
   70286711
   70286719
```
   When the user selects this input file from the dialog box that opens upon
   clicking this button, the Catalog View displays only the solution for the 3
   events with IDs specified in the input file (screenshot below), with <span
   style="color:red">Table has 3 rows</span> at the bottom left.
![Figure](img/input_jiggle_id_catalogview.png){ class="big-figure" }

   Suppose the user modifies the `input_jiggle_id.txt` file by adding two more
   event IDs as follows (Note: event 70286722 does not exist in the catalog, but
   event 70286727 does exist).
```
   70286703
   70286711
   70286719
   70286722
   70286727
```
   If the user then clicks on the ![refresh](img/refresh.gif) (Refresh event
   catalog) button, the following dialog box appears:
<p align="center">
<img src="../img/input_jiggle_id_catalog_refresh.png" width="500" height="250" align="middle">
</p>
   If the user clicks "<b>No</b>", all event IDs are displayed in the catalog
   (from the last 72 hours). If the user clicks "<b>Yes</b>", the event IDs are
   read in from the `input_jiggle_id.txt` file.  Since event 70286722 is not in
   the catalog, it does not appear, but the newly added event 70286727 now
   appears in Catalog View (screenshot below), with <span
   style="color:red">Table has 4 rows</span> at the bottom left. 

![Figure](img/input_jiggle_id_catalogview_add.png){ class="big-figure" }

*  ![dot_red](img/dot_red.gif) TODO: Load event IDs in a user-specified PCS_STATE

*  ![filter_blue](img/filter_blue.gif) TODO: Define event selection criteria -
   load from properties file or edit properties within Jiggle.

*  ![inputarrowsmall](img/inputarrowsmall.gif) Load highlighted event (white
   row, red ID) into Jiggle for waveform inspection, picks and amps,
   recalculating origin and magnitude. There are multiple ways within Jiggle to
   load the highlighted event and its waveforms, which are described in [Step 1:
   Load single event from database (Catalog
   View)](../tabviews/#step-1-load-single-event-from-database-catalog-view).
   For example, another way to load the event is to right-click within the table
   and select "<b>Load</b>" in the popup menu. Only one event can be loaded into
   Jiggle at a time.


## Loading an Event and its Waveforms

Users should first read over the [Step 1: Load single event from database
(Catalog
View)](../tabviews/#step-1-load-single-event-from-database-catalog-view) section
for an introduction to the Catalog View with an event loaded into Jiggle.

TODO: also see Step 5,6 section for next event

TODO: "Edit view id comment", "Reset to waveform view id" right-click popup menu

TODO: edit magnitude / solution / type under "Selected Solution"?

---

TODO: Distinction between “select” in catalog view and “load” event

TODO: After loading event... relevant icons in the Top Toolbar, e.g. "Event"

TODO: Can only load one event at a time --> waveform data

TODO: lock database - only one user at a time - dialog box

## Customize Catalog View

TODO: ST = A, H, I, F and colors, customize the color scheme

TODO: "Model..." menu --> Event Catalog... screenshots

TODO: "Event..." menu

TODO: The default behavior is to read all events in the SCSN database over the
last 72 hours, but the user can modify the time interval and filter the location
of desired events by going to "Model" --> "Event Catalog..." on the menu bar.
