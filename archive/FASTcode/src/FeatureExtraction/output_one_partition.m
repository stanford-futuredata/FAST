% Called by driver. Output specImages and haarImages from one partition of
% the spectrogram.
% % % function [haarImages, dt_fp, newStartOffset, partRuntime] = output_one_partition(p, startOffset, ...
% % %     noverlap, nch, inp, specSettings, baseDir, specStr)
function [normHaarImages, dt_fp, newStartOffset, partRuntime] = output_one_partition(p, startOffset, ...
    noverlap, nch, inp, specSettings, baseDir, specStr)

    % Get spectrogram for each channel
    partRuntime = 0;
    for k=1:nch

       % Read in spectrogram for partition p, channel k
       specData(k) = load_pspectrogram(specSettings(k).data, p, {'P'});
       s = size(specData(k).P);
       Norig = s(2); % same for all channels
       
       specAugment = [specData(k).P];
       clear specData;
       
       % Add overlap section if not the last partition
       if (p ~= inp.numPartitions)
           % Read in overlap section of spectrogram from beginning of partition p+1, channel k
           specOverlap = load_pspectrogram(specSettings(k).data, p+1, {'P'}, noverlap);

           % Combine spectrogram for partition p with overlap section from partition p+1
           specAugment = [specAugment specOverlap.P];
           clear specOverlap; 
       end

       %%%%%%%%%%%%%%%%%%%%%% SPECTRAL IMAGE / WAVELET %%%%%%%%%%%%%%%%%%%%%%

       % Get spectral images, wavelet transformed spectral images, for each channel
       [specImages(:,:,:,k), haarImages(:,:,:,k), NWindows, dt_fp, run_time] = get_spectral_images_and_wavelet_transform(...
           specAugment, specSettings(k), startOffset, inp.fingerprintLength, inp.fingerprintLag);
       partRuntime = partRuntime + run_time;
    end % k
    clear specAugment;

    % Output spectral images and wavelet transformed spectral images (huge files)
%    save([baseDir 'specImages' specStr '_part' num2str(p) '.mat'], 'specImages', inp.saveVersion);
%     save([baseDir 'haarImages' specStr '_part' num2str(p) '.mat'], 'haarImages', 'dt_fp', inp.saveVersion);
    clear specImages;
    
    % Normalize each Haar image
    s = size(haarImages);
    haarImages = reshape(haarImages, s(1)*s(2), s(3));
    normHaarImages = normalize_columns(haarImages, 2);
    clear haarImages;
    save([baseDir 'normHaarImages' specStr '_part' num2str(p) '.mat'], 'normHaarImages', 'dt_fp', inp.saveVersion);

    % Compute start offset for next partition
    newStartOffset = startOffset + inp.fingerprintLag*NWindows - Norig;
end
