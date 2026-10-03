\name{sod_band}
\alias{sod_band}
\alias{print.sod_band}
\title{Simultaneous Band for the Identified Mean Function}
\description{
Computes a finite-sample simultaneous band for the identified mean function
under known bounds on the initial value and on the Lipschitz constant, with
the estimated identification width and Chebyshev radius.
}
\usage{
sod_band(records, B, L, alpha = 0.05, grid = seq(0, 1, length.out = 101))

\method{print}{sod_band}(x, \dots)
}
\arguments{
\item{records}{A list of \code{"sod_record"} objects with a common threshold.}
\item{B}{Bound on \eqn{|X(0)|}.}
\item{L}{Bound on the Lipschitz constant.}
\item{alpha}{Level; the coverage is at least \code{1 - alpha}.}
\item{grid}{Increasing grid from 0 to 1 used for the union bound.}
\item{x}{An object of class \code{"sod_band"}.}
\item{\dots}{Not used.}
}
\details{
Let \eqn{\bar\ell_n}{l.bar} and \eqn{\bar u_n}{u.bar} be the averages of the
envelopes of the \eqn{n} records (\code{\link{sod_envelopes}}), \eqn{N} the
number of grid points and \eqn{h_{max}}{h.max} the largest grid spacing. If
the curves are independent with \eqn{|X(0)| \le B}{|X(0)| <= B} and Lipschitz
constant at most \eqn{L}, then with probability at least
\eqn{1 - \alpha}{1 - alpha},
\deqn{\bar\ell_n(t) - r_n - L h_{max} \le E\ell_O(t) \le E u_O(t) \le \bar u_n(t) + r_n + L h_{max}}{l.bar(t) - r - L h.max <= E l(t) <= E u(t) <= u.bar(t) + r + L h.max}
for all \eqn{t} simultaneously, with
\eqn{r_n = (B + L)\sqrt{2\log(2N/\alpha)/n}}{r = (B + L) sqrt(2 log(2N/alpha)/n)}
(Theorem 4.21). At the grid points the term \eqn{L h_{max}}{L h.max} can be
dropped. The interval \eqn{[E\ell_O(t), E u_O(t)]}{[E l(t), E u(t)]} is the
identified interval of the mean: it contains the mean of every law that
produces the same record law. Its width is set by the threshold, the
Lipschitz bound and the timing of the events and is at most
\eqn{2\delta}{2 delta}, but it does not shrink as \eqn{n} grows, so the band
is conservative. The bounds \eqn{B} and \eqn{L} must come from outside the
data: records can contradict bounds that are too small but cannot confirm
them.
}
\value{
An object of class \code{"sod_band"}: a list with the band on the grid
(\code{lower}, \code{upper}), the band as paths valid for all times
(\code{lower_path}, \code{upper_path}), the narrower band valid at the grid
points (\code{lower_grid}, \code{upper_grid}), the mean envelopes
\code{mean_lower} and \code{mean_upper}, their midpoint \code{center}, the
estimated Chebyshev \code{radius} of the identified set, the mean integrated
\code{width} with a \code{1 - alpha} interval \code{width_interval}
(Theorem 4.15(v)), the widths of the records \code{record_widths}, the
margins \code{sampling_margin} and \code{mesh_margin}, and the settings.
}
\seealso{
\code{\link{sod_envelopes}}, \code{\link{sod_midpoint_risk}},
\code{\link{sod_linear_bounds}}
}
\examples{
\dontrun{
## design D3 with n = 300, delta = 0.025 and a grid of 201 points (experiment E3)
set.seed(2026)
sim <- sim_sod(n = 300, design = "D3", delta = 0.025)
grid <- seq(0, 1, length.out = 201)
band <- sod_band(sim$records, B = sim$truth$B, L = sim$truth$L, grid = grid)
band
all(band$lower <= sim$truth$mean(grid) & sim$truth$mean(grid) <= band$upper)
plot(grid, band$upper, type = "l", ylim = range(band$lower, band$upper),
     xlab = "t", ylab = "")
lines(grid, band$lower)
lines(grid, sim$truth$mean(grid), lty = 2)
## identification widths for assumed bounds of 1, 1.5 and 2 times the valid bound
sapply(c(1, 1.5, 2), function(k)
  sod_band(sim$records, B = sim$truth$B, L = k * sim$truth$L, grid = grid)$width)
}
}
