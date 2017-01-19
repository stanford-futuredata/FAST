function [t, x, Fs] = get_channel_data(data_name)
% Interface to functions that read in different types of data
% Single channel, single station
% 
% Usage:
% [t, x, Fs] = get_channel_data(data_name)
%
% Inputs:
% data_name: Name of data source
%
% Outputs:
% t:  time vector (s)
% x:  seismogram time series
% Fs: sampling rate (Hz)

switch data_name
    case 'NCSN_Calaveras_7ch_03hr'
        [t, x, Fs] = get_NCSN_Calaveras_7ch_03hr();
    case 'NCSN_Calaveras_7ch_24hr'
        [t, x, Fs] = get_NCSN_Calaveras_7ch_24hr();
    case 'NCSN_CCOB_EHZ_01hr'
        [t, x, Fs] = get_NCSN_CCOB_EHZ_01hr();
    case 'NCSN_CCOB_EHZ_01hr_bp1to10'
        [t, x, Fs] = get_NCSN_CCOB_EHZ_01hr_bp1to10();
    case 'NCSN_CCOB_3comp_03hr'
        [t, x, Fs] = get_NCSN_CCOB_3comp_03hr();
    case 'NCSN_CCOB_3comp_24hr'
        [t, x, Fs] = get_NCSN_CCOB_3comp_24hr();
    case 'NCSN_CCOB_EHN_24hr'
        [t, x, Fs] = get_NCSN_CCOB_EHN_24hr();
    case 'NCSN_CCOB_EHE_24hr'
        [t, x, Fs] = get_NCSN_CCOB_EHE_24hr();    
    case 'NCSN_CCOB_EHZ_24hr'
        [t, x, Fs] = get_NCSN_CCOB_EHZ_24hr();
    case 'NCSN_CADB_EHZ_24hr'
        [t, x, Fs] = get_NCSN_CADB_EHZ_24hr();
    case 'NCSN_CAO_EHZ_24hr'
        [t, x, Fs] = get_NCSN_CAO_EHZ_24hr();
    case 'NCSN_CHR_EHZ_24hr'
        [t, x, Fs] = get_NCSN_CHR_EHZ_24hr();
    case 'NCSN_CML_EHZ_24hr'
        [t, x, Fs] = get_NCSN_CML_EHZ_24hr();
%----------------------------------------------------------%
    case 'NCSN_CCOB_EHE_1wk'
        [t, x, Fs] = get_NCSN_CCOB_EHE_1wk();
    case 'NCSN_CCOB_EHN_1wk'
        [t, x, Fs] = get_NCSN_CCOB_EHN_1wk();
    case 'NCSN_CCOB_EHZ_1wk'
        [t, x, Fs] = get_NCSN_CCOB_EHZ_1wk();
    case 'NCSN_CADB_EHZ_1wk'
        [t, x, Fs] = get_NCSN_CADB_EHZ_1wk();
    case 'NCSN_CAO_EHZ_bp2to6_1wk'
        [t, x, Fs] = get_NCSN_CAO_EHZ_bp2to6_1wk();
    case 'NCSN_CAO_EHZ_1wk'
        [t, x, Fs] = get_NCSN_CAO_EHZ_1wk();
    case 'NCSN_CHR_EHZ_1wk'
        [t, x, Fs] = get_NCSN_CHR_EHZ_1wk();
    case 'NCSN_CML_EHZ_1wk'
        [t, x, Fs] = get_NCSN_CML_EHZ_1wk();
%----------------------------------------------------------%
    case 'NCSN_CCOB_EHN_3days'
        [t, x, Fs] = get_NCSN_CCOB_EHN_3days();
    case 'NCSN_CCOB_EHN_2wk'
        [t, x, Fs] = get_NCSN_CCOB_EHN_2wk();
    case 'NCSN_CCOB_EHN_1month'
        [t, x, Fs] = get_NCSN_CCOB_EHN_1month();
    case 'NCSN_CCOB_EHN_3month'
        [t, x, Fs] = get_NCSN_CCOB_EHN_3month();
    case 'NCSN_CCOB_EHN_6month'
        [t, x, Fs] = get_NCSN_CCOB_EHN_6month();
