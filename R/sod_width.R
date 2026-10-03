sod_width <- function(record, L) {
  check_positive(L, "L")
  if (!sod_compatible(record, L))
    stop("The record contradicts L: an inter-event time is shorter than delta / L.",
         call. = FALSE)
  d <- record$delta
  anchors <- c(0, record$times)
  D <- pmax(1, L * diff(anchors) / d)
  D_tail <- L * (1 - anchors[length(anchors)]) / d
  d^2 / L * (sum(omega(D)) + omega_tail(D_tail))
}
