sod_reconstruct <- function(records, t, method = c("held", "chord", "midpoint"),
                            L = NULL) {
  check_times(t)
  paths <- sod_paths(records, method, L)
  do.call(rbind, lapply(paths, path_eval, t = t))
}
