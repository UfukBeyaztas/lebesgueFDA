path_refine <- function(path, breaks) {
  left <- breaks[-length(breaks)]
  j <- pmin(findInterval(left, path$breaks), length(path$value))
  list(value = path$value[j] + path$slope[j] * (left - path$breaks[j]),
       slope = path$slope[j])
}
