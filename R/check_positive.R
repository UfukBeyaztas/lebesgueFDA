check_positive <- function(x, name) {
  if (!is.numeric(x) || length(x) != 1 || !is.finite(x) || x <= 0)
    stop("'", name, "' must be a positive number.", call. = FALSE)
  invisible(x)
}
