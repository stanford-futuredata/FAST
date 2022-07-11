# Location View Introduction

First, users should read the [Step 3: Recalculate event location and origin time
(Location
View)](../tabviews/#step-3-recalculate-event-location-and-origin-time-location-view)
section for an introduction to the Location View with an event loaded into
Jiggle. The Location View screenshot from this section, with a loaded event, is
reproduced below.

![Figure](img/Jiggle_Production_LocationViewS.png)

TODO Section

New picks --> new location

Velocity Model
Hadley-Kanamori (HK) velocity model is used for the entire SCSN network.

TODO describe solservers

HYPOINVERSE (DIS 5 80 1.0 1.5)

Screenshot of location view

Run again --> location will change again

Screenshot of HYPOINVERSE output view (another tab)?

TODO describe everything in the yellow section - create a table

"SrcVer" - is this the event versio ?  (Event.Version in database schema)
Higher version number always supersedes a lower number for a particular event.

Event version is incremented each time the preferred origin, magnitude or
mechanism of the event is updated. A change in version number means a
significant change to the event solution. There may be gaps in the version
sequence, and skipped version numbers should not be interpreted as loss of event
information.  One event can have multiple origin solutions and magnitude
solutions, but there is only one preferred origin ("prefor") and preferred
magnitude ("prefmag") solution. For details link to SCSN Wiki TODO
(postproc:event_versioning)

TODO describe columns in the HYPOINVERSE output
Colors: black, orange, red, blue
Depend on "Res" (residual)

TODO select "P" filter to view only waveforms with picks in Waveform View, which
correspond to each row from HYPOINVERSE output in Location View

SCSN standard practice: Any pick with more than a 1 second residual ("Res"
column) is reviewed in Jiggle; it may be deleted (in Waveform View) if it looks
unreliable.  If the residual is less than 1.5 seconds, and the event is located
near the boundaries of the seismic network (such as Baja California), it may be
retained; otherwise, its pick weight (TODO link to pick weight definitions) is
changed to "4".

TODO describe "fix depth" and where the button is located. Explain why we would
want to use "fix depth".

SCSN standard practice: Since we are unable to constrain the depth of events
that have no picks for stations closer than 30-35 km, such events have their
depths fixed at the traditional "shallow" default value of 6 km.

"Fix depth" to a value of 10 km is also used if calculated depths are greater
than 10 km within the Imperial Valley in southeastern California.  If the depth
is left unfixed, the resulting calculation may give depths greater than 30 km
that are too deep to be physically realistic for southern California
earthquakes, because the HK velocity model is not representative of a
sedimentary basin such as the Imperial Valley.

