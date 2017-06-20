function ps = load_pspectrogram(settings,p_ind,data_str,varargin)
% Load a partition of a spectrogram
% 
% ps = load_pspectrogram(name,p_ind)
% 
% Input arguments
% settings  : struct containing 'name' and 'dir, needed to load spectrogram
%             (see default_data_settings in pspectrogram.m)
% p_ind     : the index of the partition
% data_str  : a string array explaining the data from spectrogram to load. 
%             For instance,
%             data_str = ['S', 'P'];
%             loads the spectrogram 'S' and its power spectral density 'P'.
%
% Input arguments (Optional)
% endTimeIndex: index (in time dimension) of last sample to return for this
%               spectrogram partition (Used only to read in small overlapping
%               section from beginning of next partition)
%     

% Start Optional Input Section

default_endTimeIndex = 0;

% Only want 1 optional inputs at most
if (nargin > 4)
    error('must not have more than 4 input parameters');
end

% Set defaults for optional inputs
optargs = {default_endTimeIndex};

% Overwrite defaults with optional inputs
optargs(1:nargin-3) = varargin;

% Place optional inputs in variables
[endTimeIndex] = optargs{:};

% End Optional Input Section

assert(exist(settings.dir,'dir') == 7,'Spectrogram data directory not found');
% Need to check the file path
file =  get_pname(settings, p_ind);
assert(exist(file,'file') == 2,'Spectrogram partition file not found');

load(file,'data');

if (endTimeIndex)
    for i=1:length(data_str)
        ps.(data_str{i}) = data.(data_str{i})(:,1:endTimeIndex);
    end
else
    for i=1:length(data_str)
        ps.(data_str{i}) = data.(data_str{i});
    end
end

end

function part = get_pname(settings,p_ind)
    part = [settings.dir 'spec_' settings.name '_part' num2str(p_ind) '.mat'];
end
