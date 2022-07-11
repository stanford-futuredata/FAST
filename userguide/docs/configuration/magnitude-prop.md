## Magnitude Methods and Database Views

NOTE: In the database schema the JASI_CONFIG_VIEW typically joins the Applications and AppChannels tables. 
The Applications's table PROGID numeric key is mapped to a string "name", and this name must match either the method's internal name (in table below) or the string specified by the method's "appChannelsName=name" property.

| Type | Java Class Name                                   | Name       |
|------|---------------------------------------------------|------------|
| Md   | org.trinet.jasi.magmethods.HypoinvMdMagMethod     | HypoinvMd  |
| Ml   | org.trinet.jasi.magmethods.TN.MlMagMethod         | RichterMl  |
| Ml   | org.trinet.jasi.magmethods.TN.RichterMlMagMethod2 | RichterMl2 |
| Ml   | org.trinet.jasi.magmethods.TN.CISNmlMagMethod2    | CISNml2    |
| Ml   | org.trinet.jasi.magmethods.TN.MxMlMagMethod2      | MxMl       |
| Ml   | org.trinet.jasi.magmethods.TN.HirooMlMagMethod    | HirooMl    |

The name's associated PROGID is mapped to the set of channels acceptable for processing by the magnitude method in the view. If the view has no rows mapped to the method, or the view's lookup is disabled by setting the method's property disableAppchannelsMap=true, then the channels accepted for magnitude calculations are those that match any "seedchan" template specified by the method's acceptChan property; however when this property is undefined and the view lookup has been disabled, then any channel is acceptable for a channel magnitude calculation.
For a channel's magnitude to contribute to the summary magnitude statistic, the channel's AppChannels table row for a Md method should have its CONFIG column value set to '1', and for a Ml method its CONFIG value is set to '1' for HH_ or EH_ seedchan types (high-gain), and set to '2' for HN_, HL_, or HG_ types (low-gain). Setting a row's CONFIG column value to either NULL or '0' will still allow a channel to be accepted for a channel magnitude calculation, however, it will not contribute to the summary magnitude if there are any other rows associated with the method name with a CONFIG value of '1' or '2'. If all CONFIG values are set to '0' or NULL, then if the summaryChan property declares seedchan types, only those types are accepted for the summary magnitude calculation, however, if this property is undefined or "" then all accepted channel magnitudes are used for the summary magnitude statistic (see CISNml2 example below).

## Generic Magnitude Method Properties for all Ml and Md Subtypes

