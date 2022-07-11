# Overview

Initially, RT AQMS automatically generates an event catalog with origin and
magnitude information.  RT AQMS uses the
[Earthworm](http://www.earthwormcentral.org/) software to automatically detect,
locate, and characterize individual earthquake events in real-time. However,
these automatic event origins are sometimes incorrect or need refinement.
Therefore human analysts improve the automatic event solutions to generate a
high-quality earthquake catalog.

At the SCSN, the Duty Review Page (DRP) and Trigger Review Page (TRP) tool are
used as a first pass on the automatic event catalog. Based on visual inspection
of the event waveforms, the analyst can either [<b>accept</b>](../databaseactions/#summary-of-processing-states-in-database-a-c-h-i-f) the event as an
earthquake, or [<b>cancel</b>](../databaseactions/#summary-of-processing-states-in-database-a-c-h-i-f) the event if it does not look like an earthquake
signal. Other RSNs may not have a DRP or TRP, so all human post-processing would
be done through Jiggle.

After the first pass is complete, Jiggle is then used for more careful analysis
of the earthquakes: picking phase arrival times, recomputing location, and
recomputing magnitude. Jiggle is used to [<b>save</b> and <b>finalize</b> an
improved earthquake solution to the
database](../databaseactions/#save-and-finalize-event-to-database),
[<b>delete</b> a non-earthquake event from the
database](../databaseactions/#delete-event-from-database), or [create a new
event in the database](../databaseactions/#create-new-event-in-database) for an
earthquake that was not detected automatically by RT AQMS.

![Figure](img/Jiggle_Production_Example2_CatalogViewS.png){ class="big-figure" }

There are two different types of events (as shown by <span
style="color:red">ETYPE</span> in screenshot above) in the automatically
generated catalog from RT AQMS (all pink rows in screenshot above with <span
style="color:red">ST</span> set to <b>A</b>): [earthquake](#earthquake-local) and
[trigger](#trigger), which have gone through separate processing paths in
Earthworm.

*   At the SCSN, the DRP shows [earthquake](#earthquake-local) events that have
    passed through the [Earthworm binder algorithm](http://love.isti.com/trac/ew/wiki/binder_ew). 
    These events have a location and magnitude associated with them.  After
    viewing the waveforms, the analyst takes one of the following actions
    within DRP:
    *  Accept event as an earthquake, which marks the event as human-reviewed.
       However, the event solution still needs to be reviewed, refined, and
       finalized within Jiggle.
    *  Cancel event if it is not an earthquake, then delete event from catalog
       within Jiggle.  This action is taken if RT AQMS has falsely detected a
       noise signal.  Occasionally, an earthquake event may be canceled if the
       solution is really bad, then its solution recomputed within Jiggle.
    *  Finalize event only if it is small (M < 1.95) and well-located (RMS < 0.23
       seconds, this is the residual arrival time error). These usually have
       <span style="color:red">SRC</span> set to "<b>hypomag</b>" in the final
       catalog.
    *  Delete event is generally not done in the DRP; it is preferred practice to
       delete events within Jiggle.

*   At the SCSN, the TRP shows [trigger](#trigger) events that went through the
    [Earthworm subnet trigger algorithm](http://www.earthwormcentral.org/documentation3/ovr/carltrig_ovr.html),
    consisting of the [carlstatrig](http://love.isti.com/trac/ew/wiki/carlstatrig) and
    [carlsubtrig](http://love.isti.com/trac/ew/wiki/carlsubtrig) modules,
    instead of binder. Triggers have an associated time, but no location or
    magnitude.  After viewing the waveforms, the analyst takes one of the
    following actions within TRP:
    *   Accept trigger if the waveforms look like it is an earthquake. The
        waveforms can be loaded into Jiggle. The analyst can then pick phases,
        locate the event, compute magnitude, then save and finalize the event as
        an earthquake in the standard procedure.
    *   Delete trigger if the waveforms look like noise. This step deletes the
        trigger from the database forever, so that it never appears in Jiggle.

At the SCSN, the vast majority of events in the final catalog are [local
earthquakes](#earthquake-local), although a few events are [regional or
teleseismic earthquakes from farther away](#earthquake-regional-teleseismic).
Occasionally there are human-generated events such as [quarry
blasts](#quarry-blast), or [even more unusual events](#other-exotic-events). The
final catalog of earthquakes in southern California is available to the public
at the SCEDC website:
[http://scedc.caltech.edu/eq-catalogs](http://scedc.caltech.edu/eq-catalogs).

[Understanding Waveforms at SCSN.org](http://www.scsn.org/index.php/education-outreach-2/understanding-waveforms/index.html)
- This website contains examples of waveforms from the different types of events
listed below.

TODO: Link to SCSN wiki examples

## Earthquake (Local)

Most earthquakes recorded by the SCSN are small [local
earthquakes](http://www.scsn.org/index.php/education-outreach-2/understanding-waveforms/local-earthquakes/index.html)
that occur within the [boundaries of the seismic
network](http://www.scsn.org/index.php/network/index.html). The screenshot below
shows waveforms from a typical local earthquake in the SCSN, with a distinctive
P-wave and larger S-wave only a few seconds apart, detected at different times
across many seismic stations in the network.

![Figure](img/WaveformView_37536154.png){ class="big-figure" }

Most local earthquakes start out as events that were automatically detected and
associated with the [Earthworm binder algorithm](http://love.isti.com/trac/ew/wiki/binder_ew)
within RT AQMS.  Binder is optimized to detect events in denser areas of the
seismic network.

*  These events have their [origin event type (<span
   style="color:red">ETYPE</span>)](../catalogview/#catalog-table-contents-and-navigation) 
   set to "<b>earthquake</b>", and their origin subsource (<span
   style="color:red">SRC</span>) set to "<b>RT</b>" followed by a number. 
*  These events have an initial location and magnitude associated with them,
   since the RT system has used HYPOINVERSE to compute the location and trimag
   to compute the magnitude.
*  Small events with M < 2.8 go through a second pass of automatic RT
   processing: [hypomag](https://pasadena.wr.usgs.gov/jiggle/pcshypomag.html)
   applies aggressive filters to re-pick phases, re-locate the event, and
   re-compute their magnitudes.  These events have <span
   style="color:red">SRC</span> set to "<b>hypomag</b>" in the catalog.

At the SCSN, "earthquake" events that passed through binder end up in the DRP,
where the analyst takes a first pass at post-processing by visually inspecting
the event waveforms:

*  If the event is not an earthquake (for example, if the waveforms look like
   noise, as the result of a false detection by RT AQMS), the analyst should
   cancel the event in DRP, which leaves the event in the catalog but
   sends out a cancel alarm message.  About 50% of events from the RT AQMS
   system in SCSN are canceled.  All canceled events must be reviewed in Jiggle,
   where they can be deleted from the catalog.
    *  Occasionally, an event that is an earthquake, but has a really bad
       location, may be canceled in DRP, so that alarm messages are sent to
       external websites to cancel the event. Jiggle can then be used to
       recompute its solution from the waveforms.
*  If the event is an earthquake, but it is small (M < 1.95) and well-located
   (RMS < 0.23 seconds), it can be finalized in DRP, without further processing
   in Jiggle. These usually have <span style="color:red">SRC</span> set to
   "<b>hypomag</b>" in the final catalog.
*  If the event is an earthquake, and it has magnitude M > 1.95, or RMS > 0.23
   seconds, the analyst should accept the event in DRP, which sends out an alarm
   message stating that the event was human-reviewed.  The event solution still
   needs to be reviewed, refined, and finalized within Jiggle.
*  Delete event is generally not done in the DRP; it is preferred practice to
   delete events within Jiggle.
*  [More DRP details from SCSN wiki](http://scsnwiki.gps.caltech.edu/doku.php?id=postproc:duty_review_page_drp)


Which databases? Model...

Waveform screenshot



## Earthquake (Regional, Teleseismic)

TODO

Regional earthquakes are outside the [SCSN network
boundaries](http://www.scsn.org/index.php/network/index.html).
Parkfield, Coalinga, Mammoth, Nevada.

Baja California: north of 31 degrees North latitude, and whose arrivals are not
too emergent to pick reliably.

If a large enough event is outside network boundary (for example in Parkfield),
the authoritative network solution (for example, NC) will be manually imported
through Jiggle.




[Teleseismic earthquakes](http://www.scsn.org/index.php/education-outreach-2/understanding-waveforms/teleseismic-event/index.html)
are large (at least M > 5) earthquakes located over 1000 km away from southern
California, often on the other side of the world. They have long-period
waveforms that arrive at all stations in the network almost at the same time,
and the duration of these waveforms can be several minutes long.

From other networks – import their solution?

Edit, add comment

Set GTYPE in DRP, Jiggle.  Only for earthquakes.
GTYPE - where is this attribute in database?

Telestifle?

Teleseismic events: (M > 6.5) are added by the "sedas" program, import solutions
from NEIC?  Keep in catalog
Do not finalize teleseismic event solutions, their processing state will be "A"
for automatic.  Teleseismic events are checked to see if they match those
received from the NEIC through PDL. (TODO check for accuracy)

Example of catalog + map

Waveform screenshot



## Trigger

TODO:

The automatic catalog from RT AQMS includes events have their [origin event type (<span
style="color:red">ETYPE</span>)](../catalogview/#catalog-table-contents-and-navigation) 
set to "<b>trigger</b>", and their origin subsource (<span
style="color:red">SRC</span>) set to "<b>RT</b>" followed by a number. 

These events have passed through the [Earthworm subnet trigger
algorithm](http://www.earthwormcentral.org/documentation3/ovr/carltrig_ovr.html),
consisting of the [carlstatrig](http://love.isti.com/trac/ew/wiki/carlstatrig)
and [carlsubtrig](http://love.isti.com/trac/ew/wiki/carlsubtrig) modules,
instead of binder.  Subnet triggers are used to detect events in sparser areas
of the seismic network, where binder did not detect events; in southern
California, subnet triggers are used in the eastern, northern, and offshore
western parts of the network.

Triggers are just a collection of stations that triggered on a relatively low
threshold. Triggers have an associated time, but no location or magnitude. They
may or may not be from an earthquake. 5-10% of finalized earthquake events in
the final SCSN catalog originate from the subnet triggers, and they are usually
very small or emergent events.

At the SCSN, "<b>trigger</b>" events that passed through the Earthworm subnet
trigger end up in the TRP, where the analyst takes a first pass at
post-processing by visually inspecting the waveforms: 

*  If the event is not an earthquake (for example, if the waveforms look like
   noise), the analyst should delete the event in TRP, which deletes the trigger
   from the database forever.  Triggers deleted in TRP never appear in Jiggle,
   so it is good practice to only delete triggers where the analyst is confident
   that it is not an earthquake.
*  If the event waveforms look like an earthquake, the analyst should accept the
   event in TRP, and has the option to set the origin event type <span
   style="color:red">ETYPE</span> within TRP to "earthquake" by clicking on the
   "Set Etype" button. The event solution still needs to be calculated and
   finalized within Jiggle.

For the remaining accepted triggers, the analyst can load the trigger event into
Jiggle and view its waveforms.

*  If the trigger event is not an earthquake, the analyst can
   [delete](../databaseactions/#delete-event-from-database) it in the usual way.
*  If the trigger event is an earthquake, the analyst needs to [complete all
   processing in Jiggle](../databaseactions/#new-event-from-trigger): pick
   arrival times automatically or manually, calculate location and magnitude,
   [set the origin event type <span style="color:red">ETYPE</span> and/or origin
   geographic type <span style="color:red">GTYPE</span>](../catalogview/#loading-an-event-and-its-waveforms),
   and [finalize the event in the database](../databaseactions/#save-and-finalize-event-to-database).

Which databases? Model...

Trigger – many values not in the table

Waveform screenshot



## Quarry Blast

[Quarry blasts](http://www.scsn.org/index.php/education-outreach-2/understanding-waveforms/quarry-blasts/index.html)
from mining operations within the [SCSN
boundaries](http://www.scsn.org/index.php/network/index.html) are often detected by the
automatic RT AQMS software.  Quarry blasts originate from an outward explosion
on the earth's surface, in contrast to earthquakes that originate from shear
slip on a fault at some depth underground.

![Figure](img/quarry_37218372_waveforms.png){ class="big-figure" }

The screenshot above shows an example of waveforms from a quarry blast, which
have a "ringy" long-duration and low-frequency S-wave. The screenshot below
shows a map with the quarry blast location (blue dot with pink arrow pointing to
it), which is located near the "CUSHENBURY" quarry (purple X's indicate known
quarry locations in southern California).

![Figure](img/quarry_37218372_map.png){ class="big-figure" }

TODO

Right click popup menu, Select all -> Quarry Check?

Message View
```
*  70284855 CI 2019-06-14 22:01:31.42   33.8720 -117.4987   1.65  1.34 Ml  eq  L ---      CI 02  H   2  -  H 03E   1.13  0.52    2.4 mi N   (   6. azimuth) from CORONA QRY
*  70284927 CI 2019-06-14 22:47:10.95   33.8353 -117.5162   2.47  1.35 Ml  eq  L ---      CI 02  H   2  -  H 03E   2.00  0.47    0.8 mi WSW ( 256. azimuth) from CORONA QRY
*  70288207 CI 2019-06-16 23:22:46.02   35.0513 -117.6587   0.56  1.31 Ml  eq  L ---      CI 02  H   2  -  H 03E  -0.27  0.83    1.4 mi ENE (  57. azimuth) from BORON QRY
```
Gazetteer

During daytime, located near known quarry?  Single event - box pops up saying it
is a potential quarry blast

Edit, add comment

Set ETYPE in DRP, TRP, Jiggle

Once you declare event as a quarry blast, you get a lot of ‘stale’ messages.
Depth is set to be at the surface, so this requires re-locating and re-computing
magnitude. 

Inventory of all possible quarries? from SCSN Wiki

Waveform screenshot



## Other Exotic Events

TODO: different event types (more exotic types)

Edit, add comment

Set ETYPE in DRP, TRP, Jiggle
ETYPE - where is this attribute in database?

[Sonic booms](http://www.scsn.org/index.php/education-outreach-2/understanding-waveforms/sonic-boom/index.html)
are sometimes detected by the SCSN. They may originate from test flights or
training runs at military bases in southern California. Sonic booms usually
occur from aircraft, but sometimes are the result of meteors. Sonic booms travel at
the speed of sound, which is much slower than the speed of seismic waves, so the
waveforms are spread farther apart in time at the different stations. 

Sonic booms are saved if they show strongly on “a significant number” of
stations, if they generate any public inquiries, or if they are requested
specifically by a researcher. Space shuttle re-entries are routinely saved.
(TODO link to SCSN wiki page)

[Artillery fire](http://www.scsn.org/index.php/education-outreach-2/understanding-waveforms/military-training-artillery-fire/index.html)
from military training at Marine Corps Base Camp Pendleton, located within the
SCSN boundaries, is often detected by the SCSN. There are usually several
impulsive signals, occurring very close together in time, and they travel at the
slower speed of sound.

![Figure](img/chemical_blast_waveforms_artillery_pendleton.png){ class="big-figure" }

The screenshot above shows an example of waveforms from artillery fire located
at Camp Pendleton. The screenshot below shows how the artillery fire is recorded
in the final catalog within Jiggle. The <span style="color:red">ETYPE</span> is
set to "chemical blast", the location and magnitude parameters are all set to 0,
the magnitude type <span style="color:red">MTYP</span> is "Mun", and the <span
style="color:red">COMMENT</span> field has a note stating "Camp Pendleton
Mortar/Artillery Fire".

![Figure](img/chemical_blast_catalog.png){ class="big-figure" }

TODO



Examples of exotic event waveforms from PNSN:
[https://pnsn.org/earthquakes/exotic-events](https://pnsn.org/earthquakes/exotic-events)

There are 29 possible event types for the database, and each event type is
identified by a 2-character code in the "eventtype" table within the [CISN
schema](http://www.ncedc.org/db/Documents/NewSchemas/PI/v1.6.2/PI.1.6.2/index.htm).
The [SCSN wiki contains an inventory of all possible event
types](http://scsnwiki.gps.caltech.edu/doku.php?id=datacenter:event_types).

TODO drop-down menu, and set common event types within Properties
TODO up-to-date event types?

Waveform screenshot



