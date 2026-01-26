# =========================
# Diagnostics for IGARCH / IGARCH-X in R (rugarch)
# Ljung-Box on z_t and z_t^2
# =========================

# install.packages("rugarch")
# install.packages("readr")
library(rugarch)
library(readr)

# ---- Helper: Ljung-Box table for a fitted rugarch object ----
ljung_box_diag <- function(fit, lags = c(10, 20)) {
  z <- residuals(fit, standardize = TRUE)
  z <- as.numeric(z)
  z <- z[is.finite(z)]
  
  out <- data.frame(
    lag = lags,
    lb_stat_resid = NA_real_,
    lb_pvalue_resid = NA_real_,
    lb_stat_sqresid = NA_real_,
    lb_pvalue_sqresid = NA_real_
  )
  
  for (i in seq_along(lags)) {
    L <- lags[i]
    
    bt1 <- Box.test(z, lag = L, type = "Ljung-Box")
    bt2 <- Box.test(z^2, lag = L, type = "Ljung-Box")
    
    out$lb_stat_resid[i] <- unname(bt1$statistic)
    out$lb_pvalue_resid[i] <- unname(bt1$p.value)
    
    out$lb_stat_sqresid[i] <- unname(bt2$statistic)
    out$lb_pvalue_sqresid[i] <- unname(bt2$p.value)
  }
  out
}

# -------------------------
# (A) Baseline IGARCH fits (from your earlier script)
# Make sure these objects exist in your R session:
# fit_norm, fit_std
# -------------------------
diag_igarch_norm <- ljung_box_diag(fit_norm, lags = c(10, 20))
diag_igarch_t    <- ljung_box_diag(fit_std,  lags = c(10, 20))

diag_igarch <- merge(
  transform(diag_igarch_norm, Model = "IGARCH-Normal"),
  transform(diag_igarch_t,    Model = "IGARCH-Student-t"),
  all = TRUE
)

# This merge creates duplicated rows; better stack:
diag_igarch <- rbind(
  transform(diag_igarch_norm, Model = "IGARCH-Normal"),
  transform(diag_igarch_t,    Model = "IGARCH-Student-t")
)

write_csv(diag_igarch, "igarch_diag_from_r.csv")
cat("Saved: igarch_diag_from_r.csv\n")

# -------------------------
# (B) Sentiment-augmented IGARCH-X fits
# Make sure these exist:
# fit_norm_x, fit_std_x
# -------------------------
diag_igarchx_norm <- ljung_box_diag(fit_norm_x, lags = c(10, 20))
diag_igarchx_t    <- ljung_box_diag(fit_std_x,  lags = c(10, 20))

diag_igarchx <- rbind(
  transform(diag_igarchx_norm, Model = "IGARCH-X Normal"),
  transform(diag_igarchx_t,    Model = "IGARCH-X Student-t")
)

write_csv(diag_igarchx, "igarchx_diag_from_r.csv")
cat("Saved: igarchx_diag_from_r.csv\n")

print(diag_igarch)
print(diag_igarchx)
