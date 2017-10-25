close all
clear

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% % Parameter testing for totalMatrix_WHAR_20101101_3ch_01hr
% nevents = 216;
% 
% % p1: baseline parameters
% p1.thresh = [0.06 0.08 0.1 0.12 0.14 0.16 0.18];
% p1.num_match = [204 185 172 162 152 144 135];
% p1.mean_mag_match = [1.987847 2.034586 2.069745 2.100222 2.129645 2.152155 2.170421];
% p1.min_mag_match = [1.3747 1.3747 1.4313 1.4321 1.4321 1.4321 1.4321];
% p1.max_mag_match = [3.9503 3.9503 3.9503 3.9503 3.9503 3.9503 3.9503];
% p1.L = p1.mean_mag_match - p1.min_mag_match;
% p1.U = p1.max_mag_match - p1.mean_mag_match;
% p1.num_new = [312 92 39 30 27 20 19];
% p1.max_sim_new = [0.68 0.68 0.68 0.68 0.68 0.68 0.68];
% p1.num_missed = nevents - p1.num_match;
% p1.mean_mag_missed = [1.599058 1.558419 1.561664 1.564322 1.578178 1.594432 1.625958];
% p1.min_mag_missed = [1.3998 1.3998 1.3747 1.3747 1.3747 1.3747 1.3747];
% p1.max_mag_missed = [2.1562 2.1562 2.1562 2.1562 2.1562 2.1562 2.2867];
% p1.Lm = p1.mean_mag_missed - p1.min_mag_missed;
% p1.Um = p1.max_mag_missed - p1.mean_mag_missed;

