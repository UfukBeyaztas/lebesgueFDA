sod_record <- function(initial, times = numeric(0), polarity = numeric(0), delta) {
  record <- list(initial = initial, times = as.numeric(times),
                 polarity = as.numeric(polarity), delta = delta)
  check_record(record)
  class(record) <- "sod_record"
  record
}
