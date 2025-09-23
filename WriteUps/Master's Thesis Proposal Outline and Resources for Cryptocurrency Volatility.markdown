# Master’s Thesis Proposal Outline and Resources

## Thesis Proposal Outline: Modeling Cryptocurrency Volatility with HARCH

### Title
**Modeling Bitcoin Volatility Using the HARCH Model: A Time Series Analysis of Cryptocurrency Market Risk**

### Background and Motivation
- Cryptocurrency markets, particularly Bitcoin, exhibit extreme volatility, making them ideal for studying dynamic risk behaviors in financial time series.
- Volatility modeling is critical for understanding market stability and informing risk management, yet standard models like GARCH may fail to capture the long-memory and heterogeneous nature of crypto volatility.
- The Heterogeneous Autoregressive Conditional Heteroskedasticity (HARCH) model, an extension of the HAR model, is well-suited to model long-memory volatility in high-frequency financial data.
- This study aims to apply HARCH to Bitcoin price data, assess its performance against traditional GARCH models, and estimate downside risk metrics (e.g., Value-at-Risk) to contribute to the literature on crypto market dynamics.
- The research lays the groundwork for future PhD studies, potentially extending the model to other cryptocurrencies or incorporating external drivers of volatility.

### Research Questions
1. How effectively does the HARCH model capture Bitcoin’s volatility compared to standard GARCH models?
2. Can HARCH-based Value-at-Risk (VaR) forecasts provide reliable risk measures for Bitcoin during high-volatility periods?
3. What insights do HARCH parameters reveal about the long-memory and heterogeneous behavior of Bitcoin volatility?

### Objectives
- Estimate and compare HARCH and GARCH models on Bitcoin daily returns.
- Forecast volatility and compute VaR to assess risk exposure.
- Analyze the persistence and heterogeneity of Bitcoin volatility using HARCH parameters.
- Identify limitations and propose extensions for PhD research (e.g., multi-asset analysis or model modifications).

### Methodology
- **Data**: Daily Bitcoin price data (2017–2025) from CoinGecko or Yahoo Finance, capturing multiple market cycles (e.g., 2017 bull run, 2022 bear market).
- **Model Estimation**:
  - Compute Bitcoin log-returns and test for stationarity (e.g., ADF test).
  - Estimate HARCH and GARCH models using Python (`arch` package) or R (`rugarch` package).
  - Use maximum likelihood estimation to fit models and evaluate goodness-of-fit (e.g., AIC, BIC).
- **Volatility Forecasting**:
  - Perform rolling-window forecasts to predict one-day-ahead volatility.
  - Compute VaR at 95% and 99% confidence levels and backtest against actual losses.
- **Comparison**:
  - Compare HARCH and GARCH forecasting accuracy using metrics like Mean Squared Error (MSE) or Diebold-Mariano tests.
  - Analyze HARCH parameters to interpret long-memory effects.
- **Robustness**:
  - Test models across sub-periods (e.g., bull vs. bear markets) to assess stability.
  - Consider exogenous variables (e.g., VIX or Google Trends) if time permits.

### Expected Contributions
- Provide empirical evidence on HARCH’s suitability for modeling crypto volatility.
- Offer practical insights for risk management in cryptocurrency markets.
- Lay a foundation for PhD research by identifying model limitations and potential extensions (e.g., a Crypto-HARCH model or multi-asset volatility analysis).

### Timeline
- **Jan–May 2025**: Literature review, data collection, and methodology development.
- **Jun–Aug 2025**: Model estimation, forecasting, and preliminary analysis.
- **Sep–Nov 2025**: Backtesting, robustness checks, and thesis writing.
- **Dec 2025**: Final revisions and submission.

### Future Extensions (PhD Potential)
- Develop a modified HARCH model tailored to crypto markets (e.g., incorporating asymmetry or high-frequency data).
- Extend analysis to other cryptocurrencies (e.g., Ethereum, stablecoins) or DeFi tokens.
- Integrate macro-finance drivers (e.g., interest rates, blockchain metrics) or event studies (e.g., regulatory shocks).
- Combine HARCH with machine learning or Bayesian methods for improved forecasting.

## Recommended Papers for Literature Review
These papers provide theoretical, methodological, and empirical foundations for your study. Access them via Google Scholar, JSTOR, or your university library.

1. **Corsi, F. (2009). "A Simple Approximate Long-Memory Model of Realized Volatility." Journal of Financial Econometrics, 7(2), 174–196.**
   - Introduces the HAR model, the foundation for HARCH, and demonstrates its effectiveness in capturing long-memory volatility in financial markets.
   - Relevance: Provides the theoretical basis for HARCH and insights into modeling high-frequency volatility.

