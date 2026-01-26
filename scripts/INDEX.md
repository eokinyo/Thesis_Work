# 📖 Documentation Index & Quick Links

Complete reference for the Chapter 4 Empirical Analysis Pipeline.

---

## 🚀 Getting Started (Start Here!)

**Read first:**
→ [QUICK_START.md](QUICK_START.md) — 5-minute execution guide

**Then read:**
→ [BEFORE_AFTER_EXAMPLES.md](BEFORE_AFTER_EXAMPLES.md) — Visual examples of improvements

---

## 📋 Main Documentation

### Workflow & Organization
- [README_WORKFLOW.md](README_WORKFLOW.md) — Project structure and workflow
- [IMPLEMENTATION_SUMMARY.md](IMPLEMENTATION_SUMMARY.md) — Technical implementation details
- [FILES_MODIFIED.md](FILES_MODIFIED.md) — Complete change log

### Tables & LaTeX
- [LATEX_TABLES_REFERENCE.md](LATEX_TABLES_REFERENCE.md) — **All 30+ LaTeX tables with labels**
- [BEFORE_AFTER_EXAMPLES.md](BEFORE_AFTER_EXAMPLES.md) — Visual before/after comparisons

---

## 🗂️ File Structure

```
scripts/
│
├─ 📄 Jupyter Notebooks
│  ├── Chapter4_Empirical_Analysis.ipynb    (Main analysis - Python)
│  └── Chapter4_IGARCH_Models.Rmd            (IGARCH estimation - R)
│
├─ 📁 Subdirectories
│  ├── igarch/                              (R-generated CSV files)
│  │   ├── igarch_params_from_r.csv
│  │   ├── igarchx_params_from_r.csv
│  │   ├── igarch_oos_forecasts_from_r.csv
│  │   ├── igarch_diag_from_r.csv
│  │   └── igarchx_diag_from_r.csv
│  │
│  └── outputs/                             (Python-generated outputs)
│      ├── tables/                          (LaTeX files ~30+ .tex)
│      │   ├── table_4_*.tex                (Main analysis tables)
│      │   └── robustness_*_final.tex       (Robustness check tables)
│      └── figures/                         (PNG figures)
│
└─ 📚 Documentation (This section)
   ├── README_WORKFLOW.md                    (Workflow overview)
   ├── QUICK_START.md                        (How to run)
   ├── LATEX_TABLES_REFERENCE.md             (All table references)
   ├── BEFORE_AFTER_EXAMPLES.md              (Visual examples)
   ├── IMPLEMENTATION_SUMMARY.md             (Technical details)
   ├── FILES_MODIFIED.md                     (Change log)
   └── INDEX.md                              (This file)
```

---

## 📊 Key Improvements Made

### ✅ Organized File Structure
- R outputs now in `igarch/` subdirectory (clean separation)
- Python loads automatically from subdirectory
- Easy to regenerate or backup

### ✅ Fixed LaTeX Compilation
- Column names with underscores → spaces (e.g., `RMSE_rank` → `RMSE Rank`)
- All tables now compile without errors in LaTeX
- Automatic sanitization via helper functions

### ✅ Easy Cross-Referencing
- LaTeX labels added to all major tables
- Use `\ref{tab:my_label}` in thesis text
- Automatic numbering in LaTeX

### ✅ Comprehensive Documentation
- 6 documentation files covering all aspects
- Visual examples of improvements
- Troubleshooting guide

---

## 🎯 Common Tasks

### "How do I run everything?"
→ See [QUICK_START.md](QUICK_START.md)

### "Where is table X and what's its LaTeX label?"
→ See [LATEX_TABLES_REFERENCE.md](LATEX_TABLES_REFERENCE.md)

### "My LaTeX won't compile, why?"
→ See [BEFORE_AFTER_EXAMPLES.md](BEFORE_AFTER_EXAMPLES.md) → Troubleshooting

### "What changed in the code?"
→ See [IMPLEMENTATION_SUMMARY.md](IMPLEMENTATION_SUMMARY.md) or [FILES_MODIFIED.md](FILES_MODIFIED.md)

### "How do I cite a table in my thesis?"
→ See [LATEX_TABLES_REFERENCE.md](LATEX_TABLES_REFERENCE.md) → Using Tables in LaTeX

### "I want to change settings (e.g., rolling window)"
→ See [README_WORKFLOW.md](README_WORKFLOW.md) → Configuration Notes

---

## 📚 All LaTeX Tables

**Section 4.1: Descriptive Statistics** (8 tables)
- Core descriptive stats, quantiles, ACF, Ljung-Box, JB test, ADF/KPSS, correlation

