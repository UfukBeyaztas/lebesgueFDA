sod_encode_sample <- function(t, X, delta) {
  X <- as.matrix(X)
  if (ncol(X) != length(t)) stop("'X' must have one column per time point.", call. = FALSE)
  lapply(seq_len(nrow(X)), function(i) sod_encode(t, X[i, ], delta))
}