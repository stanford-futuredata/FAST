import datetime
import obspy

IDX_TO_TS = "./idx_to_ts/ts_NZ.GVZ.10.HHZ__20161122T000000Z__20161201T000000Z"
RAW_TS = "./raw_time_series/NZ.GVZ.10.HHZ__20161122T000000Z__20161201T000000Z.mseed"

def plot_time_series(smallest_idx1, smallest_idx2, largest_idx1, largest_idx2):
	timestamps = []
	with open(IDX_TO_TS, 'r') as f:
		for index, line in enumerate(f):
			timestamp = line.strip()
			timestamps.append(timestamp)
	date_format = "%y-%m-%dT%H:%M:%S.%f"
	start_utc_idx1 = obspy.UTCDateTime(datetime.strptime(timestamps[smallest_idx1], date_format))
	end_utc_idx1 = obspy.UTCDateTime(datetime.strptime(timestamps[largest_idx1], date_format)) + 20
	start_utc_idx2 = obspy.UTCDateTime(datetime.strptime(timestamps[smallest_idx2], date_format))
	end_utc_idx2 = obspy.UTCDateTime(datetime.strptime(timestamps[largest_idx2], date_format)) + 20
	st1 = obspy.read(RAW_TS, starttime=start_utc_idx1, endtime=end_utc_idx1)
	st1.plot(outfile='event1.png', format='png')
	st2 = obspy.read(RAW_TS, starttime=start_utc_idx2, endtime=end_utc_idx2)
	st2.plot(outfile='event2.png', format='png')

def plot_heatmap(idx1_list, idx2_list, similarity_list, smallest_idx1, largest_idx1, smallest_idx2, largest_idx2):
	grid_width = largest_idx1 - smallest_idx1 + 1
	grid_height = largest_idx2 - smallest_idx2 + 1
	grid = np.zeros((grid_width, grid_height))
	length = len(idx1_list)
	for i in xrange(length):
		grid[idx1_list[i] - smallest_idx1][idx2_list[i] - smallest_idx2] = similarity_list[i]
	plt.pcolormesh(grid, cmap='hot')
	plt.colorbar()
	plt.show()