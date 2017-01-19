function [detection_out] = make_detection_list(topdata, thresh_cc, dt, skip_time)

% Input is 'topdata' generated from calling get_autocorr_detections.m
% Given a list of detection pairs sorted from highest to lowest similarity,
% returns a list of detections, with similarity greater than thresh_cc
%
% To view all outputs, see detection_out{:}
% To view all detection indices, see detection_out{1}
% To view all detection indices, see double(detection_out{1})*dt
% To view all detection cc or similarity values, see detection_out{2}

skip_samples = ceil(skip_time/dt);

% preallocsize = 6000;
preallocsize = 600000;
detection_list = zeros(preallocsize,1,'int32');
detection_cc = zeros(preallocsize,1);

index_keep = find(topdata.cc >= thresh_cc);
index_last = index_keep(end);

top_event = 1;
for k=1:index_last
    if (top_event > preallocsize)
        break;
    else
        % Add cc_i events to detection list
        search_events = detection_list(1:top_event,:);       
        if (0 == length(find( abs(search_events-topdata.cc_i(k)) < skip_samples )))
            detection_list(top_event) = topdata.cc_i(k);
            detection_cc(top_event) = topdata.cc(k);
            top_event = top_event+1;
        end
        
        % Add cc_j events to detection list
        search_events = detection_list(1:top_event,:);       
        if (0 == length(find( abs(search_events-topdata.cc_j(k)) < skip_samples )))
            detection_list(top_event) = topdata.cc_j(k);
            detection_cc(top_event) = topdata.cc(k);
            top_event = top_event+1;
        end
    end
end

% Remove zeros from detection list
detection_list = detection_list(1:top_event-1,:);
detection_cc = detection_cc(1:top_event-1,:);

% Sort detection list in increasing time order
flag_sort = 1;
if (flag_sort)
    [detection_list, ix] = sort(detection_list);
    detection_out = {detection_list(:) detection_cc(ix)};
end

end

