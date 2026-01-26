# =========================
# Walk-forward 1-step variance forecasts for IGARCH / IGARCH-X in R (rugarch)
# Exports: igarch_oos_forecasts_from_r.csv
# Date in final_data.csv is dd/mm/yyyy
# =========================

library(rugarch)
library(readr)
library(dplyr)

# -------------------------
# Settings (MATCH your Python notebook)
# -------------------------
DATA_PATH <- "../Data/final_data.csv"
TEST_SIZE <- 0.20
ROLLING_WINDOW <- 750   # set to NA for expanding window

# -------------------------
# Load + prep data
# -------------------------
df <- read_csv(DATA_PATH, show_col_types = FALSE)

# Parse dd/mm/yyyy explicitly (CRITICAL)
df$Date <- as.Date(df$Date, format = "%d/%m/%Y")

# Sanity checks
if (any(is.na(df$Date))) stop("Date parsing failed: NA dates detected. Check dd/mm/yyyy format.")
df <- df[order(df$Date), ]

cat("Date range in input data:", as.character(min(df$Date)), "→", as.character(max(df$Date)), "\n")

# Standardize sentiment column name
if ("Trends" %in% names(df) && !("Search_Interest" %in% names(df))) {
  df$Search_Interest <- df$Trends
}

# Returns: 100 * log diff
df$r <- 100 * (log(df$Close) - log(dplyr::lag(df$Close)))
df <- df[!is.na(df$r), ]

N <- nrow(df)
split_idx <- floor((1 - TEST_SIZE) * N)

# OOS dates
oos_dates <- df$Date[(split_idx + 1):N]
n_oos <- length(oos_dates)

cat("Total obs (after returns):", N, "\n")
cat("In-sample:", split_idx, "\n")
cat("Out-of-sample:", n_oos, "\n")
cat("OOS period:", as.character(min(oos_dates)), "→", as.character(max(oos_dates)), "\n")

# -------------------------
# Model specs
# -------------------------
# Baseline IGARCH
spec_igarch_norm <- ugarchspec(
  variance.model = list(model = "iGARCH", garchOrder = c(1, 1)),
  mean.model     = list(armaOrder = c(0, 0), include.mean = TRUE),
  distribution.model = "norm"
)

spec_igarch_std <- ugarchspec(
  variance.model = list(model = "iGARCH", garchOrder = c(1, 1)),
  mean.model     = list(armaOrder = c(0, 0), include.mean = TRUE),
  distribution.model = "std"
)

# IGARCH-X (sentiment in variance eq)
# IMPORTANT: external.regressors must be a matrix and match the data used in fit
x_sent_all <- as.matrix(df$Search_Interest)

spec_igarchx_norm <- ugarchspec(
  variance.model = list(
    model = "iGARCH",
    garchOrder = c(1, 1),
    external.regressors = x_sent_all
  ),
  mean.model = list(armaOrder = c(0, 0), include.mean = TRUE),
  distribution.model = "norm"
)

spec_igarchx_std <- ugarchspec(
  variance.model = list(
    model = "iGARCH",
    garchOrder = c(1, 1),
    external.regressors = x_sent_all
  ),
  mean.model = list(armaOrder = c(0, 0), include.mean = TRUE),
  distribution.model = "std"
)

# -------------------------
# Helper: 1-step variance forecast at time t (using data up to t-1)
# -------------------------
one_step_var <- function(spec, t_idx, use_x = FALSE) {
  end_est <- t_idx - 1
  
  if (is.na(ROLLING_WINDOW)) {
    start_est <- 1
  } else {
    start_est <- max(1, end_est - ROLLING_WINDOW + 1)
  }
  
  r_est <- df$r[start_est:end_est]
  
  if (use_x) {
    # Fit using the same windowed x as the return window
    x_est <- as.matrix(df$Search_Interest[start_est:end_est])
    fit <- ugarchfit(spec = spec, data = r_est, solver = "solnp")
    
    # Provide the next-period variance regressor forecast (1-step)
    x_next <- matrix(df$Search_Interest[t_idx], nrow = 1, ncol = 1)
    
    fc <- ugarchforecast(
      fit,
      n.ahead = 1,
      external.forecasts = list(vregfor = x_next)
    )
  } else {
    fit <- ugarchfit(spec = spec, data = r_est, solver = "solnp")
    fc <- ugarchforecast(fit, n.ahead = 1)
  }
  
  as.numeric(sigma(fc)^2)[1]
}

# -------------------------
# Walk-forward forecasts over the OOS window
# -------------------------
idx_forecast <- (split_idx + 1):N

f_igarch_norm  <- numeric(n_oos)
f_igarch_std   <- numeric(n_oos)
f_igarchx_norm <- numeric(n_oos)
f_igarchx_std  <- numeric(n_oos)

for (i in seq_along(idx_forecast)) {
  t_idx <- idx_forecast[i]
  
  f_igarch_norm[i]  <- one_step_var(spec_igarch_norm,  t_idx, use_x = FALSE)
  f_igarch_std[i]   <- one_step_var(spec_igarch_std,   t_idx, use_x = FALSE)
  
  f_igarchx_norm[i] <- one_step_var(spec_igarchx_norm, t_idx, use_x = TRUE)
  f_igarchx_std[i]  <- one_step_var(spec_igarchx_std,  t_idx, use_x = TRUE)
  
  if (i %% 50 == 0) cat("Completed:", i, "of", n_oos, "\n")
}

# -------------------------
# Export (ISO dates for Python)
# -------------------------
out <- data.frame(
  Date = oos_dates,
  IGARCH_Normal = f_igarch_norm,
  IGARCH_Student_t = f_igarch_std,
  IGARCHX_Normal = f_igarchx_norm,
  IGARCHX_Student_t = f_igarchx_std
)

# Force ISO date strings (unambiguous)
out$Date <- format(as.Date(out$Date), "%Y-%m-%d")

write_csv(out, "igarch_oos_forecasts_from_r.csv")
cat("Saved: igarch_oos_forecasts_from_r.csv\n")
print(head(out))
