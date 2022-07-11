This page describes actions in Jiggle that modify the database of events.

# Save and Finalize Event to Database

First, users should read the [Step 5: Save and finalize improved earthquake
solution to
database](../tabviews/#step-5-save-and-finalize-improved-earthquake-solution-to-database) 
section for an introduction on how to save and finalize a Jiggle modified
solution to the database.

TODO Section

Edit catalog parameters by hand (Event...)

Catalog view – what changes?

Disk / Gavel

Stale solutions
1. Pick arrival times on waveforms
2. Locate event with HYPOINVERSE (depends on arrival times)
3. Compute magnitude for event (depends on distance between event location to
station)
If any one of these steps are initiated in Jiggle, then all subsequent steps
must also be taken before save/finalize, otherwise the user gets a "stale
solution" warning.

1,2,3 ok
2,3 ok
3 ok

Only 1 - "stale location"
Only 1,3 - "stale location"
Only 1,2 - "stale magnitude"
Only 2 - "stale magnitude"


# Delete Event from Database

TODO Section

Not a real earthquake – false detection

TODO: delete event from Jiggle - sends cancel alarm messages.
    *  Sending a cancel alarm message should cause both the RT and PP versions
       of the alarm system to cancel any event messages they had sent earlier.
       It may not be possible to cancel certain alarm actions.
Deleting an event sets the `selectflag` attribute in the `event` table to 0
within the database.

Delete: selected vs loaded

Also works for triggers

Event --> Delete Event.  What about Undelete Event?

Screenshot of an example

Delete

# Create New Event in Database

TODO Section

Sometimes we want to manually create a new event that does not exist in database, not automatically detected by RT system

## New Event from Trigger

TODO

Pick (auto or manual), locate, magnitude, save, finalize

## New Event Clone from Existing Event

TODO

New events are often created during active earthquake sequences, when many
earthquakes occur in a short time interval.

Use the "New Event Clone" tool only when there are multiple earthquake waveforms
visible within a single loaded database event

New event icon

Example screenshots

Create new event ID, with different colors (create a clone from the parent, then pick/locate/mag).
New waveform request cards?

## Summary of processing states in database (A, C, H, I, F)

TODO

Something about alarms

Each event has an entry under the "<b>ST</b>" column (event origin processing
state) in the database.  This is the `rflag` attribute in the `origin` table.

*  <b>A</b>: <b>Automatic</b>. This is an automatically generated event
   solution from real-time AQMS, which needs to be reviewed by the analyst. 
    *  The "<b>SRC</b>" column in the database would have "<b>RT</b>" followed
       by a number, or "<b>hypomag</b>" for a small (M < 2.8) event.
*  <b>C</b>: <b>Cancel</b>. This leaves the event in the catalog, but sends
   cancel alarm messages stating that the event is not an earthquake. This action is
   performed only in DRP.
    *  The analyst performs the cancel action in DRP on a non-earthquake
       event (determined from visual inspection of waveforms). The analyst
       can later delete the canceled event in Jiggle.
    *  The analyst may also cancel an earthquake event with a really bad
       location in DRP, especially if it should be removed from external
       webpages. The analyst can later recompute the event solution in Jiggle.
    *  Sending a cancel alarm message should cause both the RT and PP versions
       of the alarm system to cancel any event messages they had sent earlier.
       It may not be possible to cancel certain alarm actions.
    *  [Cancel implementation details from SCSN wiki](http://scsnwiki.gps.caltech.edu/doku.php?id=postproc:cancel)
*  <b>H</b>: <b>Accept</b>. This marks the event as human-reviewed (H for human)
   by a seismologist to be an earthquake, and sends alarm messages. This action is
   performed only in DRP or TRP.
    *  This event goes through PDL and appears on the USGS event web page with
       the remark "event has been reviewed".
    *  This event still needs to have its solution refined within Jiggle and
       then finalized.
    *  Sending an accept alarm message should result in reevaluation of the
       event by the PP version of the alarm system, and send revised alarms.
*  <b>I</b>: <b>Intermediate</b>. Clicking the "Save event"
   ![save](img/save.gif) button in Jiggle saves the Jiggle-modified event
   solution to the database, but does not send any alarm messages.
    *  This is often used during busy times to save rough solution estimates,
       without finalizing them, for more careful analysis later.
    *  TODO: Distribute button?
    *  This event still needs to be finalized in Jiggle.
*  <b>F</b>: <b>Finalize</b>.  Clicking the "Finalize event"
   ![finalize](img/gavel.gif) button in Jiggle saves the Jiggle-modified event
   solution as the final solution in the database, sends alarm messages, and becomes
   part of the official catalog.
    *  An event is finalized when it is unlikely that its location and magnitude
       will be changed by further processing.  However, a finalized event can
       still be processed within Jiggle and finalized again.
    *  Some small events with low root-mean-squared residual travel times are
       finalized within the DRP, and do not need to be processed within Jiggle:
       M < 1.95 and RMS < 0.23 seconds, for the SCSN.
    *  [Finalize implementation details from SCSN wiki](http://scsnwiki.gps.caltech.edu/doku.php?id=postproc:finalize)

Summary of where the "<b>ST</b>" value for an event can be changed
("Delete" will remove an event from the catalog, so it no longer appears in
Jiggle):

*   RT AQMS: Automatic (A)
*   DRP: Cancel (C), Accept (H), Finalize (F), Delete
    *   Note: in practice, Delete is not used in the DRP at the SCSN; it is
        preferred practice to Delete events within Jiggle.
*   TRP: Accept (H), Delete
*   Jiggle: Save as Intermediate (I), Finalize (F), Delete
    *   Note: it is not possible to Cancel or Accept an event within Jiggle.

