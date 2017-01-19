function [inp] = get_fpss_input_parameters()
% Input parameters for fingerprint and similarity search
% Use as config file for now
%
% Parameters to change:
%
% fileNameStr            % string for input data
% specFolderStr          % cell array for spectrogram input folder strings
% numPartitions          % number of spectrogram partitions
% windowDuration         % window length (s)
% windowLag              % lag time between windows (s)
% fingerprintLength      % number of time samples in spectral image
% fingerprintLag         % number of time samples between spectral images
% t_value                % number of top magnitude wavelet coefficients to keep
% settings.nfuncs        % number of hash functions
% settings.ntbls         % number of hash tables
% settings.nvotes        % number of votes (pair must be in at least nvotes hash tables)
% settings.near_repeats  % near repeat exclusion parameter
% settings.limit         % maximum number of windows per hash bucket
% saveVersion            % string with version for save() function intermediate outputs


% NCSN CCOB 1-component, 1-station, 24 hour data
% inp.fileNameStr = {'NCSN_CCOB_EHE_24hr', 'NCSN_CCOB_EHN_24hr', 'NCSN_CCOB_EHZ_24hr', ...
%    'NCSN_CADB_EHZ_24hr', 'NCSN_CAO_EHZ_24hr', 'NCSN_CHR_EHZ_24hr', 'NCSN_CML_EHZ_24hr'};
inp.fileNameStr = {'NCSN_CCOB_EHN_24hr'};
inp.specFolderStr = num2cell(inp.fileNameStr);
inp.numPartitions = 3;
inp.windowDuration = 10.0;
inp.windowLag = 0.1;
inp.fingerprintLength = 100;
inp.fingerprintLag = 10;
% inp.t_value = 200;
% inp.t_value = 400;
inp.t_value = 800;
inp.settings.nfuncs = 5;
inp.settings.ntbls = 100;
% inp.settings.nvotes = 2;
inp.settings.nvotes = 4;
inp.settings.near_repeats = 5;
% inp.settings.limit = 1e3;
inp.settings.limit = 4e9;
inp.saveVersion = '-v7';


% % WHAR 1-component, 1-station, 3 month data
% inp.fileNameStr = {'WHAR_HHE_20100601_3month'};
% % inp.fileNameStr = {'WHAR_HHN_20100601_3month'};
% % inp.fileNameStr = {'WHAR_HHZ_20100601_3month'};
% inp.specFolderStr = num2cell(inp.fileNameStr);
% inp.numPartitions = 540; % 92 days
% inp.windowDuration = 3.0;
% inp.windowLag = 0.03;
% inp.fingerprintLength = 64;
% inp.fingerprintLag = 10;
% inp.t_value = 800;
% inp.settings.nfuncs = 8;
% inp.settings.ntbls = 100;
% inp.settings.nvotes = 4;
% inp.settings.near_repeats = 5;
% inp.settings.limit = 4e9; % do not exceed 32-bit integer limit
% inp.saveVersion = '-v7.3';

end

