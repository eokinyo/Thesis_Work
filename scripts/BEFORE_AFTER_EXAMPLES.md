# Before & After: LaTeX Table Examples

## Problem: Broken LaTeX with Underscores

### Before Implementation

**Python code generated:**
```python
metrics = pd.DataFrame({
    "Model": ["Model A", "Model B"],
    "RMSE_rank": [1, 2],
    "MAE_rank": [1, 2]
})
metrics.to_latex("table.tex")
```

**Generated LaTeX (broken):**
```latex
\begin{tabular}{lrr}
\toprule
Model & RMSE\_rank & MAE\_rank \\
\midrule
Model A & 1 & 2 \\
Model B & 2 & 1 \\
\bottomrule
\end{tabular}
```

**LaTeX compilation error:**
```
! Misplaced alignment tab character `&'.
```

---

## Solution: Column Name Sanitization + Labels

### After Implementation

**Python code with new helper:**
```python
metrics = pd.DataFrame({
    "Model": ["Model A", "Model B"],
    "RMSE Rank": [1, 2],      # No underscore!
    "MAE Rank": [1, 2]        # No underscore!
})

save_table_latex(
    metrics,
    "robustness_451_rmse_mae_final.tex",
    label="tab:robustness_rmse_mae"  # ← New parameter
)
```

**Generated LaTeX (works! ✓):**
```latex
\begin{tabular}{lrr}
\toprule
Model & RMSE Rank & MAE Rank \\
\midrule
Model A & 1 & 2 \\
Model B & 2 & 1 \\
\bottomrule
\end{tabular}
```

**Thesis usage (with reference):**
```latex
\begin{table}[h!]
    \centering
    \caption{RMSE and MAE Forecast Comparison}
    \label{tab:robustness_rmse_mae}
    \input{outputs/tables/robustness_451_rmse_mae_final.tex}
\end{table}

% Later in text:
As shown in Table \ref{tab:robustness_rmse_mae}, ...
```

---

## Detailed Transformation Examples

### Example 1: Robustness 4.5.1 (RMSE & MAE)

#### Before
| Column Name | Problem |
|------------|---------|
| `RMSE_rank` | Underscore breaks LaTeX |
| `MAE_rank` | Underscore breaks LaTeX |

#### After
| Column Name | Solution |
|------------|----------|
| `RMSE Rank` | Reads naturally in LaTeX |
| `MAE Rank` | Reads naturally in LaTeX |
| Added label: `tab:robustness_rmse_mae` | Cross-reference in text |

---

### Example 2: Robustness 4.5.2 (Absolute Returns)

#### Before
```
RMSE_abs
MAE_abs
RMSE_rank_abs
MAE_rank_abs
```

#### After
```
RMSE (Abs)
MAE (Abs)
RMSE Rank (Abs)
MAE Rank (Abs)
```

**Added label:** `tab:robustness_absolute_returns`

---

### Example 3: Robustness 4.5.3 (Restricted Window)

#### Before
```
RMSE_restricted
MAE_restricted
RMSE_rank_restricted
MAE_rank_restricted
```

#### After
```
RMSE (Restricted)
MAE (Restricted)
RMSE Rank (Restricted)
MAE Rank (Restricted)
```

**Added label:** `tab:robustness_restricted_window`

---

### Example 4: Robustness 4.5.4 (Sentiment Lag)

#### Before
```
RMSE_lag1
MAE_lag1
RMSE_rank_lag1
MAE_rank_lag1
```

#### After
```
RMSE (Lag 1)
MAE (Lag 1)
RMSE Rank (Lag 1)
MAE Rank (Lag 1)
```

**Added label:** `tab:robustness_sentiment_lag`

---

## Helper Functions in Action

### Function 1: Sanitize Column Names

```python
def sanitize_column_name(name: str) -> str:
    """Replace underscores with spaces."""
    return name.replace("_", " ")

# Examples:
sanitize_column_name("RMSE_rank")           # → "RMSE rank"
sanitize_column_name("MAE_rank_abs")        # → "MAE rank abs"
sanitize_column_name("RMSE_lag1")           # → "RMSE lag1"
sanitize_column_name("log_return")          # → "log return"
```

### Function 2: Sanitize All Columns

```python
def sanitize_dataframe_columns(df: pd.DataFrame) -> pd.DataFrame:
    """Sanitize all column names in DataFrame."""
    df = df.copy()
    df.columns = [sanitize_column_name(str(col)) for col in df.columns]
    return df

# Example:
df = pd.DataFrame({
    "RMSE_rank": [1, 2, 3],
    "MAE_rank": [2, 1, 3],
    "log_return": [0.1, 0.2, 0.15]
})