| Property Name           | Description                                                                                                                                                                                                                                                                                                                                                    | Value                                                                     |
|-------------------------|----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|---------------------------------------------------------------------------|
| methodName              | Name associated in db with magalgo as well as appchannels program lookup.                                                                                                                                                                                                                                                                                      | (default use hardcoded string in class)                                   |
| appChannelsName         | in lieu of method name use this name to associate with channels in JASI_CONFIG_VIEW see above NOTE.                                                                                                                                                                                                                                                  | myName (when property is absent, default is method's name)                |
| acceptChan              | list of seedchan codes acceptable for a channel magnitude calculation when no channels are associated in JASI_CONFIG_VIEW see disableAppChannelMaps see above NOTE.                                                                                                                                                                        | EHZ SHZ ELZ EHE EHN HHZ                                                   |
| channelDbLookUp         | repeatedly query db for missing data (lat,lon,correction) else use existing cache, ignoring the missing                                                                                                                                                                                                                                              | true (default)                                                            |
| chauvenetTrimValue      | scalar value used to trim outliers from summary magnitude, reject a channel magnitude if its probability of mean deviation is < trimValue/nobs                                                                                                                                                                                                       | 0.5 (default)                                                             |
| cullRedundantReadings   | when using primary and secondary channels lists (disableAppChannelsMap=false), process magnitude for secondary channel only when primary is missing                                                                                                                                                                                       | true (default)                                                            |
| deleteByDistanceTrim    | if true, data associated with channels located beyond cutoff distance are not saved to db.                                                                                                                                                                                                                                                                     | false (default)                                                           |
| deleteByResidualTrim    | if true, data associated with channels whose magnitude residuals exceeds tghe trimResidual are not saved to db.                                                                                                                                                                                                                                                | false (default)                                                           |
| deleteInvalid           | if true, when clipped, low SNR, or peak amp period out-of-bounds, do not save the channel's data to db                                                                                                                                                                                                                                                         | true (default)                                                            |
| deleteRejected          | if true, and rejected (e.g. missing correction), do not save the channel's data to db.                                                                                                                                                                                                                                                                         | false (default)                                                           |
| disableAppChannelsMap   | if true, disable using JASI_CONFIG_VIEW to obtain list(s) of the acceptable channels, and instead use the seedchan templates defined by the acceptChan, summaryChan properties. If false, the default, primary list channels have APPCHANNELS.CONFIG='1' and secondary list channels have APPCHANNELS.CONFIG='2' see above NOTE. | false (default)                                                           |
| filterChan              | list of seedchan codes to apply waveform conditioning filter (e.g. Butterworth LoCut) before channel mag calc scan                                                                                                                                                                                                                                   | HHZ (Md default)                                                          |
| filterCopiesWf          | apply filter to a copy of the loaded timeseries (for Jiggle =true, batch hypomag =false)                                                                                                                                                                                                                                                                       | true (default)                                                            |
| globalMagCorr           | magnitude correction to apply to all components                                                                                                                                                                                                                                                                                                                | 0. (default)                                                              |
| includedReadingTypes    | Amp/Coda type descriptor (methods hard-wired, coda method does allows adding type here)                                                                                                                                                                                                                                                                        | Pd (Md default) vs. WA WAU WAC WAS(Ml default)                            |
| maxChannels             | if specified, maximum number of channel magnitudes to calculate (in distance sorted order)                                                                                                                                                                                                                                                                     | 999999 (default)                                                          |
| maxDistance             | skip calculation for channels at distances > this km                                                                                                                                                                                                                                                                                                           | 600. (default 600., method implementation magnitude scaled for some)      |
| minDistance             | always include channel magnitudes at distances < this km                                                                                                                                                                                                                                                                                                       | 20. (Ml default, mag method implementation specific)                      |
| minValidReadings        | minimum non-zero wt channel magnitudes to require for a statistical summary magnitude                                                                                                                                                                                                                                                                          | 1 (default)                                                               |
| oneTimeAppChannelsMap   | if true, load acceptable, summary channel SNCL maps from db once only, else for every event.                                                                                                                                                                                                                                                                   | false (default)                                                           |
| requireCorrection       | require a site magnitude correction from db to use channelmag in summary statistics                                                                                                                                                                                                                                                                            | false (default)                                                           |
| summaryChan             | list of seedchan codes to accept for a summary magnitude calculation when no channels are associated in JASI_CONFIG_VIEW see disableAppChannelMap. see above NOTE.                                                                                                                                                                         | EHZ (Md default)                                                          |
| summaryMagValueStatType | Type of summary magnitude statistic returned                                                                                                                                                                                                                                                                                                                   | median (default) (mean (or average), median, wmedian (or weightedmedian)) |
| scanEnergyWindow        | start waveform scan at the predicted traveltime vs. first sample time                                                                                                                                                                                                                                                                                          | true (default), always true for Md                                        |
| sumMagStatTrim          | Chauvenet trim channel magnitude outliers from summary stats                                                                                                                                                                                                                                                                                                   | true (default)                                                            |
| trimResidual            | reject channel magnitude with residual > value from summary mag statistic.                                                                                                                                                                                                                                                                                     | 1. (default)                                                              |
| useAssignedWts          | use existing Coda, Amp, quality values, if false, all weights =1, in summary calc                                                                                                                                                                                                                                                                              | true (default)                                                            |
| useMagCorr              | for tests, if false, do not add the current correction to the channel magnitude.                                                                                                                                                                                                                                                                               | true (default)                                                            |


## Generic Md Magnitude Method Properties

| Property Name           | Description                                                                                                                                                                                                                                                                                                                                                    | Value                                                                     |
|-------------------------|----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|---------------------------------------------------------------------------|
| alwaysRecalcTauFromFit          | if true, always set coda tau to values extrapolated from Q, A fit decay                                                                                                      | false (default)                                                                                 |
| analogPeakAmpClipRatio          | EHZ clip counts= analogPeakAmpClipRatio*(maxDigitizerCnts=ChanneMap_AmpParms.clip)                                                                                           | 0.4 (default)                                                                                   |
| overlapStart                    | overlap coda amplitude windows (window center separation is 1/2 window width).                                                                                               | false (default)                                                                                 |
| overlapWindowMax                | count from start of amplitude windows overlapped.                                                                                                                            | 10. (default)                                                                                   |
| codaBiasLTASecs                 | secs used to calculate bias as well as the starting and ending lta.                                                                                                          | 10. (default)                                                                                   |
| codaGeneratorParmsType          | parameter values to use for waveform coda scanning algorithm                                                                                                                 | NC (CI default)                                                                                 |
| codaGeneratorType               | only CI or NC are accepted values here                                                                                                                                       | NC (CI default)                                                                                 |
| codaPrePTimeBiasOffsetSecs      | secs to shift end of noise bias window (demean) from the predicted time of P arrival energy                                                                                  | 2. (default)                                                                                    |
| codaStartOffsetSecs             | if >0. seconds to add to velocity model S time for start of coda windowing                                                                                                   | 1. (default, if 0 then use secs = 1.1 * SmP )                                                   |
| codaWindowSize                  | seconds over average absolute amplitude values are averages                                                                                                                  | 2. (default)                                                                                    |
| cutoffMagDists                  | cutoff distance corresponding to cutoffMagValue, channel > distance not scanned                                                                                              | 60. 120. 240. 320. (default)                                                                    |
| cutoffMagValues                 | magnitude value for which there is a cutoffMagDist, channel > distance not scanned                                                                                           | 1.4  2.0 2.5 3.0 (default)                                                                      |
| disableMagnitudeDistanceCutoff  | if true, don't reject any channels by distance/magnitude relation                                                                                                            | false (default)                                                                                 |
| filter                          | filter waveforms of the type specified in filterChan list (Butterworth)                                                                                                      | true (default)                                                                                  |
| filterCornerHighFreq            | high cut Hz for Butterworth bandpass type only                                                                                                                               | (default not defined)                                                                           |
| filterCornerLowFreq             | low cut Hz of Butterworth high-pass or bandpass types)                                                                                                                       | true (default)                                                                                  |
| filterOrder                     | order of Butterworth filter                                                                                                                                                  | 4 (default)                                                                                     |
| filterReversed                  | run filter over timeseries both forward and backwards                                                                                                                        | true (default)                                                                                  |
| filterType                      | Butterworth filter type HIGHPASS or BANDPASS                                                                                                                                 | HIGHPASS (default)                                                                              |
| logCodaCalc                     | print details of each channel waveform coda windowing fit                                                                                                                    | false (default)                                                                                 |
| maxGoodWindowsToTerminateCoda   | terminate scan at specified good window count when no end of coda by cutoff                                                                                                  | 60 (CI default) 23 (NC default)                                                                 |
| minGoodWindowsToTerminateCoda   | scan terminates upon clipping, if resetOnClipping=true and min not reached, reset start and continue scan                                                                    | 2 (default)                                                                                     |
| minSNRatioCodaCutoff            | coda scan ended if signal below estimated background noise threshold                                                                                                         | 1.0 (default)                                                                                   |
| minSNRatioForCodaStart          | min threshold to accept for the first valid window at the start of coda scan                                                                                                 | 1.0 (default)                                                                                   |
| passThruNSRatio                 | maximum of current/last (ratio of avg abs amp window values) allowed for coda scan to continue                                                                               | 1.8 (default)                                                                                   |
| resetOnClipping                 | if true, restarts coda windowing past the clipped window                                                                                                                     | false (default)                                                                                 |
| scanAllWaveformsForMag          | scan all waveforms, or only those associated with phase arrivals                                                                                                             | false (Md default, only picked) true (Ml default)                                               |
| useZeroQualityPick              | Scan waveforms having 4 weight, 0 quality picks for coda duration                                                                                                            | true (default)                                                                                  |
| velocityModelClassName          | name of velocity model java class NOTE:Applications using multiple properties filesshould declare velocity model properties only in one(e.g. only in jiggle.props) | org.trinet.util.velocitymodels.USGS_NC_VelocityModel (optional)                                 |
| velocityModel.DEFAULT.modelName | Name of velocity model to use if model list has more than one model.                                                                                                         | abc123 (optional, see NOTE)                                                                     |
| velocityModel.abc123.psRatio    | Vp/Vs ratio of velocity model.                                                                                                                                               | 1.75 (optional, see NOTE)                                                                       |
| velocityModel.abc123.depths     | List top of model layer depths.                                                                                                                                              | 0. 5. 15. 30. (optional, see NOTE)                                                              |
| velocityModel.abc123.velocities | List of model layer velocities.                                                                                                                                              | 4.0 6.0 6.5 7.9 (optional, see NOTE)                                                            |
| velocityModelList               | List defined velocity model names.                                                                                                                                           | abc123 nocal (optional, see NOTE)                                                               |
| waveformLoadWaitMillis          | if waveforms loaded in separate thread, loop wait time to recheck load status                                                                                                | 2000 (default)                                                                                  |
| maxLoadingWaits                 | if waveforms loaded in separate thread, maximum number of rechecks for waveform load                                                                                         | 15 (default)                                                                                    |
| waveformCacheSize               | number of waveforms to load in separate thread                                                                                                                               | 100 (default, set size <&EQ; 1 to disable separate thread loading)                              |
| tauTypeFilter                   | tau termination types valid for summary magnitude                                                                                                                            | tauTypeFilter=NXRH? (where N=cutoff,X=fix extrap,R=Free extrap,H=Human picked,?=unknown legacy) |

