a = [3 1 0 11 4; 1 5 4 0 0; 0 4 0 0 0; 9 0 0 0 2; 8 0 0 2 6];
b = [4 2 1 3 0; 2 5 3 0 0; 1 3 4 6 1; 3 0 6 0 0; 0 0 1 0 12];
c = [2 1 0 0 7; 1 3 1 0 9; 0 1 0 14 3; 0 0 4 0 15; 7 9 3 5 0];
s = a+b+c;
sp = sparse(a)+sparse(b)+sparse(c);

[ia, ja, ka] = find(a);
[ib, jb, kb] = find(b);
[ic, jc, kc] = find(c);
all_i = cat(1, ia, ib, ic);
all_j = cat(1, ja, jb, jc);
all_k = cat(1, ka, kb, kc);
sum_sp = sparse(all_i, all_j, all_k, 5, 5);
isequal(sp, sum_sp)

[rt, r_i, r_j, r_k] = mxAddSimilarityMatrix(uint32(all_i-1), uint32(all_j-1), all_k, 5, 1);
mx_sp = sparse(double(r_i)+1, double(r_j)+1, r_k, 5, 5);
isequal(sp, mx_sp)



nfp = 86381;
ad = load('check_NCSN_CCOB_3comp_24hr_allData.mat');
compTotalSim = sparse(double(ad.allData.pair_i)+1, double(ad.allData.pair_j)+1, ...
    ad.allData.pair_k, nfp, nfp);
[comp_i, comp_j, comp_k] = find(compTotalSim);

thresh = 0.00;
[runTime, totalPairs.i, totalPairs.j, totalPairs.k] = mxAddSimilarityMatrix(...
        ad.allData.pair_i, ad.allData.pair_j, ad.allData.pair_k, nfp, thresh);
    
[sort_comp_k, ix_comp] = sort(comp_k, 'descend');
sort_comp_i = comp_i(ix_comp);
sort_comp_j = comp_j(ix_comp);

[sort_total_k, ix_total] = sort(totalPairs.k, 'descend');
sort_total_i = totalPairs.i(ix_total);
sort_total_j = totalPairs.j(ix_total);

last_ind = 300;
[double(sort_comp_i(1:last_ind)-1) double(sort_total_i(1:last_ind)) sort_comp_k(1:last_ind) sort_total_k(1:last_ind)]
[double(sort_comp_j(1:last_ind)-1) double(sort_total_j(1:last_ind)) sort_comp_k(1:last_ind) sort_total_k(1:last_ind)]