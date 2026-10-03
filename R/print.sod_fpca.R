print.sod_fpca <- function(x, ...) {
  cat("Principal components from send-on-delta records\n")
  cat("  curves: ", x$n, ", reconstruction: ", x$method, ", delta: ", x$delta,
      "\n", sep = "")
  cat("  mean number of events per curve: ", format(mean(x$events), digits = 3),
      "\n", sep = "")
  cat("  components: ", x$npc, " (", format(100 * x$fve, digits = 3),
      "% of the variance)\n", sep = "")
  invisible(x)
}
