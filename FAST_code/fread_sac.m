function varargout = fread_sac(varargin)
% FREAD_SAC  Read SAC-formatted files and save as struct variables.
%#########################################
%#                                       #
%#    [Function]                         #
%#    Read SAC-formatted files           #
%#                                       #
%#                                       #
%#                   by Whyjay, Jan 2015 #
%#########################################
%
% >> FREAD_SAC(filename)
% >> [t, data, hdr] = FREAD_SAC(filename)
% >> sac_mat = FREAD_SAC(filename)
% >> [sac_mat1, sac_mat2, ...] = FREAD_SAC(filename1, filename2, ...)
% >> [...] = FREAD_SAC(..., machine_fmt)
%
%----Input Variables----------------------------------------------------------
% filename       -> File name. String array or Cell array. See Usage below.
% machine_fmt    -> String that specifies the character encoding scheme 
%                   associated with the file. It can be 'b' or 'ieee-be' for
%                   big-endian; 'l' or 'ieee-le' for little-endian. If omitted,
%                   the program uses the local encoding scheme.
%
%----Reference----------------------------------------------------------------
% [1] Header fieldnames reference: http://www.iris.edu/files/sac-manual/
%
%----Output Variables---------------------------------------------------------
% t              -> 1-D time records in a SAC file (from header B to header E).
% data           -> 1-D data records in a SAC file.
% hdr            -> Header structure. its fieldnames are the same with SAC 
%                   header version 6. Please see Reference for more details.
%                   e.g. to access header KSTNM, it's 
%                        >> hdr.kstnm    (all the fieldnames are lower case.)
%                        to access T0 to T9, it's
%                        >> hdr.t        (it's a 1-by-10 array, saving T0 - T9.)
%                   ##: header T, RESP, USER are all 1-by-10 arrays.
%                       header KT, KUSER are 8-by-10 and 3-by-10 arrays,
%                              each row represents one value (i.e. KT1, KT2,...)
% sac_mat        -> SAC data-pack struct. it packs T, DATA, HDR as a single
%                   varible, and naming SAC_MAT.T, SAC_MAT.DATA, SAC_MAT.HDR.
%                   e.g. to access SAC data, it's
%                        >> sac_mat.data
%                        to access header STLO, it's
%                        >> sac_mat.hdr.stlo
%
%----Usage--------------------------------------------------------------------
% FREAD_SAC(FILENAME) reads single file, and illustrate it by time-series plot.
%
% [T, DATA, HDR] = FREAD_SAC(FILENAME) reads single file, and saves as T, DATA,
% HDR separately.
%
% SAC_MAT = FREAD_SAC(FILENAME) reads one or multiple files, and saves as SAC_MAT.
% If FILENAME contains N files in 2-D text array or 1-D cell array, 
% SAC_MAT would be a 1-by-N cell array with N SAC data-pack struct.
%
% [SAC_MAT1, SAC_MAT2, ...] = FREAD_SAC(FILENAME1, FILENAME2, ...) reads multiple
% files, and saves to different variables.
%
% [...] = FREAD_SAC(..., MACHINE_FMT) specifies the character encoding scheme.
%
%----Example-----------------------------------------------------------------
%
% >> loca = fread_sac('LOCA.sac')
%             ---> read 'LOCA.sac' into loca struct.
% >> [loca_e, loca_n, loca_z] = fread_sac('LOCA_E.sac', 'LOCA_N.sac', 'LOCA_Z.sac')
%             ---> multiple reading
% >> loca = fread_sac({'LOCA_E.sac', 'LOCA_N.sac', 'LOCA_Z.sac'}, 'l')
%             ---> read multile files into loca cell array, 
%                  in little-endian encoding.
%                  loca{1} => E, loca{2} => N, loca{3} => Z
%
%----Lisensing---------------------------------------------------------------
%
%    FREAD_SAC
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


%====Set Machine Format (native, little-endian or big-endian)====

machine_fmt_list = {'b', 'l', 'ieee-be', 'ieee-le'};
fmt = 'n';
num_argin = nargin;

if ischar(varargin{end})
  if sum(strcmp(varargin{end}(1,:),machine_fmt_list))
    fmt = varargin{end};
    varargin(end) = [];
    num_argin = num_argin -1;
  end
end

%====Check Input Type====

if nargin == 0
  error('No Inputs.')
else
  for every_arg = varargin
    if ~or(ischar(every_arg{:}), iscell(every_arg{:}))
      error('Input must be text strings or a cell array.')
    end
  end
end  

%====Start Reading File====

  %====Type 1: [a, b, c,...] = fread_sac('A', 'B', 'C',...)====
if num_argin ~= 1
  if nargout == num_argin
    for i=1:length(varargin)
      [t, data, hdr] = single_read(varargin{i},fmt);
      varargout{i} = struct('hdr',hdr,'t',t,'data',data);
    end
  else
    error('Number of arguments error.')
  end

  %====Type 2: a = fread_sac('A')====
elseif nargout == 1
  if ischar(varargin{1}) & size(varargin{1},1) == 1
    [t, data, hdr] = single_read(varargin{1},fmt);
    varargout{1} = struct('hdr',hdr,'t',t,'data',data);

  %====Type 3: set = fread_sac(['A';'B';...]) or set = fread_sac({'A','B',...})====
  else
    if iscell(varargin{1}), fileset = varargin{1};     end
    if ischar(varargin{1}), fileset = (varargin{1})';  end
    varargout{1} = {};
    for fname = fileset
      if iscell(fname), fname = fname{1}; end
      [t, data, hdr] = single_read(reshape(fname,1,[]),fmt);
      varargout{1}{end+1} = struct('hdr',hdr,'t',t,'data',data);
    end
  end

  %====Type 4: [t, data, hdr] = fread_sac('A')====
elseif ischar(varargin{1}) & size(varargin{1},1) == 1 
  if nargout == 3
    [varargout{1:3}] = single_read(varargin{1},fmt);

  %====Type 5: fread_sac('A')  (no output argument)====
  elseif nargout == 0
    [t, data, hdr] = single_read(varargin{1},fmt);
    plot(t, data)
    title(varargin{1})
    tex = sprintf('%d %d, %d:%d''%d"%d %s-%s',...
             hdr.nzyear, hdr.nzjday, hdr.nzhour, hdr.nzmin,...
             hdr.nzsec, hdr.nzmsec, hdr.kstnm, hdr.kcmpnm);
    legend(tex)
  else
    error('Number of arguments error.')
  end
else
  error('Number of arguments error.')
end

%#####################################################
%##          function 'single_read' code            ##
%#####################################################

function [t, data, hdr] = single_read(filename, machine_fmt)
% Read single SAC file, and Save it into 3 parts.
%
%----Input Variables----------------------------------------------------------
% filename     -> Filename you want to read
% machine_fmt  -> FOPEN-supported format. e.g. 'b', 'l', 'ieee-be', 'ieee-le'
%
%----Output Variables---------------------------------------------------------
% t            -> SAC data time sequence:   t   1-D array.
% data         -> SAC data time sequence: f(t)  1-D array.
% hdr          -> SAC header (Version 6). It's a struct variable.
%                 field names are the same with header names (in lower case).
%

f=fopen(filename, 'r', machine_fmt);
if f==-1
  errtext = sprintf('File "%s" doesn''t exist. Please check input.',filename);
  error(errtext);
end

hdr_pt1 = fread(f, 70, 'float32');
hdr_pt2 = fread(f, 40, 'int32');
hdr_pt3 = (fread(f, 192, 'char'))';
hdr = hdr_construct(hdr_pt1, hdr_pt2, hdr_pt3);

%====If SAC header version ~= 6... ====
if hdr.nvhdr ~= 6
  fprintf('Your file %s may not contain a SAC version-6 header.\n', filename)
  fprintf('Please check your file format and encoding scheme.\n')
  continued = input('Do you want to continue reading? y/[n] :', 's');
  if ~strcmp(lower(continued), 'y')
    fclose(f);
    error('Not a SAC version-6 header.')
  end
end

data = fread(f, hdr.npts, 'float32');
t = (hdr.b : hdr.delta : (hdr.npts-1)*hdr.delta+hdr.b)';
fclose(f);

%#####################################################
%##          function 'hdr_construct' code          ##
%#####################################################

function hdr = hdr_construct(hdr_pt1, hdr_pt2, hdr_pt3)
% Construct the SAC header struct.
%
%----Input Variables----------------------------------------------------------
% hdr_ptX    -> header information, passed by SINGLE_READ.
%
%----Output Variables---------------------------------------------------------
% ndr        -> header struct.
%
% Header fieldnames reference: http://www.iris.edu/files/sac-manual/
% Example: hdr.kstnm    for header KSTNM

hdr.delta     = hdr_pt1(1);
hdr.depmin    = hdr_pt1(2);
hdr.depmax    = hdr_pt1(3);
hdr.scale     = hdr_pt1(4);
hdr.odelta    = hdr_pt1(5);
hdr.b         = hdr_pt1(6);
hdr.e         = hdr_pt1(7);
hdr.o         = hdr_pt1(8);
hdr.a         = hdr_pt1(9);
hdr.t         = hdr_pt1(11:20);    % T0 - T9
hdr.f         = hdr_pt1(21);
hdr.resp      = hdr_pt1(22:31);    % RESP0 - RESP9
hdr.stla      = hdr_pt1(32);
hdr.stlo      = hdr_pt1(33);
hdr.stel      = hdr_pt1(34);
hdr.stdp      = hdr_pt1(35);
hdr.evla      = hdr_pt1(36);
hdr.evlo      = hdr_pt1(37);
hdr.evel      = hdr_pt1(38);
hdr.evdp      = hdr_pt1(39);
hdr.mag       = hdr_pt1(40);
hdr.user      = hdr_pt1(41:50);    % USER0 - USER9
hdr.dist      = hdr_pt1(51);
hdr.az        = hdr_pt1(52);
hdr.baz       = hdr_pt1(53);
hdr.gcarc     = hdr_pt1(54);
hdr.depmen    = hdr_pt1(57);
hdr.cmpaz     = hdr_pt1(58);
hdr.cmpinc    = hdr_pt1(59);
hdr.xminimum  = hdr_pt1(60);
hdr.xmaximum  = hdr_pt1(61);
hdr.yminimum  = hdr_pt1(62);
hdr.ymaximum  = hdr_pt1(63);
hdr.nzyear    = hdr_pt2(1);
hdr.nzjday    = hdr_pt2(2);
hdr.nzhour    = hdr_pt2(3);
hdr.nzmin     = hdr_pt2(4);
hdr.nzsec     = hdr_pt2(5);
hdr.nzmsec    = hdr_pt2(6);
hdr.nvhdr     = hdr_pt2(7);
hdr.norid     = hdr_pt2(8);
hdr.nevid     = hdr_pt2(9);
hdr.npts      = hdr_pt2(10);
hdr.nwfid     = hdr_pt2(12);
hdr.nxsize    = hdr_pt2(13);
hdr.nysize    = hdr_pt2(14);
hdr.iftype    = hdr_pt2(16);
hdr.idep      = hdr_pt2(17);
hdr.iztype    = hdr_pt2(18);
hdr.iinst     = hdr_pt2(20);
hdr.istreg    = hdr_pt2(21);
hdr.ievreg    = hdr_pt2(22);
hdr.ievtyp    = hdr_pt2(23);
hdr.iqual     = hdr_pt2(24);
hdr.isynth    = hdr_pt2(25);
hdr.imagtyp   = hdr_pt2(26);
hdr.imagsrc   = hdr_pt2(27);
hdr.leven     = hdr_pt2(36);
hdr.lpspol    = hdr_pt2(37);
hdr.lovrok    = hdr_pt2(38);
hdr.lcalda    = hdr_pt2(39);
hdr.kstnm     = deblank(char(hdr_pt3(1:8)));
hdr.kevnm     = deblank(char(hdr_pt3(9:24)));
hdr.khole     = deblank(char(hdr_pt3(25:32)));
hdr.ko        = deblank(char(hdr_pt3(33:40)));
hdr.ka        = deblank(char(hdr_pt3(41:48)));
hdr.kt        = (reshape(char(hdr_pt3(49:128)),8,10))';   % KT0 - KT9
hdr.kf        = deblank(char(hdr_pt3(129:136)));
hdr.kuser     = (reshape(char(hdr_pt3(137:160)),8,3))';   % KUSER0 - KUSER2
hdr.kcmpnm    = deblank(char(hdr_pt3(161:168)));
hdr.knetwk    = deblank(char(hdr_pt3(169:176)));
hdr.kdatrd    = deblank(char(hdr_pt3(177:184)));
hdr.kinst     = deblank(char(hdr_pt3(185:192)));
