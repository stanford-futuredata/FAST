from genericpath import isfile
from textwrap import indent
from turtle import st
import seisbench
import seisbench.models as sbm
import obspy
from obspy import UTCDateTime, read, Stream
import matplotlib.pyplot as plt
import matplotlib
import os
import json
import pandas as pd
import datetime

dir_list = os.listdir('event_ids')
seisbench_picks = {'SeisBench_Picks': {}}
trace_id = " "

stations = ['CDY', 'CPM', 'GTM', 'RMM', 'RMR', 'TPC']

model = sbm.EQTransformer()
print(model)

'''
    The model created above consisted of random weights, i.e., 
    it was not trained. While this is (often) the right approach when 
    starting to train a model, for application we'll need a trained model. 
    SeisBench offers pretrained models, which can be loaded with the 
    from_pretrained method. To list available pretrained models, we can use 
    list_pretrained. By setting details=True, we also get a 
    docstring for each model.
'''

# pretrained_weights = sbm.EQTransformer.list_pretrained(details=True)
# for key, value in pretrained_weights.items():
#     print(f"{key}:\n{value}\n-----------------------\n")

model = sbm.EQTransformer.from_pretrained("original")
print(model.weights_docstring)

'''
   SeisBench models can directly annotate obspy streams. 
'''

# make directory for annotation plots
annotations_dir = 'seisbench_picks/'
if not os.path.exists(annotations_dir):
    os.makedirs(annotations_dir)
    
with open("event_picks.json", "w") as json_file:
    for d in dir_list:
        if d != '.DS_Store':
            seisbench_picks['SeisBench_Picks'][str(d)] = {}
            seisbench_picks['SeisBench_Picks'][str(d)]['P_Origin_Time'] = " "
            
            st = Stream()

            stream = read('event_ids/' + d + '/*.sac')
            
            for i in range(len(stream)):
                
                if stream[i].stats.station in stations:
                    st_temp = Stream()
                    tr_temp_e = stream[i].copy()
                    tr_temp_n = stream[i].copy()
                    tr_temp_z = stream[i].copy()
                    tr_temp_e.stats.channel = 'EHE'
                    st_temp.append(tr_temp_e)
                    tr_temp_n.stats.channel = 'EHN'
                    st_temp.append(tr_temp_n)
                    tr_temp_z.stats.channel = 'EHZ'
                    st_temp.append(tr_temp_z)
                    
                    st += st_temp
                else:
                    st += stream[i]
                    
            plt.style.use('ggplot')

            # Plot all waveforms for every event

            # fig = plt.figure(figsize=(30, 15))
            # ax = fig.add_subplot(111)

            # for i in range(len(st)):
            #     ax.plot(st[i].times(), st[i].data, label=st[i].stats.station + ' - ' + st[i].stats.channel)
            #     ax.set_title('Event ID: ' + d)
            #     ax.title.set_size(30)
                    
            # ax.legend(fontsize=15, bbox_to_anchor=(1,1), loc="upper left")

            # plt.savefig('waveform_' + d + '.png')
            # plt.figure().clear()
            # plt.close()
            # plt.cla()
            # plt.clf()
            
            '''
                SeisBench models can generate characteristic curves, i.e., 
                curves providing the probability of a pick at a certain time. For 
                this, the annotate function is used. Annotate automatically transforms 
                the trace into a compatible format for the model and merges the predictions
                into traces. For example, annotate will determine the correct component order 
                and resample the trace to the required sampling rate.
            '''

            fig = plt.figure(figsize=(30, 15))
            axs = fig.subplots(14, 1, sharex=True, gridspec_kw={'hspace' : 0.5})
            fig.suptitle('Event ID: ' + str(d), fontsize=30)

            count = 0
            station_origin_times = []
            num_of_stations = 0

            for i in range(0, len(st) + 2, 3):
                phase_picks = []
                
                st_temp = Stream()
                
                if i < len(st):
                    for j in range(i, i + 3):
                        st_temp += st[j]
                
                    annotations = model.annotate(st_temp)
                    print(annotations)
                        
                    offset = annotations[0].stats.starttime - st[0].stats.starttime
                    
                    for j in range(i, i + 3): 
                        axs[count].plot(st[j].times(), st[j].data, label=st[j].stats.channel)
                        axs[count].legend([str(st[j].stats.station) + "_" + st[j].stats.channel], loc ="upper right")
                        axs[count].set_title('Station: ' + st[i].stats.station)
                        axs[count].legend(bbox_to_anchor=(1,1), loc="upper left")
                        
                        trace_id = st[j].stats.network + '.' + st[j].stats.station
                        # seisbench_picks['SeisBench_Picks'][str(d)][trace_id] = []

                for k in range(len(annotations)):
                    if annotations[k].stats.channel[-1] != "N" and count < 14:  # Do not plot noise curve
                        axs[count + 1].plot(annotations[k].times() + offset, annotations[k].data, label=annotations[k].stats.channel)
                        axs[count + 1].set_title('EQTransformer: ' + st[i].stats.station)
                        axs[count + 1].legend(bbox_to_anchor=(1,1), loc="upper left")
                        plt.ylim([0, 1])
                        plt.xlabel("Time (s) starting at " + str(st[i].stats.starttime), size = 16,)
                        
                plt.savefig(annotations_dir + 'annotations_' + d + '.png')

                seisbench_picks['SeisBench_Picks'][str(d)][trace_id] = []

                picks, detections = model.classify(st_temp, D_threshold=0.3 ,P_threshold=0.1, S_threshold=0.1)

                print("\nPicks:")
                for pick in picks:
                    print(pick)
                    
                    p = pick.__dict__
                    
                    x = {
                            'start_time': str(p['start_time']),
                            'end_time': str(p['end_time']), 
                            'peak_time': str(p['peak_time']), 
                            'peak_value': str(p['peak_value']), 
                            'phase': p['phase']
                        }
                        
                    seisbench_picks['SeisBench_Picks'][str(d)][trace_id].append(x)

                    if len(picks) == 2:
                        phase_picks.append(p['peak_time'])

                print(phase_picks)
                print("\nDetections:")    
                for detection in detections:
                    print(detection)
                    
                if len(phase_picks) == 2:
                    p_travel_time = phase_picks[1] - phase_picks[0]
                    estimate_dist = p_travel_time * 8
                    estimate_p_travel_time = estimate_dist * 6
                    origin_time = phase_picks[0] - estimate_p_travel_time
                    
                    station_origin_times.append(origin_time.datetime)
                    
                    num_of_stations += 1
                    
                count += 2

            if len(station_origin_times) > 0:
                avg = pd.to_datetime(pd.Series(station_origin_times)).mean()
                utc_to_str = str(UTCDateTime(avg))[:-1]

                seisbench_picks['SeisBench_Picks'][str(d)]['P_Origin_Time'] = utc_to_str
        
    json.dump(seisbench_picks, json_file, indent=4)
    
