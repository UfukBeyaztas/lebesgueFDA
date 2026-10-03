check_times <- function(t) {
  if (!is.numeric(t) || any(!is.finite(t)) || any(t < 0 | t > 1))
    stop("Evaluation times must lie in [0, 1].", call. = FALSE)
  invisible(t)
}
