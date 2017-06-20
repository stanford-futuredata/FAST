close all
clear

% data_dir = '/data/cees/ceyoon/multiple_components/haar_coefficients/totalMatrix_WHAR_20100701_3ch_1month/';
% output_dir = '/data/beroza/ceyoon/multiple_components/data/haar_coefficients/totalMatrix_WHAR_20100701_3ch_1month/';

data_dir = '/data/beroza/ceyoon/multiple_components/data/haar_coefficients/totalMatrix_WHAR_20100601_3ch_3month/waveforms/';
output_dir = '/data/beroza/ceyoon/multiple_components/data/haar_coefficients/totalMatrix_WHAR_20100601_3ch_3month/';

% files = dir(strcat(data_dir, 'match_noise_waveforms_rank*.png'));
% output_file = 'match_noise_movie.avi';

% files = dir(strcat(data_dir, 'missed_noise_waveforms_rank*.png'));
% output_file = 'missed_noise_movie.avi';

% files = dir(strcat(data_dir, 'new_noise_waveforms_rank*.png'));
% output_file = 'new_noise_movie.avi';

% files = dir(strcat(data_dir, 'match_eq_waveforms_rank*.png'));
% output_file = 'match_eq_movie.avi';

% files = dir(strcat(data_dir, 'missed_eq_waveforms_rank*.png'));
% output_file = 'missed_eq_movie.avi';

files = dir(strcat(data_dir, 'longnew_eq_waveforms_rank*.png'));
output_file = 'new_eq_movie.avi';


writerObj = VideoWriter(strcat(output_dir, output_file));
writerObj.FrameRate = 1; % number of frames per second
% writerObj.FrameRate = 2;
open(writerObj);
for k=1:numel(files)
    if (mod(k,100) == 0)
        disp(k)
    end
    filename = strcat(data_dir, files(k).name); 
    thisimage = imread(filename);
    writeVideo(writerObj, thisimage);
end
close(writerObj);