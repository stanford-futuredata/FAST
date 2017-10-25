% function [] = combine_sac_time_series( input_args )
% Combine multiple SAC files of continuous data into one SAC file
% Overlaps in time: cut off overlapping end from previous section
% Gaps in time: fill with uncorrelated white Gaussian noise, scaled with
%   mean and standard deviation of surrounding data

close all
clear

addpath('../Utilities/SAC/');

% Conversion factors
DAYS_PER_YEAR = 365;
HOURS_PER_DAY = 24;
MINUTES_PER_HOUR = 60;
SECONDS_PER_MINUTE = 60;

% Read in info about all parts of sac file
[ts_inp] = get_sac_time_series_parts();

% Want this number of samples (depend on data duration)
desired_nsamples = ts_inp.data_ndays*HOURS_PER_DAY*MINUTES_PER_HOUR*SECONDS_PER_MINUTE*ts_inp.sps;
% desired_nsamples = ts_inp.data_ndays*HOURS_PER_DAY*MINUTES_PER_HOUR*SECONDS_PER_MINUTE*ts_inp.sps - 1;
% desired_nsamples = 708140039; % 7F.ARK1
% desired_nsamples = 708127271; % 7F.ARK2

% Read in first partition
currentFile = strcat(ts_inp.dir, '/', ts_inp.filenames{1});
disp(['Current file: ', currentFile]);
[t,x,SAChdr] = fread_sac(currentFile);

% samples
prev_end = length(x); % updated for each partition

% Read in each subsequent partition
for k=2:ts_inp.nparts
    % Read in next partition
    currentFile = strcat(ts_inp.dir, '/', ts_inp.filenames{k});
    disp(['Current file: ', currentFile]);
    [next.t, next.x, next.SAChdr] = fread_sac(currentFile);
    
    % Determine current start sample with respect to first start sample
    nyears = next.SAChdr.nzyear - SAChdr.nzyear;
    ndays = next.SAChdr.nzjday - SAChdr.nzjday;
    nhours = next.SAChdr.nzhour - SAChdr.nzhour;
    nmin = next.SAChdr.nzmin - SAChdr.nzmin;
    nsec = next.SAChdr.nzsec - SAChdr.nzsec;
    nmsec = next.SAChdr.nzmsec - SAChdr.nzmsec;
    curr_start = nyears*DAYS_PER_YEAR*HOURS_PER_DAY*MINUTES_PER_HOUR*SECONDS_PER_MINUTE*ts_inp.sps + ...
        ndays*HOURS_PER_DAY*MINUTES_PER_HOUR*SECONDS_PER_MINUTE*ts_inp.sps + ...
        nhours*MINUTES_PER_HOUR*SECONDS_PER_MINUTE*ts_inp.sps + ...
        nmin*SECONDS_PER_MINUTE*ts_inp.sps + ...
        (nsec+0.001*nmsec)*ts_inp.sps;
    curr_start = round(curr_start);
    
    % Find offset between curr_start and prev_end, ok if 1.
    offset_between = curr_start - prev_end;
    
    if (offset_between < 1) % overlap
        disp('Warning: overlap');
        
        % Cut off overlapping end from previous section
        prev_new_end = curr_start-1;
        x = x(1:prev_new_end);
        
    elseif (offset_between > 1) % gap
        disp(['Warning: gap; offset size = ' num2str(offset_between)]);
        
        % Get scale factor for white Gaussian noise
        ntest = 1000; % number of test samples in data - assume they are noise
        next_ntest = min(ntest, length(next.x)); % need this in case length(next.x) < 1000
        mean_gap_left = mean(x(end-ntest:end)); % mean of ntest noise values on left side of gap
        mean_gap_right = mean(next.x(1:next_ntest)); % mean of ntest noise values on right side of gap
        mean_gap = 0.5*(mean_gap_left + mean_gap_right); % mean noise in gap
        std_gap_left = std(x(end-ntest:end)); % stdev of ntest noise values on left side of gap
        std_gap_right = std(next.x(1:next_ntest)); % stdev of ntest noise values on right side of gap
        std_gap = 0.5*(std_gap_left + std_gap_right); % stdev noise in gap
        
        % Fill in gap with uncorrelated white Gaussian noise
        ngap = offset_between-1;
        gap_x = std_gap*randn(ngap, 1) + mean_gap;
        x = [x; gap_x];
    end
    
    % Attach next partition
    x = [x; next.x];
    
    % Update previous parameters for next iteration
    prev_end = length(x);
end

% Check if there is a gap at the end
if (prev_end ~= desired_nsamples)
    
    % Get scale factor for white Gaussian noise
    ntest = 1000; % number of test samples in data - assume they are noise
    mean_gap = mean(x(end-ntest:end)); % mean of ntest noise values on left side of gap
    std_gap = std(x(end-ntest:end)); % stdev of ntest noise values on left side of gap
    
    % Fill in gap with uncorrelated white Gaussian noise
    ngap = desired_nsamples-prev_end;
    gap_x = std_gap*randn(ngap, 1) + mean_gap;
    x = [x; gap_x];
end

% Create time axis (s) to go along with data in x
t = [1:length(x)]'/ts_inp.sps;

% Create new SAC header
N = length(x);
dt = 1.0/ts_inp.sps; % sample spacing
tstart = 0; % start time

% Write combined data to SAC file
outputFile = strcat(ts_inp.dir, '/', ts_inp.outfile);
sac_mat.data = x;
newhdr = SAChdr;
newhdr.delta = dt;
newhdr.b = tstart;
newhdr.e = t(end);
newhdr.npts = N;
sac_mat.hdr = newhdr;
sac_mat = fwrite_sac(sac_mat, outputFile);

% end

