check_grid <- function(t, name = "t") {
  if (!is.numeric(t) || length(t) < 2 || any(!is.finite(t)) || any(diff(t) <= 0))
    stop("'", name, "' must be a strictly increasing numeric vector.", call. = FALSE)
  if (t[1] != 0 || t[length(t)] != 1)
    stop("'", name, "' must start at 0 and end at 1.", call. = FALSE)
  invisible(t)
}