Md properties you may want to experiment with:

```
# tau termination types valid for summary magnitude
tauTypeFilter=NXRH?

# Set EHZ clipping scalar value to one appropriate for your network instrumentation
# where clip counts = analogPeakAmpClipRatio*(max_digitizer_counts=channelmap_ampparms.clip value)
analogPeakAmpClipRatio=0.4 (default)

#for cases where starting window is before peak S energy setting next two properties may help:
#If you have at least min windows extrapolate tau, otherwise reset counter and start amp measurement after signal drops below clipping
minGoodWindowsToTerminateCoda=5
resetOnClipping=true

#To resolve shorter coda tau for smaller events you can overlap the 2-sec time-amp windows from the start
overlapStart=true

#number of windows to overlap from the start
overlapWindowMax=25
```

## HypoinvMd Magnitude Method Properties 

Default Md channel magnitude equation fit parameters.

| Property Name           | Description                                                                                                                                                                                                                                                                                                                                                    | Value                                                                     |
|-------------------------|----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|---------------------------------------------------------------------------|
| fmagDistZParms | duration magnitude parameters see hypoinverse documentation | dcofm1 dbrkm1 dcofm2 dbrkm2 zcofm zbrkm <br> 0.005 40.  0.0005 350.  0.014 10.                                  |
| fmagDurParms   | duration magnitude parameters see hypoinverse documentation | fma1 fmb1 fmz1 fmd1 fmf1 fma2 fmb2 fmz2 fmd2 fmf2 fmbrk  <br> -.81 2.22 0.  0.0011 0.  0.  0.  0.  0.  0.  9999. |


