sod_encode <- function(t, x, delta) {
  check_grid(t)
  if (length(x) != length(t) || any(!is.finite(x)))
    stop("'x' must be finite and have the length of 't'.", call. = FALSE)
  check_positive(delta, "delta")
  tol <- 32 * .Machine$double.eps * max(1, abs(x), delta)
  if (delta <= 16 * tol)
    stop("'delta' is too small for the scale of 'x'.", call. = FALSE)
  times <- numeric(0)
  polarity <- numeric(0)
  level <- 0
  for (g in seq_len(length(t) - 1)) {
    change <- x[g + 1] - x[g]
    if (change == 0) next
    direction <- sign(change)
    repeat {
      target <- x[1] + delta * (level + direction)
      if (direction * (x[g + 1] - target) < -tol) break
      tau <- t[g] + (t[g + 1] - t[g]) * (target - x[g]) / change
      tau <- min(max(tau, t[g]), t[g + 1])
      if (length(times) > 0 && tau <= times[length(times)])
        stop("Two events cannot be separated in time on this grid.", call. = FALSE)
      times <- c(times, tau)
      polarity <- c(polarity, direction)
      level <- level + direction
    }
  }
  sod_record(x[1], times, polarity, delta)
}
