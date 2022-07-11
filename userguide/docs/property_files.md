# Jiggle Property Files

Jiggle requires several hundred input parameters, spread across multiple
properties files. 

# Required Jiggle Properties Files

Sub-bullet points indicate filenames for separate properties files that are
specified in the parent bullet properties file.

* `jiggle.props`: main Jiggle user properties file with >500 input parameters. This main properties file includes channel time model parameters.
  * `eventSelection.props`: properties defining the event catalog selection filter settings
  * `openmap.props`: properties defining map setup and layers that can be added, removed, or modified
  * `omap-views.properties`: properties defining map views near specific regions
  * `omap-netlayers.properties`: properties defining map layer display settings
  * `omap-layernames.properties`: properties defining names of map layers
  * `omap-bbnlayers.properties`: properties defining map layer settings
  * `mdMagEng.props`: properties defining magnitude engine setup for M<sub>d</sub> (duration magnitude)
  * `mlMagEng.props`: properties defining magnitude engine setup for M<sub>L</sub> (local magnitude)
  * `mlMagMeth2.props`: properties defining magnitude method setup for M<sub>L</sub> (local magnitude)
  * `hypoMdMagMeth.props`: properties defining magnitude method setup for M<sub>d</sub> (duration magnitude)
  * `pickEW.props`: properties for automatic phase picker
  * `pickEW-alt3.parms`: properties for automatic phase picker at every channel

The Jiggle website
[https://pasadena.wr.usgs.gov/jiggle/Install.html](https://pasadena.wr.usgs.gov/jiggle/Install.html)
has examples of properties files in `properties.zip`. However, I recommend
getting a copy of existing properties files from an experienced seismic analyst
at your RSN, and then modifying them for your specific needs.

# View Properties within Jiggle

![Screenshot](img/jiggle_view_properties.png)

Jiggle user properties can be viewed within the Jiggle GUI (see screenshot
above), by selecting either of these two options from the top menu bar:

*  <b>Properties</b> &rarr; <b>Property info</b>
*  <b>Dump</b> &rarr; <b>Property info</b>

# Modify Properties within Jiggle

To modify the properties, users can do either of the following:

* Directly edit the text files containing the Jiggle properties, then load them
into Jiggle with "<b>Properties</b> &rarr; <b>Load properties...</b>"
from the top menu bar
* Edit the properties within the GUI Preferences using "<b>Properties</b>
&rarr; <b>Edit properties...</b>" from the top menu bar (see screenshot
below)

![Screenshot](img/properties_preferences.png)