Optional alternative Md equation parameters if event origin lies within the polygon defined in the gazetteer_region table.


| Property Name           | Description                                                                                                                                                                                                                                                                                                                                                    | Value                                                                     |
|-------------------------|----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|---------------------------------------------------------------------------|
| parmsRegionNames           | space-delimited list of region names (gazetteer_region table) <br> list names in nested search order, innermost region first, outermost last. |                                                         |
| fmag.regionName.DistZParms | duration magnitude parameters values (see hypoinverse documentation)                                                                                 | dcofm1 dbrkm1 dcofm2 dbrkm2 zcofm zbrkm                 |
| fmag.regionName.DurParms   | duration magnitude parameters (see hypoinverse documentation)                                                                                        | fma1 fmb1 fmz1 fmd1 fmf1 fma2 fmb2 fmz2 fmd2 fmf2 fmbrk |


## Generic Ml Magnitude Method Properties

| Property Name           | Description                                                                                                                                                                                                                                                                                                                                                    | Value                                                                     |
|-------------------------|----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|---------------------------------------------------------------------------|
| clipCheck                     | reject amplitudes > channel's db defined clipping amp value                                                                                                                                                                                                                                                  | true (default)  |
| clippingAmpScalar.analog      | For analog channel, clipped if peak amp > scalar*(maxDigitizerCnts=ChannelMap_AmpParms.clip)                                                                                                                                                                                                                 | .8 (default)    |
| clippingAmpScalar.digital.acc | For broadband acceleration, clipped if peak amp > scalar*(maxDigitizerCnts=ChannelMap_AmpParms.clip)                                                                                                                                                                                                         | .99 (default)   |
| clippingAmpScalar.digital.vel | For broadband velocity, clipped if peak amp > scalar*maxDigitizerCnts=ChannelMap_AmpParms.clip)                                                                                                                                                                                                              | .99 (default)   |
| minSNR                        | reject peak amplitude whose signal-to-noise ratio is < this value.                                                                                                                                                                                                                                           | 3.(default)     |
| peakType                      | amp measurement choice is zero-to-peak (z2p) or peak-to-peak/2 (p2p)                                                                                                                                                                                                                                         | z2p (default)   |
| requireBothHoriz              | If true, reject channel from summary mag calc if its complementary orientation is missing/rejected.                                                                                                                                                                                                          | false (default) |
| requireGain                   | simple response gain required for channel magnitude calculation                                                                                                                                                                                                                                              | false (default) |
| scanSpanMaxWidth              | seconds duration to scan from the pre-S start time for the peak amp, if =0, instead use S-P time scalar multiplier                                                                                                                                                                                 | 0. (default)    |
| WAmagnification               | value to use for Wood-Anderson gain 2800 or 2080.                                                                                                                                                                                                                                                            | 2080 (default)  |
| mlrMagIntercept               | intercept of line for Mlr adjusted magnitude from Ml                                                                                                                                                                                                                                                         | 0. (default)    |
| mlrMagSlope                   | slope of line for Mlr adjusted magnitude from Ml                                                                                                                                                                                                                                                             | 1. (default)    |
| mlrMagMax                     | max Ml value for Mlr adjusted magnitude from Ml                                                                                                                                                                                                                                                              | -9 (default)    |
| mlrMagMin                     | min Ml value for an adjusted magnitude from Ml                                                                                                                                                                                                                                                               | 9 (default)     |
| useClosestDistCorr            | use A0 correction mapped to the distance closest to channel distance, greater or lesser, if false, use A0 correction for the closest distance less than the channel distance. If interpolate=true, the correction is interpolated between the lesser and greater distance correction values. | true (default)  |


