path_simplify <- function(path) {
  r <- length(path$value)
  if (r == 1) return(path)
  d <- diff(path$breaks)
  expected <- path$value[-r] + path$slope[-r] * d[-r]
  tol <- 64 * .Machine$double.eps * pmax(1, abs(expected), abs(path$value[-1]))
  keep <- c(TRUE, path$slope[-1] != path$slope[-r] |
              abs(path$value[-1] - expected) > tol)
  new_path(c(path$breaks[-(r + 1)][keep], 1), path$value[keep],
           path$slope[keep], path$endpoint)
}