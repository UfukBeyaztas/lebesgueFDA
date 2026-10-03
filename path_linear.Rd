\name{path_linear}
\alias{path_linear}
\title{Continuous Piecewise Linear Path}
\description{
Creates the piecewise linear path through given points, in the
representation used for reconstructions and estimates.
}
\usage{
path_linear(knots, values)
}
\arguments{
\item{knots}{Strictly increasing times, starting at 0 and ending at 1.}
\item{values}{Values at the knots.}
}
\details{
A path of class \code{"sod_path"} is a function on \eqn{[0, 1]} stored
through its breakpoints, the value at the left end and the slope of each
piece, and its value at 1. Reconstructions, estimated means and estimated
eigenfunctions are paths of this kind, and inner products between paths are
computed exactly by \code{\link{path_inner}}.
}
\value{
An object of class \code{"sod_path"}.
}
\seealso{
\code{\link{path_eval}}, \code{\link{path_inner}}
}
\examples{
\dontrun{
## a curve of design D6 is piecewise linear on 1001 points, so its integrated
## squared distance from the held path can be computed exactly
set.seed(2026)
grid <- seq(0, 1, length.out = 1001)
sim <- sim_sod(n = 1, design = "D6", delta = 0.05, t = grid)
curve <- path_linear(grid, sim$curves[1, ])
h <- held_path(sim$records[[1]])
path_inner(curve, curve) - 2 * path_inner(curve, h) + path_inner(h, h)
}
}