## MxMlMagnitude Method Properties

| Property Name           | Description                                                                                                                                                                                                                                                                                                                                                    | Value                                                                     |
|-------------------------|----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|---------------------------------------------------------------------------|
| magCorrEHE | static correction to add to component of this seedchan type | 0.(default) |
| magCorrEHE | static correction to add to component of this seedchan type | 0.(default) |
| magCorrEHZ | static correction to add to component of this seedchan type | 0.(default) |
| magCorrELE | static correction to add to component of this seedchan type | 0.(default) |
| magCorrELN | static correction to add to component of this seedchan type | 0.(default) |
| magCorrELZ | static correction to add to component of this seedchan type | 0.(default) |


## HirooMl Magnitude Method Properties

| Property Name           | Description                                                                                                                                                                                                                                                                                                                                                    | Value                                                                     |
|-------------------------|----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|---------------------------------------------------------------------------|
| cutoffDistIntercept            | reject channel from summary statistic when its distance > slope*MLsummary - intercept | -205. (default)    |
| cutoffDistSlope                | reject channel from summary statistic when its distance > slope*MLsummary - intercept | 170. (default)     |
| disableMagnitudeDistanceCutoff | if true, don't reject any channels by distance/magnitude relation                     | false (default)    |
| hiroo.A0.c                     | c in Ml distance correction formula: <br>-log(c)+log(r\*\*n)+log(e\*\*(k*r))                  | 0.3173 (default)   |
| hiroo.A0.k                     | k in Ml distance correction formula: <br>-log(c)+log(r\*\*n)+log(e\*\*(k*r))                  | -0.00505 (default) |
| hiroo.A0.n                     | n in Ml distance correction formula: <br>-log(c)+log(r\*\*n)+log(e\*\*(k*r))                  | -1.14 (default)    |
| minSNR                         | minimum SNR to accept for an peak amplitude magnitude                                 | 8.(default)        |


## RichterMl2 Properties

