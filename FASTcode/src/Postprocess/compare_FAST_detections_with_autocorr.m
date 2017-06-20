function [detections] = compare_FAST_detections_with_autocorr(ac, fast, baseDir, dataFolder, time_window)

% fingerprint/similarity search
num_fp = length(fast.times);
for k=1:length(fast.thresh)
    
    % Current detection threshold
    detections.fast(k).thresh = fast.thresh(k);

    fast.detflag = zeros(num_fp,1); % True detection flag for fast
    fast.acind = zeros(num_fp,1); % Index for corresponding match in autocorrelation
    fast.actimes = zeros(num_fp,1); % Time (s) for corresponding match in autocorrelation
    fast.acsim = zeros(num_fp,1); % CC for corresponding match in autocorrelation

    ind_false_fast = []; % indices of false detections
    detections.fast(k).false = 0; % Number of false detections
    for ifp=1:num_fp
        if (fast.sim(ifp) >= detections.fast(k).thresh) % above fingerprint/similarity search threshold
            diff_arr = abs(ac.times - fast.times(ifp));
            ind_ac = find(diff_arr == min(diff_arr));
            if ((diff_arr(ind_ac) <= time_window) & (ac.detflag(ind_ac) == 1)) % found a matching detection in autocorrelation
                ind_ac = ind_ac(1); % in case there is more than 1 index for a match (equally between 2 autocorrelation times)
                fast.detflag(ifp) = 1;
                fast.acind(ifp) = ind_ac;
                fast.actimes(ifp) = ac.times(ind_ac);
                fast.acsim(ifp) = ac.sim(ind_ac);
            else % no matching detection in autocorrelation -> false detection
                ind_false_fast = [ind_false_fast ifp];
                detections.fast(k).false = detections.fast(k).false + 1;
            end
        end
    end

    ind_true_ac = find(ac.detflag == 1); % indices of true autocorrelation detections (from visual inspection)
    ind_missed_fast = ind_true_ac(~ismember(ind_true_ac, fast.acind)); % indices of missed detections (in autocorrelation)
    
    % Find duplicate autocorrelation detections assigned to different fast detections
    % This can happen if fast detections are close together in time
    ind_true_fast = find(fast.detflag == 1); % indices of fast true detections
    acind_true = fast.acind(ind_true_fast);
    acind_unique_true = unique(acind_true);
    ndup = histc(acind_true, acind_unique_true);
    ind_hist = acind_unique_true(ndup>1); % index of duplicates in histogram
    for ii=1:length(ind_hist)
        ind_dup = find(acind_true == ind_hist(ii)); % index of duplicate in fast detection list
        [max_sim, ind_keep] = max(fast.sim(ind_true_fast(ind_dup))); % keep the fast detection with highest similarity
        ind_remove = ind_dup(~ismember(ind_dup, ind_dup(ind_keep))); % index of duplicate fast detection -> false detection
        for jj=1:length(ind_remove)
            fast.detflag(ind_true_fast(ind_remove(jj))) = 0;
            ind_false_fast = [ind_false_fast ind_true_fast(ind_remove(jj))];
            detections.fast(k).false = detections.fast(k).false + 1;
        end
    end
    ind_false_fast = sort(ind_false_fast); % re-sort indices of fast false detections
    ind_true_fast = find(fast.detflag == 1); % recalculate indices of fast true detections

    detections.fast(k).true = sum(fast.detflag(:)); % Number of true detections
    detections.fast(k).missed = sum(ac.detflag == 1) - detections.fast(k).true; % Number of missed detections
    
    % Precision and recall
    detections.fast(k).precision = detections.fast(k).true/(detections.fast(k).true + detections.fast(k).false);
    detections.fast(k).recall = detections.fast(k).true/(detections.fast(k).true + detections.fast(k).missed);
    
    
    % Output FAST detections to text file
    if (fast.output_flag)
    
        outfilename = strcat('compare_fast', fast.paramstr{1}, '_thresh', num2str(detections.fast(k).thresh), '_autocorr_timewin', num2str(time_window), '.txt');
        outfilepath = strcat(baseDir, dataFolder, '/', outfilename);
        fid = fopen(outfilepath, 'w');

        fprintf(fid, '%s\n', dataFolder);
        fprintf(fid, 'Comparison time window = %4.2f\n', time_window);
        fprintf(fid, 'FAST threshold = %7.6f\n\n', detections.fast(k).thresh);

        fprintf(fid, 'True detections: %d\n', detections.fast(k).true);
        fprintf(fid, 'Minimum CC for true detections: %10.9f\n', min(fast.acsim(ind_true_fast)));
        C = [fast.times(ind_true_fast) fast.sim(ind_true_fast) fast.acind(ind_true_fast) fast.actimes(ind_true_fast) fast.acsim(ind_true_fast)];
        fprintf(fid, '%7.5f %6.5f %d %7.5f %10.9f\n', C');
        fprintf(fid, '\n');

        fprintf(fid, 'False detections: %d\n', detections.fast(k).false);
        fprintf(fid, 'Maximum FAST similarity for false detections: %6.5f\n', max(fast.sim(ind_false_fast)));
        D = [fast.times(ind_false_fast) fast.sim(ind_false_fast)];
        fprintf(fid, '%7.5f %6.5f\n', D');
        fprintf(fid, '\n');

        fprintf(fid, 'Missed detections: %d\n', detections.fast(k).missed);
        fprintf(fid, 'Maximum CC for missed detections: %10.9f\n', max(ac.sim(ind_missed_fast)));
        E = [ac.times(ind_missed_fast) ac.sim(ind_missed_fast)];
        fprintf(fid, '%7.5f %10.9f\n', E');
        fprintf(fid, '\n');

        fprintf(fid, 'Precision: %7.6f\n', detections.fast(k).precision);
        fprintf(fid, 'Recall: %7.6f\n', detections.fast(k).recall);
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
    if (ac.output_flag)
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
