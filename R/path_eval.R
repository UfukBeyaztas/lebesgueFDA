path_eval <- function(path, t) {
  check_times(t)
  r <- length(path$value)
  j <- pmin(findInterval(t, path$breaks), r)
  out <- path$value[j] + path$slope[j] * (t - path$breaks[j])
  out[t == 1] <- path$endpoint
  out
}
