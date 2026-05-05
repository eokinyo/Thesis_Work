import pandas as pd

# Load the datasets
bitcoin_data = pd.read_csv("bitcoin_data.csv")
trends_data = pd.read_csv("final_bitcoin_trends_clean.csv")

# Convert dates to datetime — explicitly tell pandas the correct format
bitcoin_data['Date'] = pd.to_datetime(bitcoin_data['Date'], format='%d/%m/%Y')   # ← THIS FIXES IT
trends_data['Date'] = pd.to_datetime(trends_data['Date'], format='%d/%m/%Y')

# Merge on Date (inner join)
merged_data = pd.merge(bitcoin_data, trends_data, on='Date', how='inner')

# Keep only the columns needed for the thesis + R script
merged_data = merged_data[['Date', 'Open', 'Close', 'Volume', 'Search_Interest']].copy()

# Final sort and save
merged_data.sort_values('Date', inplace=True)
merged_data.to_csv("final_data.csv", index=False)

print(f"✅ Merged dataset saved to final_data.csv")
print(f"Final observations: {len(merged_data)}")
print(merged_data.head())
print("\nDate range:", merged_data['Date'].min(), "→", merged_data['Date'].max())
print(merged_data.describe())