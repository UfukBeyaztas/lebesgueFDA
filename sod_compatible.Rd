\name{sod_compatible}
\alias{sod_compatible}
\title{Compatibility of a Record with Lipschitz and Initial-Value Bounds}
\description{
Checks whether a record could have been produced by a curve whose Lipschitz
constant is at most \code{L} and whose initial value is at most \code{B} in
absolute value.
}
\usage{
sod_compatible(record, L, B = NULL)
}
\arguments{
\item{record}{An object of class \code{"sod_record"}.}
\item{L}{Bound on the Lipschitz constant.}
\item{B}{Bound on \eqn{|x(0)|}, or \code{NULL} to check \code{L} only.}
}
\details{
A curve with Lipschitz constant at most \eqn{L} needs a time of at least
\eqn{\delta/L}{delta/L} to move by \eqn{\delta}{delta}, so its record
satisfies \eqn{\delta \le L(t_k - t_{k-1})}{delta <= L (t[k] - t[k-1])} for
every event (Theorem 4.13(i)). A record that violates this inequality, or has
\eqn{|x(0)| > B}{|x(0)| > B}, shows that the bounds are too small; a
compatible record cannot confirm that they hold.
}
\value{
\code{TRUE} or \code{FALSE}.
}
\seealso{
\code{\link{sod_envelopes}}, \code{\link{sod_band}}
}
\examples{
\dontrun{
## design D3 has the valid bounds B = 0.5 and L = 2 + pi/2
set.seed(2026)
sim <- sim_sod(n = 300, design = "D3", delta = 0.05)
all(sapply(sim$records, sod_compatible, L = sim$truth$L, B = sim$truth$B))
## half the bound is contradicted by some records
mean(sapply(sim$records, sod_compatible, L = sim$truth$L / 2))
}
}
