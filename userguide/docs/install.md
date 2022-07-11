# Requirements to run Jiggle


Jiggle is intended only for use by RSNs, not by the general public.

Jiggle runs on a Java Virtual Machine (JVM), so it is platform independent.  The
user should be able to run Jiggle on a Windows, Mac, or Linux operating system.
JVM version 1.8 or higher is recommended.

Jiggle connects to an Oracle or PostgreSQL database through the Java Database Connectivity
(JDBC) application programming interface (API).

Jiggle only interfaces with the [California Integrated Seismic Network (CISN)
database schema](https://www.ncedc.org/db/Documents/NewSchemas/schema.html){:target="_blank"}. Use
by other schema would require creation of a concrete implementation of [Java
Abstract Seismic Interface
(JASI)](https://pasadena.wr.usgs.gov/jiggle/codehelp.html){:target="_blank"}.  

Jiggle may run slowly if accessed through a remote connection. Some users have
reported faster performance over Remote Desktop, than through a Virtual Private
Network (VPN).

* A reasonably fast processor and at least 2 GB memory
* Java Platform, Standard Edition (Java SE), or OpenJDK: 8 or 11.  If it is not already
installed on your computer, download it at
[https://www.oracle.com/technetwork/java/javase/downloads/index.html](https://www.oracle.com/technetwork/java/javase/downloads/index.html)
or
[https://adoptopenjdk.net/index.html](https://adoptopenjdk.net/index.html).
* [Application and external .jar files](#external-libraries-and-dependencies) 
* [Jiggle properties files with input parameters](../property_files)  
* [Script to start Jiggle GUI](#jiggle-runtime-script)
* Oracle or PostgreSQL database with CISN schema, JASI views, and a large number of stored functions.

# Installing Jiggle

Create a directory (folder) to hold Jiggle, its dependencies, and property files, e.g. `Jiggle`.
Inside that directory, create a directory for the Jiggle jar files and other dependencies.  For
example, let's call this directory `bin/`.
Also create a directory for the property files, let's call it `prop/`.
```
Jiggle/
   bin/
   prop/
   run_jiggle.sh
```

The jiggle.jar and other jar files all go into the `bin/` directory. Property files go
into the `prop/` directory. Run scripts typically go into the `Jiggle/` directory, at the same level as the `bin/` and `prop/` directories.

## Jiggle versions

Since some of the RSNs have converted to using PostgreSQL instead of Oracle databases, this is a bit complicated at the moment.

The very latest version of Jiggle should work with both Oracle and PostgreSQL databases, but only RSNs with PostgreSQL database
servers are actually using it. Most Oracle shops are still using the older Jars compiled by the previous Jiggle maintainer Allan Walter.

**Check with your network manager which Jiggle version you should use!**

### Oracle-only version

This version is no longer actively maintained. The executable jar files listed below for the gtype-enabled schema were built from
the SVN branch: `aqms/PP/branches/jungle-gtype` revision `8650` (last changed rev `8234`). The other ones were most likely built from `aqms/PP/trunk/jungle` revision `8650` (last changed rev `8231`).


The latest version of Jiggle is Java8 `jiggle18-p7.jar` from 2017-06-27 (see
most recent entry in the [Jiggle Release
Notes](https://gitlab.com/aqms-swg/jiggle-archive/-/blob/master/CHANGELOG)

Download this jiggle jar file from
[https://gitlab.com/aqms-swg/jiggle-archive](https://gitlab.com/aqms-swg/jiggle-archive){:target="_blank"},
rename it `jiggle.jar`, and put it in the `bin/` directory. 

This version of Jiggle from 2017-06-27 depends on having the up-to-date GTYPE
schema in the database. Most RSNs are now using the GTYPE schema, although there
are still a few exceptions in early 2019. 

* In the origin database table, there is a separate column for GTYPE.
* If an event type is "earthquake", the origin can have a GTYPE value of either "local", "regional", or "teleseism".

### PostgreSQL and Oracle version

The jiggle.jar files that are compatible with both PostgreSQL and Oracle are build from the gitlab repository. 
They can be reached through a link under "Other" in the releases tab:

[Jiggle releases](https://gitlab.com/aqms-swg/aqms-jiggle/-/releases){:target="_blank"}

The link leads to a temporary webadress until the AQMS Software Working Group decides on a more permanent location:
[Temporary location of the jiggle jars](https://seismo.ess.washington.edu/renate/jiggle_jars/){:target="_blank"}

## External libraries and dependencies

All external libraries and dependencies for Jiggle (`.jar`, `.zip` files)
mentioned below are available for download from
[https://gitlab.com/aqms-swg/jiggle-archive](https://gitlab.com/aqms-swg/jiggle-archive){:target="_blank"}

TO DO: add link to external dependencies to the new gitlab repo `aqms-jiggle`  releases, so people do not need to go to `jiggle-archive`.

Jiggle depends on the following external .jar files which should also go into
the `bin/` directory. Do not unpack these jar files.  New users need to download
these only once.

* `ojbdc8.jar` (formerly `ojbdc7.jar`)
* `acme.jar`
* `openmap.jar`
* `QWClient.jar`
* `swarm.jar`
* `seed-pdcc.jar`
* `looks-2.0.4.jar`
* `forms-1.0.7.jar`
* `colt.jar`
* `usgs.jar`
* `jregex1.2_01.jar`

And if you use PostgreSQL, also:
* `postgresql-42.2.5.jar`

### Openmap
Jiggle also needs supporting map interface files. Download `mapdata.zip` which should
unzip and be placed into a `mapdata/` subdirectory inside the `bin/` directory.
New users need to download these only once.

## Jiggle Property Files

Jiggle requires several hundred input parameters, spread across multiple
properties files. 

Sub-bullet points indicate filenames for separate properties files that are
specified in the parent bullet properties file.

* `jiggle.props`: main Jiggle user properties file with >500 input parameters. This main properties file includes channel time model parameters. The properties can be organized in multiple files by using the auxPropertyTags and auxPropertyFile properties.
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

Download `properties.zip` for examples. See [Properties (Input
Parameters)](../properties) for more information about these properties files.
The Jiggle website
[https://pasadena.wr.usgs.gov/jiggle/Install.html](https://pasadena.wr.usgs.gov/jiggle/Install.html)
has examples of properties files in `properties.zip`. However, I recommend
getting a copy of existing properties files from an experienced seismic analyst
at your RSN, and then modifying them for your specific needs.

NOTE: it is also possible to split all the properties in the main jiggle.props up into multiple files, using the auxPropFiles property.

# Jiggle runtime script

To run Jiggle, the user needs a runtime script (Linux/Unix/Mac) or bat file
(Windows).  This script should be in the same `bin/` directory as the
`jiggle.jar` file.

For example, a Unix runtime script, named `run_jiggle.sh`, would look like:

    #!/bin/bash

    java -Xms1000M -Xmx2560M -DJIGGLE_HOME=./ -DJIGGLE_USER_HOMEDIR=$HOME/Documents/Jiggle/Code/prop -jar jiggle.jar $1

Explanation of input arguments:

* `-Xms`: initial and minimum Java heap size (in this case, 1000 MB) to allocate
memory for the JVM
* `-Xmx`: maximum Java heap size (in this case, 2560 MB) to allocate memory for
the JVM
* `-DJIGGLE_HOME`: directory containing the Jiggle application’s files such as
`jiggle.jar`
    * In this case, `-DJIGGLE_HOME` is the current directory, assuming that this
    runtime script also lives in the `bin/` directory)
* `-DJIGGLE_USER_HOMEDIR`: directory containing the Jiggle properties files. See
[Properties (Input Parameters)](../properties) for more information.
    * This should be an absolute path; I have found that specifying a relative
    path does not work.
* The last `$1` in this command is there to specify a different Jiggle
properties filename as an input argument. Without the `$1` input, Jiggle assumes
the input parameters are in a file called `jiggle.props` within the
`-DJIGGLE_USER_HOMEDIR` directory.

Note that we need to make `run_jiggle.sh` executable:

    $ chmod +x run_jiggle.sh

To run Jiggle from the command line, with input parameters from file
`jiggle.props` located in directory `-DJIGGLE_USER_HOMEDIR`:

    $ ./run_jiggle.sh

To run Jiggle from the command line, with input parameters from a different file
`jiggle_waves.props` located in a different directory `../prop/`: 

    $ ./run_jiggle.sh ../prop/jiggle_waves.props

