import pandas as pd
from datetime import datetime

# Load the datasets
bitcoin_data = pd.read_csv("bitcoin_data.csv")
trends_data = pd.read_csv("merged_bitcoin_trends.csv")

# Ensure the 'Date' columns are in datetime format
bitcoin_data['Date'] = pd.to_datetime(bitcoin_data['Date'])
trends_data['date'] = pd.to_datetime(trends_data['date'])

# Rename 'date' column in trends_data to 'Date' for consistency
trends_data.rename(columns={'date': 'Date'}, inplace=True)

# Merge the datasets on the 'Date' column using an inner join
merged_data = pd.merge(bitcoin_data, trends_data, on='Date', how='inner')

# Select relevant columns and rename 'Bitcoin' to 'Trends'
merged_data = merged_data[['Date', 'Open', 'Close', 'Volume', 'Bitcoin']]
merged_data.rename(columns={'Bitcoin': 'Trends'}, inplace=True)

# Save the merged dataset to a new CSV file
merged_data.to_csv("final_data.csv", index=False)

print(f"Merged dataset saved to final_data.csv")
print(merged_data.head())