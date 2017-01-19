% Create plots of similarity matrices
% Clara Yoon, 2013-06-17
clear all

% Create fake fingerprints to use as windows
[NWindows, NWindowLength, Nnonzero, allwindows] = fake_fingerprints();

% Allocate similarity matrices
cosine_matrix = zeros(NWindows, NWindows);
jaccard_matrix = zeros(NWindows, NWindows);

% Loop over windows (brute force!)
% Do computations only for lower triangular matrix, then fill in the rest
time = tic;
for j=1:NWindows
    j_window = allwindows(:,j);
    for k=1:j
        k_window = allwindows(:,k);
        cosine_matrix(j,k) = cosine_similarity(j_window, k_window);
        jaccard_matrix(j,k) = jaccard(j_window, k_window);
    end
end
disp(['brute force similarity calculation took: ' num2str(toc(time))]);

% Similarity matrix is symmetric, so copy computed elements from
% lower triangular to upper triangular region
cosine_final = cosine_matrix + tril(cosine_matrix,-1)';
jaccard_final = jaccard_matrix + tril(jaccard_matrix,-1)';

% Make plots
[x,y] = meshgrid(1:1:NWindows);

figure
set(gca, 'FontSize', 18)
surf(x,y,cosine_final)
colorbar
caxis([0.0 1.0])
title('Cosine similarity')
view(2) % map view
shading interp

figure
set(gca, 'FontSize', 18)
surf(x,y,jaccard_final)
colorbar
caxis([0.0 1.0])
title('Jaccard similarity')
view(2)
shading interp

