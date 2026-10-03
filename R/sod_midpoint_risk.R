sod_midpoint_risk <- function(records, L) {
  check_sample(records)
  n <- length(records)
  if (n < 2) stop("At least two records are needed.", call. = FALSE)
  env <- lapply(records, sod_envelopes, L = L)
  mid <- lapply(env, function(e) e$midpoint)
  wid <- lapply(env, function(e) e$width)
  centre <- path_combine(mid, rep(1 / n, n))
  mean_width <- path_combine(wid, rep(1 / n, n))
  sq <- function(p) path_inner(p, p)
  var_mid <- max(0, sum(vapply(mid, sq, numeric(1))) - n * sq(centre)) / (n - 1)
  var_wid <- max(0, sum(vapply(wid, sq, numeric(1))) - n * sq(mean_width)) / (n - 1)
  rho2 <- sq(mean_width) / 4
  list(radius = sqrt(rho2), variance = var_mid, risk = rho2 + var_mid / n,
       risk_unbiased = rho2 - var_wid / (4 * n) + var_mid / n)
}
