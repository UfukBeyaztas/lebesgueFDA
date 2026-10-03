power_record <- function(initial, amplitude, power, delta) {
  ratio <- abs(amplitude) / delta
  m <- floor(ratio + 32 * .Machine$double.eps * max(1, ratio))
  times <- pmin(1, seq_len(m) * delta / abs(amplitude))^(1 / power)
  sod_record(initial, times, rep(sign(amplitude), m), delta)
}