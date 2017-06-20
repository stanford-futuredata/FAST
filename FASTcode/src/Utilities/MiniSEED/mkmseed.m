function mkmseed(f,d,varargin)
%MKMSEED Write data in miniSEED file format.
%	MKMSEED(FILENAME,D,T0,FS) writes miniSEED file FILENAME from strictly 
%	monotonic data vector D, time origin T0 (a scalar in Matlab datenum
%	compatible format) and sampling rate FS (in Hz). Encoding format will 
%	depend on D variable class (see below).
%
%	MKMSEED(FILENAME,D,T,FS) where T is a time vector of the same length as
%	data vector D, will create data records of monotonic blocks of samples,
%	splitting each time the sampling frequency FS is not equal to time  
%	difference between two successive samples (with a 50% tolerency).
%
%	Network, Station, Channel and Location codes will be extracted from FILENAME
%	which must respect the format "NN.SSSSS.LC.CCC.T" where:
%		   NN = Network Code (2 characters max, see FDSN list)
%		SSSSS = Station identifier (5 char max)
%		   LC = Location Code (2 char max)
%		  CCC = Channel identifier (3 char max)
%		    T = Data type (1 char, optional, default is D)
%	
%	Final filename will have appended string ".YYYY.DDD" corresponding to year
%	and ordinal day of origin time (from T0 value). Multiple files may be 
%	created if time span of data exceeds day limit.
%
%	MKMSEED(...,EF,RL) specifies encoding format EF and data record length RL
%	(in bytes). RL must be a power of 2 greater or equal to 256.
%
%	Data encoding format EF must be one of the following FDSN codes:
%		 1 = 16-bit integer (default for class 2-bit, 8-bit, int16)
%		 3 = 32-bit integer (default for class uint16, int32)
%		 4 = IEEE float32 (default for class single)
%		 5 = IEEE float64 (default for all other class)
%		10 = Steim-1 compression (D will be converted to int32)
%		11 = Steim-2 compression (D will be converted to int32)
%		13 = Geoscope 16-3 gain ranged (D will be converted to double)
%		14 = Geoscope 16-4 gain ranged (D will be converted to double)
%
%	MKMSEED(FILENAME,D,T,HEADER) where HEADER is a data structure similar
%	to the one from RDMSEED function, propagates the header contains into
%	written data records. HEADER can be of 1xN size, in that case each 
%	element will be assigned to each data record, respectively.
%	Valid fields of HEADER structure are:
%	           SequenceNumber: 6-char string
%	     DataQualityIndicator: 1-char string
%               NumberSamples: uint16 scalar
%	               SampleRate: double scalar (in Hz)
%	            ActivityFlags: uint8 scalar
%	                  IOFlags: uint8 scalar
%	         DataQualityFlags: uint8 scalar
%	           TimeCorrection: int32 scalar (in 0.0001 s)
%
%	File(s) will be coded big-endian, flags set to zero, blockette 1000, default
%	record length is 4096 bytes. Outputs have been tested with PQL II software
%	from IRIS PASSCAL (v2010.268).
%
%	See also RDMSEED function for miniSEED file reading.
%
%
%	Author: François Beauducel <beauducel@ipgp.fr>
%		Institut de Physique du Globe de Paris
%	Created: 2011-10-19
%	Updated: 2016-05-16
%
%	Acknowledgments:
%		Florent Brenguier, Julien Vergoz, Constanza Pardo, Sylvie Barbier.
%
%	References:
%		IRIS (2010), SEED Reference Manual: SEED Format Version 2.4, May 2010,
%		  IFDSN/IRIS/USGS, http://www.iris.edu
%		IRIS (2010), PQL II Quick Look trace viewing application, PASSCAL
%		  Instrument Center, http://www.passcal.nmt.edu/

