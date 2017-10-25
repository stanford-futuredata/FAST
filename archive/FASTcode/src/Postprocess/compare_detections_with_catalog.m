function [detections] = compare_detections_with_catalog(ac, fast, catTimes, catMag, baseDir, dataFolder, time_window)

ncatalog = length(catTimes);

% fingerprint/similarity search
num_fp = length(fast.times);
for k=1:length(fast.thresh)

    % Get matching, new, missed detections (against catalog) for fast threshold k
    [detections.fast(k), fast, ind_match_fast, ind_new_fast, ind_missed_fast] = ...
        find_matching_detections_above_thresh(k, time_window, num_fp, ncatalog, fast, catTimes, catMag);
    
    % Output FAST detections to text file
    if (fast.output_flag)
    
        outfilename = strcat('compare_fast', fast.paramstr{1}, '_thresh', num2str(detections.fast(k).thresh), '_catalog_timewin', num2str(time_window), '.txt');
        outfilepath = strcat(baseDir, dataFolder, '/', outfilename);
        fid = fopen(outfilepath, 'w');

        fprintf(fid, '%s\n', dataFolder);
        fprintf(fid, 'Comparison time window = %4.2f\n', time_window);
        fprintf(fid, 'FAST threshold = %7.6f\n\n', detections.fast(k).thresh);

        fprintf(fid, 'Matching detections: %d\n', detections.fast(k).match);
        fprintf(fid, 'Mean magnitude of matching catalog detections = %7.6f\n', mean(fast.catMag(ind_match_fast)));
        fprintf(fid, 'Minimum magnitude of matching catalog detections = %7.6f\n', min(fast.catMag(ind_match_fast)));
        fprintf(fid, 'Maximum magnitude of matching catalog detections = %7.6f\n', max(fast.catMag(ind_match_fast)));
        C = [fast.times(ind_match_fast) fast.sim(ind_match_fast) fast.catind(ind_match_fast) fast.cattime(ind_match_fast) fast.catMag(ind_match_fast)];
        fprintf(fid, '%7.5f %6.5f %d %7.5f %7.5f\n', C');
        fprintf(fid, '\n');

        fprintf(fid, 'New detections: %d\n', detections.fast(k).new);
        fprintf(fid, 'Maximum FAST similarity for new detections: %6.5f\n', max(fast.sim(ind_new_fast)));
        D = [fast.times(ind_new_fast) fast.sim(ind_new_fast)];
        fprintf(fid, '%7.5f %6.5f\n', D');
        fprintf(fid, '\n');

        fprintf(fid, 'Missed detections: %d\n', detections.fast(k).missed);
        fprintf(fid, 'Mean magnitude of missed catalog detections = %7.6f\n', mean(catMag(ind_missed_fast)));
        fprintf(fid, 'Minimum magnitude of missed catalog detections = %7.6f\n', min(catMag(ind_missed_fast)));
        fprintf(fid, 'Maximum magnitude of missed catalog detections = %7.6f\n', max(catMag(ind_missed_fast)));
        E = [catTimes(ind_missed_fast) catMag(ind_missed_fast)];
        fprintf(fid, '%7.5f %7.5f\n', E');
        fprintf(fid, '\n');

        fclose(fid);
    end
end

% autocorrelation
num_ac = length(ac.times);
for k=1:length(ac.thresh)
    
    % Get matching, new, missed detections (against catalog) for autocorrelation threshold k
    [detections.ac(k), ac, ind_match_ac, ind_new_ac, ind_missed_ac] = ...
        find_matching_detections_above_thresh(k, time_window, num_ac, ncatalog, ac, catTimes, catMag);
    
    % Output autocorrelation detections to text file
    if (ac.output_flag)
    
        outfilename = strcat('compare_autocorr_thresh', num2str(detections.ac(k).thresh), '_catalog_timewin', num2str(time_window), '.txt');
        outfilepath = strcat(baseDir, dataFolder, '/', outfilename);
        fid = fopen(outfilepath, 'w');

        fprintf(fid, '%s\n', dataFolder);
        fprintf(fid, 'Comparison time window = %4.2f\n', time_window);
        fprintf(fid, 'Autocorrelation CC threshold = %10.9f\n\n', detections.ac(k).thresh);

        fprintf(fid, 'Matching detections: %d\n', detections.ac(k).match);
        fprintf(fid, 'Mean magnitude of matching catalog detections = %7.6f\n', mean(ac.catMag(ind_match_ac)));
        fprintf(fid, 'Minimum magnitude of matching catalog detections = %7.6f\n', min(ac.catMag(ind_match_ac)));
        fprintf(fid, 'Maximum magnitude of matching catalog detections = %7.6f\n', max(ac.catMag(ind_match_ac)));
        C = [ac.times(ind_match_ac) ac.sim(ind_match_ac) ac.catind(ind_match_ac) ac.cattime(ind_match_ac) ac.catMag(ind_match_ac)];
        fprintf(fid, '%7.5f %10.9f %d %7.5f %7.5f\n', C');
        fprintf(fid, '\n');

        fprintf(fid, 'New detections: %d\n', detections.ac(k).new);
        fprintf(fid, 'Maximum Autocorrelation CC for new detections: %10.9f\n', max(ac.sim(ind_new_ac)));
        D = [ac.times(ind_new_ac) ac.sim(ind_new_ac)];
        fprintf(fid, '%7.5f %10.9f\n', D');
        fprintf(fid, '\n');

        fprintf(fid, 'Missed detections: %d\n', detections.ac(k).missed);
        fprintf(fid, 'Mean magnitude of missed catalog detections = %7.6f\n', mean(catMag(ind_missed_ac)));
        fprintf(fid, 'Minimum magnitude of missed catalog detections = %7.6f\n', min(catMag(ind_missed_ac)));
        fprintf(fid, 'Maximum magnitude of missed catalog detections = %7.6f\n', max(catMag(ind_missed_ac)));
        E = [catTimes(ind_missed_ac) catMag(ind_missed_ac)];
        fprintf(fid, '%7.5f %7.5f\n', E');
        fprintf(fid, '\n');

        fclose(fid);
    end
end

end

function [detinfo_k, newAlg, ind_match, ind_new, ind_missed] = ...
        find_matching_detections_above_thresh(k, time_window, num_newAlg, ncatalog, newAlg, catTimes, catMag)
    
    % Current detection threshold
    detinfo_k.thresh = newAlg.thresh(k);

    newAlg.detflag = zeros(num_newAlg,1); % Matching detection flag for new detection algorithm
    newAlg.catind = zeros(num_newAlg,1); % Index for corresponding match in catalog
    newAlg.cattime = zeros(num_newAlg,1); % Time (s) for corresponding match in catalog
    newAlg.catMag = zeros(num_newAlg,1); % magnitude for corresponding match in catalog

    ind_new = []; % indices of new detections
    detinfo_k.new = 0; % Number of new detections
    for ifp=1:num_newAlg
        if (newAlg.sim(ifp) >= detinfo_k.thresh) % above new algorithm detection threshold
            diff_arr = abs(catTimes - newAlg.times(ifp));
            ind_cat = find(diff_arr == min(diff_arr));
            if (diff_arr(ind_cat) <= time_window) % found a matching detection in catalog
                ind_cat = ind_cat(1); % in case there is more than 1 index for a match (equally between 2 catalog times)
                newAlg.detflag(ifp) = 1;
                newAlg.catind(ifp) = ind_cat;
                newAlg.cattime(ifp) = catTimes(ind_cat);
                newAlg.catMag(ifp) = catMag(ind_cat);
            else % no matching detection in catalog -> new detection
                ind_new = [ind_new ifp];
                detinfo_k.new = detinfo_k.new + 1;
            end
        end
    end

    ind_all_cat = [1:ncatalog]; % indices of all catalog detections
    ind_missed = ind_all_cat(~ismember(ind_all_cat, newAlg.catind)); % indices of missed detections (in catalog)
    
    % Find duplicate catalog detections assigned to different detections from new algorithm
    % This can happen if new algorithm detections are close together in time
    ind_match = find(newAlg.detflag == 1); % indices of newAlg detections matching catalog detections
    catind_match = newAlg.catind(ind_match);
    catind_unique_true = unique(catind_match);
    ndup = histc(catind_match, catind_unique_true);
    ind_hist = catind_unique_true(ndup>1); % index of duplicates in histogram
    for ii=1:length(ind_hist)
        ind_dup = find(catind_match == ind_hist(ii)); % index of duplicate in newAlg detection list
        [max_sim, ind_keep] = max(newAlg.sim(ind_match(ind_dup))); % keep the newAlg detection with highest similarity
        ind_remove = ind_dup(~ismember(ind_dup, ind_dup(ind_keep))); % index of duplicate newAlg detection -> new detection
        for jj=1:length(ind_remove)
            newAlg.detflag(ind_match(ind_remove(jj))) = 0;
            ind_new = [ind_new ind_match(ind_remove(jj))];
            detinfo_k.new = detinfo_k.new + 1;
        end
    end
    ind_new = sort(ind_new); % re-sort indices of newAlg new detections
    ind_match = find(newAlg.detflag == 1); % recalculate indices of newAlg matching detections

    detinfo_k.match = sum(newAlg.detflag(:)); % Number of matching detections
    detinfo_k.missed = ncatalog - detinfo_k.match; % Number of missed detections
end
