\name{sim_curves}
\alias{sim_curves}
\title{Latent Curves Evaluated on a Grid}
\description{
Evaluates the latent curves defined by simulated coefficients.
}
\usage{
sim_curves(coefficients, design = c("D1", "D2", "D3", "D4", "D5", "D6"), t)
}
\arguments{
\item{coefficients}{Matrix from \code{\link{sim_coefficients}}.}
\item{design}{The design of the coefficients.}
\item{t}{Evaluation times in \eqn{[0, 1]}.}
}
\details{
The curves are those of \code{\link{design_truth}}; for D6 they are the
linear interpolants on the grid of 1001 points. They serve as the fully
observed benchmark of the paper.
}
\value{
A matrix with one row per curve and one column per time.
}
\seealso{
\code{\link{sim_coefficients}}, \code{\link{sim_sod}}
}
\examples{
\dontrun{
## twenty curves of each design with the population mean
set.seed(2026)
grid <- seq(0, 1, length.out = 201)
op <- par(mfrow = c(2, 3))
for (d in c("D1", "D2", "D3", "D4", "D5", "D6")) {
  x <- sim_curves(sim_coefficients(20, d), d, grid)
  matplot(grid, t(x), type = "l", lty = 1, col = "grey50", main = d,
          xlab = "t", ylab = "")
  lines(grid, design_truth(d)$mean(grid), lwd = 2)
}
par(op)
}
}
