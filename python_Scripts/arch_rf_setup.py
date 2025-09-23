import sys
import subprocess

def install(package):
    subprocess.check_call([sys.executable, "-m", "pip", "install", package])

try:
    import pandas as pd
    import numpy as np
    from arch import arch_model
    from sklearn.ensemble import RandomForestRegressor
    from sklearn.model_selection import train_test_split, GridSearchCV
    from sklearn.preprocessing import StandardScaler
    from sklearn.metrics import mean_squared_error, mean_absolute_error
    import matplotlib.pyplot as plt
except ImportError as e:
    missing_package = str(e).split()[-1].replace("'", "")
    print(f"Installing {missing_package}...")
    install(missing_package)
    # Reload imports after installation
    import pandas as pd
    import numpy as np
    from arch import arch_model
    from sklearn.ensemble import RandomForestRegressor
    from sklearn.model_selection import train_test_split, GridSearchCV
    from sklearn.preprocessing import StandardScaler
    from sklearn.metrics import mean_squared_error, mean_absolute_error
    import matplotlib.pyplot as plt


def load_and_merge_data(merged_file):
    """
    Loads pre-merged Bitcoin data with Google Trends.
    
    Parameters:
    - merged_file (str): Path to pre-merged CSV file.
    
    Returns:
    - pandas.DataFrame: DataFrame with Date as index.
    """
    df = pd.read_csv(merged_file)
    df["Date"] = pd.to_datetime(df["Date"])
    df = df.rename(columns={"Trends": "Search_Interest"})
    df = df.set_index("Date")
    return df

def estimate_arch(data, lags=5):
    """
    Estimates ARCH model on Bitcoin returns and extracts conditional volatility.
    
    Parameters:
    - data (pandas.DataFrame): DataFrame with 'Returns' column.
    - lags (int): Number of ARCH lags (default: 5).
    
    Returns:
    - pandas.Series: Conditional volatility.
    """
    model = arch_model(data["Returns"], vol="ARCH", p=lags)
    arch_fit = model.fit(disp="off")
    return arch_fit.conditional_volatility

def prepare_features(data, include_x=False):
    """
    Creates features for RF model, including ARCH volatility and sentiment.
    
    Parameters:
    - data (pandas.DataFrame): DataFrame with price, volume, and sentiment data.
    - include_x (bool): Whether to include X sentiment features.
    
    Returns:
    - pandas.DataFrame: Features and target (squared returns).
    """
    data["Returns"] = np.log(data["Close"] / data["Close"].shift(1)) * 100
    data = data.dropna()
    
    data["ARCH_Vol"] = estimate_arch(data)
    
    data["Lagged_Returns"] = data["Returns"].shift(1)
    data["Lagged_Vol"] = data["ARCH_Vol"].shift(1)
    data["Lagged_Volume"] = data["Volume"].shift(1)
    data["Search_Interest"] = data["Search_Interest"].shift(1)
    
    if include_x:
        data["Post_Count"] = data["Post_Count"].shift(1)
        data["Avg_Polarity"] = data["Avg_Polarity"].shift(1)
        features = ["ARCH_Vol", "Lagged_Returns", "Lagged_Vol", "Lagged_Volume", 
                    "Search_Interest", "Post_Count", "Avg_Polarity"]
    else:
        features = ["ARCH_Vol", "Lagged_Returns", "Lagged_Vol", "Lagged_Volume", 
                    "Search_Interest"]
    
    data["Target"] = data["Returns"] ** 2
    data = data.dropna()
    
    return data[features], data["Target"], features

def train_rf_model(X, y):
    """
    Trains and tunes RF model using GridSearchCV.
    
    Parameters:
    - X (pandas.DataFrame): Feature matrix.
    - y (pandas.Series): Target variable.
    
    Returns:
    - RandomForestRegressor: Trained model.
    - dict: Best hyperparameters.
    """
    X_train, X_test, y_train, y_test = train_test_split(X, y, test_size=0.2, shuffle=False)
    
    scaler = StandardScaler()
    X_train_scaled = scaler.fit_transform(X_train)
    X_test_scaled = scaler.transform(X_test)
    
    rf = RandomForestRegressor(random_state=42)
    param_grid = {
        "n_estimators": [50, 100],
        "max_depth": [5, 10],
        "min_samples_split": [2, 5]
    }
    
    grid_search = GridSearchCV(rf, param_grid, cv=5, scoring="neg_mean_squared_error", n_jobs=-1)
    grid_search.fit(X_train_scaled, y_train)
    
    best_model = grid_search.best_estimator_
    y_pred = best_model.predict(X_test_scaled)
    mse = mean_squared_error(y_test, y_pred)
    mae = mean_absolute_error(y_test, y_pred)
    print(f"RF Test MSE: {mse:.6f}, MAE: {mae:.6f}")
    
    return best_model, grid_search.best_params_, X_train, X_test, y_test, y_pred

def compute_var(data, predictions, actual_vol, confidence=0.95):
    """
    Computes Value-at-Risk (VaR) using RF predictions.
    
    Parameters:
    - data (pandas.DataFrame): DataFrame with returns.
    - predictions (numpy.array): RF volatility predictions.
    - actual_vol (numpy.array): Actual volatility (squared returns).
    - confidence (float): Confidence level for VaR.
    
    Returns:
    - pandas.DataFrame: VaR estimates and violations.
    """
    var = -np.sqrt(predictions) * np.percentile(data["Returns"], (1 - confidence) * 100)
    violations = data["Returns"].values < var
    return pd.DataFrame({"VaR": var, "Violations": violations}, index=data.index)

def plot_results(data, predictions, features, model, arch_vol):
    """
    Plots feature importance and volatility forecasts.
    
    Parameters:
    - data (pandas.DataFrame): DataFrame with features and target.
    - predictions (numpy.array): RF predictions.
    - features (list): List of feature names.
    - model (RandomForestRegressor): Trained RF model.
    - arch_vol (pandas.Series): ARCH volatility.
    """
    importances = pd.Series(model.feature_importances_, index=features)
    importances.sort_values().plot(kind="barh")
    plt.title("Feature Importance for Volatility Prediction")
    plt.show()
    
    df_plot = pd.DataFrame({
        "ARCH_Vol": arch_vol[-len(predictions):],
        "RF_Vol": np.sqrt(predictions),
        "Actual_Vol": np.sqrt(data["Target"][-len(predictions):])
    })
    df_plot.plot()
    plt.title("ARCH vs. RF Volatility Forecasts")
    plt.ylabel("Volatility")
    plt.show()

def main():
    merged_file = "../Data/final_data.csv"
    
    df = load_and_merge_data(merged_file)
    
    X, y, features = prepare_features(df, include_x=False)
    
    rf_model, best_params, X_train, X_test, y_test, y_pred = train_rf_model(X, y)
    print(f"Best RF Parameters: {best_params}")
    
    var_results = compute_var(df.loc[X_test.index], y_pred, y_test)
    violation_rate = var_results["Violations"].mean()
    print(f"VaR Violation Rate (95%): {violation_rate:.4f}")
    
    plot_results(df.loc[X_test.index], y_pred, features, rf_model, df["ARCH_Vol"])
    
    results = pd.DataFrame({
        "Date": X_test.index,
        "Actual_Vol": y_test,
        "RF_Pred": y_pred,
        "VaR": var_results["VaR"]
    })
    results.to_csv("rf_results.csv", index=False)
    print("Results saved to rf_results.csv")

if __name__ == "__main__":
    main()