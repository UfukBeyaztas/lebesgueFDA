check_sample <- function(records) {
  if (inherits(records, "sod_record") || !is.list(records) || length(records) == 0)
    stop("'records' must be a nonempty list of records.", call. = FALSE)
  lapply(records, check_record)
  delta <- vapply(records, function(r) r$delta, numeric(1))
  if (any(delta != delta[1]))
    stop("All records must share the same threshold delta.", call. = FALSE)
  invisible(delta[1])
}