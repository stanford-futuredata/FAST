import seisbench
import seisbench.models as sbm
import obspy

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

pretrained_weights = sbm.EQTransformer.list_pretrained(details=True)
for key, value in pretrained_weights.items():
    print(f"{key}:\n{value}\n-----------------------\n")

model = sbm.EQTransformer.from_pretrained("original")
print(model.weights_docstring)

'''
   SeisBench models can directly annotate obspy streams. 
'''

from obspy import UTCDateTime, read
import matplotlib.pyplot as plt

stream = read('event_ids/00000000/00000000_19991015144323_6203.0_HEC_BH*.sac')

fig = plt.figure(figsize=(15, 5))
ax = fig.add_subplot(111)
for i in range(3):
    ax.plot(stream[i].times(), stream[i].data, label=stream[i].stats.channel)
ax.legend()

# plt.savefig('waveform.png')

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
axs = fig.subplots(2, 1, sharex=True, gridspec_kw={'hspace': 0})

offset = annotations[0].stats.starttime - stream[0].stats.starttime
for i in range(3):
    axs[0].plot(stream[i].times(), stream[i].data, label=stream[i].stats.channel)
    if annotations[i].stats.channel[-1] != "N":  # Do not plot noise curve
        axs[1].plot(annotations[i].times() + offset, annotations[i].data, label=annotations[i].stats.channel)

axs[0].legend()
axs[1].legend()

# plt.savefig('annotations.png')

picks, detections = model.classify(stream, D_threshold=0.3 ,P_threshold=0.1, S_threshold=0.1)

print("Picks:")
for pick in picks:
    print(pick)

print("\nDetections:")    
for detection in detections:
    print(detection)