%	History:
%	[2015-01-26]
%		- fixes an issue with time sampling in T0,FS mode
%
%	[2014-05-28]
%		- adds possibility to force block headers parameters
%
%	[2014-05-15]
%		- bug correction for sample rate expressed in seconds/sample
%
%	[2014-05-07]
%		- accepts time vector T and detects data blocks (gaps and overlaps)
%		- adds GEOSCOPE 16/3-4 bit gain ranged coding
%
%	[2011-12-16]
%		- adds STEIM 1/2 compression.
%
%	[2011-10-20]
%		- first version with integer and float encodings (no compression)
%		  and continuous time series (T0 + FS)
%
%	[2011-10-25]
%		- add Steim-1 and Steim-2 encoding formats
%
%	[2011-11-03]
%		- accepts column vector D
%
%	[2011-11-16]
%		- accepts void location code (thanks to Julien Vergoz)
%
%
%	Copyright (c) 2016, François Beauducel, covered by BSD License.
%	All rights reserved.
%
%	Redistribution and use in source and binary forms, with or without 
%	modification, are permitted provided that the following conditions are met:
%
%	   * Redistributions of source code must retain the above copyright 
%	     notice, this list of conditions and the following disclaimer.
%	   * Redistributions in binary form must reproduce the above copyright 
%	     notice, this list of conditions and the following disclaimer in 
%	     the documentation and/or other materials provided with the distribution
%	                           
%	THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" 
%	AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE 
%	IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE 
%	ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE 
%	LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR 
%	CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF 
%	SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS 
%	INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN 
%	CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) 
%	ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE 
%	POSSIBILITY OF SUCH DAMAGE.

if nargin < 3
	error('Not enought input arguments.');
end
	
% default input arguments
rl = 2^12;	% Record length

fs_tol = 0.5; % relative tolerency on sampling frequency (gap and overlap detection)

if ~ischar(f)
	error('FILENAME argument must be a string.');
else
	% check filename
	[fpath,fname,fext] = fileparts(f);
	s = textscan([fname,fext],'%s','delimiter','.');
	cc = s{1};
	if length(cc) < 4
		error('FILENAME must be of the form: NN.SSSSS.LC.CCC');
	end
	% extract data channel identifiers
	X.NetworkCode = sprintf('%-2s',upper(cc{1}(1:min(length(cc{1}),2))));
	X.StationIdentifierCode = sprintf('%-5s',upper(cc{2}(1:min(length(cc{2}),5))));
	X.LocationIdentifier = sprintf('%-2s',cc{3}(1:min(length(cc{3}),3)));
	X.ChannelIdentifier = sprintf('%-3s',cc{4}(1:min(length(cc{4}),4)));
end

if ~isnumeric(d)
	error('Argument D must be numeric.');
else
	d = d(:);
end

t = varargin{1};
if ischar(t)
	try
		t = datenum(varargin{1});
	catch
		error('Argument T or T0 must be valid date (see DATENUM).');
	end
end

if numel(t) ~= 1 && numel(t) ~= numel(d)
	error('Argument T must be scalar or array of same size as D.');
end

if numel(t) > 1
	t = t(:);
	dt = diff(t);
end

if nargin > 3 && ~isempty(varargin{2})
	% syntax rdmseed(F,D,T,HEADER)
	if isstruct(varargin{2})
		H = varargin{2};
	else
		if ~isnumeric(varargin{2}) || numel(varargin{2}) > 1
			error('Argument FS must be a scalar.');
		end
		H.SampleRate = varargin{2};
	end
end
if ~exist('H','var') || ~isfield(H,'SampleRate')
	if numel(t) > 1
		% guess sampling rate from vector T
		k = find(dt>0);
		if ~isempty(k)
			H.SampleRate = 1/(86400*dt(k(1)));
			fprintf('MKMSEED: guessed sampling rate at %g Hz. Hope it is OK...\n',H.SampleRate);
		else
			error('MKMSEED: cannot guess sampling rate from T. Please specify FS argument.');
		end
	end
end

if numel(t) == 1
	t0 = t;
	t = linspace(t0,t0 + (length(d) - 1)/H(1).SampleRate/86400,length(d))';
	m = zeros(size(t));
