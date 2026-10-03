\name{sim_sod}
\alias{sim_sod}
\title{Simulate Send-on-Delta Records from the Designs of the Paper}
\description{
Draws latent curves from one of the six simulation designs of the paper and
records them with a given threshold.
}
\usage{
sim_sod(n, design = c("D1", "D2", "D3", "D4", "D5", "D6"), delta = 0.05, t = NULL)
}
\arguments{
\item{n}{Number of curves.}
\item{design}{One of \code{"D1"}, ..., \code{"D6"}; see \code{\link{design_truth}}.}
\item{delta}{Threshold \eqn{\delta > 0}{delta > 0}.}
\item{t}{Optional evaluation times; when given, the latent curves on
\code{t} are returned as well.}
}
\details{
The simulations of the paper use \eqn{n = 100}, 300 and 900 curves and the
thresholds \eqn{\delta = 0.10}{delta = 0.10}, 0.05 and 0.025; losses are
computed on \eqn{[0.1, 0.9]}. The function combines
\code{\link{sim_coefficients}}, \code{\link{sim_records}} and
\code{\link{sim_curves}}.
}
\value{
A list with the \code{records}, the \code{coefficients}, the population
quantities \code{truth} (see \code{\link{design_truth}}), the \code{design},
the threshold \code{delta} and, when \code{t} is given, the matrix
\code{curves} of latent curves.
}
\seealso{
\code{\link{design_truth}}, \code{\link{sod_fpca}}, \code{\link{sod_band}}
}
\examples{
\dontrun{
## one replication of experiment E1 for design D1, n = 300, delta = 0.05
set.seed(2026)
grid <- seq(0.1, 0.9, length.out = 201)
sim <- sim_sod(n = 300, design = "D1", delta = 0.05, t = grid)
fits <- list(held = sod_fpca(sim$records, method = "held"),
             chord = sod_fpca(sim$records, method = "chord"),
             midpoint = sod_fpca(sim$records, method = "midpoint", L = sim$truth$L))
ise <- function(m) 0.8 * mean((m - sim$truth$mean(grid))^2)
c(sapply(fits, function(f) ise(sod_mean(f, grid))), oracle = ise(colMeans(sim$curves)))
}
}
