# =========================
# IGARCH(1,1) estimation in R (rugarch)
# =========================

# If not installed:
install.packages("rugarch")
install.packages("readr")

library(rugarch)
library(readr)

# -------------------------
# 1) Load data
# -------------------------
# Set this to your actual file path (same file you use in Python)
data_path <- "../Data/final_data.csv"

df <- read_csv(data_path, show_col_types = FALSE)

# Robust date parsing
df$Date <- as.Date(df$Date)

# Standardize sentiment column name
if ("Trends" %in% names(df) && !("Search_Interest" %in% names(df))) {
  df$Search_Interest <- df$Trends
}

# Sort by date just in case
df <- df[order(df$Date), ]

# -------------------------
# 2) Compute returns (percent log returns)
# -------------------------
df$r <- 100 * (log(df$Close) - log(dplyr::lag(df$Close)))
df <- df[!is.na(df$r), ]  # drop first NA return

r <- df$r

# -------------------------
# 3) Specify IGARCH(1,1) models
# -------------------------
spec_norm <- ugarchspec(
  variance.model = list(model = "iGARCH", garchOrder = c(1, 1)),
  mean.model     = list(armaOrder = c(0, 0), include.mean = TRUE),
  distribution.model = "norm"
)

spec_std <- ugarchspec(
  variance.model = list(model = "iGARCH", garchOrder = c(1, 1)),
  mean.model     = list(armaOrder = c(0, 0), include.mean = TRUE),
  distribution.model = "std"  # Student-t
)

# -------------------------
# 4) Fit models
# -------------------------
fit_norm <- ugarchfit(spec = spec_norm, data = r, solver = "solnp")
fit_std  <- ugarchfit(spec = spec_std,  data = r, solver = "solnp")

# -------------------------
# 5) Extract parameters in a Python-friendly format
# -------------------------
params_norm <- coef(fit_norm)
params_std  <- coef(fit_std)

# Create a unified parameter table
all_params <- sort(unique(c(names(params_norm), names(params_std))))

out <- data.frame(
  param = all_params,
  IGARCH_Normal = as.numeric(params_norm[all_params]),
  IGARCH_Student_t = as.numeric(params_std[all_params])
)

# Replace NAs (parameters not present under normal, e.g. shape) with blank
out[is.na(out)] <- NA

# Optional: add log-likelihood
out_ll <- data.frame(
  param = c("loglik"),
  IGARCH_Normal = likelihood(fit_norm),
  IGARCH_Student_t = likelihood(fit_std)
)

out <- rbind(out, out_ll)

# -------------------------
# 6) Export to CSV (for Python to read)
# -------------------------
# Save into your thesis outputs folder structure if you want:
# e.g., "./outputs/tables/igarch_params_from_r.csv"
write_csv(out, "igarch_params_from_r.csv")

cat("Saved: igarch_params_from_r.csv\n")
print(out)

