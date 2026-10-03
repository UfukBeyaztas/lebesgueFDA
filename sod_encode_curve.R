sod_encode_curve <- function(curve, turning, delta, tol = 1e-13) {
  check_grid(turning, "turning")
  check_positive(delta, "delta")
  x <- curve(turning)
  if (length(x) != length(turning) || any(!is.finite(x)))
    stop("'curve' must return finite values at the turning points.", call. = FALSE)
  eps <- 32 * .Machine$double.eps * max(1, abs(x), delta)
  times <- numeric(0)
  polarity <- numeric(0)
  level <- 0
  for (j in seq_len(length(turning) - 1)) {
    direction <- sign(x[j + 1] - x[j])
    if (direction == 0) next
    held <- x[1] + delta * level
    q <- floor((direction * (x[j + 1] - held) + eps) / delta)
    if (q < 1) next
    target <- held + direction * delta * seq_len(q)
    root <- rep(turning[j + 1], q)
    open <- which(abs(x[j + 1] - target) > eps)
    if (length(open) > 0) {
      lo <- rep(turning[j], length(open))
      hi <- rep(turning[j + 1], length(open))
      for (iter in seq_len(200)) {
        mid <- (lo + hi) / 2
        above <- direction * (curve(mid) - target[open]) >= 0
        hi[above] <- mid[above]
        lo[!above] <- mid[!above]
        if (max(hi - lo) <= tol) break
      }
      root[open] <- (lo + hi) / 2
    }
    last <- if (length(times) > 0) times[length(times)] else 0
    if (any(diff(c(last, root)) <= 0))
      stop("Consecutive events cannot be separated in time.", call. = FALSE)
    times <- c(times, root)
    polarity <- c(polarity, rep(direction, q))
    level <- level + direction * q
  }
  sod_record(x[1], times, polarity, delta)
}