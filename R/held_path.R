held_path <- function(record) {
  v <- record_values(record)
  time <- c(0, record$times)
  inside <- time < 1
  new_path(c(time[inside], 1), v[inside], rep(0, sum(inside)), v[length(v)])
}