| Property Name           | Description                                                                                                                                                                                                                                                                                                                                                    | Value                                                                     |
|-------------------------|----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|---------------------------------------------------------------------------|
| corr                | list of -logA0 values for distances listed in "corrDist" property                                                                                        | (if absent, default to table defined in Richter Elementary Seismology) |
| corrDist            | list of distances for -logA0 values listed in "corr" property                                                                                            | (if absent, default to table defined in Richter Elementary Seismology) |
| corrDistVert        | list of distances for -logA0 values listed in "corrVert" property)                                                                                       | (if absent, default to distances used for horizontal components)       |
| corrVert            | list of -logA0 values for distances listed in "corrDistVert" property                                                                                    | (if absent, default to corrections used for horizontal components)     |
| interpolate         | interpolate Ml correction at distance between -logA0 table values.                                                                                       | false (default)                                                        |
| ml.xxx.corr         | "xxx" is a region name specified in "parmRegionNames" property <br> list of -logA0 values for distances listed in "corrDist" property             | (if absent, defaults to "corr" values)                                 |
| ml.xxx.corrDist     | "xxx" is a region name specified in "parmRegionNames" property <br> list of distances for -logA0 values listed in "corr" property                 | (if absent, defaults to "corrDist" values)                             |
| ml.xxx.corrVert     | "xxx" is a region name specified in "parmRegionNames" property <br> list of -logA0 values for distances listed in "corrDistVert" property         | (if absent, defaults to horizontal component values)                   |
| ml.xxx.corrVertDist | "xxx" is a region name specified in "parmRegionNames" property <br> list of distances for -logA0 values listed in "corrVert" property)            | (if absent, defaults to horizontal component values)                   |
| parmsRegionNames    | space-delimited list of region names (gazetteer_region table) <br> list the names in nested search order, innermost region first, outermost last. |
| useSlant            | A0 function distance values require slant (hypocentral) distance.                                                                                        | false (default)                                                        |


Both RichterMlMagMethod2 and CISNMlMagMethod2 also accept the properties (listed below) to define data filtering constraints, see comments in the example CISNml2 properties file for CISNMlMagMethod2 shown below.

```markdown
# Scalars to define amplitude period envelopes
minPeriod
minPeriodC1
minPeriodC2
maxPeriod
maxPeriodC1
maxPeriodC2
#
# Scalars to define below-noise or clipped amplitudes
minVelAmp
maxVelAmp
minAccAmp
maxAccAmp
minSummarySNR
#
# Butterworth filter to remove long-period microseisms
bwFilterType (HIPASS or BANDPASS)
bwFilterLoFreq
bwFilterHiFreq
bwFilterOrder
bwFilterScalePassBandByDistance
bwMicroseismMinAmp
bwMicroseismMaxMag
#
# Magnitude versus distance cutoff function scalars
cutoffDistSlope
cutoffDistIntercept
cutoffMag0Km
cutoffPivotMag
cutoffPivotMagKm
cutoffMaxMag
cutoffMaxMagKm
```

## Example of a CISNml2 Magnitude Method Properties File

