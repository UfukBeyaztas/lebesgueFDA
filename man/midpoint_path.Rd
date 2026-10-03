\name{midpoint_path}
\alias{midpoint_path}
\title{Midpoint Path of a Record}
\description{
Returns the average of the two envelopes of a record under a Lipschitz bound.
}
\usage{
midpoint_path(record, L)
}
\arguments{
\item{record}{An object of class \code{"sod_record"}, compatible with \code{L}.}
\item{L}{Bound on the Lipschitz constant.}
}
\details{
The midpoint path \eqn{M_o = (\ell_o + u_o)/2}{M = (l + u)/2} produces the
record itself and satisfies
\eqn{\sup_t |M_o(t) - x(t)| \le \sup_t w_o(t)/2 \le \delta}{sup |M(t) - x(t)| <= sup w(t)/2 <= delta}
for every path \eqn{x} compatible with the record (Theorem 4.13(v)). Since the
envelopes are themselves compatible, no path does better, so the midpoint is
a Chebyshev center of the compatible paths in the uniform norm. Averages of
midpoint paths estimate the center of the identified set of mean functions
(Theorem 4.17).
}
\value{
An object of class \code{"sod_path"}.
}
\seealso{
\code{\link{sod_envelopes}}, \code{\link{sod_midpoint_risk}}
}
\examples{
\dontrun{
## the record of Figure 1: the midpoint path reproduces the record
rec <- sim_records(cbind(a0 = 0.2, a1 = 0.5, a2 = 0.5), "D3", delta = 0.1)[[1]]
m <- midpoint_path(rec, L = 2 + pi / 2)
knots <- sort(unique(c(seq(0, 1, length.out = 1001), m$breaks)))
again <- sod_encode(knots, path_eval(m, knots), delta = 0.1)
all.equal(again$times, rec$times)
}
}