% % p2: Changed inp.t_value to 400
% p2.thresh = [0.06 0.08 0.1 0.12 0.14 0.16 0.18];
% p2.num_match = [206 189 171 163 160 155 151];
% p2.mean_mag_match = [1.985891 2.02468 2.072464 2.086947 2.096408 2.103837 2.112173];
% p2.min_mag_match = [1.3747 1.3747 1.3998 1.3998 1.3998 1.3998 1.3998];
% p2.max_mag_match = [3.9503 3.9503 3.9503 3.9503 3.9503 3.9503 3.9503];
% p2.L = p2.mean_mag_match - p2.min_mag_match;
% p2.U = p2.max_mag_match - p2.mean_mag_match;
% p2.num_new = [267 107 68 53 47 46 41];
% p2.max_sim_new = [0.87 0.87 0.87 0.87 0.87 0.87 0.87];
% p2.num_missed = nevents - p2.num_match;
% p2.mean_mag_missed = [1.56159 1.557215 1.562624 1.59504 1.594359 1.616634 1.627251];
% p2.min_mag_missed = [1.4441 1.4075 1.3747 1.3747 1.3747 1.3747 1.3747];
% p2.max_mag_missed = [1.825 1.825 1.825 2.2867 2.2867 2.3827 2.3827];
% p2.Lm = p2.mean_mag_missed - p2.min_mag_missed;
% p2.Um = p2.max_mag_missed - p2.mean_mag_missed;
% 
% % p3: Changed inp.fingerprintLength to 64
% p3.thresh = [0.06 0.08 0.1 0.12 0.14 0.16 0.18];
% p3.num_match = [214 209 193 181 175 165 160];
% p3.mean_mag_match = [1.969347 1.980195 2.018838 2.048759 2.065118 2.090398 2.105374];
% p3.min_mag_match = [1.3747 1.3747 1.4313 1.4313 1.4321 1.4321 1.4321];
% p3.max_mag_match = [3.9503 3.9503 3.9503 3.9503 3.9503 3.9503 3.9503];
% p3.L = p3.mean_mag_match - p3.min_mag_match;
% p3.U = p3.max_mag_match - p3.mean_mag_match;
% p3.num_new = [563 342 133 55 32 22 17];
% p3.max_sim_new = [0.94 0.94 0.94 0.94 0.94 0.94 0.94];
% p3.num_missed = nevents - p3.num_match;
% p3.mean_mag_missed = [1.63455 1.5498 1.524943 1.539543 1.544237 1.564582 1.568741];
% p3.min_mag_missed = [1.4441 1.3998 1.3747 1.3747 1.3747 1.3747 1.3747];
% p3.max_mag_missed = [1.825 1.825 1.825 1.825 1.825 2.2867 2.2867];
% p3.Lm = p3.mean_mag_missed - p3.min_mag_missed;
% p3.Um = p3.max_mag_missed - p3.mean_mag_missed;
% 
% % p4: Changed inp.fingerprintLag to 5
% p4.thresh = [0.06 0.08 0.1 0.12 0.14 0.16 0.18];
% p4.num_match = [211 195 181 172 163 149 144];
% p4.mean_mag_match = [1.972194 2.008774 2.047894 2.070135 2.097841 2.139467 2.15006];
% p4.min_mag_match = [1.3747 1.3747 1.4313 1.4313 1.4321 1.4321 1.4321];
% p4.max_mag_match = [3.9503 3.9503 3.9503 3.9503 3.9503 3.9503 3.9503];
% p4.L = p4.mean_mag_match - p4.min_mag_match;
% p4.U = p4.max_mag_match - p4.mean_mag_match;
% p4.num_new = [462 158 60 34 28 22 21];
% p4.max_sim_new = [0.97 0.97 0.97 0.97 0.97 0.97 0.97];
% p4.num_missed = nevents - p4.num_match;
% p4.mean_mag_missed = [1.71528 1.571357 1.544014 1.560139 1.561534 1.581027 1.598622];
% p4.min_mag_missed = [1.4441 1.3998 1.3747 1.3747 1.3747 1.3747 1.3747];
% p4.max_mag_missed = [2.1501 2.1501 2.1501 2.1501 2.1501 2.1501 2.1501];
% p4.Lm = p4.mean_mag_missed - p4.min_mag_missed;
% p4.Um = p4.max_mag_missed - p4.mean_mag_missed;
% 
% % p5: Changed inp.settings.ntbls to 500
% p5.thresh = [0.02 0.024 0.028 0.032 0.036 0.04 0.044];
% % p5.thresh = p5.thresh*5 - 0.04; % *** calibration only
% p5.num_match = [209 201 194 191 181 175 169];
% p5.mean_mag_match = [1.97631 1.995265 2.011926 2.019683 2.045277 2.06203 2.0798];
% p5.min_mag_match = [1.3747 1.4075 1.4075 1.4138 1.4313 1.4313 1.4321];
% p5.max_mag_match = [3.9503 3.9503 3.9503 3.9503 3.9503 3.9503 3.9503];
% p5.L = p5.mean_mag_match - p5.min_mag_match;
% p5.U = p5.max_mag_match - p5.mean_mag_match;
% p5.num_new = [372 202 95 67 51 43 35];
% p5.max_sim_new = [0.338 0.338 0.338 0.338 0.338 0.338 0.338];
% % p5.max_sim_new = p5.max_sim_new*5 - 0.04; % *** calibration only
% p5.num_missed = nevents - p5.num_match;
% p5.mean_mag_missed = [1.6658 1.577413 1.563441 1.557996 1.557549 1.557417 1.55794];
% p5.min_mag_missed = [1.4441 1.3747 1.3747 1.3747 1.3747 1.3747 1.3747];
% p5.max_mag_missed = [2.1501 2.1501 2.1501 2.1501 2.1501 2.1501 2.1501];
% p5.Lm = p5.mean_mag_missed - p5.min_mag_missed;
% p5.Um = p5.max_mag_missed - p5.mean_mag_missed;
% 
% % p6: Changed inp.settings.nfuncs to 6
% p6.thresh = [0.06 0.08 0.1 0.12 0.14 0.16 0.18];
% p6.num_match = [181 163 148 139 129 119 115];
% p6.mean_mag_match = [2.04446 2.09666 2.141927 2.16555 2.186754 2.218034 2.233364];
% p6.min_mag_match = [1.4075 1.4075 1.4522 1.4522 1.4522 1.4522 1.6556];
% p6.max_mag_match = [3.9503 3.9503 3.9503 3.9503 3.9503 3.9503 3.9503];
% p6.L = p6.mean_mag_match - p6.min_mag_match;
% p6.U = p6.max_mag_match - p6.mean_mag_match;
% p6.num_new = [52 24 20 17 12 11 8];
% p6.max_sim_new = [0.64 0.64 0.64 0.64 0.64 0.64 0.64];
% p6.num_missed = nevents - p6.num_match;
% p6.mean_mag_missed = [1.561846 1.565168 1.583885 1.606466 1.639289 1.657355 1.662104];
% p6.min_mag_missed = [1.3747 1.3747 1.3747 1.3747 1.3747 1.3747 1.3747];
% p6.max_mag_missed = [2.1501 2.1501 2.1501 2.2624 2.3827 2.3827 2.3827];
% p6.Lm = p6.mean_mag_missed - p6.min_mag_missed;
% p6.Um = p6.max_mag_missed - p6.mean_mag_missed;
% 
% % p7: Changed inp.settings.nfuncs to 4
% p7.thresh = [0.06 0.08 0.1 0.12 0.14 0.16 0.18];
% p7.num_match = [213 212 207 193 180 174 168];
% p7.mean_mag_match = [1.969555 1.971517 1.982416 2.015525 2.047586 2.062764 2.082881];
% p7.min_mag_match = [1.3747 1.3747 1.3998 1.4138 1.4313 1.4313 1.4321];
% p7.max_mag_match = [3.9503 3.9503 3.9503 3.9503 3.9503 3.9503 3.9503];
% p7.L = p7.mean_mag_match - p7.min_mag_match;
% p7.U = p7.max_mag_match - p7.mean_mag_match;
% p7.num_new = [648 553 302 112 57 38 29];
% p7.max_sim_new = [0.95 0.95 0.95 0.95 0.95 0.95 0.95];
% p7.num_missed = nevents - p7.num_match;
% p7.mean_mag_missed = [1.7314 1.686975 1.594356 1.552743 1.559553 1.566393 1.558029];
% p7.min_mag_missed = [1.4441 1.4441 1.3747 1.3747 1.3747 1.3747 1.3747];
% p7.max_mag_missed = [2.1501 2.1501 2.1501 2.1501 2.1501 2.1501 2.1501];
% p7.Lm = p7.mean_mag_missed - p7.min_mag_missed;
% p7.Um = p7.max_mag_missed - p7.mean_mag_missed;
% 
% % p8: Changed inp.fingerprintLength to 64, inp.tvalue to 400
% p8.thresh = [0.06 0.08 0.1 0.12 0.14 0.16 0.18];
% p8.num_match = [211 207 193 182 170 162 160];
% p8.mean_mag_match = [1.975704 1.984299 2.015921 2.043404 2.066302 2.080907 2.082879];
% p8.min_mag_match = [1.3747 1.3747 1.3998 1.3998 1.4321 1.4321 1.4321];
% p8.max_mag_match = [3.9503 3.9503 3.9503 3.9503 3.9503 3.9503 3.9503];
% p8.L = p8.mean_mag_match - p8.min_mag_match;
% p8.U = p8.max_mag_match - p8.mean_mag_match;
% p8.num_new = [499 316 168 86 65 51 39];
% p8.max_sim_new = [1.59 1.59 1.59 1.59 1.59 1.59 1.59];
% p8.num_missed = nevents - p8.num_match;
% p8.mean_mag_missed = [1.56718 1.551067 1.549422 1.553232 1.59648 1.622269 1.633014];
% p8.min_mag_missed = [1.4441 1.4138 1.3747 1.3747 1.3747 1.3747 1.3747];
% p8.max_mag_missed = [1.825 1.825 1.825 1.825 2.2867 2.3827 2.3827];
% p8.Lm = p8.mean_mag_missed - p8.min_mag_missed;
% p8.Um = p8.max_mag_missed - p8.mean_mag_missed;
% 
% % p9: Changed inp.fingerprintLength to 32, inp.tvalue to 400
% p9.thresh = [0.12 0.16 0.2 0.24 0.28 0.32 0.36];
% p9.num_match = [212 200 184 162 147 138 132];
% p9.mean_mag_match = [1.973714 2.001967 2.032804 2.085762 2.129608 2.150488 2.16266];
% p9.min_mag_match = [1.3747 1.4313 1.4313 1.4321 1.4321 1.4321 1.4321];
% p9.max_mag_match = [3.9503 3.9503 3.9503 3.9503 3.9503 3.9503 3.9503];
% p9.L = p9.mean_mag_match - p9.min_mag_match;
% p9.U = p9.max_mag_match - p9.mean_mag_match;
% p9.num_new = [526 319 141 75 28 16 11];
% p9.max_sim_new = [2 2 2 2 2 2 2];
% p9.num_missed = nevents - p9.num_match;
% p9.mean_mag_missed = [1.570525 1.519744 1.583547 1.607704 1.618217 1.640282 1.657599];
% p9.min_mag_missed = [1.4441 1.3747 1.3747 1.3747 1.3747 1.3747 1.3747];
% p9.max_mag_missed = [1.825 1.825 2.9776 2.9776 2.9776 2.9776 2.9776];
% p9.Lm = p9.mean_mag_missed - p9.min_mag_missed;
% p9.Um = p9.max_mag_missed - p9.mean_mag_missed;
% 
% % p10: Changed inp.fingerprintLength to 32, inp.tvalue to 200
% p10.thresh = [0.12 0.16 0.2 0.24 0.28 0.32 0.36];
% p10.num_match = [211 197 183 173 162 147 140];
% p10.mean_mag_match = [1.975521 2.005917 2.040174 2.068482 2.07592 2.117254 2.128103];
% p10.min_mag_match = [1.3747 1.3747 1.4075 1.4321 1.4321 1.5021 1.5252];
% p10.max_mag_match = [3.9503 3.9503 3.9503 3.9503 3.9503 3.9503 3.9503];
% p10.L = p10.mean_mag_match - p10.min_mag_match;
% p10.U = p10.max_mag_match - p10.mean_mag_match;
% p10.num_new = [532 408 277 178 104 57 26];
% p10.max_sim_new = [1.87 1.87 1.87 1.87 1.87 1.87 1.87];
% p10.num_missed = nevents - p10.num_match;
% p10.mean_mag_missed = [1.57488 1.554937 1.556291 1.55493 1.644536 1.622269 1.668092];
% p10.min_mag_missed = [1.4441 1.3998 1.3747 1.3747 1.3747 1.3747 1.3747];
% p10.max_mag_missed = [1.6381 1.825 1.825 1.825 2.9776 2.9776 2.9776];
% p10.Lm = p10.mean_mag_missed - p10.min_mag_missed;
% p10.Um = p10.max_mag_missed - p10.mean_mag_missed;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Parameter testing for totalMatrix_WHAR_20101101_3ch_24hr
nevents = 3558;

