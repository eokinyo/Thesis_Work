# =========================
# IGARCH-X(1,1) estimation in R (rugarch)
# External regressor: Search_Interest (Google Trends)
# =========================

# If not installed:
# install.packages("rugarch")
# install.packages("readr")
# install.packages("dplyr")

library(rugarch)
library(readr)
library(dplyr)

# -------------------------
# 1) Load data
# -------------------------
data_path <- "../Data/final_data.csv"  # <-- adjust if needed
df <- read_csv(data_path, show_col_types = FALSE)

df$Date <- as.Date(df$Date)
df <- df[order(df$Date), ]

# Standardize sentiment column name
if ("Trends" %in% names(df) && !("Search_Interest" %in% names(df))) {
  df$Search_Interest <- df$Trends
}

# -------------------------
# 2) Compute returns (percent log returns)
# -------------------------
df$r <- 100 * (log(df$Close) - log(lag(df$Close)))
df <- df[!is.na(df$r), ]  # drop first NA return

r <- df$r

# External regressor for variance equation (must be a matrix)
x_sent <- as.matrix(df$Search_Interest)

# -------------------------
# 3) Specify IGARCH-X(1,1)
# NOTE: variance.model includes external.regressors
# -------------------------
spec_norm_x <- ugarchspec(
  variance.model = list(
    model = "iGARCH",
    garchOrder = c(1, 1),
    external.regressors = x_sent
  ),
  mean.model = list(armaOrder = c(0, 0), include.mean = TRUE),
  distribution.model = "norm"
)

spec_std_x <- ugarchspec(
  variance.model = list(
    model = "iGARCH",
    garchOrder = c(1, 1),
    external.regressors = x_sent
  ),
  mean.model = list(armaOrder = c(0, 0), include.mean = TRUE),
  distribution.model = "std"
)

# -------------------------
# 4) Fit models
# -------------------------
fit_norm_x <- ugarchfit(spec = spec_norm_x, data = r, solver = "solnp")
fit_std_x  <- ugarchfit(spec = spec_std_x,  data = r, solver = "solnp")

# -------------------------
# 5) Extract parameters
# -------------------------
params_norm <- coef(fit_norm_x)
params_std  <- coef(fit_std_x)

all_params <- sort(unique(c(names(params_norm), names(params_std))))

out <- data.frame(
  param = all_params,
  IGARCHX_Normal = as.numeric(params_norm[all_params]),
  IGARCHX_Student_t = as.numeric(params_std[all_params])
)

out[is.na(out)] <- NA

# Add log-likelihood (useful for reporting)
out_ll <- data.frame(
  param = c("loglik"),
  IGARCHX_Normal = likelihood(fit_norm_x),
  IGARCHX_Student_t = likelihood(fit_std_x)
)

out <- rbind(out, out_ll)

# -------------------------
# 6) Export (for Python import)
# -------------------------
write_csv(out, "igarchx_params_from_r.csv")
cat("Saved: igarchx_params_from_r.csv\n")
print(out)
