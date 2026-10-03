\name{design_truth}
\alias{design_truth}
\title{Population Quantities of the Simulation Designs}
\description{
Returns the mean, the covariance, the pooled target and the bounds of the six
simulation designs of the paper.
}
\usage{
design_truth(design = c("D1", "D2", "D3", "D4", "D5", "D6"))
}
\arguments{
\item{design}{One of \code{"D1"}, \code{"D2"}, \code{"D3"}, \code{"D4"},
\code{"D5"} and \code{"D6"}.}
}
\details{
All random elements are independent.
\describe{
\item{D1}{\eqn{X(t) = Z + A t^{1+R}}{X(t) = Z + A t^(1+R)} with
\eqn{Z \sim U(-0.2, 0.2)}{Z ~ U(-0.2, 0.2)}, \eqn{A \sim U(0.5, 1.5)}{A ~ U(0.5, 1.5)}
and \eqn{R \sim Ber(1/2)}{R ~ Ber(1/2)}. The speed grows with the level, so
the pooled target \eqn{13(t + 2t^3)/[12(1 + 2t)]}{13 (t + 2t^3)/(12 (1 + 2t))}
exceeds the mean \eqn{(t + t^2)/2}. Bounds \eqn{B = 0.2}, \eqn{L = 3}.}
\item{D2}{\eqn{X(t) = Z + 0.9t} with \eqn{Z \sim U(-0.6, 0.6)}{Z ~ U(-0.6, 0.6)}:
parallel lines with a common event schedule, for which pooling is unbiased.
Bounds \eqn{B = 0.6}, \eqn{L = 1.5}.}
\item{D3}{\eqn{X(t) = a_0 + a_1 t + a_2\sin(\pi t)}{X(t) = a0 + a1 t + a2 sin(pi t)}
with \eqn{a_0, a_2 \sim U(-1/2, 1/2)}{a0, a2 ~ U(-1/2, 1/2)} and
\eqn{a_1 \sim U(0, 2)}{a1 ~ U(0, 2)}: a bounded Lipschitz model with the sharp
bounds \eqn{B = 1/2} and \eqn{L = 2 + \pi/2}{L = 2 + pi/2}.}
\item{D4}{\eqn{X(t) = 2t + \sin(2\pi t)/2 + \sum_{j=1}^3 \xi_j\phi_j(t)}{X(t) = 2t + sin(2 pi t)/2 + sum xi[j] phi[j](t)}
with \eqn{\xi_j \sim N(0, \lambda_j)}{xi[j] ~ N(0, lambda[j])},
\eqn{\lambda = (0.5, 0.3, 0.1)}{lambda = (0.5, 0.3, 0.1)} and
\eqn{\phi = (1, \sqrt2\sin 2\pi t, \sqrt2\cos 2\pi t)}{phi = (1, sqrt(2) sin(2 pi t), sqrt(2) cos(2 pi t))}:
a Gaussian process with a trend and a time-varying variance; the pooled target
follows from Theorem 4.6.}
\item{D5}{\eqn{X(t) = A + Bt} with \eqn{A \sim N(0, 0.5^2)}{A ~ N(0, 0.5^2)} and
\eqn{B \sim N(1, 0.4^2)}{B ~ N(1, 0.4^2)}: Gaussian lines with pooled target
\eqn{1.1578\,t}{1.1578 t} (Example 4.9).}
\item{D6}{The linear interpolant on \eqn{j/1000}, \eqn{j = 0, \dots, 1000}{j = 0, ..., 1000},
of \eqn{\sqrt{0.4}(A_1\cos t + B_1\sin t) + \sqrt{0.6}(A_2\cos 3t + B_2\sin 3t)}{sqrt(0.4) (A1 cos t + B1 sin t) + sqrt(0.6) (A2 cos 3t + B2 sin 3t)}
with standard normal coefficients. The mean is zero and the covariance is
that of the interpolant; at \eqn{(0.10, 0.83)} it equals \eqn{-0.0502},
whereas the pooled pair smoother converges to \eqn{0.1855} (Example 4.10).}
}
The Gaussian designs D4--D6 have no finite bounds.
}
\value{
A list with the functions \code{mean(t)}, \code{covariance(s, t = s)}
(returning a matrix) and \code{event_mean(t)}, the variation-weighted target
\eqn{\mu_{ev}}{mu_ev} of event pooling (\code{NULL} for D3), the bounds
\code{B} and \code{L} (\code{Inf} for D4--D6), and the name of the design.
}
\seealso{
\code{\link{sim_sod}}, \code{\link{sim_coefficients}}
}
\examples{
\dontrun{
## the gap between the pooled target and the mean in designs D1, D4 and D5
grid <- seq(0, 1, length.out = 201)
gaps <- sapply(c("D1", "D4", "D5"), function(d) {
  truth <- design_truth(d)
  truth$event_mean(grid) - truth$mean(grid)
})
matplot(grid, gaps, type = "l", lty = 1, xlab = "t", ylab = "mu_ev - mu")
## Example 4.9: in design D5 the gap equals 0.157760 t
design_truth("D5")$event_mean(1) - 1
}
}