% p1: baseline parameters
p1.thresh = [0.15 0.17 0.19 0.21 0.23 0.25 0.27 0.29 0.31];
p1.num_match = [3198 3044 2940 2814 2709 2615 2527 2435 2336];
p1.mean_mag_match = [2.112076 2.137137 2.154869 2.177306 2.194749 2.211906 2.227548 2.243897 2.262543];
p1.min_mag_match = [1.2608 1.2608 1.2608 1.3751 1.3751 1.3751 1.3957 1.3957 1.3957];
p1.max_mag_match = [4.8036 4.8036 4.8036 4.8036 4.8036 4.8036 4.8036 4.8036 4.8036];
p1.L = p1.mean_mag_match - p1.min_mag_match;
p1.U = p1.max_mag_match - p1.mean_mag_match;
p1.num_new = [2220 1125 631 442 347 291 259 233 211];
p1.max_sim_new = [1.88 1.88 1.88 1.88 1.88 1.88 1.88 1.88 1.88];
p1.num_missed = nevents - p1.num_match;
p1.mean_mag_missed = [1.606046 1.609243 1.613724 1.620506 1.633712 1.642061 1.652359 1.664032 1.675365];
p1.min_mag_missed = [1.2744 1.2744 1.2744 1.2608 1.2608 1.2608 1.2608 1.2608 1.2608];
p1.max_mag_missed = [2.9996 2.9996 2.9996 3.312 3.312 3.4484 3.4484 3.4484 3.4484];
p1.Lm = p1.mean_mag_missed - p1.min_mag_missed;
p1.Um = p1.max_mag_missed - p1.mean_mag_missed;

