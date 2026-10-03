\name{sod_envelopes}
\alias{sod_envelopes}
\title{Envelopes of the Paths Compatible with a Record}
\description{
Under a known Lipschitz bound, computes the pointwise smallest and largest
values of the paths that produce a record, their midpoint and their distance.
}
\usage{
sod_envelopes(record, L)
}
\arguments{
\item{record}{An object of class \code{"sod_record"}, compatible with
\code{L} (see \code{\link{sod_compatible}}).}
\item{L}{Bound on the Lipschitz constant.}
}
\details{
For \eqn{t} between two events \eqn{t_k}{t[k]} and \eqn{t_{k+1}}{t[k+1]},
\deqn{\ell_o(t) = \max[v_k - \delta,\; v_k - L(t - t_k),\; v_{k+1} - L(t_{k+1} - t)],}{l(t) = max(v[k] - delta, v[k] - L (t - t[k]), v[k+1] - L (t[k+1] - t)),}
\deqn{u_o(t) = \min[v_k + \delta,\; v_k + L(t - t_k),\; v_{k+1} + L(t_{k+1} - t)],}{u(t) = min(v[k] + delta, v[k] + L (t - t[k]), v[k+1] + L (t[k+1] - t)),}
and after the last event the third terms are dropped. These are the extremal
\eqn{L}-Lipschitz functions through the recorded values (McShane extensions),
truncated by the silence bands. By Theorem 4.13, \eqn{\ell_o(t)}{l(t)} and
\eqn{u_o(t)}{u(t)} are the infimum and the supremum of \eqn{x(t)} over the
\eqn{L}-Lipschitz paths \eqn{x} that produce the record. The width
\eqn{w_o = u_o - \ell_o}{w = u - l} is at most \eqn{2\delta}{2 delta}, and
its integral is given in closed form by \code{\link{sod_width}}. All
intersections of the affine pieces are breakpoints, so the envelopes are
exact.
}
\value{
A list with the paths \code{lower}, \code{upper}, \code{midpoint} and
\code{width} (objects of class \code{"sod_path"}) and the number
\code{integrated_width}.
}
\seealso{
\code{\link{midpoint_path}}, \code{\link{sod_width}}, \code{\link{sod_band}}
}
\examples{
\dontrun{
## Figure 1(b) of the paper: design D3 with a0 = 0.2, a1 = 0.5 and a2 = 0.5,
## threshold 0.1 and Lipschitz bound 2 + pi/2
rec <- sim_records(cbind(a0 = 0.2, a1 = 0.5, a2 = 0.5), "D3", delta = 0.1)[[1]]
env <- sod_envelopes(rec, L = 2 + pi / 2)
env$integrated_width                             # 0.1290
grid <- seq(0, 1, length.out = 1001)
low <- path_eval(env$lower, grid)
up <- path_eval(env$upper, grid)
plot(grid, up, type = "l", ylim = range(low, up), xlab = "t", ylab = "")
lines(grid, low)
lines(grid, path_eval(env$midpoint, grid), lty = 2, col = 2)
lines(grid, 0.2 + 0.5 * grid + 0.5 * sin(pi * grid), col = 4)
}
}