%----------------------------------------------------------%
% Synthetic data
    case {'synthetic_NCSN_CCOB_EHN_12hr_24_36_amp1', ...
    'synthetic_NCSN_CCOB_EHN_12hr_24_36_amp0.5', ...
    'synthetic_NCSN_CCOB_EHN_12hr_24_36_amp0.1', ...
    'synthetic_NCSN_CCOB_EHN_12hr_24_36_amp0.05', ...
    'synthetic_NCSN_CCOB_EHN_12hr_24_36_amp0.04', ...
    'synthetic_NCSN_CCOB_EHN_12hr_24_36_amp0.03', ...
    'synthetic_NCSN_CCOB_EHN_12hr_24_36_amp0.02', ...
    'synthetic_NCSN_CCOB_EHN_12hr_24_36_amp0.01'}
        [t, x, Fs] = get_synthetic_NCSN_CCOB_EHN_24_36_12hr();
    case {'synthetic_NCSN_CCOB_EHN_12hr_69_81_amp1', ...
    'synthetic_NCSN_CCOB_EHN_12hr_69_81_amp0.5', ...
    'synthetic_NCSN_CCOB_EHN_12hr_69_81_amp0.1', ...
    'synthetic_NCSN_CCOB_EHN_12hr_69_81_amp0.05', ...
    'synthetic_NCSN_CCOB_EHN_12hr_69_81_amp0.04', ...
    'synthetic_NCSN_CCOB_EHN_12hr_69_81_amp0.03', ...
    'synthetic_NCSN_CCOB_EHN_12hr_69_81_amp0.02', ...
    'synthetic_NCSN_CCOB_EHN_12hr_69_81_amp0.01'}
        [t, x, Fs] = get_synthetic_NCSN_CCOB_EHN_69_81_12hr();
%----------------------------------------------------------%
    case 'HRSN_GHIB_BP1_20060509_24hr'
        [t, x, Fs] = get_HRSN_GHIB_BP1_20060509_24hr();
    case 'HRSN_GHIB_BP2_20060509_24hr'
        [t, x, Fs] = get_HRSN_GHIB_BP2_20060509_24hr();
    case 'HRSN_GHIB_BP3_20060509_24hr'
        [t, x, Fs] = get_HRSN_GHIB_BP3_20060509_24hr();
    case 'HRSN_EADB_BP1_20060509_24hr'
        [t, x, Fs] = get_HRSN_EADB_BP1_20060509_24hr();
    case 'HRSN_EADB_BP2_20060509_24hr'
        [t, x, Fs] = get_HRSN_EADB_BP2_20060509_24hr();
    case 'HRSN_EADB_BP3_20060509_24hr'
        [t, x, Fs] = get_HRSN_EADB_BP3_20060509_24hr();
    case 'HRSN_JCNB_BP1_20060509_24hr'
        [t, x, Fs] = get_HRSN_JCNB_BP1_20060509_24hr();
    case 'HRSN_JCNB_BP2_20060509_24hr'
        [t, x, Fs] = get_HRSN_JCNB_BP2_20060509_24hr();
    case 'HRSN_JCNB_BP3_20060509_24hr'
        [t, x, Fs] = get_HRSN_JCNB_BP3_20060509_24hr();
    case 'HRSN_FROB_BP1_20060509_24hr'
        [t, x, Fs] = get_HRSN_FROB_BP1_20060509_24hr();
    case 'HRSN_FROB_BP2_20060509_24hr'
        [t, x, Fs] = get_HRSN_FROB_BP2_20060509_24hr();
    case 'HRSN_FROB_BP3_20060509_24hr'
        [t, x, Fs] = get_HRSN_FROB_BP3_20060509_24hr();
    case 'HRSN_VCAB_BP1_20060509_24hr'
        [t, x, Fs] = get_HRSN_VCAB_BP1_20060509_24hr();
    case 'HRSN_VCAB_BP2_20060509_24hr'
        [t, x, Fs] = get_HRSN_VCAB_BP2_20060509_24hr();
    case 'HRSN_VCAB_BP3_20060509_24hr'
        [t, x, Fs] = get_HRSN_VCAB_BP3_20060509_24hr();
    case 'HRSN_MMNB_BP1_20060509_24hr'
        [t, x, Fs] = get_HRSN_MMNB_BP1_20060509_24hr();
    case 'HRSN_MMNB_BP2_20060509_24hr'
        [t, x, Fs] = get_HRSN_MMNB_BP2_20060509_24hr();
    case 'HRSN_MMNB_BP3_20060509_24hr'
        [t, x, Fs] = get_HRSN_MMNB_BP3_20060509_24hr();
    case 'HRSN_LCCB_BP1_20060509_24hr'
        [t, x, Fs] = get_HRSN_LCCB_BP1_20060509_24hr();
    case 'HRSN_LCCB_BP2_20060509_24hr'
        [t, x, Fs] = get_HRSN_LCCB_BP2_20060509_24hr();
    case 'HRSN_LCCB_BP3_20060509_24hr'
        [t, x, Fs] = get_HRSN_LCCB_BP3_20060509_24hr();
    case 'HRSN_RMNB_BP1_20060509_24hr'
        [t, x, Fs] = get_HRSN_RMNB_BP1_20060509_24hr();
    case 'HRSN_RMNB_BP2_20060509_24hr'
        [t, x, Fs] = get_HRSN_RMNB_BP2_20060509_24hr();
    case 'HRSN_RMNB_BP3_20060509_24hr'
        [t, x, Fs] = get_HRSN_RMNB_BP3_20060509_24hr();
    case 'HRSN_CCRB_BP1_20060509_24hr'
        [t, x, Fs] = get_HRSN_CCRB_BP1_20060509_24hr();
    case 'HRSN_CCRB_BP2_20060509_24hr'
        [t, x, Fs] = get_HRSN_CCRB_BP2_20060509_24hr();
    case 'HRSN_CCRB_BP3_20060509_24hr'
        [t, x, Fs] = get_HRSN_CCRB_BP3_20060509_24hr();
    case 'HRSN_SMNB_BP1_20060509_24hr'
        [t, x, Fs] = get_HRSN_SMNB_BP1_20060509_24hr();
    case 'HRSN_SMNB_BP2_20060509_24hr'
        [t, x, Fs] = get_HRSN_SMNB_BP2_20060509_24hr();
    case 'HRSN_SMNB_BP3_20060509_24hr'
        [t, x, Fs] = get_HRSN_SMNB_BP3_20060509_24hr();
    case 'HRSN_SCYB_BP1_20060509_24hr'
        [t, x, Fs] = get_HRSN_SCYB_BP1_20060509_24hr();
    case 'HRSN_SCYB_BP2_20060509_24hr'
        [t, x, Fs] = get_HRSN_SCYB_BP2_20060509_24hr();
    case 'HRSN_SCYB_BP3_20060509_24hr'
        [t, x, Fs] = get_HRSN_SCYB_BP3_20060509_24hr();
    case 'HRSN_VARB_BP1_20060509_24hr'
        [t, x, Fs] = get_HRSN_VARB_BP1_20060509_24hr();
    case 'HRSN_VARB_BP2_20060509_24hr'
        [t, x, Fs] = get_HRSN_VARB_BP2_20060509_24hr();
    case 'HRSN_VARB_BP3_20060509_24hr'
        [t, x, Fs] = get_HRSN_VARB_BP3_20060509_24hr();
    case 'HRSN_EADB_3comp_24hr'
        [t, x, Fs] = get_HRSN_EADB_3comp_24hr();
