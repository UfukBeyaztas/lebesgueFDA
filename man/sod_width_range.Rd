\name{sod_width_range}
\alias{sod_width_range}
\title{Attainable Range of the Integrated Width}
\description{
Computes the smallest and the largest integrated widths over all records with
a given number of events that are compatible with a Lipschitz bound.
}
\usage{
sod_width_range(m, delta, L)
}
\arguments{
\item{m}{Number of events, at most \eqn{L/\delta}{L/delta}.}
\item{delta}{Threshold \eqn{\delta > 0}{delta > 0}.}
\item{L}{Bound on the Lipschitz constant.}
}
\details{
Let \eqn{\Gamma = L/\delta}{Gamma = L/delta} and
\eqn{x = \Gamma - m}{x = Gamma - m} be the unused speed budget. By Theorem
4.15(iii), \eqn{W(o)} ranges exactly over
\eqn{[\delta^2\omega_{min}/L, \delta^2\omega_{max}/L]}{[delta^2 w.min/L, delta^2 w.max/L]}
with \eqn{\omega_{max} = \Omega(x + 1)}{w.max = Omega(x + 1)}, and
\eqn{\omega_{min}}{w.min} equal to \eqn{x^2} for \eqn{x \le 1/2}{x <= 1/2},
to \eqn{(\Gamma + m)^2/(4m + 1) - m}{(Gamma + m)^2/(4m + 1) - m} for
\eqn{1/2 \le x \le 2m + 1}{1/2 <= x <= 2m + 1}, and to
\eqn{2\Gamma - 3m - 1}{2 Gamma - 3m - 1} beyond. For
\eqn{0 < x \le 1/2}{0 < x <= 1/2} the ratio of the largest to the smallest
width is \eqn{(x + 4)/(4x)}, which is unbounded as \eqn{L/\delta}{L/delta}
decreases to \eqn{m}.
}
\value{
A named vector with the \code{minimum} and the \code{maximum}.
}
\seealso{
\code{\link{sod_width}}
}
\examples{
\dontrun{
## three events, delta = 0.1 and L = 0.35, as in Figure S1 of the paper
sod_width_range(m = 3, delta = 0.1, L = 0.35)    # 0.0071 and 0.0161
## the ratio of the largest to the smallest width as L/delta decreases to 3
x <- c(0.5, 0.25, 0.1, 0.05)
sapply(x, function(s) {
  r <- sod_width_range(m = 3, delta = 0.1, L = 0.1 * (3 + s))
  r[["maximum"]] / r[["minimum"]]
})
(x + 4) / (4 * x)
}
}
