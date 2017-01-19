from obspy import read
from obspy import Stream
from obspy import Trace
from obspy.signal import filter
import matplotlib.pyplot as plt
import numpy as np

sac_dir = '/data/cees/ceyoon/multiple_components/data/ncsn/NC_CCOB_EHN_2011_3month/'
#origchannel = read(sac_dir+'NC.CCOB..EHN.D.2011,001,00:00:00.SAC')
#deci_outfile = 'obspy.deci5.NC.CCOB..EHN.D.2011,001,00:00:00.SAC.bp4to10'
origchannel = read(sac_dir+'3month.2011.001.000000.NC.CCOB..EHN.D.SAC')
deci_outfile = '3month.2011.001.000000.deci5.NC.CCOB..EHN.D.SAC.bp4to10'

#sac_dir = '/data/beroza/ceyoon/multiple_components/data/ncsn/NC_CCOB_EHN_2011_6month/'
#origchannel = read(sac_dir+'6month.2011.001.000000.NC.CCOB..EHN.D.SAC')
#deci_outfile = '6month.2011.001.000000.deci5.NC.CCOB..EHN.D.SAC.bp4to10'

#sac_dir = '/data/beroza/ceyoon/multiple_components/data/ncsn/NC_CCOB_EHN_2011_1year/'
#origchannel = read(sac_dir+'1year.2011.001.000000.NC.CCOB..EHN.D.SAC')
#deci_outfile = '1year.2011.001.000000.deci5.NC.CCOB..EHN.D.SAC.bp4to10'
#origchannel = read(sac_dir+'Part1.1year.2011.001.000000.NC.CCOB..EHN.D.SAC')
#deci_outfile = 'Part1.1year.2011.001.000000.deci5.NC.CCOB..EHN.D.SAC.bp4to10'
#origchannel = read(sac_dir+'Part2.1year.2011.001.000000.NC.CCOB..EHN.D.SAC')
#deci_outfile = 'Part2.1year.2011.001.000000.deci5.NC.CCOB..EHN.D.SAC.bp4to10'

#sac_dir = '/data/cees/ceyoon/multiple_components/data/ncsn/'
#origchannel = read(sac_dir+'1week.2011.008.00.00.00.0000.NC.CCOB..EHN.D.SAC')
#deci_outfile = 'obspy.1week.2011.008.00.00.00.0000.deci5.NC.CCOB..EHN.D.SAC.bp4to10'

df = origchannel[0].stats.sampling_rate
print "original sampling rate = ", df

# 2 passes, 2 poles Butterworth filter
filtchannel = origchannel.copy()
filtchannel.filter('bandpass', freqmin=4, freqmax=10, corners=2, zerophase=True)

# Decimate data
factor = 5
print "sampling rate after decimation = ", df/factor

maxfreq = (origchannel[0].stats.sampling_rate/factor)/2
print "maxfreq = ", maxfreq

decchannel = filtchannel.copy()
#decchannel.filter('lowpass', freq=maxfreq, corners=2, zerophase=True) # zero phase anti alias filter
filter.lowpass(decchannel, maxfreq, df, corners=2, zerophase=True) # zero phase anti alias filter - this works better
decchannel.decimate(factor, no_filter=True)

print "len(decchannel) = ", decchannel[0].stats.npts
print "sampling rate(decchannel) = ", decchannel[0].stats.sampling_rate

# write to SAC file
decchannel.write(deci_outfile, format='SAC')
