import matplotlib.pyplot as plt
from matplotlib import rcParams
import numpy as np

output_dir = '/data/beroza/ceyoon/FASTcode/data/OutputFAST/totalMatrix_WHAR_20100601_3ch_3month/'
test_labels = 'Earthquakes', 'Ambiguous', 'Other Noise', 'Narrowband Noise'

# Matching events
fracs_match = np.array([11736., 2232., 1364., 494.])
total_match = sum(fracs_match)
print "Total match: ", total_match
fracs_match = fracs_match/total_match
print fracs_match

plt.figure(num=0, figsize=(10,9))
rcParams.update({'font.size': 16})
rcParams['axes.color_cycle'].remove('k')
colors = plt.cm.Set1(np.linspace(0,1,7))
plt.pie(fracs_match, labels=test_labels, colors=colors, autopct='%1.1f%%', startangle=45)
plt.title(str(int(total_match))+' matching events, both FAST and template matching')
plt.savefig(output_dir+'pie_match_events.png')
plt.clf()

# Missed events
fracs_missed = np.array([1008., 619., 23061., 1993.])
total_missed = sum(fracs_missed)
print "Total missed: ", total_missed
fracs_missed = fracs_missed/total_missed
print fracs_missed

plt.figure(num=0, figsize=(10,9))
plt.pie(fracs_missed, labels=test_labels, colors=colors, autopct='%1.1f%%', startangle=50)
plt.title(str(int(total_missed))+' missed events, found by templates, not by FAST')
plt.savefig(output_dir+'pie_missed_events.png')
plt.clf()

# New events
fracs_new = np.array([612., 138., 1855., 10244.])
total_new = sum(fracs_new)
print "Total new: ", total_new
fracs_new = fracs_new/total_new
print fracs_new

plt.figure(num=0, figsize=(10,9))
plt.pie(fracs_new, labels=test_labels, colors=colors, autopct='%1.1f%%', startangle=45)
plt.title(str(int(total_new))+' new events, found by FAST, not by templates')
plt.savefig(output_dir+'pie_new_events.png')
plt.clf()

# Visually inspected earthquakes
eq_labels = 'Matching', 'New', 'Missed'
eq_fracs = np.array([11736., 612., 1008.])
total_eq = sum(eq_fracs)
print "Total eq: ", total_eq
eq_fracs = eq_fracs/total_eq
print eq_fracs

plt.pie(eq_fracs, labels=eq_labels, autopct='%1.1f%%', startangle=45)
plt.title(str(int(total_eq))+' earthquakes in 3 months of WHAR data')
plt.savefig(output_dir+'pie_earthquakes.png')
plt.clf()
