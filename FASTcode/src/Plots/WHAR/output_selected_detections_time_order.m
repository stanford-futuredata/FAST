close all
clear

input_dir = '../../../data/OutputFAST/totalMatrix_WHAR_20100601_3ch_3month/';

% input_file = strcat(input_dir, 'selected_match_eq_detections.txt');
% output_file = strcat(input_dir, 'selected_match_eq_times_mag.txt');
% input_file = strcat(input_dir, 'SP_match_eq_detections.txt');
% output_file = strcat(input_dir, 'SP_match_eq_times_mag.txt');

% input_file = strcat(input_dir, 'selected_missed_eq_detections.txt');
% output_file = strcat(input_dir, 'selected_missed_eq_times_mag.txt');
% input_file = strcat(input_dir, 'SP_missed_eq_detections.txt');
% output_file = strcat(input_dir, 'SP_missed_eq_times_mag.txt');

% input_file = strcat(input_dir, 'selected_new_eq_detections.txt');
% output_file = strcat(input_dir, 'selected_new_eq_times.txt');
% input_file = strcat(input_dir, 'SP_new_eq_detections.txt');
% output_file = strcat(input_dir, 'SP_new_eq_times.txt');
% input_file = strcat(input_dir, '3sta_amb_new_eq_detections.txt');
% output_file = strcat(input_dir, '3sta_amb_new_eq_times.txt');
input_file = strcat(input_dir, '3sta_noisy_new_eq_detections.txt');
output_file = strcat(input_dir, '3sta_noisy_new_eq_times.txt');

det = dlmread(input_file);
times = det(:,1);
mag = det(:,2);

[order_times, ix] = sort(times);
out_data = [order_times mag(ix)];

% % Use with match, missed: output times in order with magnitudes
% fid = fopen(output_file, 'w');
% fprintf(fid, '%7.5f %7.5f\n', out_data');
% fclose(fid);

% Use with new: output times in order
order_times = order_times - 2; % subtract 2 seconds from each new detection time to center the waveform
fid = fopen(output_file, 'w');
fprintf(fid, '%7.5f\n', order_times');
fclose(fid);
