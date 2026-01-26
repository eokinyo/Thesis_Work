# Implementation Summary: IGARCH Subdirectory & LaTeX Improvements

## Changes Made

### 1. ✅ Created `igarch/` Subdirectory Structure

**What changed:**
- R Markdown script now saves all CSV files to `igarch/` subdirectory instead of root
- Python notebook loads from `igarch/` subdirectory
- Directory is automatically created on first R Markdown run

**Files updated:**
- `Chapter4_IGARCH_Models.Rmd` (5 export statements)
- `Chapter4_Empirical_Analysis.ipynb` (Cell 2: added `IGARCH_DIR` path variable, updated 3 cells that load CSV files)

**New file structure:**
```
scripts/
├── Chapter4_IGARCH_Models.Rmd
├── Chapter4_Empirical_Analysis.ipynb
├── igarch/  ← NEW SUBDIRECTORY
│   ├── igarch_params_from_r.csv
│   ├── igarchx_params_from_r.csv
│   ├── igarch_oos_forecasts_from_r.csv
│   ├── igarch_diag_from_r.csv
│   └── igarchx_diag_from_r.csv
└── outputs/
    └── tables/
```

---

### 2. ✅ LaTeX Table Formatting Improvements

#### A. Column Name Sanitization
- **Problem**: Underscores in column names break LaTeX tables
  ```
  Example: RMSE_rank → ERROR in LaTeX
  ```
- **Solution**: Automatic conversion of underscores to spaces
  ```python
  def sanitize_column_name(name: str) -> str:
      return name.replace("_", " ")
  ```
  ```
  Example: RMSE_rank → "RMSE rank" ✓ (works in LaTeX)
  ```

#### B. Descriptive Column Naming
- **Old** (breaks LaTeX):
  ```
  RMSE_rank, MAE_rank, RMSE_rank_abs, etc.
  ```
- **New** (readable + LaTeX-safe):
  ```
  RMSE Rank, MAE Rank, RMSE Rank (Abs), etc.
  ```

#### C. LaTeX Labels for Cross-Referencing
- **New** helper function parameter:
  ```python
  save_table_latex(df, filename, float_fmt, label="tab:my_label")
  ```
- **Example usage in document**:
  ```latex
  \ref{tab:baseline_garch_igarch_params}
  \ref{tab:robustness_rmse_mae}
  ```

**Files updated:**
- `Chapter4_Empirical_Analysis.ipynb`:
  - Cell 2: Added 3 new helper functions
  - Cell 8: Updated descriptive stats table call
  - Cell 29: Added label to baseline GARCH/IGARCH table
  - Cell 31: Added label to sentiment GARCH-X/IGARCH-X table
  - Cells 71-77 (Robustness): Updated all 4 robustness check tables with:
    - Descriptive column names (no underscores)
    - LaTeX-safe naming
    - Proper labels for cross-referencing

---

### 3. ✅ Updated Documentation

**New files created:**
- `LATEX_TABLES_REFERENCE.md` — Complete reference guide for all LaTeX tables
  - Filename, label, description for each table
  - Column name formatting explanations
  - How to use tables in LaTeX (3 options)
  - Troubleshooting section

**Files updated:**
- `README_WORKFLOW.md` — Updated file organization section

---

## Summary of Column Name Changes

### Robustness Tables (4.5.1 - 4.5.4)

#### Table 4.5.1 (RMSE & MAE)
```python
# Before → After
"RMSE_rank"       → "RMSE Rank"
"MAE_rank"        → "MAE Rank"
```

#### Table 4.5.2 (Absolute Returns)
```python
# Before → After
"RMSE_abs"        → "RMSE (Abs)"
"MAE_abs"         → "MAE (Abs)"
"RMSE_rank_abs"   → "RMSE Rank (Abs)"
"MAE_rank_abs"    → "MAE Rank (Abs)"
```

#### Table 4.5.3 (Restricted Window)
```python
# Before → After
"RMSE_restricted" → "RMSE (Restricted)"
"MAE_restricted"  → "MAE (Restricted)"
"RMSE_rank_restricted" → "RMSE Rank (Restricted)"
"MAE_rank_restricted"  → "MAE Rank (Restricted)"
```

#### Table 4.5.4 (Sentiment Lag)
```python
# Before → After
"RMSE_lag1"       → "RMSE (Lag 1)"
"MAE_lag1"        → "MAE (Lag 1)"
"RMSE_rank_lag1"  → "RMSE Rank (Lag 1)"
"MAE_rank_lag1"   → "MAE Rank (Lag 1)"
```

---

## Workflow After Changes

### Step 1: Generate R Outputs
```bash
# Creates: igarch/igarch_*.csv files
Rscript -e "rmarkdown::render('Chapter4_IGARCH_Models.Rmd')"
```

### Step 2: Run Python Analysis
```bash
# Creates: outputs/tables/*.tex files
jupyter lab Chapter4_Empirical_Analysis.ipynb
# Execute all cells
```

### Step 3: Use in LaTeX
```latex
% Cross-reference example:
See Table \ref{tab:baseline_garch_igarch_params} for parameters...

% Input example:
\input{outputs/tables/table_4_8_baseline_econometric_params_garch_igarch.tex}
```

---

## Benefits

✅ **Organized structure**: R outputs isolated in `igarch/` subdirectory
✅ **No broken LaTeX**: Underscores automatically converted to spaces
✅ **Better naming**: Descriptive column names (e.g., "RMSE Rank" instead of "RMSE_rank")
✅ **Easy cross-referencing**: LaTeX labels automatically generated
✅ **Complete documentation**: Full reference guide with examples
✅ **Reproducible**: Same functions work for all tables

---

## Next Steps

1. **Run the R Markdown** to generate igarch/ CSV files:
   ```bash
   cd ~/OneDrive-UniversityofHelsinki/rMScE/Year2/Thesis_Work/scripts
   Rscript -e "rmarkdown::render('Chapter4_IGARCH_Models.Rmd')"
   ```

2. **Run the Python notebook** to generate updated LaTeX tables:
   - Execute all cells or run from command line

3. **Check outputs**:
   - `igarch/` folder should contain 5 CSV files
   - `outputs/tables/` should contain all `.tex` files with clean column names

4. **Reference in LaTeX**:
   - Use the `LATEX_TABLES_REFERENCE.md` guide for table labels and filenames

---

**Created:** January 26, 2026