2. **Bollerslev, T. (1986). "Generalized Autoregressive Conditional Heteroskedasticity." Journal of Econometrics, 31(3), 307–327.**
   - Seminal paper on GARCH models, essential for understanding the benchmark against which HARCH is compared.
   - Relevance: Establishes the standard volatility modeling framework.

3. **Cheikh, N. B., Zaied, Y. B., & Chevallier, J. (2021). "On the Nonlinear Relationship Between Bitcoin and Precious Metals: Evidence from the Asymmetric GARCH Model." Finance Research Letters, 39, 101620.**
   - Applies asymmetric GARCH models to Bitcoin, highlighting the need for advanced models to capture crypto volatility.
   - Relevance: Shows gaps in standard GARCH applications to crypto, motivating HARCH.

4. **Dyhrberg, A. H. (2016). "Bitcoin, Gold and the Dollar – A GARCH Volatility Analysis." Finance Research Letters, 16, 85–92.**
   - Uses GARCH to study Bitcoin volatility, offering a benchmark for your HARCH comparison.
   - Relevance: Provides empirical context for Bitcoin’s volatility behavior.

5. **Katsiampa, P. (2017). "Volatility Estimation for Bitcoin: A Comparison of GARCH Models." Economics Letters, 158, 3–6.**
   - Compares GARCH variants for Bitcoin volatility, highlighting model performance differences.
   - Relevance: Guides your methodology for comparing HARCH and GARCH.

6. **Trucíos, C., & Hotta, L. K. (2016). "On the Robustness of HAR-type Models to Outliers and Structural Breaks." Journal of Statistical Computation and Simulation, 86(6), 1123–1144.**
   - Examines the robustness of HAR-based models, relevant for applying HARCH to crypto’s erratic data.
   - Relevance: Informs robustness checks in your analysis.

7. **Bouri, E., Molnár, P., Azzi, G., Roubaud, D., & Hagfors, L. I. (2017). "On the Hedge and Safe Haven Properties of Bitcoin: Is it Really More Than a Diversifier?" Finance Research Letters, 20, 192–198.**
   - Analyzes Bitcoin’s volatility and risk properties, providing context for your risk metrics (VaR).
   - Relevance: Links volatility modeling to practical risk management.

## Recommended Data Sources for Crypto Econometrics
These sources provide reliable, freely accessible data for your analysis. Ensure you check data quality and consistency before use.

1. **CoinGecko API (https://www.coingecko.com/en/api)**
   - Offers free access to historical and real-time price, volume, and market cap data for Bitcoin and other cryptocurrencies.
   - Granularity: Daily, hourly, or minute-level data.
   - Usage: Use Python (`requests` library) to fetch Bitcoin daily prices from 2017–2025.

2. **CoinMarketCap API (https://coinmarketcap.com/api/)**
   - Provides historical price and volume data, with a free tier for academic use.
   - Granularity: Daily or intraday.
   - Usage: Suitable for cross-checking CoinGecko data or expanding to other cryptocurrencies.

3. **Yahoo Finance (https://finance.yahoo.com/quote/BTC-USD/history/)**
   - Offers daily Bitcoin price data (open, high, low, close) downloadable as CSV.
   - Granularity: Daily or weekly.
   - Usage: Simple for initial analysis; use Python’s `yfinance` library for automation.

4. **CryptoCompare (https://min-api.cryptocompare.com/)**
   - Provides historical OHLCV (open, high, low, close, volume) data for Bitcoin.
   - Granularity: Minute, hourly, daily.
   - Usage: Ideal for high-frequency volatility analysis if you extend to intraday data.

5. **Glassnode (https://glassnode.com/)**
   - Offers on-chain data (e.g., transaction volume, hash rate) that could be used as exogenous variables.
   - Granularity: Daily or higher.
   - Usage: Free tier limited; use for robustness checks if budget allows.

6. **Quandl (https://www.quandl.com/)**
   - Aggregates crypto exchange data (e.g., Bitfinex, Kraken) with a free academic tier.
   - Granularity: Daily or intraday.
   - Usage: Alternative source for Bitcoin price data.

## Notes for Implementation
- **Data Cleaning**: Ensure consistency in time zones and handle missing values (e.g., interpolate or exclude). Crypto markets operate 24/7, so daily data should align on UTC.
- **Software**: Use Python (`arch` for HARCH, `pandas` for data handling) or R (`rugarch` for HARCH, `tseries` for stationarity tests). Python is recommended for its flexibility and API integration.
- **Validation**: Cross-validate data from multiple sources (e.g., CoinGecko vs. Yahoo Finance) to ensure accuracy.
- **PhD Transition**: Save your data pipeline and code from the Master’s to reuse in the PhD. Document limitations (e.g., daily vs. intraday data) to justify PhD extensions.