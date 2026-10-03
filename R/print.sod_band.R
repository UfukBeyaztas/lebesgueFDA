print.sod_band <- function(x, ...) {
  cat("Simultaneous ", 100 * (1 - x$alpha), "% band for the identified mean\n", sep = "")
  cat("  curves: ", x$n, ", delta: ", x$delta, ", B: ", x$B, ", L: ",
      format(x$L, digits = 4), "\n", sep = "")
  cat("  margins: sampling ", format(x$sampling_margin, digits = 3), ", grid ",
      format(x$mesh_margin, digits = 3), "\n", sep = "")
  cat("  mean integrated width: ", format(x$width, digits = 3),
      ", Chebyshev radius: ", format(x$radius, digits = 3), "\n", sep = "")
  invisible(x)
}
