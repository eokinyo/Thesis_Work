# Quick Start: Running the Analysis Pipeline

## 📋 Prerequisites

✅ R with `rugarch`, `readr`, `dplyr` packages installed
✅ Python 3.14+ with packages from `requirements.txt`
✅ Data file at `../Data/final_data.csv`

---

## 🚀 Step-by-Step Execution

### Step 1: Generate IGARCH Models (R)

**Option A: RStudio**
```
1. Open Chapter4_IGARCH_Models.Rmd
2. Click "Knit" → "Knit to HTML"
3. Wait for completion (15-30 minutes)
```

**Option B: Command Line**
```bash
cd ~/OneDrive-UniversityofHelsinki/rMScE/Year2/Thesis_Work/scripts
Rscript -e "rmarkdown::render('Chapter4_IGARCH_Models.Rmd')"
```

**Outputs created:**
- ✅ `igarch/igarch_params_from_r.csv`
- ✅ `igarch/igarchx_params_from_r.csv`
- ✅ `igarch/igarch_oos_forecasts_from_r.csv`
- ✅ `igarch/igarch_diag_from_r.csv`
- ✅ `igarch/igarchx_diag_from_r.csv`

---

### Step 2: Run Python Notebook

**Option A: VS Code**
```
1. Open Chapter4_Empirical_Analysis.ipynb
2. Select Python kernel
3. Run → Run All Cells
4. Wait for completion (20-40 minutes)
```

**Option B: Jupyter Lab**
```bash
jupyter lab Chapter4_Empirical_Analysis.ipynb
# Then: Run → Run All Cells
```

**Option C: Command Line**
```bash
jupyter nbconvert --to notebook --execute Chapter4_Empirical_Analysis.ipynb
```

**Outputs created:**
- ✅ `outputs/tables/table_4_*.tex` (LaTeX tables)
- ✅ `outputs/figures/fig_*.png` (Figures)
- ✅ `robustness_*.csv` (Robustness check results)

---

### Step 3: Verify Outputs

```bash
# Check R outputs
ls -la igarch/
# Should show 5 CSV files

# Check Python outputs  
ls -la outputs/tables/ | grep .tex
# Should show 20+ LaTeX files

ls -la outputs/figures/ | grep .png
# Should show 2+ PNG figures
```

---

## 📖 Reference Documentation

| Document | Purpose |
|----------|---------|
| **README_WORKFLOW.md** | Project workflow and file organization |
| **LATEX_TABLES_REFERENCE.md** | Complete table reference with LaTeX labels |
| **IMPLEMENTATION_SUMMARY.md** | Technical details of recent changes |

---

## ⚙️ Configuration

### Adjust Analysis Settings

**File:** `Chapter4_Empirical_Analysis.ipynb` → Cell 2

```python
TEST_SIZE = 0.20              # Change out-of-sample fraction (currently 20%)
ROLLING_WINDOW = 750          # Change rolling window size (currently 3 years)
BOOTSTRAP_B = 1000            # Bootstrap iterations for SPA/MCS
MCS_ALPHA = 0.10              # Significance level for Model Confidence Set
```

**Make same changes in:** `Chapter4_IGARCH_Models.Rmd` → Section 3

```r
TEST_SIZE <- 0.20
ROLLING_WINDOW <- 750
```

---

## ❌ Troubleshooting

### Problem: "FileNotFoundError: igarch_params_from_r.csv"
**Solution:** Run R Markdown first! The Python notebook depends on R outputs.

### Problem: "Solver failed to converge" in R
**Solution:** Try alternative solver
```r
# In Chapter4_IGARCH_Models.Rmd, change:
solver = "solnp"  # Current
# to:
solver = "hybrid"  # Alternative
```

### Problem: "ImportError: No module named 'arch'"
**Solution:** Install missing packages
```bash
pip install -r requirements.txt
```

### Problem: LaTeX tables still have underscores
**Solution:** Regenerate tables by running Python notebook again. The sanitization is automatic.

### Problem: "igarch/ directory doesn't exist"
**Solution:** The R Markdown creates it automatically. If not, manually create:
```bash
mkdir -p igarch
```

---

## 📊 Quality Checks

After completion, verify:

- [ ] All 5 igarch/ CSV files created
- [ ] All table_*.tex files created (should have ~20+ files)
- [ ] All figure_*.png files created (should have 2+ files)
- [ ] No cells show error messages
- [ ] Check first robustness table: column names should be readable (spaces, not underscores)

---

## 💾 Saving Your Work

```bash
# Backup analysis results
cp -r outputs/ outputs_backup_$(date +%Y%m%d)
cp -r igarch/ igarch_backup_$(date +%Y%m%d)

# Version control
git add Chapter4_IGARCH_Models.Rmd
git add Chapter4_Empirical_Analysis.ipynb
git add outputs/tables/*.tex
git commit -m "Update: Analysis with improved LaTeX tables"
```

---

## 🔄 Re-running Analysis

If you need to re-run everything:

```bash
# Clean up old outputs (optional)
rm -rf outputs/tables/*.tex
rm -rf outputs/figures/*.png
rm -rf igarch/*.csv

# Step 1: R
Rscript -e "rmarkdown::render('Chapter4_IGARCH_Models.Rmd')"

# Step 2: Python
jupyter nbconvert --to notebook --execute Chapter4_Empirical_Analysis.ipynb

# Step 3: Verify
ls igarch/ | wc -l  # Should be 5
ls outputs/tables/ | grep .tex | wc -l  # Should be 20+
```

---

## ⏱️ Expected Runtime

- **R Markdown**: 15-30 minutes (depends on ROLLING_WINDOW size)
- **Python Notebook**: 20-40 minutes (depends on RF hyperparameters)
- **Total**: ~45-70 minutes

💡 **Tip:** Run overnight if you have other work to do!

---

## 📞 Questions?

See detailed documentation in:
- `README_WORKFLOW.md` — General workflow questions
- `LATEX_TABLES_REFERENCE.md` — Table naming and LaTeX questions  
- `IMPLEMENTATION_SUMMARY.md` — Technical implementation details

---

**Last Updated:** January 26, 2026