font_size = 16;
% p_check = p2; p_legend_check = 'tvalue=400';
% p_check = p3; p_legend_check = 'fpLength=64';
% p_check = p4; p_legend_check = 'fpLag=5';
% p_check = p5; p_legend_check = 'ntbls=500';
% p_check = p6; p_legend_check = 'nfuncs=6';
% p_check = p7; p_legend_check = 'nfuncs=4';
% p_check = p8; p_legend_check = 'fpLength=64, tvalue=400';
% p_check = p9; p_legend_check = 'fpLength=32, tvalue=400';
% p_check = p10; p_legend_check = 'fpLength=32, tvalue=200';


figure
set(gca,'FontSize',font_size);
plot(p1.thresh, p1.num_match/nevents, 'o-');
% % plot(p1.thresh, p1.num_match/nevents, 'o-', p_check.thresh, p_check.num_match/nevents, 'o-');
% % legend('baseline', p_legend_check);
% plot(p1.thresh, p1.num_match/nevents, 'o-', p2.thresh, p2.num_match/nevents, 'o-', ...
%     p3.thresh, p3.num_match/nevents, 'o-', p_check.thresh, p_check.num_match/nevents, 'o-');
% legend('baseline', 'tvalue=400', 'fpLength=64', p_legend_check);
xlabel('network FAST similarity threshold');
ylabel('% of matching detections with template catalog');
title('% of matching detections by FAST');

