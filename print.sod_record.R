print.sod_record <- function(x, ...) {
  cat("Send-on-delta record: initial value ", format(x$initial, digits = 4),
      ", ", length(x$times), " events, delta = ", x$delta, "\n", sep = "")
  invisible(x)
}