else
	t = t(:);
	% computes time continuity: 50% tolerance on the sampling frequency
	m = [0;(dt > (1 + fs_tol)/H(1).SampleRate/86400 | dt < (1 - fs_tol)/H(1).SampleRate/86400)];
end

% ! IMPORTANT NOTE ON ENCODING FORMAT ARGUMENT ! 
% For very specific usage (data transform), EF argument accepts a 2-element
% vector: EF(1) is used to encode the data, and optionaly, EF(2) is used to
% fill the blockette 1000 header value. These 2 value must be the same or 
% may lead to corrupted data... Another option is to set EF(2) to 0, then 
% original blockette 1000 value is used (from HEADER argument), while data 
% are still encoded as EF(1). !! For expert only !!
if nargin > 4 && ~isempty(varargin{3})
	ef = varargin{3};
	if ~isnumeric(ef) || numel(ef) > 2 ...
			|| ~ismember(ef(1),[1,3,4,5,10,11,13,14]) ...
			|| (numel(ef)==2 && ~ismember(ef(2),[0,1,3,4,5,10,11,13,14]))
		error('Argument EF not valid. See documentation.');
	end
	% EF specified: converts D to correct class
	switch ef(1)
	case 1
		d = int16(d);
	case {3,10,11}
		d = int32(d);
	case 4
		d = single(d);
	otherwise
		d = double(d);
	end
else
	% EF not specified: choose encoding consistent with data range
	switch class(d)
	case {'logical','char','uint8','int8','int16'}
		ef = 1;		% 16-bit
		d = int16(d);
	case {'uint16','int32'}
		ef = 3;		% 32-bit
		d = int32(d);
	case 'single'
		ef = 4;	% IEEE float32
	otherwise
		ef = 5;	% IEEE float64 (double)
		d = double(d);
	end

end

if nargin > 5
	rl = varargin{4};
	if ~isnumeric(rl) || numel(rl) > 1 || rl < 256 || mod(log(rl)/log(2),1) ~=0
		error('Argument RL must be a power of 2, scalar >= 256.');
	end
end

% reconstructs the filename base (without date)
fbase = fullfile(fpath,sprintf('%s.%s.%s.%s', ...
	deblank(X.NetworkCode),deblank(X.StationIdentifierCode), ...
	deblank(X.LocationIdentifier),deblank(X.ChannelIdentifier)));

% number of bytes per data
dl = length(typecast(d(1),'int8'));

% maximum number of samples in a data block
switch ef(1)
case {1,3,4,5}
	nbs = (rl - 64)/dl;
case 10
	nbs = ((rl/64-1)*15 - 1)*4;	% Steim-1 maximum compression is four 8-bit per longword
case 11
	nbs = ((rl/64-1)*15 - 1)*7;	% Steim-2 maximum compression is seven 4-bit per longword
case {13,14}
	nbs = (rl - 64)/2;	% Geoscope gain ranged is 16-bit per sample
end

