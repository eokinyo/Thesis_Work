# Master’s Thesis Proposal Outline: Modeling Bitcoin Volatility with ARCH and Machine Learning

## Title
**Forecasting bitcoin volatility and risk: A hybrid long-memory ARCH and random forest approach**

## Background and Motivation
- Cryptocurrency markets, particularly Bitcoin, are characterized by extreme volatility, making them a prime subject for advanced time series modeling.
- The Heterogeneous Autoregressive Conditional Heteroskedasticity (ARCH) model captures long-memory volatility, but may miss non-linear patterns prevalent in crypto markets.
- Machine learning (ML), specifically Random Forest (RF), can enhance volatility forecasting by modeling non-linear relationships and incorporating diverse predictors (e.g., price, volume, sentiment).
- This study combines ARCH’s econometric rigor with RF’s predictive power to model Bitcoin volatility, forecast risk metrics (e.g., Value-at-Risk), and explore drivers of crypto volatility.
- The hybrid approach lays a foundation for PhD research, potentially developing novel ML-econometric models or extending to multi-asset crypto markets.

## Research Questions
1. How does the ARCH model perform in capturing Bitcoin volatility compared to traditional GARCH models?
2. Can a Random Forest model, using ARCH volatility estimates and additional features, improve volatility forecasting accuracy over standalone ARCH?
3. What are the key drivers of Bitcoin volatility identified by Random Forest feature importance?
4. How reliable are ARCH and RF-based Value-at-Risk (VaR) forecasts for assessing Bitcoin downside risk?

## Objectives
- Estimate ARCH and GARCH models on Bitcoin daily returns to model volatility.
- Use Random Forest to forecast volatility, incorporating ARCH outputs and exogenous features (e.g., lagged returns, volume).
- Compare forecasting accuracy and VaR performance across ARCH, GARCH, and RF models.
- Analyze RF feature importance to interpret volatility drivers.
- Propose extensions for PhD research (e.g., deep learning or multi-asset volatility modeling).

## Methodology
- **Data**:
  - Daily Bitcoin price and volume data (2017–2025) from CoinGecko API (see provided Python script).
  - Optional: Sentiment data (e.g., Google Trends for “Bitcoin” or X post counts via web scraping, if time permits).
- **Model Estimation**:
  - Compute Bitcoin log-returns and test for stationarity (ADF test).
  - Estimate ARCH and GARCH models using Python (`arch` package).
  - Extract ARCH volatility estimates (e.g., conditional variance).
- **Random Forest Forecasting**:
  - Prepare features: ARCH volatility, lagged returns, trading volume, and (if feasible) sentiment indicators.
  - Train RF model (`scikit-learn`) to predict one-day-ahead volatility (e.g., squared returns as proxy).
  - Tune hyperparameters (e.g., number of trees, max depth) using cross-validation.
- **Evaluation**:
  - Forecast volatility using ARCH, GARCH, and RF over a rolling window.
  - Compute VaR at 95% and 99% confidence levels and backtest against actual losses.
  - Compare model performance using Mean Squared Error (MSE), Mean Absolute Error (MAE), or Diebold-Mariano tests.
  - Extract RF feature importance scores to identify key volatility drivers.
- **Robustness**:
  - Test models across sub-periods (e.g., bull vs. bear markets).
  - Assess sensitivity to feature selection (e.g., excluding sentiment).

## Expected Contributions
- Demonstrate the efficacy of ARCH for modeling crypto volatility.
- Introduce a novel ARCH-RF hybrid approach to improve volatility forecasting.
- Provide insights into Bitcoin volatility drivers via RF feature importance.
- Offer practical risk management tools (VaR) for crypto markets.
- Establish a scalable framework for PhD research in ML-econometric hybrid modeling.

## Timeline
- **Jan–May 2025**: Literature review, data collection, and methodology development.
- **Jun–Jul 2025**: ARCH and GARCH estimation, RF model setup.
- **Aug–Sep 2025**: Forecasting, VaR analysis, and model comparison.
- **Oct–Nov 2025**: Robustness checks, feature importance analysis, and thesis writing.
- **Dec 2025**: Final revisions and submission.

## Future Extensions (PhD Potential)
- Develop a new ML-econometric model (e.g., LSTM-ARCH hybrid) for crypto volatility.
- Extend to multi-asset volatility modeling (e.g., Ethereum, stablecoins) using ML.
- Incorporate high-frequency data (e.g., minute-level prices) or on-chain metrics (e.g., hash rate, wallet activity).
- Explore deep learning or reinforcement learning for dynamic volatility prediction.
- Apply the hybrid framework to other volatile markets (e.g., meme stocks, commodities).