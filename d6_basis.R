d6_basis <- function(t) {
  knots <- d6_knots()
  b <- d6_template(knots)
  out <- vapply(seq_len(4), function(j) approx(knots, b[, j], xout = t)$y,
                numeric(length(t)))
  matrix(out, length(t), 4)
}