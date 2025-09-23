# Project Documentation: Bitcoin Price and Trends Analysis

## Introduction
This document tracks the steps for the thesis study on correlating Bitcoin prices with Google search trends. It ensures reproducibility, adhering to academic standards (e.g., data evidence, citations). Maintain this as a living document: Update after each milestone using Markdown. Use sections for clarity, and include code snippets, outputs, and decisions. For complex analysis, consider Jupyter Notebooks (.ipynb) for interactive documentation.

## Guide to Documenting Steps
- **Structure**: Use headers for phases (e.g., Data Collection). Include timestamps, rationale, code/examples, outputs, and issues/resolutions.
- **Tools**: Markdown for text; embed code blocks; use tables for data summaries; cite sources inline.
- **Best Practices**: Version control with Git; note Windows-specific paths (e.g., use os.path); test code step-by-step; log errors.
- **Update Frequency**: After each sub-task; ask for user/clarifier input if unclear.
- **Current Status (as of September 23, 2025)**: Data fetching complete. Next: Data merging and initial cleaning.

## Steps Taken So Far

### 1. Project Setup and Planning
- Defined scope: Analyze BTC prices vs. "Bitcoin" Trends from 2017 onward.
- Selected libraries: yfinance (prices), pytrends (trends), pandas (handling).
- Rationale: Daily granularity for alignment; fallback to CSVs for caching.
- Date: Early project phase.
- Issues: None.

### 2. Data Collection - BTC Prices
- Script: `fetch_bitcoin_data.py`.
- Steps:
  - Set range: 2017-01-01 to yesterday.
  - Download via yfinance.Ticker("BTC-USD").history().
  - Select columns: Date, Open, Close, Volume.
  - Save to `bitcoin_data.csv`.
- Error Handling: yfinance handles network issues internally; add try-except if needed.
- Output Example (head):
