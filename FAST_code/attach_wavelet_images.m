function [largeHaarImages] = attach_wavelet_images(haarImages)

% Attach wavelet images from each component together to form one big image
szHaar = size(haarImages);
if (numel(szHaar) < 4)
    numCh = 1;
else
    numCh = szHaar(4);
end

largeHaarImages = zeros(numCh*szHaar(1), szHaar(2), szHaar(3));
for k=1:numCh
    largeHaarImages((k-1)*szHaar(1)+1:k*szHaar(1),:,:) = haarImages(:,:,:,k);
end

end

