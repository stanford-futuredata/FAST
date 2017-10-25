function [t, x, Fs] = get_channel_data(file_name, data_name)
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

if (length(strfind(file_name, lower('mseed')))) % read in MiniSEED file
    XX = rdmseed(file_name);
%     t = cat(1,XX.t);
    x = cat(1,XX.d);
    Fs = XX(1).SampleRate;
    delta_t = 1.0 / Fs;
    t = [0:delta_t:delta_t*(length(x)-1)]';
    clear XX;
else % assume it is SAC file
    [t, x, SAChdr] = fread_sac(file_name);
    Fs = round(1.0 / SAChdr.delta);
    delta_t = SAChdr.delta;
end


switch data_name
%     case 'NCSN_Calaveras_7ch_03hr'
%         [t, x, Fs] = get_NCSN_Calaveras_7ch_03hr();
%     case 'NCSN_Calaveras_7ch_24hr'
%         [t, x, Fs] = get_NCSN_Calaveras_7ch_24hr();
%     case 'NCSN_CCOB_EHZ_01hr'
%         [t, x, Fs] = get_NCSN_CCOB_EHZ_01hr();
%     case 'NCSN_CCOB_EHZ_01hr_bp1to10'
%         [t, x, Fs] = get_NCSN_CCOB_EHZ_01hr_bp1to10();
%     case 'NCSN_CCOB_3comp_03hr'
%         [t, x, Fs] = get_NCSN_CCOB_3comp_03hr();
%     case 'NCSN_CCOB_3comp_24hr'
%         [t, x, Fs] = get_NCSN_CCOB_3comp_24hr();
% %----------------------------------------------------------%
    case 'NCSN_CCOB_EHN_3days'
        % Return only first 3 days
        end_sample = 86400*3*Fs;
        t = t(1:end_sample);
        x = x(1:end_sample);
    case 'NCSN_CCOB_EHN_2wk'
        % Return only first 2 weeks (14 days)
        end_sample = 86400*14*Fs;
        t = t(1:end_sample);
        x = x(1:end_sample);
% %----------------------------------------------------------%
%     case 'HRSN_GHIB_BP1_20060509_24hr'
%         [t, x, Fs] = get_HRSN_GHIB_BP1_20060509_24hr();
%     case 'HRSN_GHIB_BP2_20060509_24hr'
%         [t, x, Fs] = get_HRSN_GHIB_BP2_20060509_24hr();
%     case 'HRSN_GHIB_BP3_20060509_24hr'
%         [t, x, Fs] = get_HRSN_GHIB_BP3_20060509_24hr();
    case 'HRSN_EADB_BP1_20060509_24hr'
       % Pad by one element
       t = [t; t(end)+delta_t];
       x = [x; 0];
    case 'HRSN_EADB_BP2_20060509_24hr'
       % Pad by one element
       t = [t; t(end)+delta_t];
       x = [x; 0];
    case 'HRSN_EADB_BP3_20060509_24hr'
       % Pad by one element
       t = [t; t(end)+delta_t];
       x = [x; 0];
%     case 'HRSN_JCNB_BP1_20060509_24hr'
%         [t, x, Fs] = get_HRSN_JCNB_BP1_20060509_24hr();
%     case 'HRSN_JCNB_BP2_20060509_24hr'
%         [t, x, Fs] = get_HRSN_JCNB_BP2_20060509_24hr();
%     case 'HRSN_JCNB_BP3_20060509_24hr'
%         [t, x, Fs] = get_HRSN_JCNB_BP3_20060509_24hr();
%     case 'HRSN_FROB_BP1_20060509_24hr'
%         [t, x, Fs] = get_HRSN_FROB_BP1_20060509_24hr();
%     case 'HRSN_FROB_BP2_20060509_24hr'
%         [t, x, Fs] = get_HRSN_FROB_BP2_20060509_24hr();
%     case 'HRSN_FROB_BP3_20060509_24hr'
%         [t, x, Fs] = get_HRSN_FROB_BP3_20060509_24hr();
    case 'HRSN_VCAB_BP1_20060509_24hr'
       % Pad by one element
       t = [t; t(end)+delta_t];
       x = [x; 0];
    case 'HRSN_VCAB_BP2_20060509_24hr'
       % Pad by one element
       t = [t; t(end)+delta_t];
       x = [x; 0];
    case 'HRSN_VCAB_BP3_20060509_24hr'
       % Pad by one element
       t = [t; t(end)+delta_t];
       x = [x; 0];