%----------------------------------------------------------%
    case 'HRSN_GHIB_BP1_20071026_24hr'
        [t, x, Fs] = get_HRSN_GHIB_BP1_20071026_24hr();
    case 'HRSN_GHIB_BP2_20071026_24hr'
        [t, x, Fs] = get_HRSN_GHIB_BP2_20071026_24hr();
    case 'HRSN_GHIB_BP3_20071026_24hr'
        [t, x, Fs] = get_HRSN_GHIB_BP3_20071026_24hr();
    case 'HRSN_EADB_BP1_20071026_24hr'
        [t, x, Fs] = get_HRSN_EADB_BP1_20071026_24hr();
    case 'HRSN_EADB_BP2_20071026_24hr'
        [t, x, Fs] = get_HRSN_EADB_BP2_20071026_24hr();
    case 'HRSN_EADB_BP3_20071026_24hr'
        [t, x, Fs] = get_HRSN_EADB_BP3_20071026_24hr();
    case 'HRSN_JCNB_BP1_20071026_24hr'
        [t, x, Fs] = get_HRSN_JCNB_BP1_20071026_24hr();
    case 'HRSN_JCNB_BP2_20071026_24hr'
        [t, x, Fs] = get_HRSN_JCNB_BP2_20071026_24hr();
    case 'HRSN_JCNB_BP3_20071026_24hr'
        [t, x, Fs] = get_HRSN_JCNB_BP3_20071026_24hr();
    case 'HRSN_JCSB_BP1_20071026_24hr'
        [t, x, Fs] = get_HRSN_JCSB_BP1_20071026_24hr();
    case 'HRSN_JCSB_BP2_20071026_24hr'
        [t, x, Fs] = get_HRSN_JCSB_BP2_20071026_24hr();
    case 'HRSN_JCSB_BP3_20071026_24hr'
        [t, x, Fs] = get_HRSN_JCSB_BP3_20071026_24hr();
    case 'HRSN_FROB_BP1_20071026_24hr'
        [t, x, Fs] = get_HRSN_FROB_BP1_20071026_24hr();
    case 'HRSN_FROB_BP2_20071026_24hr'
        [t, x, Fs] = get_HRSN_FROB_BP2_20071026_24hr();
    case 'HRSN_FROB_BP3_20071026_24hr'
        [t, x, Fs] = get_HRSN_FROB_BP3_20071026_24hr();
    case 'HRSN_VCAB_BP1_20071026_24hr'
        [t, x, Fs] = get_HRSN_VCAB_BP1_20071026_24hr();
    case 'HRSN_VCAB_BP2_20071026_24hr'
        [t, x, Fs] = get_HRSN_VCAB_BP2_20071026_24hr();
    case 'HRSN_VCAB_BP3_20071026_24hr'
        [t, x, Fs] = get_HRSN_VCAB_BP3_20071026_24hr();
    case 'HRSN_MMNB_BP1_20071026_24hr'
        [t, x, Fs] = get_HRSN_MMNB_BP1_20071026_24hr();
    case 'HRSN_MMNB_BP2_20071026_24hr'
        [t, x, Fs] = get_HRSN_MMNB_BP2_20071026_24hr();
    case 'HRSN_MMNB_BP3_20071026_24hr'
        [t, x, Fs] = get_HRSN_MMNB_BP3_20071026_24hr();
    case 'HRSN_LCCB_BP1_20071026_24hr'
        [t, x, Fs] = get_HRSN_LCCB_BP1_20071026_24hr();
    case 'HRSN_LCCB_BP2_20071026_24hr'
        [t, x, Fs] = get_HRSN_LCCB_BP2_20071026_24hr();
    case 'HRSN_LCCB_BP3_20071026_24hr'
        [t, x, Fs] = get_HRSN_LCCB_BP3_20071026_24hr();
    case 'HRSN_RMNB_BP1_20071026_24hr'
        [t, x, Fs] = get_HRSN_RMNB_BP1_20071026_24hr();
    case 'HRSN_RMNB_BP2_20071026_24hr'
        [t, x, Fs] = get_HRSN_RMNB_BP2_20071026_24hr();
    case 'HRSN_RMNB_BP3_20071026_24hr'
        [t, x, Fs] = get_HRSN_RMNB_BP3_20071026_24hr();
    case 'HRSN_CCRB_BP1_20071026_24hr'
        [t, x, Fs] = get_HRSN_CCRB_BP1_20071026_24hr();
    case 'HRSN_CCRB_BP2_20071026_24hr'
        [t, x, Fs] = get_HRSN_CCRB_BP2_20071026_24hr();
    case 'HRSN_CCRB_BP3_20071026_24hr'
        [t, x, Fs] = get_HRSN_CCRB_BP3_20071026_24hr();
    case 'HRSN_SMNB_BP1_20071026_24hr'
        [t, x, Fs] = get_HRSN_SMNB_BP1_20071026_24hr();
    case 'HRSN_SMNB_BP2_20071026_24hr'
        [t, x, Fs] = get_HRSN_SMNB_BP2_20071026_24hr();
    case 'HRSN_SMNB_BP3_20071026_24hr'
        [t, x, Fs] = get_HRSN_SMNB_BP3_20071026_24hr();
    case 'HRSN_SCYB_BP1_20071026_24hr'
        [t, x, Fs] = get_HRSN_SCYB_BP1_20071026_24hr();
    case 'HRSN_SCYB_BP2_20071026_24hr'
        [t, x, Fs] = get_HRSN_SCYB_BP2_20071026_24hr();
    case 'HRSN_SCYB_BP3_20071026_24hr'
        [t, x, Fs] = get_HRSN_SCYB_BP3_20071026_24hr();
    case 'HRSN_VARB_BP1_20071026_24hr'
        [t, x, Fs] = get_HRSN_VARB_BP1_20071026_24hr();
    case 'HRSN_VARB_BP2_20071026_24hr'
        [t, x, Fs] = get_HRSN_VARB_BP2_20071026_24hr();
    case 'HRSN_VARB_BP3_20071026_24hr'
        [t, x, Fs] = get_HRSN_VARB_BP3_20071026_24hr();
