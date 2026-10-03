record_values <- function(record) {
  record$initial + record$delta * c(0, cumsum(record$polarity))
}
