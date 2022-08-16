from genericpath import isfile
from turtle import st
import seisbench
import seisbench.models as sbm
import obspy
from obspy import UTCDateTime, read, Stream
import matplotlib.pyplot as plt
import matplotlib
import os

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
dir_list = os.listdir('event_ids')

with open('picks_detections.txt', 'w') as f:
    for d in dir_list:
        if d != '.DS_Store':
            # event_id_list = os.listdir('event_ids/' + d)

            stream = read('event_ids/' + d + '/*.sac')

            plt.style.use('ggplot')

            fig = plt.figure(figsize=(15, 5))
            ax = fig.add_subplot(111)
            for i in range(len(stream)):
                ax.plot(stream[i].times(), stream[i].data, label=stream[i].stats.channel)
            ax.legend()

            plt.savefig('waveform_' + d + '.png')
            plt.close()

            '''
                SeisBench models can generate characteristic curves, i.e., 
                curves providing the probability of a pick at a certain time. For 
                this, the annotate function is used. Annotate automatically transforms 
                the trace into a compatible format for the model and merges the predictions
                into traces. For example, annotate will determine the correct component order 
                and resample the trace to the required sampling rate.
            '''

            annotations = model.annotate(stream)
            print(annotations)

            fig = plt.figure(figsize=(15, 10))
            axs = fig.subplots(10, 1, sharex=True, gridspec_kw={'hspace': 0})

            offset = annotations[0].stats.starttime - stream[0].stats.starttime
            for i in range(len(stream)):

                axs[i].plot(stream[i].times(), stream[i].data, label=stream[i].stats.channel)
                axs[i].legend([str(stream[i].stats.station) + "_" + stream[i].stats.channel], loc ="upper right")

                if i < len(annotations):
                    if annotations[i].stats.channel[-1] != "N":  # Do not plot noise curve
                        axs[9].plot(annotations[i].times() + offset, annotations[i].data, label=annotations[i].stats.channel)

            axs[0].legend()
            axs[9].legend(loc ="upper right")

            fig.tight_layout()
            plt.savefig('annotations_' + d + '.png')
            plt.close()

            picks, detections = model.classify(stream, D_threshold=0.3 ,P_threshold=0.1, S_threshold=0.1)

            print("Picks:")
            for pick in picks:
                print(pick)

            print("\nDetections:")    
            for detection in detections:
                print(detection)

            # Write picks and detections to a file
            f.write("\nPicks for: " + d + "\n")
            for pick in picks:
                f.write(str(pick) + '\n')

            f.write("\nDetections for: " + d + "\n")
            for detection in detections:
                f.write(str(detection) +'\n')





# 1 component vertical (EHZ) only data: make copies and change channel name
# if (len(stream) == 1):
#     st_temp = Stream()
#     tr_temp_e = stream[0].copy()
#     tr_temp_n = stream[0].copy()
#     tr_temp_z = stream[0].copy()
#     tr_temp_e.stats.channel = 'EHE'
#     print(tr_temp_e)
#     st_temp.append(tr_temp_e)
#     print(st_temp)
#     tr_temp_n.stats.channel = 'EHN'
#     print(tr_temp_n)
#     st_temp.append(tr_temp_n)
#     print(st_temp)
#     tr_temp_z.stats.channel = 'EHZ'
#     print(tr_temp_z)
#     st_temp.append(tr_temp_z)
#     print("Copied 1 component into 3 channels")
#     print(st_temp)
#     stream = st_temp




