# Jiggle Tips
## Changing the layout

It is possible to change the frame layout in Jiggle so that the [Catalog
View](../catalogview), [Map Layer View](../maplayerview), and [Waveform
View](../waveformview) can be viewed at the same time within one window
(screenshot below). This is called the "SplitPane" frame layout.

![Figure](img/jiggle_sameframe.png)

To get the SplitPane layout, select the following in the "<span
style="color:red">Menu bar</span>": 

*  "<b>View</b> &rarr; <b>Waveforms...</b> &rarr; <b>Waveforms in SplitPane</b>"
   to view the waveforms on the same screen as the catalog.  Notice that the
   Waveform View ![sinewave2](img/sinewave2.gif) tab icon is no longer there.
*  Then select "<b>View</b> &rarr; <b>Map...</b> &rarr; <b>Split with
   Catalog</b>" to view the map within the same window as the catalog (and
   waveforms).
*  The "<b>View</b>" menu also offers the option of either a vertical or
   horizontal split of the catalog window with the map, and with the waveform
   window.
*  Use the mouse to resize the different frames. 

To go back to the default frame layout, select the following in the "<span
style="color:red">Menu bar</span>": 

*  "<b>View</b> &rarr; <b>Waveforms...</b> &rarr; <b>Waveforms in TabPane</b>"
   to create a separate tab for the Waveform View
   ![sinewave2](img/sinewave2.gif).
*  Then select "<b>View</b> &rarr; <b>Map...</b> &rarr; <b>Separate Window</b>"
   to move the map back to its own window.


## Navigation Tips

Here are some suggestions for navigating within Jiggle:

<p align="center">
<img src="../img/tooltip_mouseover.png" width="400" align="middle">
</p>

*  When in doubt, hover the mouse pointer on an icon to display a <span
   style="background-color:LemonChiffon">tooltip (within a yellow box)</span>
   with a short summary of what it does (screenshot above).
*  On the "<span style="color:red">Menu bar</span>", click "<b>Help</b>" &rarr;
   "<b>Mouse button action help</b>" for mouse shortcuts for common actions in
   Jiggle (see text below).

## Hot keys
```
Jiggle Tab Pane Navigation
 Typing 'C' in Waveform, Location, Magnitude, or Message tab selects Catalog tab.
 Typing 'L' in Waveform, Magnitude, Catalog, or Message tab selects Location tab.
 Typing 'M' in Waveform, Location, Catalog, or Message tab selects Magnitude tab.
 Typing 'T' in Waveform, Location, Magnitude, or Catalog tab selects Message tab.
 Typing 'W' in Location, Magnitude, Catalog, or Message tab selects Waveform tab.
 Case-sensitive in Waveform panel, because 'c' and 't' are defined for other actions, see Picking help

Location, Magnitude Tab Data Lists:
 SHIFT+LEFT click, selects list data element then shows selected channel
 waveforms panel in waveform tab.
 DELETE key, deletes selected channel data element from list (i.e. highlighted phase, amp).

Waveform Tab Picking Panel:
 LEFT click drag and release defines viewport time bounds using waveform`s min,max amp bounds.
 SHIFT+LEFT click drag and release defines both viewport time bounds and viewport amp bounds.

 Phase time picking:
  LEFT click centers waveform viewport at the click time.
  RIGHT click pops up a phase descriptor menu for pick at the viewport center time.

  Uncertainty in phase time:
    CTRL+LEFT click DRAG straddling a pick sets its uncertainty duration, centered on the pick.

 Coda duration picking:
  Note a P or S phase pick is required to scan waveform for coda decay fit.
      Inside S coda, CTRL+LEFT click to define start time then CTRL+LEFT click again to define end time.
      or use SHIFT+CTRL+LEFT click to scan a "filtered" waveform if its amplitude units is counts.
      a double-click, or an CTRL+ALT click, resets the timespan (erases window marker lines).

 Peak amplitude picking:
  Note a phase pick is not required to scan waveform for maximum Wood-Anderson amplitude.
      ALT+LEFT click to define start time then ALT+LEFT click again to define end time.
      or use SHIFT+ALT+LEFT click to scan a "filtered" waveform if its amplitude units is counts.
      a double-click, or an CTRL+ALT click, resets the timespan (erases window marker lines).

 Auto phase pick :
  Requires an automatic phase picker instance setup via properties. Requires use of a MIDDLE mouse button.
      CTRL+MIDDLE click to define start time before pick then CTRL+MIDDLE click again to define end time after pick.
      or use SHIFT+CTRL+MIDDLE click to scan a "filtered" waveform if its amplitude units is counts.
      a double-click, or an CTRL+ALT MIDDLE click, resets the timespan (erases window marker lines).

 Noise level in timespan:
  Requires use of a MIDDLE mouse button.
      ALT+MIDDLE click to define noise span's start time then ALT+MIDDLE click again to define its end time.
      or use SHIFT+ALT+MIDDLE click to scan a "filtered" waveform.
      a double-click, or an CTRL+ALT click, resets the timespan (erases window marker lines).

 Peak amplitude picking:
  Note a phase pick is not required to scan waveform for max WA amp.
      ALT+LEFT click to define start time then ALT+LEFT click again to define end time.
      or use SHIFT+ALT+LEFT click to scan a "filtered" waveform if its amplitude units is counts.
      a double-click, or an CTRL+ALT click, resets the timespan (erases window marker lines).

Catalog Tab Table:
 LEFT double-click a table column header cell to sort table rows with column's value ascending.
 LEFT+SHIFT double-click a table column header cell to sort table rows with column's value descending.