%----------------------------------------------------------%
    case 'AZ_KNW_01hr'
        [t, x, Fs] = get_AZ_KNW_01hr();
    case 'AZ_KNW_24hr'
        [t, x, Fs] = get_AZ_KNW_24hr();
    case 'N_HIYH_N_01hr'
        [t, x, Fs] = get_N_HIYH_N_01hr();
%----------------------------------------------------------%
    case 'WHAR_HHE_20100701_1wk'
        [t, x, Fs] = get_WHAR_HHE_20100701_1wk();
    case 'WHAR_HHN_20100701_1wk'
        [t, x, Fs] = get_WHAR_HHN_20100701_1wk();
    case 'WHAR_HHZ_20100701_1wk'
        [t, x, Fs] = get_WHAR_HHZ_20100701_1wk();
    case 'WHAR_HHE_20100701_2wk'
        [t, x, Fs] = get_WHAR_HHE_20100701_2wk();
    case 'WHAR_HHN_20100701_2wk'
        [t, x, Fs] = get_WHAR_HHN_20100701_2wk();
    case 'WHAR_HHZ_20100701_2wk'
        [t, x, Fs] = get_WHAR_HHZ_20100701_2wk();
    case 'WHAR_HHE_20100501_2wk'
        [t, x, Fs] = get_WHAR_HHE_20100501_2wk();
    case 'WHAR_HHN_20100501_2wk'
        [t, x, Fs] = get_WHAR_HHN_20100501_2wk();
    case 'WHAR_HHZ_20100501_2wk'
        [t, x, Fs] = get_WHAR_HHZ_20100501_2wk();
    case 'WHAR_HHE_20100601_1month'
        [t, x, Fs] = get_WHAR_HHE_20100601_1month();
    case 'WHAR_HHN_20100601_1month'
        [t, x, Fs] = get_WHAR_HHN_20100601_1month();
    case 'WHAR_HHZ_20100601_1month'
        [t, x, Fs] = get_WHAR_HHZ_20100601_1month();
    case 'WHAR_HHE_20100601_3month'
        [t, x, Fs] = get_WHAR_HHE_20100601_3month();
    case 'WHAR_HHN_20100601_3month'
        [t, x, Fs] = get_WHAR_HHN_20100601_3month();
    case 'WHAR_HHZ_20100601_3month'
        [t, x, Fs] = get_WHAR_HHZ_20100601_3month();
    case 'WHAR_HHE_20100701_1month'
        [t, x, Fs] = get_WHAR_HHE_20100701_1month();
    case 'WHAR_HHN_20100701_1month'
        [t, x, Fs] = get_WHAR_HHN_20100701_1month();
    case 'WHAR_HHZ_20100701_1month'
        [t, x, Fs] = get_WHAR_HHZ_20100701_1month();
    case 'WHAR_HHE_20100801_1month'
        [t, x, Fs] = get_WHAR_HHE_20100801_1month();
    case 'WHAR_HHN_20100801_1month'
        [t, x, Fs] = get_WHAR_HHN_20100801_1month();
    case 'WHAR_HHZ_20100801_1month'
        [t, x, Fs] = get_WHAR_HHZ_20100801_1month();
    case 'WHAR_HHE_20101101_01hr'
        [t, x, Fs] = get_WHAR_HHE_20101101_01hr();
    case 'WHAR_HHN_20101101_01hr'
        [t, x, Fs] = get_WHAR_HHN_20101101_01hr();
    case 'WHAR_HHZ_20101101_01hr'
        [t, x, Fs] = get_WHAR_HHZ_20101101_01hr();
    case 'WHAR_HHE_20101101_24hr'
        [t, x, Fs] = get_WHAR_HHE_20101101_24hr();
    case 'WHAR_HHN_20101101_24hr'
        [t, x, Fs] = get_WHAR_HHN_20101101_24hr();
    case 'WHAR_HHZ_20101101_24hr'
        [t, x, Fs] = get_WHAR_HHZ_20101101_24hr();
    case 'WHAR_HHE_20101101_1month'
        [t, x, Fs] = get_WHAR_HHE_20101101_1month();
    case 'WHAR_HHN_20101101_1month'
        [t, x, Fs] = get_WHAR_HHN_20101101_1month();
    case 'WHAR_HHZ_20101101_1month'
        [t, x, Fs] = get_WHAR_HHZ_20101101_1month();
end

end

