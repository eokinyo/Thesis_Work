import yfinance as yf
import pandas as pd
from datetime import datetime, timedelta

# Set date range: from Jan 1, 2017 to yesterday
start_date = "2017-01-01"
end_date = (datetime.today() - timedelta(days=1)).strftime("%Y-%m-%d")

# Download Bitcoin data
btc = yf.download("BTC-USD", start=start_date, end=end_date)

# Select and rename columns
btc = btc[["Open", "Close", "Volume"]].reset_index()
btc.rename(columns={"Date": "Date"}, inplace=True)

# Save to CSV
btc.to_csv("bitcoin_data.csv", index=False)

print(f"Data from {start_date} to {end_date} saved to bitcoin_data.csv")
print(btc.head())