doy0 = 0;
n = 1; % index for the data vector
r = 1; % index for data record blocks
while n <= length(d)

	% start time of block
	X.StartTime = t(n);
	tv = datevec(X.StartTime);
	doy = floor(datenum(tv)) - datenum(tv(1),1,0);

	% filename with year and day
	fn = sprintf('%s.%04d.%03d',fbase,tv(1),doy);

	% open a new file
	if doy ~= doy0
		if doy0 ~= 0
			fclose(fid);
			fprintf(' done.\n');
		end
		fid = fopen(fn,'wb','ieee-be');
		if fid == -1
			error('Cannot create file "%s".',fn);
		end
		fprintf('MKMSEED: writing file "%s"...',fn);
		doy0 = doy;
	end

	% index of data to write in the block
	if length(H) >= r && isfield(H,'NumberSamples')
		k = n:(n + H(r).NumberSamples - 1);
	else
		k = n:min([n + nbs - 1,length(d),n + find(m(n:end),1)]);
	end
	X.data = d(k);
	
	% index of header information
	kh = min(r,length(H));
	
	X.SampleRate = H(kh).SampleRate;
	X.SequenceNumber = sprintf('%06d',r);
	if isfield(H,'SequenceNumber')
		X.SequenceNumber = H(kh).SequenceNumber;
	end
	X.DataQualityIndicator = 'D';
	if isfield(H,'DataQualityIndicator')
		X.DataQualityIndicator = H(kh).DataQualityIndicator;
	end
	X.Flags = zeros(3,1);
	if isfield(H,'ActivityFlags')
		X.Flags(1) = H(kh).ActivityFlags;
	end
	if isfield(H,'IOFlags')
		X.Flags(2) = H(kh).IOFlags;
	end
	if isfield(H,'DataQualityFlags')
		X.Flags(3) = H(kh).DataQualityFlags;
	end
	X.TimeCorrection = 0;
	if isfield(H,'TimeCorrection')
		X.TimeCorrection = H(kh).TimeCorrection;
	end
	if numel(ef)==2 && ef(2)==0 && isfield(H(kh),'BLOCKETTES') && isfield(H(kh).BLOCKETTES,'B1000')
		X.EncodingFormat = H(kh).BLOCKETTES.B1000.EncodingFormat;
	end
	
	nn = write_data_record(fid,X,ef,rl);
	n = k(nn) + 1;
	r = r + 1;

end

fclose(fid);
fprintf(' done.\n');


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function n = write_data_record(fid,X,ef,rl)
% N=write_data_record(FID,X,EF,RL) writes a single data record block using
% FID file ID, structure X containing header and data information,
% sample rate FS, encoding format EF, record length RL.
% Returns the number of data N effectively written.

% --- prepare the data
switch ef(1)
case {1,3,4,5} % int16, int32, float32, float64: just writes the data flow!
	data = X.data;
	dl = length(typecast(X.data(1),'int8'));
	n = length(X.data);
	nrem = rl - n*dl - 64;
case {10,11} % Steim-1/2: a bit more complicated...
	nb64 = rl/64-1;
	nibble = zeros(15,nb64);
	steim = zeros(15,nb64,'uint32');
	switch ef(1)
	case 10 % Steim-1
		bnib = [8,16,32];	% number of bit
		nnib = [4,2,1];		% number of differences
		cnib = [1,2,3];		% Cnib value
	case 11 % Steim-2
		bnib = [4,5,6,8,10,15,30];	% number of bit
		nnib = [7,6,5,4,3,2,1];		% number of differences
		cnib = [3,3,3,1,2,2,2];		% Cnib value
		dnib = [2,1,0,-1,3,2,1];	% Dnib value
	end
	steim(1) = typecast(X.data(1),'uint32'); % X0
	dd = [0;diff(double(X.data))]; % computes the differences (D0=0)
	ldd = length(dd);
	n = 0;
	for k = 3:numel(steim) % loop on each 32-bit word in the block
		for kk = 1:length(bnib) % will try each compression scheme from max to min
			if (n + nnib(kk)) <= ldd % first condition is to not exceed data length!
				ddd = dd(n + (1:nnib(kk)));
				sbn = 2^(bnib(kk)-1);
				if length(find(ddd>=-sbn & ddd<=(sbn-1)))==nnib(kk)
					nibble(k) = cnib(kk);
					steim(k) = bitjoin(double(bitsignset(ddd,bnib(kk))),bnib(kk));
					% 2-bit dnib for Steim-2 other than four 8-bit
					if ef(1)==11 && dnib(kk) >= 0
						steim(k) = bitset(steim(k),31,bitget(uint8(dnib(kk)),1));
						steim(k) = bitset(steim(k),32,bitget(uint8(dnib(kk)),2));
					end
					n = n + nnib(kk);
					break;
				end
			end
		end
		if n >= length(dd)
			break;
		end
	end
	steim(2) = typecast(X.data(n),'uint32'); % Xn (for inverse integration check)
	% fill-in data block with nibbles and 32-bit words
	data = zeros(16,nb64,'uint32');
	for k = 1:nb64
		data(1,k) = bitjoin([0;nibble(:,k)],2);
		data(2:16,k) = steim(:,k);
	end
	nrem = 0;
