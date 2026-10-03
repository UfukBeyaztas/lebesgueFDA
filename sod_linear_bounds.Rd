\name{sod_linear_bounds}
\alias{sod_linear_bounds}
\title{Bounds for a Nonnegative Linear Functional of the Mean}
\description{
Estimates the endpoints of the identified interval of
\eqn{\int_0^1 \psi(t)\mu(t)\,dt}{the integral of psi(t) mu(t)} for a
nonnegative weight function \eqn{\psi}{psi}.
}
\usage{
sod_linear_bounds(band, weight)
}
\arguments{
\item{band}{An object of class \code{"sod_band"}.}
\item{weight}{A nonnegative object of class \code{"sod_path"}, for instance
from \code{\link{path_linear}}.}
}
\details{
For nonnegative \eqn{\psi}{psi}, the identified set of
\eqn{\int\psi\mu}{the integral of psi mu} contains the open interval between
\eqn{E\int\psi\ell_O}{E integral of psi l} and \eqn{E\int\psi u_O}{E integral of psi u}
and is contained in its closure (Theorem 4.13(iii)). The function replaces
the expectations by averages over the records, using the mean envelopes of
the band. The results are estimated identification bounds, not confidence
limits.
}
\value{
A named vector with the \code{lower} and the \code{upper} bound.
}
\seealso{
\code{\link{sod_band}}
}
\examples{
\dontrun{
## the integral of the mean in design D3, whose true value is 1/2
set.seed(2026)
sim <- sim_sod(n = 300, design = "D3", delta = 0.05)
band <- sod_band(sim$records, B = sim$truth$B, L = sim$truth$L)
sod_linear_bounds(band, path_linear(c(0, 1), c(1, 1)))
## a weight that increases linearly over [0, 1]
sod_linear_bounds(band, path_linear(c(0, 1), c(0, 2)))
}
}
