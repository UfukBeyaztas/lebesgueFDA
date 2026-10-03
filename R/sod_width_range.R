sod_width_range <- function(m, delta, L) {
  check_positive(delta, "delta")
  check_positive(L, "L")
  gamma <- L / delta
  if (m < 0 || m != floor(m) || m > gamma + 1e-12)
    stop("'m' must be a whole number not larger than L / delta.", call. = FALSE)
  if (m == 0) {
    w <- delta^2 / L * omega_tail(gamma)
    return(c(minimum = w, maximum = w))
  }
  x <- max(0, gamma - m)
  low <- if (x <= 0.5) {
    x^2
  } else if (x <= 2 * m + 1) {
    (gamma + m)^2 / (4 * m + 1) - m
  } else {
    2 * gamma - 3 * m - 1
  }
  c(minimum = delta^2 / L * low, maximum = delta^2 / L * omega(x + 1))
}
