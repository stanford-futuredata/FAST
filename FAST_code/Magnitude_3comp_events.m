close all;
clear all;
addpath ./MatSAC/

% file1='./201007_HHE.SAC';file2='./201007_HHN.SAC';file3='./201007_HHZ.SAC';
% T_events=load('./201007_t0_reclusterhhe_1_20hz.txt');
input_dir = '../data/GuyArkansas/';
output_dir = '../data/haar_coefficients/totalMatrix_WHAR_20100601_3ch_3month/';

% file1 = strcat(input_dir, '201007_HHE.SAC');
% file2 = strcat(input_dir, '201007_HHN.SAC');
% file3 = strcat(input_dir, '201007_HHZ.SAC');
% % output_file = '201007_mag_test.txt';
% % T_events=load(strcat(input_dir, '201007_Time.txt'));
% output_file = strcat(output_dir, 'selected_201007_new_eq_mag.txt');
% T_events=load(strcat(output_dir, 'selected_201007_zero_new_eq_times.txt'));
% % output_file = strcat(output_dir, 'SP_201007_new_eq_mag.txt');
% % T_events=load(strcat(output_dir, 'SP_201007_zero_new_eq_times.txt'));
% % output_file = strcat(output_dir, '3sta_noisy_201007_new_eq_mag.txt');
% % T_events=load(strcat(output_dir, '3sta_noisy_201007_zero_new_eq_times.txt'));
% % output_file = strcat(output_dir, '3sta_amb_201007_new_eq_mag.txt');
% % T_events=load(strcat(output_dir, '3sta_amb_201007_zero_new_eq_times.txt'));

file1 = strcat(input_dir, '201006_HHE.SAC');
file2 = strcat(input_dir, '201006_HHN.SAC');
file3 = strcat(input_dir, '201006_HHZ.SAC');
% output_file = '201006_mag_test.txt';
% T_events=load(strcat(input_dir, '201006_Time.txt'));
% output_file = strcat(output_dir, 'selected_201006_new_eq_mag.txt');
% T_events=load(strcat(output_dir, 'selected_201006_new_eq_times.txt'));
% output_file = strcat(output_dir, 'SP_201006_new_eq_mag.txt');
% T_events=load(strcat(output_dir, 'SP_201006_new_eq_times.txt'));
output_file = strcat(output_dir, '3sta_noisy_201006_new_eq_mag.txt');
T_events=load(strcat(output_dir, '3sta_noisy_201006_new_eq_times.txt'));

% file1 = strcat(input_dir, '201008_HHE.SAC');
% file2 = strcat(input_dir, '201008_HHN.SAC');
% file3 = strcat(input_dir, '201008_HHZ.SAC');
% % output_file = '201008_mag_test.txt';
% % T_events=load(strcat(input_dir, '201008_Time.txt'));
% output_file = strcat(output_dir, 'selected_201008_new_eq_mag.txt');
% T_events=load(strcat(output_dir, 'selected_201008_zero_new_eq_times.txt'));
% % output_file = strcat(output_dir, 'SP_201008_new_eq_mag.txt');
% % T_events=load(strcat(output_dir, 'SP_201008_zero_new_eq_times.txt'));
% % output_file = strcat(output_dir, '3sta_noisy_201008_new_eq_mag.txt');
% % T_events=load(strcat(output_dir, '3sta_noisy_201008_zero_new_eq_times.txt'));
% % output_file = strcat(output_dir, '3sta_amb_201008_new_eq_mag.txt');
% % T_events=load(strcat(output_dir, '3sta_amb_201008_zero_new_eq_times.txt'));

N_events=size(T_events,1);

tnoise=10;T_events=T_events-tnoise; %%%%

ttotal=30; 
[t_init,data_init,header_init]=fget_sac_window(T_events(1),ttotal,file1);
nttotal=size(data_init,1);dt=t_init(2)-t_init(1);Fs=1/dt;
alpha=0.1;taper=tukeywin(nttotal,alpha);
tlength=4;nt=round(tlength/dt)+1;ntnoise=round(tnoise/dt)+1;
data1=zeros(nt,N_events);normdata1=zeros(nt,N_events);
data2=zeros(nt,N_events);normdata2=zeros(nt,N_events);
data3=zeros(nt,N_events);normdata3=zeros(nt,N_events);
data=zeros(nt,N_events);
amp1=zeros(N_events,1);amp2=zeros(N_events,2);amp3=zeros(N_events,3);
amp_a=zeros(N_events,1);amp_b=zeros(N_events,1);

Fc=1;[b1,a1]=butter(4,2*Fc/Fs,'high'); %%%!!! filter
Fc=20;[b2,a2]=butter(4,2*Fc/Fs,'low'); %%%!!! filter

fid1=fopen(file1, 'rb');[~]=fread(fid1, [5, 14], 'float32');
[~]=fread(fid1, [5, 8], 'int32');[~]=fread(fid1, [24, 8], 'char');
fid2=fopen(file2, 'rb');[~]=fread(fid2, [5, 14], 'float32');
[~]=fread(fid2, [5, 8], 'int32');[~]=fread(fid2, [24, 8], 'char');
fid3=fopen(file3, 'rb');[~]=fread(fid3, [5, 14], 'float32');
[~]=fread(fid3, [5, 8], 'int32');[~]=fread(fid3, [24, 8], 'char');

N0=1;
n0=round(T_events(N0)/dt);[~]=fread(fid1, n0, 'float32');
[~]=fread(fid2, n0, 'float32');[~]=fread(fid3, n0, 'float32');

for i=N0:N_events
    longdata1=fread(fid1,nttotal,'float32');
    longdata1=detrend(longdata1,'constant');longdata1=detrend(longdata1);
    longdata1=longdata1.*taper;
    longdata1=filter(b1,a1,longdata1);longdata1=filter(b2,a2,longdata1);

    longdata2=fread(fid2,nttotal,'float32');
    longdata2=detrend(longdata2,'constant');longdata2=detrend(longdata2);
    longdata2=longdata2.*taper;
    longdata2=filter(b1,a1,longdata2);longdata2=filter(b2,a2,longdata2);
    
    longdata3=fread(fid3,nttotal,'float32');
    longdata3=detrend(longdata3,'constant');longdata3=detrend(longdata3);
    longdata3=longdata3.*taper;
    longdata3=filter(b1,a1,longdata3);longdata3=filter(b2,a2,longdata3);
    
    data1(:,i)=longdata1(ntnoise:ntnoise+nt-1);
    data2(:,i)=longdata2(ntnoise:ntnoise+nt-1);
    data3(:,i)=longdata3(ntnoise:ntnoise+nt-1);
    amp1(i)=max(data1(:,i));amp2(i)=max(data2(:,i));amp3(i)=max(data3(:,i));
    amp_a(i)=sqrt((amp1(i)^2+amp2(i)^2+amp3(i)^2)/3);

%     data(:,i)=sqrt((data1(:,i).^2+data2(:,i).^2+data3(:,i).^2)./3);
%     amp_b(i)=max(data(:,i));
   
    fseek(fid1,-nttotal*4,'cof');
    fseek(fid2,-nttotal*4,'cof');
    fseek(fid3,-nttotal*4,'cof');
    
    if i<N_events
       ntt=round((T_events(i+1)-T_events(i))/dt);
       fseek(fid1,ntt*4,'cof');
       fseek(fid2,ntt*4,'cof');
       fseek(fid3,ntt*4,'cof');
    end
end
fclose(fid1);fclose(fid2);fclose(fid3);

mamp_a=log10(amp_a);
dlmwrite(output_file,mamp_a,'delimiter','\n','precision','%.4f');