```markdown
#
#                                            mlMagMeth2.props
#
#In database Applications table
#PROGID NAME         
#------ --------
#  9100 CISNml2      
#
#In database AppChannels table, config=1 for (highgain), config=2 for (lowgain) channels mapped to application
#PROGID NET      STA    SEE LO CONFIG ONDATE              OFFDATE            
#------ -------- ------ --- -- ------ ------------------- -------------------
#  9100 AZ       BZN    HGE -- 2      1900-01-01 00:00:00 3000-01-01 00:00:00
#  9100 AZ       BZN    HGN -- 2      1900-01-01 00:00:00 3000-01-01 00:00:00
#  9100 AZ       BZN    HHE -- 1      1900-01-01 00:00:00 3000-01-01 00:00:00
#  9100 AZ       BZN    HHN -- 1      1900-01-01 00:00:00 3000-01-01 00:00:00
#
#Set true to disable use of AppChannels table mapping of magmethod's progid (e.g. 9100)
disableAppChannelsMap = false
#
#When disableAppChannelsMap=true, use acceptChan seedchan as declared below for channel mag calc
acceptChan=HHE HHN HLN HLE HNN HNE HGE HGN
#
#When disableAppChannelsMap=true, use summaryChan seedchan declared below for summary mag calc
#to be used the seedchan template listed  must be a subset of acceptChan list template
#both HH and HL are used if included (unlike map option, where HL is culled when site HH is present)
summaryChan=HHE HHN HLN HLE HNN HNE HGE HGN
#
#Type of Butterworth secondary filter to apply to filter microseisms from low amp signals
bwFilterType=BANDPASS
#
#Set bwFilterOrder =0 to skip secondary BW bandpass filtering
bwFilterOrder=6
bwFilterLoFreq=0.5
bwFilterHiFreq=20.0
#When below true, bwFilterHiFreq reduced by distance =1./max(minPeriod, 0.05*exp(.0015*slantDist))
bwFilterScalePassBandByDistance=true
#Do not apply secondary filter if channel mag > bwMicroseismMaxMag
bwMicroseismMaxMag=4.5
#apply secondary filter if WAS amp < bwMicroseismMinAmp cm
bwMicroseismMinAmp=0.025
#
#WAS amp rejected or its derivation from waveform skipped when channel distance exceeds cutoff km
#Used to be if (magValue <= 2.0) max(minDistance(), (66.0*magValue - 2.0))
#else (magValue > 2.) cutoffKm = max(minDistance(), (cutoffDistSlope * magValue) - cutoffDistIntercept)
#cutoffDistIntercept=270.0
#cutoffDistSlope=200.0
#Now code states:
#Pivot at ML=2 (600+200)/200=4.0 (600+174/182)=4.25 (600+222/191)=4.3 (600+270)/200=4.35 (600+205)/170=4.74
# if (magValue <= cutoffPivotMag) {
#  cutoffKm = max(minDistance, ((cutoffPivotMagKm-cutoffMag0Km)*magValue/cutoffPivotMag + cutoffMag0Km))
# }
# else {
#  cutoffDistSlope = (cutoffMaxMagKm-cutoffPivotMagKm)/(cutoffMaxMag-cutoffPivotMag) 
#  cutoffDistIntercept = cutoffPivotMagKm - (cutoffDistSlope * cutoffPivotMag) 
#  cutoffKm = max(minDistance, (cutoffDistSlope * magValue + cutoffDistIntercept))
# }
cutoffMag0Km=25
cutoffPivotMag=2
cutoffPivotMagKm=130
cutoffMaxMag=4.35
cutoffMaxMagKm=600
#
#deleteInvalid WAS amp failing clipping, SNR, or period tests not saved to db 
deleteInvalid=true
#delete all rejected WAS for any reason (eg. seedchan type, no correction) not saved to db
deleteRejected=false
#deleteByDistanceTrim WAS amp exceeding maxDistance not saved to db
deleteByDistanceTrim=false
#deleteByResidualTrim WAS amp exceeding trimResidual not saved to db
deleteByResidualTrim=false
#
#disableMagnitudeDistanceCutoff distance rejection not scaled by event magnitude
disableMagnitudeDistanceCutoff=false
#filterCopiesWf true for jiggle, for hypomag false
filterCopiesWf=true
#globalMagCorr not used in Ml
globalMagCorr=0.0
#acceptable WA amp types for Ml
includedReadingTypes=WAS WASF WA WAU WAC 
#
#default HH WAS clipping amp cm, amp > maxVelAmp reject/delete
maxVelAmp=100.0
#default HH noise floor cm, amp < minAccAmp reject/delete 
minVelAmp=0.0010
#default HL WAS clipping amp cm, amp > maxAccAmp reject/delete
maxAccAmp=12000.0
#default HL noise floor cm, amp < minAccAmp reject/delete 
minAccAmp=0.0010
#
#WAS amp slantDist > maxDistance reject/delete 
#Note: a0(r) calibrated only r=500 im, so maxDistance=500 is set in code
#set method delete options to not delete distance trimmed/rejected amps
#to enable saving amps with slantDist > 500 for future A0 calibration
maxDistance=600.0
#
#WAS amp period < minPeriod always reject/delete 
minPeriod=0.040
#WAS amp period > maxPeriod always reject/delete
maxPeriod=5.0
#coefs for WAS period rejection scaled by distance
#do secondary microseism filter if WAS per > maxPeriodC1*exp(maxPeriodC2*wfSlantDist)
#if filtered WAS period > maxPeriodC1*exp(maxPeriodC2*slantDist) reject from summary
maxPeriodC1=0.70
maxPeriodC2=0.0022
#coefs for WAS period rejection scaled by distance, reject per < minPeriodC1*exp(minPeriodC2*slantDist)
minPeriodC1=0.040
minPeriodC2=0.0050
#
#When screening by distance(magnitude), don't reject WAS amp slantDist < minDistance
minDistance=20.0
#
#min SNR=(peakAmp/avgPreEventNoisePeak) acceptable for a channel mag calc
#where minSNR  < = minSummarySNR
minSNR=3.0
#
#min WAS SNR=(peakAmp/avgPreEventNoisePeak) acceptable for event summary mag calc
#where minSummarySNR  >= minSNR
minSummarySNR=5.0
#
#min valid readings needed for event summary mag calculation (channel mag count)
minValidReadings=5
#
#reject/delete WAS whose channel mag resid > trimResidual
trimResidual=1.0
#useAssignedWts=true,WAS amp inWgt = ampQuality*ml_magparms_view.summary_wgt,  else inWgt=1.
useAssignedWts=true
#simple_response gain required for calculation
requireGain=false
#filterChan not used for Ml only Md 
filterChan=
#maxChannels to use for event summary mag
maxChannels=999999
#lookup any missing channel metadata (corrections etc.) in db
channelDbLookUp=true
#use default value 0.5
chauvenetTrimValue=0.5
#require channel magcorr for summary mag calculation, set false if network has no corrections
requireCorrection=true
#scanAllWaveformsForMag=true always true for Ml, usually false for Md (only picked)
scanAllWaveformsForMag=true
#Don't scan entire trace for peak amplitude, only predicted energy window
scanEnergyWindow=true
#reject/delete WAS amp using summary magnitude statistics (ie. Chauvenet)
sumMagStatTrim=true
#velocity model used for determining energy window
velocityModelClassName=org.trinet.util.velocitymodel.HK_SoCalVelocityModel
#
#output for debugging 
debug=false
#detailed output of calculations
verbose=true
```

