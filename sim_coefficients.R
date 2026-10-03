sim_coefficients <- function(n, design = c("D1", "D2", "D3", "D4", "D5", "D6")) {
  design <- match.arg(design)
  if (n < 1 || n != floor(n)) stop("'n' must be a positive whole number.", call. = FALSE)
  switch(design,
         D1 = cbind(Z = runif(n, -0.2, 0.2), A = runif(n, 0.5, 1.5),
                    R = rbinom(n, 1, 0.5)),
         D2 = cbind(Z = runif(n, -0.6, 0.6)),
         D3 = cbind(a0 = runif(n, -0.5, 0.5), a1 = runif(n, 0, 2),
                    a2 = runif(n, -0.5, 0.5)),
         D4 = cbind(xi1 = rnorm(n, 0, sqrt(0.5)), xi2 = rnorm(n, 0, sqrt(0.3)),
                    xi3 = rnorm(n, 0, sqrt(0.1))),
         D5 = cbind(A = rnorm(n, 0, 0.5), B = rnorm(n, 1, 0.4)),
         D6 = cbind(A1 = rnorm(n), B1 = rnorm(n), A2 = rnorm(n),
                    B2 = rnorm(n)))
}