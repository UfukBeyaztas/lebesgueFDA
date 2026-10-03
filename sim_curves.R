sim_curves <- function(coefficients, design = c("D1", "D2", "D3", "D4", "D5", "D6"), t) {
  design <- match.arg(design)
  check_times(t)
  cf <- as.matrix(coefficients)
  n <- nrow(cf)
  switch(design,
         D1 = cf[, 1] + outer(cf[, 2] * (1 - cf[, 3]), t) + outer(cf[, 2] * cf[, 3], t^2),
         D2 = cf[, 1] + outer(rep(0.9, n), t),
         D3 = cf[, 1] + outer(cf[, 2], t) + outer(cf[, 3], sin(pi * t)),
         D4 = matrix(2 * t + 0.5 * sin(2 * pi * t), n, length(t), byrow = TRUE) +
           tcrossprod(cf, d4_basis(t)),
         D5 = cf[, 1] + outer(cf[, 2], t),
         D6 = tcrossprod(cf, d6_basis(t)))
}