path_pieces <- function(path) {
  left <- path$breaks[-length(path$breaks)]
  list(left = left, slope = path$slope, intercept = path$value - path$slope * left)
}
