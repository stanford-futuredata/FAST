function B = block_max(A,m,n,num_coeff)

  [am,an] = size(A); 

  B = false(am,an);

  for i=1:m:am
  for j=1:n:an
      i_ = i:(i+m-1);
      j_ = j:(j+n-1);
      loc_A = A(i_,j_);
      [val ind] = sort(loc_A(:),'descend');
      threshold = val(num_coeff);
      B(i_,j_) = loc_A >= threshold;
  end
  end

end
