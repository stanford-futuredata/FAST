from obspy import read

# Applies bandpass filter using ObsPy
data_dir = '/data/beroza/ceyoon/FASTcode/'

# Inputs
sac_dir = data_dir+'data/TimeSeries/Ometepec/'
sac_files = 'RAW/Fill.15days.201203.PNIG.HH*.sac'
#sac_dir = data_dir+'data/TimeSeries/HectorMine/Unfiltered/'
#sac_files = 'Deci5.NoGlitchCutoff20hr.19991015130000.CI.TPC.EHZ.SAC'

# Filter band
file_ext = '.unfilt'

#file_ext = '.bp1to8'
#freq_min = 1
#freq_max = 8

#file_ext = '.bp3to30'
#freq_min = 3
#freq_max = 30

#file_ext = '.bp3to20'
#freq_min = 3
#freq_max = 20

#file_ext = '.hp1_bps6to8'
#freq_min = 1
#freq_stop_min = 6
#freq_stop_max = 8

# Read data
allch = read(sac_dir+sac_files)
nch = len(allch)
print nch

# Filter data
filtch = allch.copy()
filtch.detrend(type='demean')
filtch.detrend(type='linear')
#filtch.filter('highpass', freq=freq_min, corners=2, zerophase=False)
#filtch.filter('bandstop', freqmin=freq_stop_min, freqmax=freq_stop_max, corners=2, zerophase=False)
#filtch.filter('bandpass', freqmin=freq_min, freqmax = freq_max, corners=2, zerophase=False)
print filtch

# Output filtered data as SAC files
filtch[0].write(sac_dir+'Fill.15days.201203.PNIG.HHE.sac'+file_ext, format='SAC')
filtch[1].write(sac_dir+'Fill.15days.201203.PNIG.HHN.sac'+file_ext, format='SAC')
filtch[2].write(sac_dir+'Fill.15days.201203.PNIG.HHZ.sac'+file_ext, format='SAC')
#filtch[0].write(sac_dir+sac_files+file_ext, format='SAC')
