\name{sod_encode_curve}
\alias{sod_encode_curve}
\title{Send-on-Delta Record of a Curve with Known Turning Points}
\description{
Computes the record of a curve that is monotone between known turning points;
the event times are located by bisection.
}
\usage{
sod_encode_curve(curve, turning, delta, tol = 1e-13)
}
\arguments{
\item{curve}{A vectorized function on \eqn{[0, 1]}.}
\item{turning}{Increasing vector of turning points, starting at 0 and ending
at 1. It must contain every point at which the curve changes direction.}
\item{delta}{Threshold \eqn{\delta > 0}{delta > 0}.}
\item{tol}{Tolerance of the bisection, in time.}
}
\details{
On a monotone piece the curve crosses the levels
\eqn{v + \delta, v + 2\delta, \dots}{v + delta, v + 2 delta, ...} (or the
corresponding decreasing levels) in order, where \eqn{v} is the value held
at the start of the piece. All crossings of a piece are found together by
bisection to the tolerance \code{tol}, and a level reached at the end of a
piece is recorded there. Turning points are not inferred from the curve.
Designs D3 and D4 of the paper are recorded in this way, with turning points
computed analytically.
}
\value{
An object of class \code{"sod_record"}.
}
\seealso{
\code{\link{sod_encode}}, \code{\link{sim_records}}
}
\examples{
\dontrun{
## the curve of Figure 1: X(t) = 0.2 + 0.5 t + 0.5 sin(pi t), from design D3,
## which turns at t = acos(-1/pi)/pi
f <- function(t) 0.2 + 0.5 * t + 0.5 * sin(pi * t)
rec <- sod_encode_curve(f, turning = c(0, acos(-1 / pi) / pi, 1), delta = 0.1)
rec
sod_readings(rec)
}
}
