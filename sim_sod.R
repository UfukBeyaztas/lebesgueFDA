sim_sod <- function(n, design = c("D1", "D2", "D3", "D4", "D5", "D6"), delta = 0.05,
                    t = NULL) {
  design <- match.arg(design)
  cf <- sim_coefficients(n, design)
  out <- list(records = sim_records(cf, design, delta), coefficients = cf,
              truth = design_truth(design), design = design, delta = delta)
  if (!is.null(t)) out$curves <- sim_curves(cf, design, t)
  out
}