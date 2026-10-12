# Does Google Trends Improve Bitcoin Volatility Forecasts?  
**Evidence from Sentiment-Augmented GARCH and Random Forest Models**

Master’s Thesis — Elly Okinyo  
University of Helsinki, May 2026

The compiled thesis PDF is not stored in this repository. It is published open access on Helda, the University of Helsinki repository: <https://helda.helsinki.fi/items/54af4cb8-7493-4951-850e-5ba7c10e6deb> (permanent link: <http://hdl.handle.net/10138/633236>).

## Project Overview

This repository contains all code, data, and materials for the master’s thesis **"Does Google Trends Improve Bitcoin Volatility Forecasts? Evidence from Sentiment-Augmented GARCH and Random Forest Models"**.

The study conducts a systematic comparison of classical GARCH-family models (GARCH(1,1), IGARCH(1,1), and their sentiment-augmented versions) with Random Forest regression for one-step-ahead Bitcoin volatility forecasting. Google Trends search interest is used as a proxy for investor attention. The analysis covers daily data from **1 January 2017 to 8 September 2025**.

Key components include:
- Data collection and preprocessing
- Econometric modeling (GARCH / IGARCH in R)
- Machine learning (Random Forest in Python)
- Out-of-sample forecast evaluation using QLIKE loss, SPA test, and MCS procedure
- Extensive robustness checks
- Full LaTeX thesis write-up

## Repository Structure

```bash
Thesis_Work/
├── Data/                                      # Raw and processed datasets
│   ├── bitcoin_data.csv
│   ├── final_bitcoin_trends_clean.csv
│   ├── BitcoinTrendsData/                     # Contains all six-month Google Trends CSV files
│   ├── fetch_bitcoin_data.py
│   └── merged_trends_btc_data.py
├── scripts/                                   # Main analysis code
│   ├── Chapter4_Empirical_Analysis.ipynb      # Python: data prep, Random Forest, evaluation
│   ├── garchFamilyModels.Rmd                  # R: GARCH-family estimation & forecasts
│   ├── garch_family/                          # R output folder (parameters, forecasts, diagnostics)
│   ├── outputs/                               # All generated tables and figures
│   │   ├── tables/
│   │   └── figures/
│   └── WriteUps/                              # Complete LaTeX source files of the thesis
├── Lit-review/                                # Literature notes (if any)
├── README.md
├── requirements.txt                           # Python dependencies
├── .gitignore
└── .gitattributes
```

## Data Sources

- **Bitcoin daily price and volume data**: Downloaded via the `yfinance` library (ticker: BTC-USD).
- **Google Trends search interest**: Collected using the `pytrends` library for the keyword "Bitcoin". Data were fetched in six-month windows due to API limitations and then concatenated and re-normalized.

All raw and processed datasets are included in the `Data/` folder.

## How to Reproduce the Analysis

### 1. Prerequisites
- Python 3.9+ (recommended)
- R (with `rmarkdown`, `rugarch`, and `sandwich` packages)
- Overleaf (or local LaTeX distribution) for compiling the thesis

### 2. Python Environment
```bash
pip install -r requirements.txt
```

### 3. Execution Order

1. **(Optional)** Refresh the raw data  
   Run the data fetching scripts located in `Data/`. The trends scripts are available under the sub-folder `BitcoinTrendsData/`

2. **Run the R script** (GARCH-family models)  
   Render `garchFamilyModels.Rmd`.  
   This estimates all GARCH(1,1), IGARCH(1,1), GARCH-X, and IGARCH-X models and exports the parameters, diagnostics, and one-step-ahead forecasts.
   **Important**: Run this before running the Jupyter notebook since it relies on values estimated from the R scripts for the GARCH-family models
   
3. **Run the Python notebook** (main analysis)  
   Open and execute `Chapter4_Empirical_Analysis.ipynb`.  
   This notebook handles data preparation, Random Forest modeling, forecast evaluation, SPA/MCS tests, and all robustness checks.

4. The Python notebook will automatically load the R-generated outputs and produce the final tables and figures used in the thesis.

All outputs (tables and figures) are saved into the `outputs/` folder.
### 4. Compiling the Thesis

The complete LaTeX source files are located in `scripts/WriteUps/`.  
Open the main `.tex` file in Overleaf (or locally) and compile with **pdfLaTeX**.

### Reproducibility Notes

- All random seeds are fixed (`RANDOM_STATE = 42` in Python).
- Rolling-window out-of-sample forecasts are fully aligned between the R and Python pipelines.
- The repository is designed so that anyone can reproduce **every table and figure** in the thesis exactly.

---

**Licence**  
Code (R, Python and notebooks) is released under the MIT License, see [LICENSE](LICENSE). The thesis text (the LaTeX sources in `scripts/WriteUps/`) is licensed under CC BY 4.0, see [LICENSE-CC-BY-4.0](LICENSE-CC-BY-4.0); the published thesis is open access under CC BY 4.0 on Helda. The datasets in `Data/` are derived from Google Trends and third-party price data and remain subject to their providers' terms.

**Author**: Elly Okinyo  
**Supervisor**: Professor Mika Meitz  
**Date**: May 2026  

For questions or issues, please open an issue on GitHub or contact the author.

