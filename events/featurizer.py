from tsfresh import extract_features, select_features
from tsfresh.utilities.dataframe_functions import impute
from dateutil.relativedelta import relativedelta
import sys
import datetime
import pandas as pd

INTERVAL = relativedelta(months=+1)

if __name__ == '__main__':
	start_time = datetime.datetime.strptime(sys.argv[1], "%y-%m")
	end_time = datetime.datetime.strptime(sys.argv[2], "%y-%m")
	station = sys.argv[3]

	time = start_time
	while time < end_time:
		eq_examples = pd.read_csv('%s-HHZ-%s-eq.csv' % (station, time.strftime('%y-%m'))
		extracted_features = extract_features(eq_examples,
		 	column_kind=None, column_value='x', column_id="id", column_sort="time")
		extracted_features.to_csv('%s-%s_features.csv' % (station, time.strftime('%Y-%m')))

		eq_examples = pd.read_csv('%s-HHZ-%s-normal.csv' % (station, time.strftime('%y-%m')))
		extracted_features = extract_features(eq_examples,
		 	column_kind=None, column_value='x', column_id="id", column_sort="time")
		extracted_features.to_csv('%s-%s_features_normal.csv' % (station, time.strftime('%Y-%m')))
		time += INTERVAL
