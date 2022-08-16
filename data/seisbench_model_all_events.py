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
            for i in range(3):
                ax.plot(stream[i].times(), stream[i].data, label=stream[i].stats.channel)
            ax.legend()

            plt.savefig('waveform_' + d + '.png')
            plt.close()

            annotations = model.annotate(stream)
            print(annotations)

            fig = plt.figure(figsize=(15, 10))
            axs = fig.subplots(2, 1, sharex=True, gridspec_kw={'hspace': 0})

            offset = annotations[0].stats.starttime - stream[0].stats.starttime
            for i in range(3):
                axs[0].plot(stream[i].times(), stream[i].data, label=stream[i].stats.channel)
                if annotations[i].stats.channel[-1] != "N":  # Do not plot noise curve
                    axs[1].plot(annotations[i].times() + offset, annotations[i].data, label=annotations[i].stats.channel)

            axs[0].legend()
            axs[1].legend()

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

            # print('\nFiles in: event_ids/' + d)

            # for e in event_id_list:
            #     if e != '.DS_Store':
            #         # print(e)




# stream = read('event_ids/00000000/00000000_19991015144323_6203.0_*_*.sac')

# print(len(stream))

# stream = read('event_ids/00000000/00000000_*_*_HEC_*.sac')

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

# plt.style.use('ggplot')

# fig = plt.figure(figsize=(15, 5))
# ax = fig.add_subplot(111)
# for i in range(3):
#     ax.plot(stream[i].times(), stream[i].data, label=stream[i].stats.channel)
# ax.legend()

# plt.savefig('waveform.png')

'''
    Plot all of the HEC channels for all events in
    event_ids
'''

# count = 0

# for i in range(0, len(stream), 3):
#     fig = plt.figure(figsize=(15, 5))
#     ax = fig.add_subplot(111)
#     for i in range(3):
#         ax.plot(stream[count].times(), stream[count].data, label=stream[count].stats.channel)
#         count += 1
#     ax.legend()

#     plt.savefig('waveform' + '_' + str(count) + '.png')
#     plt.close()

'''
    SeisBench models can generate characteristic curves, i.e., 
    curves providing the probability of a pick at a certain time. For 
    this, the annotate function is used. Annotate automatically transforms 
    the trace into a compatible format for the model and merges the predictions
    into traces. For example, annotate will determine the correct component order 
    and resample the trace to the required sampling rate.
'''

# annotations = model.annotate(stream)
# print(annotations)

# fig = plt.figure(figsize=(15, 10))
# axs = fig.subplots(2, 1, sharex=True, gridspec_kw={'hspace': 0})

# offset = annotations[0].stats.starttime - stream[0].stats.starttime
# for i in range(3):
#     axs[0].plot(stream[i].times(), stream[i].data, label=stream[i].stats.channel)
#     if annotations[i].stats.channel[-1] != "N":  # Do not plot noise curve
#         axs[1].plot(annotations[i].times() + offset, annotations[i].data, label=annotations[i].stats.channel)

# axs[0].legend()
# axs[1].legend()

# plt.savefig('annotations.png')

# picks, detections = model.classify(stream, D_threshold=0.3 ,P_threshold=0.1, S_threshold=0.1)

# print("Picks:")
# for pick in picks:
#     print(pick)

# print("\nDetections:")    
# for detection in detections:
#     print(detection)

# # Write picks and detections to a file

# with open('picks_detections.txt', 'w') as f:
#     f.write("Picks:\n")
#     for pick in picks:
#         f.write(str(pick) + '\n')

#     f.write("\nDetections: \n")
#     for detection in detections:
#         f.write(str(detection) +'\n')