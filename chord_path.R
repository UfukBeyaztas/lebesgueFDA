chord_path <- function(record) {
  v <- record_values(record)
  time <- c(0, record$times)
  if (time[length(time)] < 1) {
    time <- c(time, 1)
    v <- c(v, v[length(v)])
  }
  path_linear(time, v)
}