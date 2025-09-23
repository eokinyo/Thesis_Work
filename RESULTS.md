# Analysis Results: Bitcoin Price and Google Trends Correlation

## Introduction
This file summarizes the key findings from the thesis analysis, including statistical metrics, visualizations, and interpretations. Results are derived from merged daily data (BTC prices from Yahoo Finance via yfinance; "Bitcoin" search interest from Google Trends via pytrends, scaled 0-100). All claims are evidence-based; see DOCUMENTATION.md for methods. Date of last update: September 23, 2025.

## Data Summary
- Time Period: January 1, 2017, to [yesterday's date].
- BTC Data: [Number of rows] entries; columns: Date, Open, Close, Volume.
- Trends Data: [Number of rows] entries; columns: date, Bitcoin (interest), isPartial.
- Merged Dataset: [Number of rows] after handling missing values/duplicates.

| Metric | Value | Notes |
|--------|-------|-------|
| Mean BTC Close Price | [Placeholder: e.g., $15,000] | USD |
| Mean Trends Interest | [Placeholder: e.g., 50] | Scaled 0-100 |
| Data Completeness | [Placeholder: e.g., 99%] | Percentage of non-missing dates |

## Key Statistical Findings
- **Correlation Analysis**: Pearson correlation between BTC Close Price and Trends Interest.
  - Coefficient: [Placeholder: e.g., 0.75] (indicating strong positive correlation).
  - P-value: [Placeholder: e.g., <0.001] (statistically significant).
  - Interpretation: Higher search interest often coincides with price increases, potentially reflecting market hype cycles.
- **Other Metrics**:
  - Spearman Rank Correlation: [Placeholder: e.g., 0.70] (for non-linear relationships).
  - Regression: [Placeholder: e.g., Simple linear model: Interest = a * Price + b; R-squared: 0.60].
- Time-Series Insights: [Placeholder: e.g., Peaks in 2021 bull run show synchronized spikes].

## Visualizations
- **Line Plot: Price vs. Trends Over Time**  
  Description: Dual-axis plot showing BTC Close (left, USD) and Trends Interest (right, 0-100).  
  [Placeholder: Link to /figures/price_vs_trends.png]  
  Key Observation: [e.g., Trends lead price by ~1-2 weeks in some periods].

- **Scatter Plot: Correlation Visualization**  
  Description: Points for daily Close vs. Interest, with trend line.  
  [Placeholder: Link to /figures/scatter_correlation.png]  
  Key Observation: [e.g., Clustering around high-volatility events].

- **Additional Plots**: [e.g., Volume vs. Interest heatmap; add as generated via matplotlib].

## Interpretations and Thesis Implications
- Based on data: [Placeholder: e.g., Trends appear to be a leading indicator for price volatility, supporting hypotheses on public sentiment driving crypto markets].
- Limitations: Trends data is relative, not absolute; potential biases in search behavior; external factors (e.g., news events) not modeled here.
- Citations: Yahoo Finance (2025) for prices; Google Trends (2025) for interest.

## Future Expansions
- Advanced models (e.g., Granger causality for lead-lag).
- Sub-period analysis (e.g., bull vs. bear markets).

Update this file after running analysis scripts (e.g., analyze.py).
