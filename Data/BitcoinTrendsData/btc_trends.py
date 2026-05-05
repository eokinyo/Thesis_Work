from pytrends.request import TrendReq
import pandas as pd
import time
from datetime import datetime, date, timedelta
import os

# Set up the pytrends request
pytrends = TrendReq(hl='en-US', tz=360)

# Set the keyword
keyword = 'Bitcoin'

# Define the start date and calculate the end date (yesterday)
start_date = date(2017, 1, 1)
yesterday = date.today() - timedelta(days=1)

current_date = start_date
six_months = timedelta(days=6 * 30.44)  # Approximate six months

while current_date < yesterday:
    period_end_date = current_date + six_months
    if period_end_date > yesterday:
        period_end_date = yesterday

    timeframe = f"{current_date.strftime('%Y-%m-%d')} {period_end_date.strftime('%Y-%m-%d')}"
    filename_prefix = f"bitcoin_trends_{current_date.strftime('%b').lower()}-{period_end_date.strftime('%b%Y').lower()}"
    filename = f"{filename_prefix}.csv"
    filepath = os.path.join(os.getcwd(), filename)

    print(f"Fetching data for: {timeframe}")
    try:
        pytrends.build_payload([keyword], cat=0, timeframe=timeframe, geo='', gprop='')
        time.sleep(5)
        interest_over_time_df = pytrends.interest_over_time()

        if not interest_over_time_df.empty:
            interest_over_time_df.to_csv(filepath)
            print(f"Data saved to: {filepath}\n")
        else:
            print(f"No data returned for {timeframe}\n")

    except Exception as e:
        print(f"Error fetching data for {timeframe}: {e}\n")
        time.sleep(60) # Wait longer if there's an error

    current_date = period_end_date + timedelta(days=1)

print("Finished fetching and saving data for all periods.")