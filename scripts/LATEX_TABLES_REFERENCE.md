# LaTeX Tables Reference Guide

This document provides a quick reference for all generated LaTeX tables with their filenames and recommended labels for cross-referencing in your thesis.

## Table Organization

All LaTeX tables are saved to: `outputs/tables/`

---

## Section 4.1: Descriptive Statistics

| Table | Filename | LaTeX Label | Description |
|-------|----------|-------------|-------------|
| 4.1 | `table_4_1_core_descriptives.tex` | `tab:descriptive_stats` | Mean, Std Dev, Min, Max, Skewness, Kurtosis of returns, squared returns, sentiment |
| 4.2 | `table_4_2_quantiles_tail_behaviour.tex` | (auto) | Quantiles (1%, 5%, 25%, 50%, 75%, 95%, 99%) |
| 4.3 | `table_4_3_ljung_box_tests.tex` | (auto) | Ljung-Box tests on returns and squared returns (lags 10, 20) |
| 4.4 | `table_4_4_jarque_bera_tests.tex` | (auto) | Jarque-Bera normality tests |
| 4.5 | `table_4_5_adf_stationarity_tests.tex` | (auto) | ADF stationarity tests |
| 4.5b | `table_4_5_kpss_stationarity_tests.tex` | (auto) | KPSS stationarity tests (robustness) |
| 4.6 | `table_4_6_correlation_matrix.tex` | (auto) | Pearson correlation matrix |
| 4.6b | `table_4_6_correlation_matrix_spearman.tex` | (auto) | Spearman rank correlation matrix |

---

## Section 4.2: Model Estimation & Diagnostics

### Model Specification & Parameters

| Table | Filename | LaTeX Label | Description |
|-------|----------|-------------|-------------|
| 4.7 | `table_4_7_model_specifications_setup.tex` | (auto) | Model specifications: variables, features, sample sizes |
| 4.8 | `table_4_8_baseline_econometric_params_garch_igarch.tex` | `tab:baseline_garch_igarch_params` | GARCH(1,1) and IGARCH(1,1) parameters (Normal & Student-t) |
| 4.9 | `table_4_9_sentiment_augmented_econometric_params.tex` | `tab:sentiment_garch_igarch_params` | GARCH-X(1,1) and IGARCH-X(1,1) parameters with sentiment |

### Random Forest Models

| Table | Filename | LaTeX Label | Description |
|-------|----------|-------------|-------------|
| 4.12 | `table_4_12_rf_in_sample_fit.tex` | (auto) | In-sample MSE and R² for Baseline RF and RF+Sentiment |
| 4.13 | `table_4_13_rf_feature_importance.tex` | (auto) | Feature importance weights for RF models |

### Residual Diagnostics

| Table | Filename | LaTeX Label | Description |
|-------|----------|-------------|-------------|
| 4.10 | `table_4_10_garch_residual_diagnostics.tex` | (auto) | GARCH residual Ljung-Box tests |
| 4.10 | `table_4_10_all_baseline_residual_diagnostics_garch_igarch.tex` | (auto) | Combined GARCH + IGARCH baseline diagnostics |
| 4.11 | `table_4_11_garchx_residual_diagnostics.tex` | (auto) | GARCH-X residual Ljung-Box tests |
| 4.11 | `table_4_11_all_sentiment_residual_diagnostics_garchx_igarchx.tex` | (auto) | Combined GARCH-X + IGARCH-X sentiment diagnostics |
| 4.12 | `table_4_12_arch_lm_tests.tex` | (auto) | ARCH-LM test statistics on standardized residuals |

---

## Section 4.3: Forecast Evaluation

| Table | Filename | LaTeX Label | Description |
|-------|----------|-------------|-------------|
| 4.15 | `table_4_15_forecast_loss_summary.tex` | (auto) | QLIKE, MSE, MAE loss summary (all models) |
| 4.17 | `table_4_17_forecast_loss_ranking.tex` | (auto) | Model rankings by loss metric |

---

## Section 4.5: Robustness Checks

