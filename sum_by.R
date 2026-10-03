sum_by <- function(x, index, size) {
  out <- numeric(size)
  s <- rowsum(x, index)
  out[as.numeric(rownames(s))] <- s[, 1]
  out
}