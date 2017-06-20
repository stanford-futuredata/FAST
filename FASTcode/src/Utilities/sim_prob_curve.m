% function h = sim_prob_curve(sim,detections,trials,nhashfuncs,ntbls,nvotes)
function h = sim_prob_curve(jsim,nhashfuncs,ntbls,nvotes,nparam,colorstr)
% Plot the Similarity-Probability curve for a given detection.
% The probability is the number of times a pair was successfully detected
% over the total number of trials performed.
% The experimental results are compared against theory.
%
% h = sim_prob_curve(sim,detections,trials)
% sim: Similarity metric ranging from [0,1] for each pair.
% detections: Number of detections recorded for each pair.
% trials: Number of trials used the experiment.
% nhashfuncs: Number of hash functions used.
% ntbls: Number of hash tables used.
% nvotes: Number of votes required.
% Example:
% 
%



% h = plot(sim,vote_prob(sim,nhashfuncs,ntbls,nvotes),'ro',sim,detections/trials,'bo');
FigHandle = figure('Position',[1500 500 800 600]);
hold all % cycle through different colors
for k=1:nparam
    h = plot(jsim,vote_prob(jsim,nhashfuncs(k),ntbls(k),nvotes(k)), 'LineWidth', 2);
%     h = plot(jsim,vote_prob(jsim,nhashfuncs(k),ntbls(k),nvotes(k)),colorstr, 'LineWidth', 2);
end
hold off
set(gca,'FontSize',22);
% legend('Model','Experiment','Location','Northwest');
% xlabel('Similarity');
% ylabel('Probability (detections/trials)');
% title(['Trials: ' num2str(trials), ', Votes: ' num2str(nvotes) ...
%       ,', Tables: ' num2str(ntbls) ...
%        ', Hash functions:' num2str(nhashfuncs)]);  
xlabel('Jaccard Similarity');
ylabel('Probability of successful search');
xlim([0 1]);
ylim([0 1]);
% title('Theoretical probability of successful search vs. Jaccard similarity');

end

function P = vote_prob(s,r,b,N)
%Probability of finding a match with similarity s in b tables with r rows each
%in at least N tables

assert(b >= N,' b < N, more successful trials than total number of trials!');

P = 0;
for i=0:N-1
    p = s.^r; %Probability of success in each experiment 
    x0 = nchoosek(b,i);
    y0 = x0.*(1-p).^(b-i).*p.^i;
    P  = P +  y0;
end
P = 1 - P;   
end
