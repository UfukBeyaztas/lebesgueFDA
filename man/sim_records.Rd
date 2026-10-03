\name{sim_records}
\alias{sim_records}
\title{Send-on-Delta Records of Simulated Curves}
\description{
Records the latent curves defined by simulated coefficients with a given
threshold.
}
\usage{
sim_records(coefficients, design = c("D1", "D2", "D3", "D4", "D5", "D6"), delta)
}
\arguments{
\item{coefficients}{Matrix from \code{\link{sim_coefficients}}.}
\item{design}{The design of the coefficients.}
\item{delta}{Threshold \eqn{\delta > 0}{delta > 0}.}
}
\details{
The records are computed as in the paper: in closed form for the monotone
curves of D1, D2 and D5, by bisection on monotone pieces with analytic
turning points for D3 and D4 (\code{\link{sod_encode_curve}}), and exactly
for the piecewise linear curves of D6 (\code{\link{sod_encode}}). The same
coefficients can be recorded with several thresholds.
}
\value{
A list of \code{"sod_record"} objects, one per curve.
}
\seealso{
\code{\link{sim_coefficients}}, \code{\link{sim_sod}}
}
\examples{
\dontrun{
## the same 300 curves of design D4 recorded at the three thresholds of the
## paper, as in experiment E1
set.seed(2026)
cf <- sim_coefficients(n = 300, design = "D4")
truth <- design_truth("D4")
grid <- seq(0.1, 0.9, length.out = 201)
for (delta in c(0.10, 0.05, 0.025)) {
  fit <- sod_fpca(sim_records(cf, "D4", delta), method = "held", npc = 3)
  ise <- 0.8 * mean((sod_mean(fit, grid) - truth$mean(grid))^2)
  cat("delta =", delta, " integrated squared error:", signif(ise, 3), "\n")
}
}
}
