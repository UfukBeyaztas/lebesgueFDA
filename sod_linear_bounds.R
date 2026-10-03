sod_linear_bounds <- function(band, weight) {
  ends <- c(weight$value, weight$value + weight$slope * diff(weight$breaks), weight$endpoint)
  if (min(ends) < 0) stop("'weight' must be nonnegative on [0, 1].", call. = FALSE)
  c(lower = path_inner(band$mean_lower, weight), upper = path_inner(band$mean_upper, weight))
}