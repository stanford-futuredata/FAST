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

	time = start_time
	while time < end_time:
		eq_examples = pd.read_csv('KHZ-HHZ-%s-eq.csv' % time.strftime('%y-%m'))
		extracted_features = extract_features(eq_examples,
		 	column_kind=None, column_value='x', column_id="id", column_sort="time")
		extracted_features.to_csv('%s_features.csv' % time.strftime('%Y-%m'))

		eq_examples = pd.read_csv('KHZ-HHZ-%s-normal.csv' % time.strftime('%y-%m'))
		extracted_features = extract_features(eq_examples,
		 	column_kind=None, column_value='x', column_id="id", column_sort="time")
		extracted_features.to_csv('%s_features_normal.csv' % time.strftime('%Y-%m'))
		time += INTERVAL
