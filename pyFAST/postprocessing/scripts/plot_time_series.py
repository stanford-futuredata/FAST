import datetime
import obspy

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
	st2 = obspy.read(RAW_TS, starttime=start_utc_idx2, endtime=end_utc_idx2)
	st1.plot()
	st2.plot()