sod_compatible <- function(record, L, B = NULL) {
  check_positive(L, "L")
  tol <- 128 * .Machine$double.eps * max(1, L, record$delta, abs(record$initial))
  ok <- all(record$delta - L * diff(c(0, record$times)) <= tol)
  if (!is.null(B)) ok <- ok && abs(record$initial) <= B + tol
  ok
}