\name{sod_midpoint_risk}
\alias{sod_midpoint_risk}
\title{Chebyshev Radius and Worst-Case Risk of the Midpoint Estimator}
\description{
Estimates the Chebyshev radius of the identified set of mean functions and
the worst-case risk of the averaged midpoint estimator.
}
\usage{
sod_midpoint_risk(records, L)
}
\arguments{
\item{records}{A list of at least two \code{"sod_record"} objects with a
common threshold, compatible with \code{L}.}
\item{L}{Bound on the Lipschitz constant.}
}
\details{
With \eqn{a = E\ell_O}{a = E l}, \eqn{b = E u_O}{b = E u} and
\eqn{c = (a + b)/2}, the closure of the identified set of mean functions has
Chebyshev center \eqn{c} and radius \eqn{\rho = \|b - a\|/2}{rho = ||b - a||/2}
in \eqn{L^2}, and the average \eqn{\hat\mu_M}{mu.hat_M} of the midpoint
paths has worst-case risk
\deqn{\sup E\|\hat\mu_M - \mu\|^2 = \rho^2 + \sigma_M^2/n, \qquad \sigma_M^2 = E\|M_O - c\|^2,}{sup E||mu.hat_M - mu||^2 = rho^2 + sigma_M^2/n,   sigma_M^2 = E||M_O - c||^2,}
the supremum being over the laws that produce the same record law. No
estimator improves on \eqn{\rho^2}{rho^2} uniformly, and
\eqn{\rho^2 \le \delta E W(O)/2 \le \delta^2}{rho^2 <= delta E W(O)/2 <= delta^2}
(Theorem 4.17). The function replaces \eqn{a}, \eqn{b} and
\eqn{\sigma_M^2}{sigma_M^2} by their sample versions; all integrals are exact.
}
\value{
A list with the estimated \code{radius}, the sample \code{variance} of the
midpoint paths, the plug-in worst-case risk \code{risk}, and
\code{risk_unbiased}, which corrects the plug-in estimate of
\eqn{\rho^2}{rho^2} for its bias.
}
\seealso{
\code{\link{midpoint_path}}, \code{\link{sod_band}}
}
\examples{
\dontrun{
## design D1 with n = 300 at the three thresholds of the paper (experiment E3)
set.seed(2026)
cf <- sim_coefficients(300, "D1")
L <- design_truth("D1")$L
sapply(c(0.10, 0.05, 0.025), function(delta)
  unlist(sod_midpoint_risk(sim_records(cf, "D1", delta), L = L)))
}
}