### Alternative Metrics

| Table | Filename | LaTeX Label | Description |
|-------|----------|-------------|-------------|
| 4.5.1 | `robustness_451_rmse_mae_final.tex` | `tab:robustness_rmse_mae` | **RMSE and MAE** evaluation metrics (alternative to QLIKE) |

### Alternative Volatility Proxies

| Table | Filename | LaTeX Label | Description |
|-------|----------|-------------|-------------|
| 4.5.2 | `robustness_452_abs_returns_final.tex` | `tab:robustness_absolute_returns` | **Absolute Returns** as volatility proxy (instead of squared returns) |

### Alternative Forecasting Schemes

| Table | Filename | LaTeX Label | Description |
|-------|----------|-------------|-------------|
| 4.5.3 | `robustness_453_restricted_oos_final.tex` | `tab:robustness_restricted_window` | **Restricted OOS window** (last 70% of evaluation period) |

### Sentiment Robustness

| Table | Filename | LaTeX Label | Description |
|-------|----------|-------------|-------------|
| 4.5.4 | `robustness_454_sentiment_lag1_final.tex` | `tab:robustness_sentiment_lag` | **Lagged sentiment** (t-1) instead of contemporaneous |

---

## Column Name Formatting

All tables are automatically **sanitized** for LaTeX compatibility:

- Underscores (`_`) are converted to spaces
- Example: `RMSE_rank` becomes `RMSE rank` in LaTeX

**Before (breaks LaTeX):**
```latex
\begin{tabular}{lrr}
RMSE_rank & MAE_rank \\
1 & 2 \\
\end{tabular}
```

**After (clean LaTeX):**
```latex
\begin{tabular}{lrr}
RMSE rank & MAE rank \\
1 & 2 \\
\end{tabular}
```

---

## Using Tables in LaTeX

### Option 1: Direct Input (Recommended)
```latex
\input{outputs/tables/table_4_8_baseline_econometric_params_garch_igarch.tex}
```

### Option 2: With Label and Caption
```latex
\begin{table}[h!]
    \centering
    \caption{GARCH and IGARCH Baseline Parameters}
    \label{tab:baseline_garch_igarch_params}
    \input{outputs/tables/table_4_8_baseline_econometric_params_garch_igarch.tex}
\end{table}
```

### Option 3: Reference Cross-Reference
After defining a table with a label:
```latex
As shown in Table \ref{tab:baseline_garch_igarch_params}, ...
```

---

## Regenerating Tables

**If data or models change:**

1. **R tables** (IGARCH results):
   ```bash
   Rscript -e "rmarkdown::render('Chapter4_IGARCH_Models.Rmd')"
   ```
   Outputs to: `igarch/igarch_*.csv`

2. **Python tables** (all others):
   ```bash
   jupyter nbconvert --to notebook --execute Chapter4_Empirical_Analysis.ipynb
   ```
   Outputs to: `outputs/tables/table_*.tex` and `robustness_*.tex`

---

## Troubleshooting LaTeX Compilation

### Issue: "Undefined reference to table label"
**Solution:** Compile twice (LaTeX needs two passes for references)
```bash
pdflatex -interaction=nonstopmode thesis.tex
pdflatex -interaction=nonstopmode thesis.tex
```

### Issue: "Misplaced alignment tab character"
**Solution:** This was fixed by the column name sanitization. If you see this, check your table column names in Python.

### Issue: "Cannot find file outputs/tables/..."
**Solution:** Make sure you've run the Python notebook to generation tables before LaTeX compilation.

---

## Python Helper Functions

Located in **Cell 2** (Configuration) of `Chapter4_Empirical_Analysis.ipynb`:

```python
# Sanitize individual column name
sanitize_column_name(name: str) -> str

# Sanitize all columns in a DataFrame
sanitize_dataframe_columns(df: pd.DataFrame) -> pd.DataFrame

# Save table with automatic sanitization and optional label
save_table_latex(df, filename, float_fmt="%.4f", label=None)
```

---

**Last Updated:** January 2026
