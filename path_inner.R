path_inner <- function(f, g, lower = 0, upper = 1) {
  if (lower < 0 || upper > 1 || lower >= upper)
    stop("Limits must satisfy 0 <= lower < upper <= 1.", call. = FALSE)
  knots <- sort(unique(c(lower, upper, f$breaks, g$breaks)))
  knots <- knots[knots >= lower & knots <= upper]
  a <- path_refine(f, knots)
  b <- path_refine(g, knots)
  d <- diff(knots)
  sum(d * (a$value + a$slope * d / 2) * (b$value + b$slope * d / 2) +
        d^3 * a$slope * b$slope / 12)
}