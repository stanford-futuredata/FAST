function [detections] = compare_fpss_detections_with_autocorr(ac, fpss, baseDir, dataFolder)

% Set these to 1 to output text files with comparison summary
flag_output_autocorr = 0;
flag_output_fpss = 0;

% Time window (s) for comparison: fpss and autocorrelation detections are
% equal if they fall within time_window of each other
time_window = 19.0;

% fingerprint/similarity search
num_fp = length(fpss.times);
for k=1:length(fpss.thresh)
    
    % Current detection threshold
    detections.fpss(k).thresh = fpss.thresh(k);

    fpss.detflag = zeros(num_fp,1); % True detection flag for fpss
    fpss.acind = zeros(num_fp,1); % Index for corresponding match in autocorrelation
    fpss.actimes = zeros(num_fp,1); % Time (s) for corresponding match in autocorrelation
    fpss.acsim = zeros(num_fp,1); % CC for corresponding match in autocorrelation

    ind_false_fpss = []; % indices of false detections
    detections.fpss(k).false = 0; % Number of false detections
    for ifp=1:num_fp
        if (fpss.sim(ifp) >= detections.fpss(k).thresh) % above fingerprint/similarity search threshold
            diff_arr = abs(ac.times - fpss.times(ifp));
            ind_ac = find(diff_arr == min(diff_arr));
            if ((diff_arr(ind_ac) <= time_window) & (ac.detflag(ind_ac) == 1)) % found a matching detection in autocorrelation
                ind_ac = ind_ac(1); % in case there is more than 1 index for a match (equally between 2 autocorrelation times)
                fpss.detflag(ifp) = 1;
                fpss.acind(ifp) = ind_ac;
                fpss.actimes(ifp) = ac.times(ind_ac);
                fpss.acsim(ifp) = ac.sim(ind_ac);
            else % no matching detection in autocorrelation -> false detection
                ind_false_fpss = [ind_false_fpss ifp];
                detections.fpss(k).false = detections.fpss(k).false + 1;
            end
        end
    end

    ind_true_ac = find(ac.detflag == 1); % indices of true autocorrelation detections (from visual inspection)
    ind_missed_fpss = ind_true_ac(~ismember(ind_true_ac, fpss.acind)); % indices of missed detections (in autocorrelation)
    
    % Find duplicate autocorrelation detections assigned to different fpss detections
    % This can happen if fpss detections are close together in time
    ind_true_fpss = find(fpss.detflag == 1); % indices of fpss true detections
    acind_true = fpss.acind(ind_true_fpss);
    acind_unique_true = unique(acind_true);
    ndup = histc(acind_true, acind_unique_true);
    ind_hist = acind_unique_true(ndup>1); % index of duplicates in histogram
    for ii=1:length(ind_hist)
        ind_dup = find(acind_true == ind_hist(ii)); % index of duplicate in fpss detection list
        [max_sim, ind_keep] = max(fpss.sim(ind_true_fpss(ind_dup))); % keep the fpss detection with highest similarity
        ind_remove = ind_dup(~ismember(ind_dup, ind_dup(ind_keep))); % index of duplicate fpss detection -> false detection
        for jj=1:length(ind_remove)
            fpss.detflag(ind_true_fpss(ind_remove(jj))) = 0;
            ind_false_fpss = [ind_false_fpss ind_true_fpss(ind_remove(jj))];
            detections.fpss(k).false = detections.fpss(k).false + 1;
        end
    end
    ind_false_fpss = sort(ind_false_fpss); % re-sort indices of fpss false detections
    ind_true_fpss = find(fpss.detflag == 1); % recalculate indices of fpss true detections

    detections.fpss(k).true = sum(fpss.detflag(:)); % Number of true detections
    detections.fpss(k).missed = sum(ac.detflag == 1) - detections.fpss(k).true; % Number of missed detections
    
    % Precision and recall
    detections.fpss(k).precision = detections.fpss(k).true/(detections.fpss(k).true + detections.fpss(k).false);
    detections.fpss(k).recall = detections.fpss(k).true/(detections.fpss(k).true + detections.fpss(k).missed);
    
    
    % Output FPSS detections to text file
    if (flag_output_fpss)
    
        outfilename = strcat('compare_fpss', fpss.paramstr{1}, '_thresh', num2str(detections.fpss(k).thresh), '_autocorr_timewin', num2str(time_window), '.txt');
        outfilepath = strcat(baseDir, dataFolder, '/', outfilename);
        fid = fopen(outfilepath, 'w');

        fprintf(fid, '%s\n', dataFolder);
        fprintf(fid, 'Comparison time window = %4.2f\n', time_window);
        fprintf(fid, 'FPSS threshold = %7.6f\n\n', detections.fpss(k).thresh);

        fprintf(fid, 'True detections: %d\n', detections.fpss(k).true);
        fprintf(fid, 'Minimum CC for true detections: %10.9f\n', min(fpss.acsim(ind_true_fpss)));
        C = [fpss.times(ind_true_fpss) fpss.sim(ind_true_fpss) fpss.acind(ind_true_fpss) fpss.actimes(ind_true_fpss) fpss.acsim(ind_true_fpss)];
        fprintf(fid, '%7.5f %6.5f %d %7.5f %10.9f\n', C');
        fprintf(fid, '\n');

        fprintf(fid, 'False detections: %d\n', detections.fpss(k).false);
        fprintf(fid, 'Maximum FPSS similarity for false detections: %6.5f\n', max(fpss.sim(ind_false_fpss)));
        D = [fpss.times(ind_false_fpss) fpss.sim(ind_false_fpss)];
        fprintf(fid, '%7.5f %6.5f\n', D');
        fprintf(fid, '\n');

        fprintf(fid, 'Missed detections: %d\n', detections.fpss(k).missed);
        fprintf(fid, 'Maximum CC for missed detections: %10.9f\n', max(ac.sim(ind_missed_fpss)));
        E = [ac.times(ind_missed_fpss) ac.sim(ind_missed_fpss)];
        fprintf(fid, '%7.5f %10.9f\n', E');
        fprintf(fid, '\n');

        fprintf(fid, 'Precision: %7.6f\n', detections.fpss(k).precision);
        fprintf(fid, 'Recall: %7.6f\n', detections.fpss(k).recall);
        fclose(fid);
    end
end

% autocorrelation (assume ac.detflag(:) from file is set after visual inspection)
num_ac = length(ac.times);
for k=1:length(ac.thresh)

    % Current detection threshold
    detections.ac(k).thresh = ac.thresh(k);
    
    detections.ac(k).false = 0; % Number of false detections
    detections.ac(k).true = 0; % Number of true detections
    detections.ac(k).missed = 0; % Number of missed detections
    ind_true_det_ac = [];
    ind_false_ac = [];
    ind_missed_ac = [];
    for iac=1:num_ac
        if (ac.sim(iac) >= detections.ac(k).thresh) % above autocorrelation threshold
            if (ac.detflag(iac) == 1) % marked as true detection by visual inspection
                ind_true_det_ac = [ind_true_det_ac iac];
                detections.ac(k).true = detections.ac(k).true + 1;
            else
                ind_false_ac = [ind_false_ac iac];
                detections.ac(k).false = detections.ac(k).false + 1;
            end
        else % below autocorrelation threshold
            if (ac.detflag(iac) == 1) % marked as true detection by visual inspection, missed by threshold
                ind_missed_ac = [ind_missed_ac iac];
                detections.ac(k).missed = detections.ac(k).missed + 1;
            end
        end
    end

    % Precision and recall
    detections.ac(k).precision = detections.ac(k).true/(detections.ac(k).true + detections.ac(k).false);
    detections.ac(k).recall = detections.ac(k).true/(detections.ac(k).true + detections.ac(k).missed);
    
    
    % Output autocorrelation detections to text file
    if (flag_output_autocorr)
        outfilename = strcat('compare_autocorr_thresh', num2str(detections.ac(k).thresh), '.txt');
        outfilepath = strcat(baseDir, dataFolder, '/', outfilename);
        fid = fopen(outfilepath, 'w');

        fprintf(fid, '%s\n', dataFolder);
        fprintf(fid, 'Autocorrelation threshold = %7.6f\n\n', detections.ac(k).thresh);

        fprintf(fid, 'True detections: %d\n', detections.ac(k).true);
        F = [ac.times(ind_true_det_ac) ac.sim(ind_true_det_ac) ac.detflag(ind_true_det_ac)];
        fprintf(fid, '%7.5f %10.9f %d\n', F');
        fprintf(fid, '\n');

        fprintf(fid, 'False detections: %d\n', detections.ac(k).false);
        F = [ac.times(ind_false_ac) ac.sim(ind_false_ac) ac.detflag(ind_false_ac)];
        fprintf(fid, '%7.5f %10.9f %d\n', F');
        fprintf(fid, '\n');

        fprintf(fid, 'Missed detections: %d\n', detections.ac(k).missed);
        F = [ac.times(ind_missed_ac) ac.sim(ind_missed_ac) ac.detflag(ind_missed_ac)];
        fprintf(fid, '%7.5f %10.9f %d\n', F');
        fprintf(fid, '\n');

        fprintf(fid, 'Precision: %7.6f\n', detections.ac(k).precision);
        fprintf(fid, 'Recall: %7.6f\n', detections.ac(k).recall);
        fclose(fid);
    end
end

end
