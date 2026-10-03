check_record <- function(record) {
  if (!is.numeric(record$initial) || length(record$initial) != 1 ||
      !is.finite(record$initial))
    stop("The initial value must be a finite number.", call. = FALSE)
  check_positive(record$delta, "delta")
  tt <- record$times
  if (any(!is.finite(tt)) || any(tt <= 0 | tt > 1) || any(diff(tt) <= 0))
    stop("Event times must increase strictly in (0, 1].", call. = FALSE)
  if (length(record$polarity) != length(tt) || any(!record$polarity %in% c(-1, 1)))
    stop("Each event needs a polarity equal to -1 or 1.", call. = FALSE)
  invisible(record)
}