figure
set(gca,'FontSize',font_size);
% plot(p1.thresh, p1.mean_mag_match, 'o-', p_check.thresh, p_check.mean_mag_match, 'o-');
errorbar([p1.thresh'], [p1.mean_mag_match'], [p1.L'], [p1.U']);
% % errorbar([p1.thresh' p_check.thresh'], [p1.mean_mag_match' p_check.mean_mag_match'], [p1.L' p_check.L'], [p1.U' p_check.U']);
% % legend('baseline', p_legend_check);
xlabel('network FAST similarity threshold');
ylabel('Magnitude from template catalog');
title('Matching detections: magnitude from template catalog');
% % xlim([0.06 0.18]);
% % ylim([1 4]);

figure
set(gca,'FontSize',font_size);
plot(p1.thresh, p1.num_new, 'o-');
% % plot(p1.thresh, p1.num_new, 'o-', p_check.thresh, p_check.num_new, 'o-');
% % legend('baseline', p_legend_check);
% plot(p1.thresh, p1.num_new, 'o-', p2.thresh, p2.num_new, 'o-', ...
%     p3.thresh, p3.num_new, 'o-', p_check.thresh, p_check.num_new, 'o-');
% legend('baseline', 'tvalue=400', 'fpLength=64', p_legend_check);
xlabel('network FAST similarity threshold');
ylabel('# of new detections not in template catalog');
title('Number of new detections by FAST');

% Missed detections: can infer from matching detections, so redundant
% figure
% set(gca,'FontSize',font_size);
% plot(p1.thresh, p1.num_missed/nevents, 'o-', p_check.thresh, p_check.num_missed/nevents, 'o-');
% legend('baseline', p_legend_check);
% xlabel('network FAST similarity threshold');
% ylabel('Percent of missed detections');
% title('Percent of missed detections by FAST');

figure
set(gca,'FontSize',font_size);
errorbar([p1.thresh'], [p1.mean_mag_missed'], [p1.Lm'], [p1.Um']);
% % errorbar([p1.thresh' p_check.thresh'], [p1.mean_mag_missed' p_check.mean_mag_missed'], [p1.Lm' p_check.Lm'], [p1.Um' p_check.Um']);
% % legend('baseline', p_legend_check);
xlabel('network FAST similarity threshold');
ylabel('Magnitude from template catalog');
title('Missed detections: magnitude from template catalog');
% % xlim([0.06 0.18]);
% % ylim([1 2.5]);
