function y = dsq_test()

    num_iter = 1000;

%     dsq_data.n = 128;
%     dsq_data.dx = 0.1;
%     dsq_data.thres = 0.1; %cannot be less than dx
%     dsq_data.xmax = 1;

    dsq_data.n = 256;
    dsq_data.dx = 0.05;
    dsq_data.thres = 0.05; %cannot be less than dx
    dsq_data.xmax = 1;


    [x y] = timeit(dsq_data,num_iter);

    figure(1);
    qplot(-x);
    figure(2);
    imgplot(y);


end

function [x y] = timeit(dsq_data,num_iter)

    x = test_data(num_iter,dsq_data.n);

    time = tic;
    for i=1:num_iter
        y = dsqf(x(i,:),dsq_data.dx,dsq_data.xmax,dsq_data.thres);
    end
    time = toc(time);
    disp(['Number of iterations: ' num2str(num_iter) ...
          ', Time taken: ' num2str(time) ' s' ...
          ', Iterations/sec: ' num2str(num_iter/time) ]);
    x = x(num_iter,:);

end


% Test data in range [-1,1)
function y = test_data(m,n);
    y = 2*rand(m,n) - 1;
end


function qplot(x)
    plot(1:length(x),x);
end

function imgplot(x)
     imagesc(x');
     caxis(0:1);
     colormap('gray')
end