## Magnitude Engine Properties

| Property Name           | Description                                                                                                                                                                                                                                                                                                                                                    | Value                                                                     |
|-------------------------|----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|---------------------------------------------------------------------------|
| avgStaChannelMags            | if true, each channel mag/weight from a station is set to its average value for the summary magnitude calculation                  | false (default)                                  |
| avgStaChannelMags.reset      | Set all station component magnitude values, corrections, and weight to the calculated station averages                             | true (default)                                   |
| avgStaChannelMags.type       | mags=average of the channel magnitudes of all components,or magnitude calculated from average of all components data values (amps) | amps (default = mags)                            |
| channelDbLookUp              | query db for missing channel lat,lon, or correction data                                                                           | true (default)                                   |
| logMagResiduals              | logs details of channel magnitude residuals                                                                                        | false (default)                                  |
| makePreferredMag             | make calculated summary magnitude the event preferred                                                                              | true (default)                                   |
| addMagToMagList              | add new summary magnitude to solution's magnitude list                                                                             | false (default false except for event preferred) |
| recalcChanMagsForSumMag      | recalculate channel magnitudes (default) or use values as is, for summary mag calc                                                 | true (default)                                   |
| useExistingData              | use existing magnitude associated readings loaded from db rather than create ones from a waveform scan.                            | false (default)                                  |
| defaultChannelListComponents | create new cached channel list derived from db query for listed components                                                         | (property not used)                              |


## Extra Magnitude Engine Properties available for CISNml2 and RichterMl2 mag methods

| Property Name           | Description                                                                                                                                                                                                                                                                                                                                                    | Value                                                                     |
|-------------------------|----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|---------------------------------------------------------------------------|
| nextEventWindowSecs | Check for events whose origin times are within specified seconds post input event <br> If any, set amp scan window's end 2 seconds before the next event's P traveltime to that station. | 0 (default = 0, do not use) |
| nextEventMaxDist    | Excludes any event within nextEventWindowSeconds >0 of current event when located farther than this distance from current magnitude event.                                          | 50 (km default)             |


## Magnitude Engine Properties Available for Batch Applications (not for Jiggle, see jiggle.props) 

| Property Name           | Description                                                                                                                                                                                                                                                                                                                                                    | Value                                                                     |
|-------------------------|----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|---------------------------------------------------------------------------|
| magMethod     | name of magnitude method Java Class used by engine       | org.trinet.jasi.magmethods.myMagMethod             |
| magMethodProp | default property filename for the magnitude method class | myMagMethod.props (default, use engine properties) |



