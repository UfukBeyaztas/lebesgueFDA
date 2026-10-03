path_linear <- function(knots, values) {
  check_grid(knots, "knots")
  if (length(values) != length(knots) || any(!is.finite(values)))
    stop("'values' must be finite and have the length of 'knots'.", call. = FALSE)
  r <- length(knots)
  new_path(knots, values[-r], diff(values) / diff(knots), values[r])
}
