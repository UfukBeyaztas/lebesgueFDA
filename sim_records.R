sim_records <- function(coefficients, design = c("D1", "D2", "D3", "D4", "D5", "D6"),
                        delta) {
  design <- match.arg(design)
  check_positive(delta, "delta")
  cf <- as.matrix(coefficients)
  lapply(seq_len(nrow(cf)), function(i) design_record(cf[i, ], design, delta))
}