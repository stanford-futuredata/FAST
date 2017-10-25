function [passed] = TestSpecImageFingerprint()

% Unit test for spectral image fingerprint generation
% Outputs from data_1hr_fingerprint and spec_fingerprint should match
% passed = 1 if all tests pass, passed = 0 if any test fails

% Get data
addpath('input_data');
[t, x, samplingRate] = get_channel_data('NCSN_CCOB_01hr');
nx = length(x);

% Get spectrogram
% run with num_partitions = 1, settings.data.name = 'NCSN_CCOB_01hr'
partitionIndex = 1;
specFlag = 0; % read spectrogram from file
numPartitions = 1;
[specData, specSettings] = get_spectrogram(x, nx, samplingRate, ...
    partitionIndex, specFlag, numPartitions, 'NCSN_CCOB_01hr');

% Run data_1hr_fingerprint and spec_fingerprint
[data1hrFp, datadtfp] = data_1hr_fingerprint(specData, specSettings, x);
[specFp, specdtfp] = spec_fingerprint(specData.P, specSettings);

% Check dimensions
passed = logical(1);
passed = passed & (datadtfp == specdtfp);

s_d = size(data1hrFp);
s_s = size(specFp);
passed = passed & (s_d(1) == s_s(1));
passed = passed & (s_d(2) == s_s(2));

% Check that fingerprint outputs match
diff_fp = (data1hrFp ~= specFp);
passed = passed & (sum(diff_fp(:)) == 0);

end

