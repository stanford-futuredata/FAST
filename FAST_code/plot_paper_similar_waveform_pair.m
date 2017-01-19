close all
clear

% Plot steps of fingerprint algorithm
addpath('input_data');
[t, x, samplingRate] = get_channel_data('NCSN_CCOB_EHN_1wk');
% [t, x, samplingRate] = get_channel_data('NCSN_CCOB_EHZ_24hr');
% [t, x, samplingRate] = get_channel_data('NCSN_CADB_EHZ_24hr');
% [t, x, samplingRate] = get_channel_data('NCSN_CAO_EHZ_24hr');
% [t, x, samplingRate] = get_channel_data('NCSN_CHR_EHZ_24hr');
% [t, x, samplingRate] = get_channel_data('NCSN_CML_EHZ_24hr');
% last_index = 72001; % 1 hr
% t = t(1:last_index);
% x = x(1:last_index);

output_str = '';
% i_sig = 786.85; % start time of first time window (s)
% j_sig = 1620.65; % start time of second time window (s)
% i_sig = 1266; % start time of first time window (s)
i_sig = [1266.95];
% i_sig = 2500; % noise window start time (s)
% i_sig = 555;
% i_sig = 618;
% i_sig = 793.5;
% i_sig = 1629;
j_sig = [1629]; % start time of second time window (s)

% Missed by FAST, found by autocorr
% output_str = 'missed_pair_';
% i_sig = [361730.15];
% j_sig = [57585.65];
% i_sig = 336718.75;
% j_sig = 377465.15;
% i_sig = 57585.65;
% j_sig = 361730.15;
% i_sig = 314070.05;
% j_sig = 444565.95;
% i_sig = 152033.55;
% j_sig = 449503.35;
% i_sig = 329703.75;
% j_sig = 378142.05;
% i_sig = 329855.75;
% j_sig = 446075.75;
% i_sig = 446437.25;
% j_sig = 571979.45;
% i_sig = 51448.55;
% j_sig = 396395.25;
% i_sig = 55724.95;
% j_sig = 314789.85;
% i_sig = 245004.15;
% j_sig = 377586.95;
% i_sig = 298128.35;
% j_sig = 583287.95;
% i_sig = 329780.85;
% j_sig = 378142.65;
% i_sig = 331733.55;
% j_sig = 446075.65;
% i_sig = 548.05;
% j_sig = 332528.45;
% i_sig = 332918.65;
% j_sig = 361734.15;
% i_sig = 340640.25;
% j_sig = 446075.65;
% i_sig = 442172.55;
% j_sig = 442376.25;
% i_sig = 446371.85;
% j_sig = 452129.25;
% i_sig = 377586.65;
% j_sig = 510464.25;
% i_sig = 245004.65;
% j_sig = 560483.95;


% FAST false detections
% output_str = 'false_pair_';
% i_sig = [432734 263895 324483 256800 577120 411585 489945 542189];
% j_sig = [73919 81227 176032 8288 323884 176072 489334 411588];

% % FAST new detections
% output_str = 'new_pair_';
% i_sig = [506661 11296 411557 352901 188987 524516 189017 429894 429896 489737 ...
%     427201 429897 444730 489944 490170 489806 489805 504882 506661 519785 524516];
% j_sig = [7790 988 63713 136263 138966 176074 90733 322949 352902 403900 ...
%     314782 429006 444646 489645 489675 489696 489675 8286 352901 447459 176074];
% i_sig = 506661;
% j_sig = 7790;
% i_sig = 11296;
% j_sig = 988;
% i_sig = 411557;
% j_sig = 63713;
% i_sig = 352901;
% j_sig = 136263;
% i_sig = 489645;
% j_sig = 489675;
% i_sig = 489645;
% j_sig = 489675;

% i_sig = i_sig + 5;
% j_sig = j_sig + 5;


% j_sig = 245272.5;
% j_sig = 1738.2;
% j_sig = 1341.35;
% j_sig = 4000;
% j_sig = 100000;
% j_sig = 500000;

% i_sig = 153023;
% j_sig = 152043.1;
% i_sig = 395180;
% j_sig = 161550.2;
% i_sig = 480719;
% j_sig = 480129.95;


for k=1:length(i_sig)
    plot_similar_waveform_pair(t, x, samplingRate, i_sig(k), j_sig(k), output_str);
end