Map Layer Mouse Actions:
 Network Stations:
   LEFT double-click on a station's symbol to change view selection to first one matching that station's name.
 Event Catalog:
   LEFT double-click on an event's symbol to load that event into waveform view.
 MasterView Solutions:
   LEFT+SHIFT click anywhere on map to change the currently selected event's origin to the mouse's map location.
 Faults:
   LEFT click on a map fault segment to reveal the fault name tooltip (e.g. when regions boundaries layer is active).
```
*  On the "<span style="color:red">Menu bar</span>", click "<b>Help</b>" &rarr;
   "<b>Panel hot key help</b>" for keyboard shortcuts or "hotkeys", which can be
   significantly faster when using Jiggle over remote connections (see text
   below).
```
                   HOT KEY ACTION MAPPINGS

Typing one of the below listed keys,
effects the pick closest to the window''s centertime.
 x         = delete
 r         = add +5 to weight
 f         = flip polarity
 p         = popup pick menu

NOTE: pick flag''s color when its weight=0 is 'color.pick.unused' property,
      value default is dark pink.

Typing one of the below listed keys make a P-pick
at the window''s centertime with the listed descriptor,
holding down ALT or SHIFT makes it a S-pick.
 `         = 'iP0'
 NUMPAD0   = 'iP0'
 NUMPAD1   = 'iP1'
 NUMPAD2   = 'eP2'
 NUMPAD3   = 'eP3'
 NUMPAD4   = 'eP4'

When property pickingPanelHotKeyNum2Wt=false (default),
typing one of the below listed keys makes a P-pick
at the window''s centertime with the listed descriptor,
holding down ALT or SHIFT make it a S-pick, otherwise
the weight of the pick closest to centertime is set to the value.
 0         = 'iP0'
 1         = 'iP1'
 2         = 'eP2'
 3         = 'eP3'
 4         = 'eP4'

Keys that change pick descriptor weight:
 F1 1
 F2 2
 F3 3
 F4 4
 F5 0

Keys that change pick descriptor onset:
 i
 e

Keys that change pick descriptor first motion:
 space or . (none, undetermined)
 c (up, compression high SNR)
 + (up, compression low SNR)
 d (down, dilation high SNR)
 - (down, dilation low SNR)
 . none
   (space, none)

Keys that change the zoom panel viewport:
 [ Time Zoom-out (contract)
 ] Time Zoom-in (expand)
 ; Time Full Range (collapse)
 : Time and Amp Full Range (collapse)

 * Amp Zoom-in (expand)
 | Amp Zoom-in (expand)
 / Zoom-out (contract)
 \ Zoom-out (contract)
 ' Show Full (collapse)
 " Show Full Time and Full Amp Range (collapse)

 t toggles time tick border at top/bottom of zoom viewport
 h toggles visibility of all pick, coda, amp flags
 H toggles visibility of the pick residual and delta time bars

Keys that change the selected waveform view:
 UP        = move selection up   1 trace
 DOWN      =                down 1 trace
 PAGE_UP   =                up   1 page
 PAGE_DOWN =                down 1 page
 HOME      =                first  trace
 END       =                last   trace

Keys that delete parametric data:
 x Deletes the picks closest to centertime for the selected channel
 X Deletes all picks (P and S) on the selected channel
 x+ALT Deletes ALL automatic picks for the EVENT (Human timed remain)
 x+CTRL Deletes ALL picks for the EVENT

 For the selected channel view and current event:
  BACKSPACE+SHIFT Deletes all picks, amp, and coda
  BACKSPACE+CTRL  Deletes coda
  BACKSPACE+ALT   Deletes amp
  DELETE First deletes coda, if none, the amp, if none, the picks
  DELETE+SHIFT deletes picks, if none, the amp, if none, the coda

 For the current event:
  F9+SHIFT Deletes ALL event picks, amps, and codas
  F9+ALT   Deletes ALL event amps
  F9+CTRL  Deletes ALL event codas

Keys that restore deleted parametric data:
 z+SHIFT Restores picks deleted by last pick delete action
 z+ALT   Restores amps deleted by last amp delete action
 z+CTRL  Restores codas deleted by last coda delete action

Keys that control tab pane navigation:
 C or c Selects Catalog tab (EXCEPTION: for Wavefrom tab, 'c' changes fm)
 L or l Selects Location tab
 M or m Selects Magnitude tab
 T or t Selects Message tab (EXCEPTION: for Wavefrom tab, 't' toggles time scale)
 W or w Selects Waveform tab


Keys that control waveform filtering for selected panel:
 o Toggles current waveform filter on/off
 b Highpass Butterworth filter on
 B Bandpass Butterworth filter on
 b+ALT Lowpass Butterworth filter on

 w Wood-Anderson filter on
 W Bandpass Wood-Anderson filter on
 w+ALT Highpass Wood-Anderson filter on

Keys that control flags:
 F6+SHIFT Hides currently selected panel in lower scroller panel

 F7+SHIFT Toggles highlighted panel's view's selection flag
 F7+ALT Flags all unhidden views in scroller as 'selected'
 F7+CTRL Flags all unhidden views in scroller as 'unselected'

 F8+SHIFT Toggles selected waveform's clip flag
```
*  Right-click the mouse to open a menu of possible actions specific to the
   window. For example, the screenshot below displays a pop-up menu that appears
   when right-clicking the mouse within the ["<span style="color:red">All event
   waveforms"</span> window in Waveform
   View](#step-2-modify-picks-and-amplitudes-on-event-waveform-channels-waveform-view).

![Figure](img/rightclick_menu_example.png)


*  TODO: floating toolbars, press X to go back to default docking (on Mac)
