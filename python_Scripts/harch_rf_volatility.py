import pandas as pd
import numpy as np
from arch import arch_model
from sklearn.ensemble import RandomForestRegressor
from sklearn.metrics import mean_squared_error
import matplotlib.pyplot as plt

# Load Bitcoin data
df = pd.read_csv("bitcoin_data.csv")
df["Date"] = pd.to_datetime(df["Date"])
df = df.set_index("Date")

# Compute log-returns
df["Returns"] = np.log(df["Price"] / df["Price"].shift(1)) * 100
df = df.dropna()

# Estimate HARCH model
model = arch_model(df["Returns"], vol="HARCH", lags=[1, 5, 22])
harch_fit = model.fit(disp="off")
df["HARCH_Vol"] = harch_fit.conditional_volatility

# Prepare features for Random Forest
df["Lagged_Returns"] = df["Returns"].shift(1)
df["Lagged_Vol"] = df["HARCH_Vol"].shift(1)
df["Volume"] = df["Volume"].shift(1)  # Lagged volume
df = df.dropna()

# Define features and target (volatility proxy: squared returns)
features = ["HARCH_Vol", "Lagged_Returns", "Lagged_Vol", "Volume"]
target = df["Returns"] ** 2  # Squared returns as volatility proxy

# Split data (80% train, 20% test)
train_size = int(0.8 * len(df))
X_train = df[features][:train_size]
y_train = target[:train_size]
X_test = df[features][train_size:]
y_test = target[train_size:]

# Train Random Forest
rf = RandomForestRegressor(n_estimators=100, random_state=42)
rf.fit(X_train, y_train)

# Predict volatility
y_pred = rf.predict(X_test)

# Evaluate
mse = mean_squared_error(y_test, y_pred)
print(f"Random Forest MSE: {mse:.6f}")

# Plot feature importance
importances = pd.Series(rf.feature_importances_, index=features)
importances.sort_values().plot(kind="barh")
plt.title("Feature Importance for Volatility Prediction")
plt.show()

# Compare RF and HARCH forecasts (basic visualization)
df["RF_Vol"] = np.nan
df["RF_Vol"][train_size:] = y_pred
df[["HARCH_Vol", "RF_Vol"]].plot()
plt.title("HARCH vs. RF Volatility Forecasts")
plt.show()