function [SACdata]=sachdr(head1, head2, head3)
%function [SACdata]=sachdr(head1, head2, head3)
% Read from the output header of one single SAC format file and generate 
% the SACdata structure array contains the following elements:
%    times
%    station
%    event
%    user
%    descrip
%    evsta
%    llnl
%    response
%    data

%Most of these elements are themselves structures and their members
%are as follows:
%times	station	event	user	 descrip  evsta	llnl		data	
%-----	-------	-----	------   -------  -----	----		----
%delta	stla	evla	data(10) iftype   dist	xminimum	trcLen	
%b	stlo	evlo	label(3) idep     az	xmaximum	scale
%e	stel	evel		 iztype   baz	yminimum
%o	stdp	evdp		 iinst    gcarc	ymaximum
%a	cmpaz	nzyear		 istreg		norid
%t0	cmpinc	nzjday		 ievreg		nevid
%t1	kstnm	nzhour		 ievtyp		nwfid
%t2	kcmpnm	nzmin		 iqual		nxsize
%t3	knetwk	nzsec		 isynth		nysize
%t4		nzmsec
%t5		kevnm
%t6		mag
%t7		imagtyp
%t8		imagsrc
%t9
%f
%k0
%ka
%kt1
%kt2
%kt3
%kt4
%kt5
%kt6
%kt7
%kt8
%kt9
%kf

%response is a 10-element array, and trcLen is a scalar. Thus, to 
%reference the begin time you would write:
%SACdata.times.b 

% Note: The above data structure is copied from the SAC2000 mat 
% reference.

% Function called: sac.m
% Written by Zhigang Peng, USC
% Updated Sun Jul 29 19:04:20 PDT 2001

%[head1, head2, head3, data]=sac(filename);

% SACdata.times

      SACdata.times.delta   = head1(1,1); 
      SACdata.times.b   = head1(2,1);
      SACdata.times.e   = head1(2,2);
      SACdata.times.o   = head1(2,3);
      SACdata.times.a   = head1(2,4);
      SACdata.times.t0  = head1(3,1);
      SACdata.times.t1  = head1(3,2);
      SACdata.times.t2  = head1(3,3);
      SACdata.times.t3  = head1(3,4);
      SACdata.times.t4  = head1(3,5);
      SACdata.times.t5  = head1(4,1);
      SACdata.times.t6  = head1(4,2);
      SACdata.times.t7  = head1(4,3);
      SACdata.times.t8  = head1(4,4);
      SACdata.times.t9  = head1(4,5);
      SACdata.times.k0  = char(head3(2,9:16));
      SACdata.times.ka  = char(head3(2,17:24));
      SACdata.times.kt0 = char(head3(3,1:8));
      SACdata.times.kt1 = char(head3(3,9:16));
      SACdata.times.kt2 = char(head3(3,17:24));
      SACdata.times.kt3 = char(head3(4,1:8));
      SACdata.times.kt4 = char(head3(4,9:16));
      SACdata.times.kt5 = char(head3(4,17:24));
      SACdata.times.kt6 = char(head3(5,1:8));
      SACdata.times.kt7 = char(head3(5,9:16));
      SACdata.times.kt8 = char(head3(5,17:24));
      SACdata.times.kt9 = char(head3(6,1:8));
      SACdata.times.kf = char(head3(6,9:16));

% SACdata.station

      SACdata.station.stla = head1(7,2);
      SACdata.station.stlo = head1(7,3);
      SACdata.station.stel = head1(7,4);
      SACdata.station.stdp = head1(7,5);
      SACdata.station.cmpaz = head1(12,3);
      SACdata.station.cmpinc = head1(12,4);
      SACdata.station.kstnm = char(head3(1,1:8));
      SACdata.stations.kcmpnm = char(head3(7,17:24));
      SACdata.stations.knetwk = char(head3(8,1:8));

% SACdata.event
      SACdata.event.evla = head1(8,1);
      SACdata.event.evlo = head1(8,2);
      SACdata.event.evel = head1(8,3);
      SACdata.event.evdp = head1(8,4);
      SACdata.event.nzyear = head2(1,1);
      SACdata.event.nzjday = head2(1,2);
      SACdata.event.nzhour = head2(1,3);
      SACdata.event.nzmin = head2(1,4);
      SACdata.event.nzsec = head2(1,5);
      SACdata.event.nzmsec = head2(2,1);
      SACdata.event.kevnm = char(head3(1,9:24));
      SACdata.event.mag = head1(8,5);
      SACdata.event.imagtyp = [];
      SACdata.event.imagsrc = [];

% SACdata.user
      SACdata.user.data = [head1(9,1:5),head1(10,1:5)];
      SACdata.user.label = [char(head3(6,17:24)),char(head3(7,1:8)),char(head3(7,9:16))];

% SACdata.descrip
      SACdata.descrip.iftype = head2(4,1);
      SACdata.descrip.idep = head2(4,2);
      SACdata.descrip.iztype = head2(4,3);
      SACdata.descrip.iinst = head2(4,5);
      SACdata.descrip.istreg = head2(5,1);
      SACdata.descrip.ievreg = head2(5,2);
      SACdata.descrip.ievtyp = head2(5,3);
      SACdata.descrip.iqual = head2(5,4);
      SACdata.descrip.isynth = head2(5,5);

% SACdata.evsta
      SACdata.evsta.dist = head1(11,1);
      SACdata.evsta.az = head1(11,2);
      SACdata.evsta.baz = head1(11,3);
      SACdata.evsta.gcarc = head1(11,4);

% SACdata.llnl
      SACdata.llnl.xminimum = head1(12,5);
      SACdata.llnl.xmaximum = head1(13,1);
      SACdata.llnl.yminimum = head1(13,2);
      SACdata.llnl.ymaximum = head1(13,3);
      SACdata.llnl.norid = [];
      SACdata.llnl.nevid = [];
      SACdata.llnl.nxsize = [];
      SACdata.llnl.nysize = [];

% SACdata.response
      SACdata.response = [head1(5,2:5),head1(6,1:5),head1(7,1)];

% SACdata.data
      SACdata.data.trcLen = head2(2,5);
      SACdata.data.scale = head1(1,4);
