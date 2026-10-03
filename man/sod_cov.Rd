\name{sod_cov}
\alias{sod_cov}
\title{Estimated Covariance Function}
\description{
Evaluates the covariance function estimated by \code{\link{sod_fpca}} at all
pairs of times.
}
\usage{
sod_cov(fit, s, t = s)
}
\arguments{
\item{fit}{An object of class \code{"sod_fpca"}.}
\item{s, t}{Evaluation times in \eqn{[0, 1]}.}
}
\details{
The estimate is the sample covariance of the reconstructed paths, with
divisor \eqn{n}; it is the full estimate, not its expansion in the retained
components. Its expected squared Hilbert--Schmidt error is of order
\eqn{n^{-1} + \delta^2}{1/n + delta^2} (Theorem 4.18).
}
\value{
A matrix with \code{length(s)} rows and \code{length(t)} columns.
}
\seealso{
\code{\link{sod_fpca}}, \code{\link{sod_eigenfunctions}}
}
\examples{
\dontrun{
## design D6: at the pair (0.10, 0.83) the covariance is -0.0502, while the
## pooled pair smoother would converge to +0.1855 (Example 4.10); estimates from
## 20 replications with n = 300 and delta = 0.05 scatter around the negative value
set.seed(2026)
est <- replicate(20, {
  sim <- sim_sod(n = 300, design = "D6", delta = 0.05)
  sod_cov(sod_fpca(sim$records, method = "held", npc = 1), 0.10, 0.83)
})
mean(est)
design_truth("D6")$covariance(0.10, 0.83)
## the estimated covariance surface of one replication
sim <- sim_sod(n = 300, design = "D6", delta = 0.05)
fit <- sod_fpca(sim$records, method = "held")
grid <- seq(0, 1, length.out = 51)
persp(grid, grid, sod_cov(fit, grid), theta = 30, phi = 30, xlab = "s",
      ylab = "t", zlab = "")
}
}