%     case 'HRSN_MMNB_BP1_20060509_24hr'
%         [t, x, Fs] = get_HRSN_MMNB_BP1_20060509_24hr();
%     case 'HRSN_MMNB_BP2_20060509_24hr'
%         [t, x, Fs] = get_HRSN_MMNB_BP2_20060509_24hr();
%     case 'HRSN_MMNB_BP3_20060509_24hr'
%         [t, x, Fs] = get_HRSN_MMNB_BP3_20060509_24hr();
%     case 'HRSN_LCCB_BP1_20060509_24hr'
%         [t, x, Fs] = get_HRSN_LCCB_BP1_20060509_24hr();
%     case 'HRSN_LCCB_BP2_20060509_24hr'
%         [t, x, Fs] = get_HRSN_LCCB_BP2_20060509_24hr();
%     case 'HRSN_LCCB_BP3_20060509_24hr'
%         [t, x, Fs] = get_HRSN_LCCB_BP3_20060509_24hr();
%     case 'HRSN_RMNB_BP1_20060509_24hr'
%         [t, x, Fs] = get_HRSN_RMNB_BP1_20060509_24hr();
%     case 'HRSN_RMNB_BP2_20060509_24hr'
%         [t, x, Fs] = get_HRSN_RMNB_BP2_20060509_24hr();
%     case 'HRSN_RMNB_BP3_20060509_24hr'
%         [t, x, Fs] = get_HRSN_RMNB_BP3_20060509_24hr();
%     case 'HRSN_CCRB_BP1_20060509_24hr'
%         [t, x, Fs] = get_HRSN_CCRB_BP1_20060509_24hr();
%     case 'HRSN_CCRB_BP2_20060509_24hr'
%         [t, x, Fs] = get_HRSN_CCRB_BP2_20060509_24hr();
%     case 'HRSN_CCRB_BP3_20060509_24hr'
%         [t, x, Fs] = get_HRSN_CCRB_BP3_20060509_24hr();
%     case 'HRSN_SMNB_BP1_20060509_24hr'
%         [t, x, Fs] = get_HRSN_SMNB_BP1_20060509_24hr();
%     case 'HRSN_SMNB_BP2_20060509_24hr'
%         [t, x, Fs] = get_HRSN_SMNB_BP2_20060509_24hr();
%     case 'HRSN_SMNB_BP3_20060509_24hr'
%         [t, x, Fs] = get_HRSN_SMNB_BP3_20060509_24hr();
%     case 'HRSN_SCYB_BP1_20060509_24hr'
%         [t, x, Fs] = get_HRSN_SCYB_BP1_20060509_24hr();
%     case 'HRSN_SCYB_BP2_20060509_24hr'
%         [t, x, Fs] = get_HRSN_SCYB_BP2_20060509_24hr();
%     case 'HRSN_SCYB_BP3_20060509_24hr'
%         [t, x, Fs] = get_HRSN_SCYB_BP3_20060509_24hr();
%     case 'HRSN_VARB_BP1_20060509_24hr'
%         [t, x, Fs] = get_HRSN_VARB_BP1_20060509_24hr();
%     case 'HRSN_VARB_BP2_20060509_24hr'
%         [t, x, Fs] = get_HRSN_VARB_BP2_20060509_24hr();
%     case 'HRSN_VARB_BP3_20060509_24hr'
%         [t, x, Fs] = get_HRSN_VARB_BP3_20060509_24hr();
%     case 'HRSN_EADB_3comp_24hr'
%         [t, x, Fs] = get_HRSN_EADB_3comp_24hr();
% %----------------------------------------------------------%
%     case 'HRSN_GHIB_BP1_20071026_24hr'
%         [t, x, Fs] = get_HRSN_GHIB_BP1_20071026_24hr();
%     case 'HRSN_GHIB_BP2_20071026_24hr'
%         [t, x, Fs] = get_HRSN_GHIB_BP2_20071026_24hr();
%     case 'HRSN_GHIB_BP3_20071026_24hr'
%         [t, x, Fs] = get_HRSN_GHIB_BP3_20071026_24hr();
%     case 'HRSN_EADB_BP1_20071026_24hr'
%         [t, x, Fs] = get_HRSN_EADB_BP1_20071026_24hr();
%     case 'HRSN_EADB_BP2_20071026_24hr'
%         [t, x, Fs] = get_HRSN_EADB_BP2_20071026_24hr();
%     case 'HRSN_EADB_BP3_20071026_24hr'
%         [t, x, Fs] = get_HRSN_EADB_BP3_20071026_24hr();
%     case 'HRSN_JCNB_BP1_20071026_24hr'
%         [t, x, Fs] = get_HRSN_JCNB_BP1_20071026_24hr();
%     case 'HRSN_JCNB_BP2_20071026_24hr'
%         [t, x, Fs] = get_HRSN_JCNB_BP2_20071026_24hr();
%     case 'HRSN_JCNB_BP3_20071026_24hr'
%         [t, x, Fs] = get_HRSN_JCNB_BP3_20071026_24hr();
%     case 'HRSN_JCSB_BP1_20071026_24hr'
%         [t, x, Fs] = get_HRSN_JCSB_BP1_20071026_24hr();
%     case 'HRSN_JCSB_BP2_20071026_24hr'
%         [t, x, Fs] = get_HRSN_JCSB_BP2_20071026_24hr();
%     case 'HRSN_JCSB_BP3_20071026_24hr'
%         [t, x, Fs] = get_HRSN_JCSB_BP3_20071026_24hr();
%     case 'HRSN_FROB_BP1_20071026_24hr'
%         [t, x, Fs] = get_HRSN_FROB_BP1_20071026_24hr();
%     case 'HRSN_FROB_BP2_20071026_24hr'
%         [t, x, Fs] = get_HRSN_FROB_BP2_20071026_24hr();
%     case 'HRSN_FROB_BP3_20071026_24hr'
%         [t, x, Fs] = get_HRSN_FROB_BP3_20071026_24hr();
%     case 'HRSN_VCAB_BP1_20071026_24hr'
%         [t, x, Fs] = get_HRSN_VCAB_BP1_20071026_24hr();
%     case 'HRSN_VCAB_BP2_20071026_24hr'
%         [t, x, Fs] = get_HRSN_VCAB_BP2_20071026_24hr();
%     case 'HRSN_VCAB_BP3_20071026_24hr'
%         [t, x, Fs] = get_HRSN_VCAB_BP3_20071026_24hr();
%     case 'HRSN_MMNB_BP1_20071026_24hr'
%         [t, x, Fs] = get_HRSN_MMNB_BP1_20071026_24hr();
%     case 'HRSN_MMNB_BP2_20071026_24hr'
%         [t, x, Fs] = get_HRSN_MMNB_BP2_20071026_24hr();
%     case 'HRSN_MMNB_BP3_20071026_24hr'
%         [t, x, Fs] = get_HRSN_MMNB_BP3_20071026_24hr();
%     case 'HRSN_LCCB_BP1_20071026_24hr'
%         [t, x, Fs] = get_HRSN_LCCB_BP1_20071026_24hr();
%     case 'HRSN_LCCB_BP2_20071026_24hr'
%         [t, x, Fs] = get_HRSN_LCCB_BP2_20071026_24hr();
%     case 'HRSN_LCCB_BP3_20071026_24hr'
%         [t, x, Fs] = get_HRSN_LCCB_BP3_20071026_24hr();
%     case 'HRSN_RMNB_BP1_20071026_24hr'
%         [t, x, Fs] = get_HRSN_RMNB_BP1_20071026_24hr();
%     case 'HRSN_RMNB_BP2_20071026_24hr'
%         [t, x, Fs] = get_HRSN_RMNB_BP2_20071026_24hr();
%     case 'HRSN_RMNB_BP3_20071026_24hr'
%         [t, x, Fs] = get_HRSN_RMNB_BP3_20071026_24hr();
%     case 'HRSN_CCRB_BP1_20071026_24hr'
%         [t, x, Fs] = get_HRSN_CCRB_BP1_20071026_24hr();
%     case 'HRSN_CCRB_BP2_20071026_24hr'
%         [t, x, Fs] = get_HRSN_CCRB_BP2_20071026_24hr();
%     case 'HRSN_CCRB_BP3_20071026_24hr'
%         [t, x, Fs] = get_HRSN_CCRB_BP3_20071026_24hr();
%     case 'HRSN_SMNB_BP1_20071026_24hr'
%         [t, x, Fs] = get_HRSN_SMNB_BP1_20071026_24hr();
%     case 'HRSN_SMNB_BP2_20071026_24hr'
%         [t, x, Fs] = get_HRSN_SMNB_BP2_20071026_24hr();
%     case 'HRSN_SMNB_BP3_20071026_24hr'
%         [t, x, Fs] = get_HRSN_SMNB_BP3_20071026_24hr();
%     case 'HRSN_SCYB_BP1_20071026_24hr'
%         [t, x, Fs] = get_HRSN_SCYB_BP1_20071026_24hr();
%     case 'HRSN_SCYB_BP2_20071026_24hr'
%         [t, x, Fs] = get_HRSN_SCYB_BP2_20071026_24hr();
%     case 'HRSN_SCYB_BP3_20071026_24hr'
%         [t, x, Fs] = get_HRSN_SCYB_BP3_20071026_24hr();
%     case 'HRSN_VARB_BP1_20071026_24hr'
%         [t, x, Fs] = get_HRSN_VARB_BP1_20071026_24hr();
%     case 'HRSN_VARB_BP2_20071026_24hr'
%         [t, x, Fs] = get_HRSN_VARB_BP2_20071026_24hr();
%     case 'HRSN_VARB_BP3_20071026_24hr'
%         [t, x, Fs] = get_HRSN_VARB_BP3_20071026_24hr();
% %----------------------------------------------------------%
%     case 'AZ_KNW_01hr'
%         [t, x, Fs] = get_AZ_KNW_01hr();
%     case 'AZ_KNW_24hr'
%         [t, x, Fs] = get_AZ_KNW_24hr();
%     case 'N_HIYH_N_01hr'
%         [t, x, Fs] = get_N_HIYH_N_01hr();
%----------------------------------------------------------%
    case 'WHAR_HHE_20100701_1wk'
        t = t(1:end-1);
        x = x(1:end-1);
        [x] = filter_taper_guy_data(x, Fs); % Filter data 1-20 Hz, normalize
    case 'WHAR_HHN_20100701_1wk'
        t = t(1:end-1);
        x = x(1:end-1);
        [x] = filter_taper_guy_data(x, Fs); % Filter data 1-20 Hz, normalize
    case 'WHAR_HHZ_20100701_1wk'
        t = t(1:end-1);
        x = x(1:end-1);
        [x] = filter_taper_guy_data(x, Fs); % Filter data 1-20 Hz, normalize
    case 'WHAR_HHE_20100701_2wk'
        t = t(1:end-1);
        x = x(1:end-1);
        [x] = filter_taper_guy_data(x, Fs); % Filter data 1-20 Hz, normalize
    case 'WHAR_HHN_20100701_2wk'
        t = t(1:end-1);
        x = x(1:end-1);
        [x] = filter_taper_guy_data(x, Fs); % Filter data 1-20 Hz, normalize
    case 'WHAR_HHZ_20100701_2wk'
        t = t(1:end-1);
        x = x(1:end-1);
        [x] = filter_taper_guy_data(x, Fs); % Filter data 1-20 Hz, normalize
    case 'WHAR_HHE_20100501_2wk'
        [x] = filter_taper_guy_data(x, Fs); % Filter data 1-20 Hz, normalize
    case 'WHAR_HHN_20100501_2wk'
        [x] = filter_taper_guy_data(x, Fs); % Filter data 1-20 Hz, normalize
    case 'WHAR_HHZ_20100501_2wk'
        [x] = filter_taper_guy_data(x, Fs); % Filter data 1-20 Hz, normalize
    case 'WHAR_HHE_20100601_1month'
        t = t(1:end-1);
        x = x(1:end-1);
        [x] = filter_taper_guy_data(x, Fs); % Filter data 1-20 Hz, normalize
    case 'WHAR_HHN_20100601_1month'
        t = t(1:end-1);
        x = x(1:end-1);
        [x] = filter_taper_guy_data(x, Fs); % Filter data 1-20 Hz, normalize
    case 'WHAR_HHZ_20100601_1month'
        t = [t; t(end)+SAChdr.times.delta*[1:15]'];
        x = [x; zeros(15,1)];
        [x] = filter_taper_guy_data(x, Fs); % Filter data 1-20 Hz, normalize
    case 'WHAR_HHE_20100601_3month'
        t = t(1:794880000);
        x = x(1:794880000);
        [x] = filter_taper_guy_data(x, Fs); % Filter data 1-20 Hz, normalize
    case 'WHAR_HHN_20100601_3month'
        t = t(1:794880000);
        x = x(1:794880000);
        [x] = filter_taper_guy_data(x, Fs); % Filter data 1-20 Hz, normalize
    case 'WHAR_HHZ_20100601_3month'
        t = t(1:794880000);
        x = x(1:794880000);
        [x] = filter_taper_guy_data(x, Fs); % Filter data 1-20 Hz, normalize
    case 'WHAR_HHE_20100701_1month'
        t = t(1:end-1);
        x = x(1:end-1);
        [x] = filter_taper_guy_data(x, Fs); % Filter data 1-20 Hz, normalize
    case 'WHAR_HHN_20100701_1month'
        t = t(1:end-1);
        x = x(1:end-1);
        [x] = filter_taper_guy_data(x, Fs); % Filter data 1-20 Hz, normalize
    case 'WHAR_HHZ_20100701_1month'
        t = t(1:end-1);
        x = x(1:end-1);
        [x] = filter_taper_guy_data(x, Fs); % Filter data 1-20 Hz, normalize
    case 'WHAR_HHE_20100801_1month'
        t = t(1:267840000);
        x = x(1:267840000);
        [x] = filter_taper_guy_data(x, Fs); % Filter data 1-20 Hz, normalize
    case 'WHAR_HHN_20100801_1month'
        t = t(1:267840000);
        x = x(1:267840000);
        [x] = filter_taper_guy_data(x, Fs); % Filter data 1-20 Hz, normalize
    case 'WHAR_HHZ_20100801_1month'
        t = t(1:267840000);
        x = x(1:267840000);
        [x] = filter_taper_guy_data(x, Fs); % Filter data 1-20 Hz, normalize
    case 'WHAR_HHE_20101101_01hr'
        t = t(1:end-1);
        x = x(1:end-1);
        [x] = filter_taper_guy_data(x, Fs); % Filter data 1-20 Hz, normalize
    case 'WHAR_HHN_20101101_01hr'
        t = t(1:end-1);
        x = x(1:end-1);
        [x] = filter_taper_guy_data(x, Fs); % Filter data 1-20 Hz, normalize
    case 'WHAR_HHZ_20101101_01hr'
        t = t(1:end-1);
        x = x(1:end-1);
        [x] = filter_taper_guy_data(x, Fs); % Filter data 1-20 Hz, normalize
    case 'WHAR_HHE_20101101_24hr'
        t = t(1:end-1);
        x = x(1:end-1);
        [x] = filter_taper_guy_data(x, Fs); % Filter data 1-20 Hz, normalize
    case 'WHAR_HHN_20101101_24hr'
        t = t(1:end-1);
        x = x(1:end-1);
        [x] = filter_taper_guy_data(x, Fs); % Filter data 1-20 Hz, normalize
    case 'WHAR_HHZ_20101101_24hr'
        t = t(1:end-1);
        x = x(1:end-1);
        [x] = filter_taper_guy_data(x, Fs); % Filter data 1-20 Hz, normalize
    case 'WHAR_HHE_20101101_1month'
        t = t(1:259200000);
        x = x(1:259200000);
        [x] = filter_taper_guy_data(x, Fs); % Filter data 1-20 Hz, normalize
    case 'WHAR_HHN_20101101_1month'
        t = t(1:259200000);
        x = x(1:259200000);
        [x] = filter_taper_guy_data(x, Fs); % Filter data 1-20 Hz, normalize
    case 'WHAR_HHZ_20101101_1month'
        t = t(1:259200000);
        x = x(1:259200000);
        [x] = filter_taper_guy_data(x, Fs); % Filter data 1-20 Hz, normalize
%----------------------------------------------------------%
    case 'IG_PNIG_HHE_2to3day_24hr_Filter3to30'
        t = t(1:end-1);
        x = x(1:end-1);
    case 'IG_PNIG_HHN_2to3day_24hr_Filter3to30'
        t = t(1:end-1);
        x = x(1:end-1);
    case 'IG_PNIG_HHZ_2to3day_24hr_Filter3to30'
        t = t(1:end-1);
        x = x(1:end-1);
    case 'IG_PNIG_HHE_2to3day_24hr_Filter3to20'
        t = t(1:end-1);
        x = x(1:end-1);
    case 'IG_PNIG_HHN_2to3day_24hr_Filter3to20'
        t = t(1:end-1);
        x = x(1:end-1);
    case 'IG_PNIG_HHZ_2to3day_24hr_Filter3to20'
        t = t(1:end-1);
        x = x(1:end-1);
    case 'IG_PNIG_HHE_2day_4hr_Part1_Filter3to20'
        t = t(1:end-1);
        x = x(1:end-1);
    case 'IG_PNIG_HHE_2day_4hr_Part2_Filter3to20'
        t = t(1:end-1);
        x = x(1:end-1);
    case 'IG_PNIG_HHE_2day_4hr_Part3_Filter3to20'
        t = t(1:end-1);
        x = x(1:end-1);
    case 'IG_PNIG_HHE_2day_4hr_Part4_Filter3to20'
        t = t(1:end-1);
        x = x(1:end-1);
    case 'IG_PNIG_HHE_2day_4hr_Part5_Filter3to20'
        t = t(1:end-1);
        x = x(1:end-1);
    case 'IG_PNIG_HHE_2day_4hr_Part6_Filter3to20'
        t = t(1:end-1);
        x = x(1:end-1);
    case 'IG_PNIG_HHE_8day_4hr_Part1_Filter3to20'
        t = t(1:end-1);
        x = x(1:end-1);
    case 'IG_PNIG_HHE_8day_4hr_Part2_Filter3to20'
        t = t(1:end-1);
        x = x(1:end-1);
    case 'IG_PNIG_HHE_8day_4hr_Part3_Filter3to20'
        t = t(1:end-1);
        x = x(1:end-1);
    case 'IG_PNIG_HHE_8day_4hr_Part4_Filter3to20'
        t = t(1:end-1);
        x = x(1:end-1);
    case 'IG_PNIG_HHE_8day_4hr_Part5_Filter3to20'
        t = t(1:end-1);
        x = x(1:end-1);
    case 'IG_PNIG_HHE_8day_4hr_Part6_Filter3to20'
        t = t(1:end-1);
        x = x(1:end-1);
    case 'IG_PNIG_HHE_2to3day_24hr_Filter1to8'
        t = t(1:end-1);
        x = x(1:end-1);
    case 'IG_PNIG_HHN_2to3day_24hr_Filter1to8'
        t = t(1:end-1);
        x = x(1:end-1);
    case 'IG_PNIG_HHZ_2to3day_24hr_Filter1to8'
        t = t(1:end-1);
        x = x(1:end-1);
    case 'IG_PNIG_HHE_2to3day_24hr_Unfilt'
        t = t(1:end-1);
        x = x(1:end-1);
    case 'IG_PNIG_HHN_2to3day_24hr_Unfilt'
        t = t(1:end-1);
        x = x(1:end-1);
    case 'IG_PNIG_HHZ_2to3day_24hr_Unfilt'
        t = t(1:end-1);
        x = x(1:end-1);
    case 'IG_PNIG_HHE_8to9day_24hr_Filter3to30'
        t = t(1:end-1);
        x = x(1:end-1);
    case 'IG_PNIG_HHN_8to9day_24hr_Filter3to30'
        t = t(1:end-1);
        x = x(1:end-1);
    case 'IG_PNIG_HHZ_8to9day_24hr_Filter3to30'
        t = t(1:end-1);
        x = x(1:end-1);
    case 'IG_PNIG_HHE_8to9day_24hr_Filter3to20'
        t = t(1:end-1);
        x = x(1:end-1);
    case 'IG_PNIG_HHN_8to9day_24hr_Filter3to20'
        t = t(1:end-1);
        x = x(1:end-1);
    case 'IG_PNIG_HHZ_8to9day_24hr_Filter3to20'
        t = t(1:end-1);
        x = x(1:end-1);
    case 'IG_PNIG_HHE_10to11day_24hr_Filter3to20'
        t = t(1:end-1);
        x = x(1:end-1);
    case 'IG_PNIG_HHN_10to11day_24hr_Filter3to20'
        t = t(1:end-1);
        x = x(1:end-1);
    case 'IG_PNIG_HHZ_10to11day_24hr_Filter3to20'
        t = t(1:end-1);
        x = x(1:end-1);
    case 'IG_PNIG_HHE_8to9day_24hr_Filter1to8'
        t = t(1:end-1);
        x = x(1:end-1);
    case 'IG_PNIG_HHN_8to9day_24hr_Filter1to8'
        t = t(1:end-1);
        x = x(1:end-1);
    case 'IG_PNIG_HHZ_8to9day_24hr_Filter1to8'
        t = t(1:end-1);
        x = x(1:end-1);
    case 'IG_PNIG_HHE_8to9day_24hr_Unfilt'
        t = t(1:end-1);
        x = x(1:end-1);
    case 'IG_PNIG_HHN_8to9day_24hr_Unfilt'
        t = t(1:end-1);
        x = x(1:end-1);
    case 'IG_PNIG_HHZ_8to9day_24hr_Unfilt'
        t = t(1:end-1);
        x = x(1:end-1);
    case 'IG_PNIG_HHE_2day_1hr_Filter3to20'
        t = t(1:end-1);
        x = x(1:end-1);
    case 'IG_PNIG_HHE_8day_1hr_Filter3to20'
        t = t(1:end-1);
        x = x(1:end-1);
%----------------------------------------------------------%
%     case 'CI_CDY_EHZ_20hr'
%         [t, x, Fs] = get_CI_CPM_EHZ_20hr();
%     case 'CI_GTM_EHZ_20hr'
%         [t, x, Fs] = get_CI_GTM_EHZ_20hr();
%     case 'CI_RMM_EHZ_20hr'
%         [t, x, Fs] = get_CI_RMM_EHZ_20hr();
%     case 'CI_RMR_EHZ_20hr'
%         [t, x, Fs] = get_CI_RMR_EHZ_20hr();
%     case 'CI_TPC_EHZ_20hr'
%         [t, x, Fs] = get_CI_TPC_EHZ_20hr();
%     case 'CI_HEC_BHZ_20hr'
%         [t, x, Fs] = get_CI_HEC_BHZ_20hr();
%     case 'CI_HEC_BHN_20hr'
%         [t, x, Fs] = get_CI_HEC_BHN_20hr();
%     case 'CI_HEC_BHE_20hr'
%         [t, x, Fs] = get_CI_HEC_BHE_20hr();
end

end

