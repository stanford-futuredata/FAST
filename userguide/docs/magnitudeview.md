# Magnitude View Introduction

First, users should read the [Step 4: Recalculate event magnitude (Magnitude
View)](../tabviews/#step-4-recalculate-event-magnitude-magnitude-view)
section for an introduction to the Magnitude View with an event loaded into
Jiggle. The Magnitude View screenshot from this section, with a loaded event, is
reproduced below.

![Figure](img/Jiggle_Production_MagnitudeViewS.png)

TODO Section

What is each type of magnitude?  Refer to the section from tabviews

Depend on waveform amplitude at each station, and location (distance from event to each station)

Different tab view for each magnitude type, some are from RT or other sources,
Jiggle can only compute ML and Md
What are the magnitude algorithms?
trimag-SF for ML (RT)
CISNml2 for ML (Jiggle)
HypoinvMd for Md (need coda estimates as inputs)

TODO describe everything in the yellow section - create a table

TODO describe columns in the Magnitude View output
Colors: black, orange, red - how are these defined?

TODO select "A" filter to view only waveforms with amps in Waveform View, which
correspond to each row from magnitude calculation output in Magnitude View

Rejected amps (hollow orange triangles in Waveform View) - appear as "REJECT" in
the row for this channel. Rejected amps are not used in magnitude calculation -
why?

Preferred magnitude?  Usually ML or Mw, what are the rules?  See Wiki Page

add info from magnitudes.AQMS.pdf (NetOps ppt)
