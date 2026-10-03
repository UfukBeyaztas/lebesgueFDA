\name{sod_mean}
\alias{sod_mean}
\title{Estimated Mean Function}
\description{
Evaluates the mean function estimated by \code{\link{sod_fpca}}.
}
\usage{
sod_mean(fit, t)
}
\arguments{
\item{fit}{An object of class \code{"sod_fpca"}.}
\item{t}{Evaluation times in \eqn{[0, 1]}.}
}
\details{
The estimate is the average of the reconstructed paths; see
\code{\link{sod_fpca}} for its risk.
}
\value{
A numeric vector of the estimated mean at \code{t}.
}
\seealso{
\code{\link{sod_fpca}}, \code{\link{sod_cov}}
}
\examples{
\dontrun{
## design D1, where level and speed are associated: reconstruction-based
## means follow mu, whereas pooling would follow mu_ev (dashed)
set.seed(2026)
sim <- sim_sod(n = 900, design = "D1", delta = 0.025)
held <- sod_fpca(sim$records, method = "held")
chord <- sod_fpca(sim$records, method = "chord")
grid <- seq(0.1, 0.9, length.out = 201)
plot(grid, sim$truth$event_mean(grid), type = "l", lty = 2, xlab = "t",
     ylab = "mean")
lines(grid, sim$truth$mean(grid), lwd = 2)
lines(grid, sod_mean(held, grid), col = 2)
lines(grid, sod_mean(chord, grid), col = 3)
}
}
