\name{sod_encode}
\alias{sod_encode}
\title{Exact Send-on-Delta Record of a Piecewise Linear Curve}
\description{
Computes the send-on-delta record of the linear interpolant of a curve given
on a grid, without approximation (Algorithm S1 of the paper).
}
\usage{
sod_encode(t, x, delta)
}
\arguments{
\item{t}{Strictly increasing grid of times, starting at 0 and ending at 1.}
\item{x}{Values of the curve at \code{t}.}
\item{delta}{Threshold \eqn{\delta > 0}{delta > 0}.}
}
\details{
On each grid segment the linear interpolant is monotone, so its events are
the successive times at which it reaches the stored value plus or minus
\eqn{\delta}{delta}, and each time solves a linear equation. The record is
computed in \eqn{O(G + m)} operations for \eqn{G} segments and \eqn{m}
events. It is the record of the interpolant: for an unknown signal, an
excursion of height \eqn{\delta}{delta} completed between two grid points is
not seen. The function records design D6, whose curves are piecewise linear
by construction.
}
\value{
An object of class \code{"sod_record"}.
}
\seealso{
\code{\link{sod_encode_sample}}, \code{\link{sod_encode_curve}},
\code{\link{sod_record}}
}
\examples{
\dontrun{
## a curve of design D6: the linear interpolant on 1001 points of a smooth
## stationary Gaussian template
set.seed(2026)
knots <- seq(0, 1, length.out = 1001)
a <- rnorm(4)
x <- sqrt(0.4) * (a[1] * cos(knots) + a[2] * sin(knots)) +
  sqrt(0.6) * (a[3] * cos(3 * knots) + a[4] * sin(3 * knots))
rec <- sod_encode(knots, x, delta = 0.05)
rec
## the held path stays within delta of the curve
max(abs(path_eval(held_path(rec), knots) - x))
plot(knots, x, type = "l", xlab = "t", ylab = "")
lines(knots, path_eval(held_path(rec), knots), type = "s", col = 2)
}
}
