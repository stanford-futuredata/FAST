function sac_mat = fwrite_sac(sac_mat, varargin)
% FWRITE_SAC  Write a SAC struct variable into a binary file.
%#########################################
%#                                       #
%#    [Function]                         #
%#    Write SAC-formatted files          #
%#                                       #
%#                                       #
%#                   by Whyjay, Jan 2015 #
%#########################################
%
% >> sac_mat = FWRITE_SAC(sac_mat)
% >> sac_mat = FWRITE_SAC(sac_mat, filename)
% >> sac_mat = FWRITE_SAC(sac_mat, filename, machine_fmt)
%
%----Input Variables----------------------------------------------------------
% sac_mat         -> SAC data-pack struct, specified in 3 fields.
%    sac_mat.t       -> 1-D time array, i.e. t
%                       If omitted, SAC_MAT.HDR.E or SAC_MAT.HDR.DELTA is needed.
%    sac_mat.data    -> 1-D data array, i.e. f(t)
%                       If omitted, no any data but only header is written to output.
%    sac_mat.hdr     -> 1-by-1 struct. the field names and types are the same with 
%                       SAC header version 6. please see Reference for more details.
%                       If the time information (i.e. HDR.B, HDR.E, HDR.DELTA)
%                       is omitted, SAC_MAT.T is needed.
%                  e.g. to access header KSTNM, it's 
%                       >> sac_mat.hdr.kstnm   (all the fieldnames are lower case.)
%                       to access T0 to T9, it's
%                       >> sac_mat.hdr.t    (it's a 1-by-10 array, saving T0 - T9.)
% filename       -> File name. 1-D String array.
% machine_fmt    -> String that specifies the character encoding scheme 
%                   associated with the file. It can be 'b' or 'ieee-be' for
%                   big-endian; 'l' or 'ieee-le' for little-endian. If omitted,
%                   the program uses the local encoding scheme.
%
%----Reference----------------------------------------------------------------
% [1] Header fieldnames reference: http://www.iris.edu/files/sac-manual/
% [2] function FREAD_SAC could help create SAC_MAT struct format from a SAC file. 
%
%----Output Variables---------------------------------------------------------
% sac_mat        -> Verified SAC data-pack struct. The program may change some 
%                   headers of the original SAC_MAT.HDR if the time information 
%                   is not consistent. The program also auto fills the omitted
%                   field in SAC_MAT.HDR with its default value.
%
%----Usage--------------------------------------------------------------------
% SAC_MAT = FWRITE_SAC(SAC_MAT) verifies and completes header data in SAC_MAT.HDR
%
% FWRITE_SAC(SAC_MAT, FILENAME) writes SAC_MAT into FILENAME.
%
% FWRITE_SAC(SAC_MAT, FILENAME, MACHINE_FMT) specifies the character encoding scheme.
%
%----Example-----------------------------------------------------------------
%
% [TASK 1] save a time sequence into .sac file
%   >> hum.t = linspace(0,1,201);
%   >> hum.data = humps(hum.t);
%   >> fwrite_sac(hum, 'humps.sac');
%
% [TASK 2] auto-complete all the header information
%   >> sacmat.data = sin(0:pi/180:2*pi);
%   >> sacmat.hdr.delta = pi/180;
%   >> sacmat.hdr.b = 0;
%   >> sacmat.hdr.kstnm = 'TEST';
%   >> sacmat = fwrite_sac(sacmat);
%
%----Lisensing---------------------------------------------------------------
%
%    FWRITE_SAC
%    AUTHOR: Whyjay Zheng
%    E-MAIL: jhsttshj@gmail.com
%    CREATED: 2015.01.14

%    Copyright (c) 2015, Whyjay Zheng
%    All rights reserved.
%
%    Redistribution and use in source and binary forms, with or without
%    modification, are permitted provided that the following conditions are
%    met:
%
%        * Redistributions of source code must retain the above copyright
%          notice, this list of conditions and the following disclaimer.
%        * Redistributions in binary form must reproduce the above copyright
%          notice, this list of conditions and the following disclaimer in
%          the documentation and/or other materials provided with the distribution
%
%    THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
%    AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
%    IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
%    ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE
%    LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
%    CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
%    SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
%    INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
%    CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
%    ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
%    POSSIBILITY OF SUCH DAMAGE.


%====Check input: nargin====
if nargin >= 4
  error('Too many input arguments.')
elseif nargin == 3
  machine_fmt_list = {'b', 'l', 'ieee-be', 'ieee-le'};
  if sum(strcmp(varargin{2},machine_fmt_list))
    machine_fmt = varargin{2};
  else
    error('Wrong Machine Format. only ''b'', ''l'', ''ieee-be'', ''ieee-le'' can be accepted.')
  end
elseif nargin == 2
  machine_fmt = 'n';
end

%====Check input: sac_mat====
if ~isstruct(sac_mat)
  error('Input is not a struct variable.')
elseif ~isfield(sac_mat, 'hdr')
  sac_mat.hdr = struct('b', 0);
elseif ~isstruct(sac_mat.hdr)
  error('Header is not a struct variable.')
elseif length(sac_mat.hdr) == 0
  sac_mat.hdr(1).b = 0;
end

%====Verify Header====
hdr_verified = check_hdr(sac_mat.hdr);
hdr_verified = check_data(sac_mat, hdr_verified);
sac_mat.hdr = hdr_verified;

%====Start Writing File, if needed====
if nargin == 2 | nargin == 3
  w_action(varargin{1}, sac_mat, machine_fmt);
end

%#####################################################
%##           function 'check_hdr' code             ##
%#####################################################

function hdr = check_hdr(hdr)
% Check hdr struct availability, and fill the missing headers with -12345.
%
%----Input Variables----------------------------------------------------------
% hdr          -> SAC header struct.
%
%----Output Variables---------------------------------------------------------
% hdr_verified -> just like input, but all the essential field are filled
%                 with undefined value: -12345.
%

%====Settings...====
hdr_list = {'delta', 'depmin', 'depmax', 'scale', 'odelta',...
  'b', 'e', 'o', 'a', 't', 'f', 'resp',...
  'stla', 'stlo', 'stel', 'stdp', 'evla', 'evlo', 'evel', 'evdp',...
  'mag', 'user', 'dist', 'az', 'baz', 'gcarc', 'depmen',...
  'cmpaz', 'cmpinc', 'xminimum', 'xmaximum', 'yminimum', 'ymaximum'...
  'nzyear', 'nzjday', 'nzhour', 'nzmin', 'nzsec', 'nzmsec',...
  'nvhdr', 'norid', 'nevid', 'npts', 'nwfid', 'nxsize', 'nysize',...
  'iftype', 'idep', 'iztype', 'iinst', 'istreg', 'ievreg', 'ievtyp',...
  'iqual', 'isynth', 'imagtyp', 'imagsrc',...
  'leven', 'lpspol', 'lovrok', 'lcalda',...
  'kstnm', 'kevnm', 'khole', 'ko', 'ka', 'kt', 'kf',...
  'kuser', 'kcmpnm', 'knetwk', 'kdatrd', 'kinst'};

existence = isfield(hdr, hdr_list);
lack_hdr = hdr_list(find(~existence));

%====Start to fill the lacking headers====
for key = lack_hdr
  switch key{:}(1)
    case 'k'                       % All the headers which begins with 'k' has a default of '-12345'
      if strcmp(key{:},'kt')      % except KT and KUSER, since they are 10-by-8 and 3-by-8 text arrays.
        hdr.(key{:}) = repmat('-12345  ', 10, 1);
      elseif strcmp(key{:},'kuser')
        hdr.(key{:}) = repmat('-12345  ', 3, 1);
      else
        hdr.(key{:}) = '-12345';
      end
    case 'l'                       % All the headers which begins with 'l' have a default of 0, except LEVEN
      if strcmp(key{:},'leven')         % default vaule of LEVEN is 1 (evenly spaced).
        hdr.(key{:}) = 1;
      elseif strcmp(key{:},'lovrok')    % default vaule of LOVROK is 1 (enable overwrite).
        hdr.(key{:}) = 1;
      else
        hdr.(key{:}) = 0;
      end
    case {'t', 'r', 'u'}           % All the headers which begins with 't', 'r' and 'u'
      hdr.(key{:}) = -12345 * ones(10,1);      %  have a default of -12345 * ones(10,1)
    otherwise
      if strcmp(key{:},'nvhdr')         % default vaule of NVHDR is 6 (header version).
        hdr.(key{:}) = 6;
      elseif strcmp(key{:},'b')        % default vaule of B is 0 (begin time).
        hdr.(key{:}) = 0;
      elseif strcmp(key{:},'iftype')   % default vaule of IFTYPE is 1 (time series data).
        hdr.(key{:}) = 1;
      else
        hdr.(key{:}) = -12345;     % The other headers have a a default of -12345.
      end
  end
end

%#####################################################
%##           function 'check_data' code            ##
%#####################################################

function hdr_verified = check_data(sac_mat, hdr_verified)
% Check data availability, and overwrite some header related to time.
%
%----Input Variables----------------------------------------------------------
% sac_mat      -> SAC data struct. must has fieldname 'hdr'.
% hdr_verified -> header struct after function CHECK_HDR. 
%
%----Output Variables---------------------------------------------------------
% hdr_verified -> just like input, but some headers possibly have changed.
%                 headers that may be changed: B, E, DELTA, NPTS.
%
%====If no sac_mat.data ... Only write headers====
if ~isfield(sac_mat, 'data')
  hdr_verified.e = hdr_verified.b;
  hdr_verified.npts = 0;
  hdr_verified.delta = 0;

%====If there's no any time tag ... ERROR====
elseif hdr_verified.e - (-12345) < eps & hdr_verified.delta - (-12345) < eps & ~isfield(sac_mat, 't')
  error('Time is not properly specified or not given. Please edit header or time array.')

%====Time tag priority when conflicted: sac_mat.t > sac_mat.hdr.delta > sac_mat.hdr.e====
elseif isfield(sac_mat, 't')
  if length(sac_mat.t) ~= length(sac_mat.data)
    error('Number of Time and Data points are inconsistent.')
  end
  hdr_verified.b = sac_mat.t(1);
  hdr_verified.e = sac_mat.t(end);
  hdr_verified.npts = length(sac_mat.data);
  if length(sac_mat.data) <= 1 
    hdr_verified.delta = 0;
  else
    hdr_verified.delta = sac_mat.t(2) - sac_mat.t(1);
  end
elseif isfield(sac_mat.hdr, 'delta')
  hdr_verified.npts = length(sac_mat.data);
  if hdr_verified.b - (-12345) > eps
    hdr_verified.e = hdr_verified.b + hdr_verified.delta * (length(sac_mat.data) - 1);
  elseif hdr_verified.e - (-12345) > eps
    hdr_verified.b = hdr_verified.e - hdr_verified.delta * (length(sac_mat.data) - 1);
  else
    error('Time is not properly specified. (No Begin and End.)')
  end
else          %if isfield(sac_mat.hdr, 'e')
  if hdr_verified.b - (-12345) > eps
    error('Time is not properly specified. (No Begin or Delta.)')
  end
  hdr_verified.npts = length(sac_mat.data);
  hdr_verified.delta = (hdr_verified.e - hdr_verified.b) / (length(sac_mat.data) - 1);
end

%#####################################################
%##            function 'w_action' code             ##
%#####################################################

function w_action(filename, sac_mat, machine_fmt)
% Write SAC struct into file.
%
%----Input Variables----------------------------------------------------------
% filename    -> Writing File name. 1-D text array.
% sac_mat     -> SAC data struct. must has fieldname 'hdr'.
% machine_fmt -> FOPEN-supported format. e.g. 'b', 'l', 'ieee-be', 'ieee-le'
%

hdr = sac_mat.hdr;
f = fopen(filename, 'w', machine_fmt);
fmt = 'float32';
fwrite(f, hdr.delta, fmt);
fwrite(f, hdr.depmin, fmt);
fwrite(f, hdr.depmax, fmt);
fwrite(f, hdr.scale, fmt);
fwrite(f, hdr.odelta, fmt);
fwrite(f, hdr.b, fmt);
fwrite(f, hdr.e, fmt);
fwrite(f, hdr.o, fmt);
fwrite(f, hdr.a, fmt);
fwrite(f, -12345, fmt);
fwrite(f, hdr.t, fmt);
fwrite(f, hdr.f, fmt);
fwrite(f, hdr.resp, fmt);
fwrite(f, hdr.stla, fmt);
fwrite(f, hdr.stlo, fmt);
fwrite(f, hdr.stel, fmt);
fwrite(f, hdr.stdp, fmt);
fwrite(f, hdr.evla, fmt);
fwrite(f, hdr.evlo, fmt);
fwrite(f, hdr.evel, fmt);
fwrite(f, hdr.evdp, fmt);
fwrite(f, hdr.mag, fmt);
fwrite(f, hdr.user, fmt);
fwrite(f, hdr.dist, fmt);
fwrite(f, hdr.az, fmt);
fwrite(f, hdr.baz, fmt);
fwrite(f, hdr.gcarc, fmt);
fwrite(f, -12345, fmt);
fwrite(f, -12345, fmt);
fwrite(f, hdr.depmen, fmt);
fwrite(f, hdr.cmpaz, fmt);
fwrite(f, hdr.cmpinc, fmt);
fwrite(f, hdr.xminimum, fmt);
fwrite(f, hdr.xmaximum, fmt);
fwrite(f, hdr.yminimum, fmt);
fwrite(f, hdr.ymaximum, fmt);
fwrite(f, -12345 * ones(7,1), fmt);
fmt = 'int32';
fwrite(f, hdr.nzyear, fmt);
fwrite(f, hdr.nzjday, fmt);
fwrite(f, hdr.nzhour, fmt);
fwrite(f, hdr.nzmin, fmt);
fwrite(f, hdr.nzsec, fmt);
fwrite(f, hdr.nzmsec, fmt);
fwrite(f, hdr.nvhdr, fmt);
fwrite(f, hdr.norid, fmt);
fwrite(f, hdr.nevid, fmt);
fwrite(f, hdr.npts, fmt);
fwrite(f, -12345, fmt);
fwrite(f, hdr.nwfid, fmt);
fwrite(f, hdr.nxsize, fmt);
fwrite(f, hdr.nysize, fmt);
fwrite(f, -12345, fmt);
fwrite(f, hdr.iftype, fmt);
fwrite(f, hdr.idep, fmt);
fwrite(f, hdr.iztype, fmt);
fwrite(f, -12345, fmt);
fwrite(f, hdr.iinst, fmt);
fwrite(f, hdr.istreg, fmt);
fwrite(f, hdr.ievreg, fmt);
fwrite(f, hdr.ievtyp, fmt);
fwrite(f, hdr.iqual, fmt);
fwrite(f, hdr.isynth, fmt);
fwrite(f, hdr.imagtyp, fmt);
fwrite(f, hdr.imagsrc, fmt);
fwrite(f, -12345 * ones(8,1), fmt);
fwrite(f, hdr.leven, fmt);
fwrite(f, hdr.lpspol, fmt);
fwrite(f, hdr.lovrok, fmt);
fwrite(f, hdr.lcalda, fmt);
fwrite(f, -12345, fmt);
fmt = 'char';
fwrite(f, sprintf('%-8s', hdr.kstnm), fmt);
fwrite(f, sprintf('%-16s', hdr.kevnm), fmt);
fwrite(f, sprintf('%-8s', hdr.khole), fmt);
fwrite(f, sprintf('%-8s', hdr.ko), fmt);
fwrite(f, sprintf('%-8s', hdr.ka), fmt);
fwrite(f, hdr.kt', fmt);
fwrite(f, sprintf('%-8s', hdr.kf), fmt);
fwrite(f, hdr.kuser', fmt);
fwrite(f, sprintf('%-8s', hdr.kcmpnm), fmt);
fwrite(f, sprintf('%-8s', hdr.knetwk), fmt);
fwrite(f, sprintf('%-8s', hdr.kdatrd), fmt);
fwrite(f, sprintf('%-8s', hdr.kinst), fmt);

if isfield(sac_mat,'data')
  fwrite(f, sac_mat.data, 'float32');
end
fclose(f);
