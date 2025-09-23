# Bitcoin Price and Google Trends Correlation Analysis

## Project Overview
This repository supports a thesis examining the relationship between Bitcoin (BTC-USD) prices and public interest, measured by Google search trends for the keyword "Bitcoin." The analysis covers data from January 1, 2017, to the most recent available date (yesterday). Key components include data fetching scripts, with plans for merging, cleaning, statistical analysis (e.g., correlation, regression), and visualizations.

### Thesis Objectives
- Fetch and preprocess historical BTC price data (Open, Close, Volume) using yfinance.
- Retrieve Google Trends data using pytrends, handling API limitations by fetching in six-month intervals.
- Merge datasets on daily dates for analysis.
- Investigate correlations and trends, with evidence-based insights.
- Note: All scripts are designed for Windows compatibility using Python 3.x, with libraries from the standard environment (e.g., pandas, numpy, matplotlib for future steps).

## Installation and Setup
1. Ensure Python 3.x is installed on your Windows machine.
2. Install required libraries (no external installations beyond pip):