df_clean = sanitize_dataframe_columns(df)
# Result: columns are now "RMSE rank", "MAE rank", "log return"
```

### Function 3: Enhanced save_table_latex()

#### Before
```python
def save_table_latex(df: pd.DataFrame, filename: str, float_fmt: str = "%.4f"):
    path = TABLE_DIR / filename
    df.to_latex(path, float_format=lambda x: float_fmt % x)
    print(f"Saved LaTeX table → {path}")
```

#### After
```python
def save_table_latex(
    df: pd.DataFrame,
    filename: str,
    float_fmt: str = "%.4f",
    label: str = None  # ← NEW parameter
) -> None:
    """Save DataFrame as LaTeX table with optional label and sanitized columns."""
    path = TABLE_DIR / filename
    df_clean = sanitize_dataframe_columns(df)  # ← NEW: auto-sanitization
    
    df_clean.to_latex(path, float_format=lambda x: float_fmt % x)
    print(f"Saved LaTeX table → {path}")
    if label:
        print(f"  Label for reference: {label}")  # ← NEW: show label
```

---

## File Organization: Before and After

### Before

```
scripts/
├── Chapter4_IGARCH_Models.Rmd
├── Chapter4_Empirical_Analysis.ipynb
├── igarch_params_from_r.csv          ← Files scattered
├── igarchx_params_from_r.csv         ← in root directory
├── igarch_oos_forecasts_from_r.csv   ← Hard to organize
├── igarch_diag_from_r.csv
├── igarchx_diag_from_r.csv
└── outputs/tables/table_*.tex        ← Inconsistent naming
```

### After

```
scripts/
├── Chapter4_IGARCH_Models.Rmd
├── Chapter4_Empirical_Analysis.ipynb
├── igarch/                           ← Clean subfolder
│   ├── igarch_params_from_r.csv
│   ├── igarchx_params_from_r.csv
│   ├── igarch_oos_forecasts_from_r.csv
│   ├── igarch_diag_from_r.csv
│   └── igarchx_diag_from_r.csv
├── outputs/tables/
│   ├── table_4_*.tex                 ← Main tables
│   └── robustness_*_final.tex        ← Robustness with clean names
├── QUICK_START.md                    ← Documentation
├── LATEX_TABLES_REFERENCE.md
├── IMPLEMENTATION_SUMMARY.md
└── FILES_MODIFIED.md
```

---

## Thesis LaTeX Integration Examples

### Example 1: Simple Table Input

```latex
\section{Robustness Checks}

\input{outputs/tables/robustness_451_rmse_mae_final.tex}
```

### Example 2: Table with Caption and Label

```latex
\begin{table}[h!]
    \centering
    \caption{Alternative Volatility Proxies: Absolute Returns}
    \label{tab:robustness_absolute_returns}
    \input{outputs/tables/robustness_452_abs_returns_final.tex}
\end{table}

See Table \ref{tab:robustness_absolute_returns} for results using absolute returns.
```

### Example 3: Multiple Tables in Appendix

```latex
\appendix
\section{Robustness Checks}

\subsection{RMSE and MAE Metrics}
\label{sec:robustness_rmse_mae}

\begin{table}[h!]
    \centering
    \caption{RMSE and MAE Evaluation}
    \label{tab:robustness_rmse_mae}
    \input{outputs/tables/robustness_451_rmse_mae_final.tex}
\end{table}

In Section \ref{sec:robustness_rmse_mae}, Table \ref{tab:robustness_rmse_mae}
presents alternative evaluation metrics...
```

### Example 4: Structured Cross-References

```latex
% In main text:
The baseline results (Table \ref{tab:baseline_garch_igarch_params})
show strong persistence in volatility. 

Robustness checks confirm this finding:
\begin{itemize}
    \item Alternative metrics (Table \ref{tab:robustness_rmse_mae})
    \item Alternative volatility proxies (Table \ref{tab:robustness_absolute_returns})
    \item Restricted evaluation window (Table \ref{tab:robustness_restricted_window})
    \item Lagged sentiment effects (Table \ref{tab:robustness_sentiment_lag})
\end{itemize}
```

---

## Summary of Changes

| Aspect | Before | After |
|--------|--------|-------|
| **Column names** | `RMSE_rank` (breaks LaTeX) | `RMSE Rank` (works ✓) |
| **File organization** | 5 CSV files in root | 5 CSV files in `igarch/` |
| **Table labels** | None | LaTeX labels for cross-reference |
| **Documentation** | Minimal | Comprehensive guides |
| **LaTeX compilation** | ❌ Fails | ✅ Works |
| **Table readability** | Low (underscores) | High (spaces) |
| **Cross-referencing** | Manual | Automatic via labels |

---

**Updated:** January 26, 2026