case {13,14} % Geoscope: computes 3 or 4-bit exponent and 12-bit mantissa 
	gain = min(floor(log(2^11./abs(X.data))/log(2)),16 - (ef(1)==13));
	mant = X.data.*2.^gain + 2^11;
	data = uint16(mant + gain*2^12);
	n = length(X.data);
	nrem = rl - n*2 - 64;
end


% --- write Data Header (48 bytes)

fwrite(fid,X.SequenceNumber,'char');
fwrite(fid,'D','char');	% data header/quality indicator
fwrite(fid,' ','char');	% reserved byte
fwrite(fid,X.StationIdentifierCode,'char');
fwrite(fid,X.LocationIdentifier,'char');
fwrite(fid,X.ChannelIdentifier,'char');
fwrite(fid,X.NetworkCode,'char');

% start time
tv = datevec(X.StartTime);
fwrite(fid,tv(1),'uint16');
fwrite(fid,floor(datenum(tv)) - datenum(tv(1),1,0),'uint16');
fwrite(fid,tv(4),'uint8');
fwrite(fid,tv(5),'uint8');
fwrite(fid,floor(tv(6)),'uint8');
fwrite(fid,0,'uint8');
fwrite(fid,round(1e4*mod(tv(6),1)),'uint16');

% number of samples
fwrite(fid,n,'uint16');

% sample rate: if the factor is not codable in int16, calculates the maximum
% possible divisor to preserve the precision
fs = X.SampleRate;

if fs >= 1
	p2 = multip2(fs);
	fwrite(fid,abs(p2)*fs,'int16');	% Sample rate factor (Hz)
	fwrite(fid,-p2,'int16');	% Sample rate multiplier (division)
else
	p2 = multip2(1/fs);
	fwrite(fid,-abs(p2)/fs,'int16');	% Sample rate factor (s)
	fwrite(fid,p2,'int16');	% Sample rate multiplier (division)
end

fwrite(fid,X.Flags,'uint8');	% Activity, I/O, Data Quality flags
fwrite(fid,1,'uint8');		% Number Blockettes Follow
fwrite(fid,X.TimeCorrection,'int32');		% Time Correction
fwrite(fid,64,'uint16');	% Offset Begin Data
fwrite(fid,48,'uint16');	% Offset First Blockette

% blockette 1000 (8 bytes)
fwrite(fid,1000,'uint16');	% Blockette type
fwrite(fid,0,'uint16');		% Offset Next Blockette
if numel(ef)==2 && ef(2)==0 && isfield(X,'EncodingFormat')
	fwrite(fid,X.EncodingFormat,'uint8');		% Original Encoding Format
else
	fwrite(fid,ef(end),'uint8');		% Forced Encoding Format
end
fwrite(fid,1,'uint8');		% Word Order (big-endian)
fwrite(fid,round(log(rl)/log(2)),'uint8');	% Data Record Length
fwrite(fid,0,'uint8');		% Reserved

% complete header to reach standard 64 bytes length
fwrite(fid,zeros(8,1),'int8');

% --- write the data
fwrite(fid,data(:),class(data));

% leading null to respect Data Record Length
if nrem > 0
	fwrite(fid,zeros(nrem,1),'int8');
end



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function d = bitjoin(x,n)
% bitjoin(X,N,B) joins the N-bit array X into one unsigned 32-bit number

d = uint32(sum(flipud(x(:)).*2.^(0:n:(length(x)-1)*n)'));


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function d = bitsignset(x,n)
% bitsignset(X,N) returns unsigned N-bit coded from signed double X.
% Result is coded as uint32 class.
% (This is the reverse function of bitsign in RDMSEED)

d = uint32(x + (x<0)*2^n);



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function m = multip2(x)
% multip2(X) returns the maximum 2^N factor of X value.

if abs(x) < 2^15 && x==fix(x)
	m = -1;
else
	m = 2^(14-ceil(log(x)/log(2)));
end