**Section 4.2: Model Estimation** (8 tables)
- Model specifications, GARCH/IGARCH parameters, GARCH-X/IGARCH-X parameters
- Random Forest in-sample fit and feature importance
- Residual diagnostics (GARCH, GARCH-X, IGARCH, IGARCH-X)
- ARCH-LM tests

**Section 4.3: Forecasting** (2 tables)
- Forecast loss summary (QLIKE, MSE, MAE)
- Forecast loss ranking

**Section 4.5: Robustness** (4 tables)
- 4.5.1: RMSE & MAE metrics
- 4.5.2: Absolute returns volatility proxy
- 4.5.3: Restricted OOS window
- 4.5.4: Lagged sentiment

**Total: 22+ tables**

→ Full reference: [LATEX_TABLES_REFERENCE.md](LATEX_TABLES_REFERENCE.md)

---

## 💻 Python Helper Functions

All located in **Cell 2** of notebook:

```python
# Sanitize a single column name
sanitize_column_name(name: str) -> str

# Sanitize all column names in DataFrame
sanitize_dataframe_columns(df: pd.DataFrame) -> pd.DataFrame

# Save table with automatic sanitization and LaTeX label
save_table_latex(
    df: pd.DataFrame,
    filename: str,
    float_fmt: str = "%.4f",
    label: str = None  # Optional LaTeX label
) -> None
```

---

## 🔄 Workflow Overview

```
1. Run R Markdown (15-30 min)
   ↓
   igarch/*.csv files generated
   ↓

2. Run Python Notebook (20-40 min)
   ↓
   outputs/tables/*.tex files generated
   ↓

3. Use in LaTeX thesis
   ↓
   \input{outputs/tables/...}
   \ref{tab:label}
```

---

## ⏱️ Expected Timeline

| Step | Time | Output |
|------|------|--------|
| R Markdown | 15-30 min | 5 CSV files |
| Python Notebook | 20-40 min | 22+ LaTeX tables + figures |
| **Total** | **45-70 min** | **Complete analysis** |

---

## ✅ Verification Checklist

After running the pipeline:

- [ ] `igarch/` directory exists with 5 CSV files
- [ ] `outputs/tables/` contains 20+ `.tex` files
- [ ] `outputs/figures/` contains 2+ PNG files
- [ ] No error messages in notebook cells
- [ ] LaTeX tables compile without "Misplaced alignment tab" errors
- [ ] Column names use spaces instead of underscores
- [ ] Tables have appropriate labels for cross-referencing

---

## 📞 Need Help?

| Question | Answer In |
|----------|-----------|
| How do I run the analysis? | [QUICK_START.md](QUICK_START.md) |
| What tables are available? | [LATEX_TABLES_REFERENCE.md](LATEX_TABLES_REFERENCE.md) |
| What changed in the code? | [IMPLEMENTATION_SUMMARY.md](IMPLEMENTATION_SUMMARY.md) |
| Examples of improvements? | [BEFORE_AFTER_EXAMPLES.md](BEFORE_AFTER_EXAMPLES.md) |
| Project structure? | [README_WORKFLOW.md](README_WORKFLOW.md) |
| Complete file change log? | [FILES_MODIFIED.md](FILES_MODIFIED.md) |

---

## 📝 Version Information

- **Updated**: January 26, 2026
- **Python Version**: 3.14+
- **R Packages**: rugarch, readr, dplyr
- **Python Packages**: See requirements.txt
- **Status**: ✅ Complete and documented

---

## 🎓 Academic Guidelines

When citing tables in your thesis:

```latex
% In Chapter 4 text:
Table \ref{tab:baseline_garch_igarch_params} presents parameter estimates
for GARCH(1,1) and IGARCH(1,1) models with...

% In LaTeX document:
\begin{table}[h!]
    \centering
    \caption{GARCH and IGARCH Parameter Estimates}
    \label{tab:baseline_garch_igarch_params}
    \input{outputs/tables/table_4_8_baseline_econometric_params_garch_igarch.tex}
\end{table}
```

---

## 🔐 Backup & Version Control

```bash
# Backup analysis results
cp -r outputs/ outputs_backup_$(date +%Y%m%d)
cp -r igarch/ igarch_backup_$(date +%Y%m%d)

# Version control
git add *.Rmd *.ipynb *.md
git commit -m "Chapter 4 empirical analysis with improved LaTeX tables"
git push
```

---

## 📞 Support

For questions or issues:
1. Check the relevant documentation file (see matrix above)
2. Review [BEFORE_AFTER_EXAMPLES.md](BEFORE_AFTER_EXAMPLES.md) for common issues
3. Check notebook cells for error messages
4. Refer to [README_WORKFLOW.md](README_WORKFLOW.md) → Troubleshooting

---

**Index Last Updated:** January 26, 2026  
**Documentation Complete:** ✅ Yes  
**All Links Verified:** ✅ Yes
