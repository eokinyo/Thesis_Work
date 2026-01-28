# Quick LaTeX Compilation Guide

## Compiling Your Thesis

Now that your Overleaf project is integrated, here's how to compile the PDF locally:

### Prerequisites
- LaTeX distribution installed (`pdflatex`, `bibtex`)
- On macOS: `brew install --cask mactex` (or use MacTeX from tug.org)
- Verify installation: `pdflatex --version`

### One-Time Setup
If you're missing any LaTeX packages, install them:
```bash
# For APA citation style (apacite)
tlmgr install apacite

# For other utilities
tlmgr install setspace geometry titlesec booktabs natbib hyperref
```

### Compilation Steps

**Option 1: Manual (Full compilation)**
```bash
cd /Users/eokinyo/Library/CloudStorage/OneDrive-UniversityofHelsinki/rMScE/Year2/Thesis_Work

# Remove old auxiliary files
rm -f main.{aux,toc,lof,lot,log,out,bbl,blg}

# Compile (3-pass process for cross-references and bibliography)
pdflatex main.tex      # First pass: build structure
bibtex main            # Generate bibliography
pdflatex main.tex      # Second pass: include citations
pdflatex main.tex      # Third pass: resolve all references
```

**Option 2: Using a Makefile** (Recommended)
Create `Makefile` in the root Thesis_Work folder:
```makefile
TEX = pdflatex
BIB = bibtex
DOCUMENT = main

.PHONY: clean all pdf

all: pdf

pdf: $(DOCUMENT).pdf

$(DOCUMENT).pdf: $(DOCUMENT).tex references.bib
	$(TEX) $(DOCUMENT)
	$(BIB) $(DOCUMENT)
	$(TEX) $(DOCUMENT)
	$(TEX) $(DOCUMENT)

clean:
	rm -f $(DOCUMENT).{aux,toc,lof,lot,log,out,bbl,blg,pdf}

.PHONY: help
help:
	@echo "Available targets:"
	@echo "  make        - Compile main.tex to PDF"
	@echo "  make clean  - Remove auxiliary files"
```

Then simply run:
```bash
cd /Users/eokinyo/Library/CloudStorage/OneDrive-UniversityofHelsinki/rMScE/Year2/Thesis_Work
make clean && make
```

**Option 3: VS Code with LaTeX Workshop Extension**
1. Install "LaTeX Workshop" extension in VS Code
2. Open `main.tex`
3. Right-click → "LaTeX Workshop: Build LaTeX project"
4. Or press `Ctrl+Alt+B` (Mac: `Cmd+Shift+B`)

### Troubleshooting

**Error: File not found - `scripts/outputs/tables/...`**
- Run your Python notebook (`scripts/Chapter4_Empirical_Analysis.ipynb`) to generate tables
- Run your R Markdown (`scripts/Chapter4_IGARCH_Models.Rmd`) to generate figures

**Error: `Undefined control sequence \citep`**
- Make sure `natbib` and `apacite` are installed
- Run: `tlmgr install natbib apacite`

**Error: Bibliography not showing**
- Delete `main.bbl` and recompile
- Ensure `references.bib` is in the same directory as `main.tex`

**Missing packages**
- Install with: `tlmgr install <package-name>`
- Common packages needed: `geometry`, `setspace`, `titlesec`, `booktabs`

### Output

After successful compilation:
- **PDF:** `main.pdf` (your thesis document)
- **Aux files:** `main.aux`, `main.toc`, `main.lof` (can be deleted after viewing PDF)

### Pushing to Overleaf (Optional)

If you want to keep Overleaf updated:
1. Download the generated `main.pdf`
2. Upload to Overleaf as a backup
3. Or switch Overleaf to read-only mode and use this repo as primary

### Next: Version Control

Add to your git repository:
```bash
git add main.tex references.bib OVERLEAF_INTEGRATION.md LATEX_COMPILATION.md
git commit -m "Integrate Overleaf project into repository"
git push
```

---

**Happy compiling!** 📖✨
