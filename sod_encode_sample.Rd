\name{sod_encode_sample}
\alias{sod_encode_sample}
\title{Send-on-Delta Records of Curves Observed on a Common Grid}
\description{
Applies \code{\link{sod_encode}} to each row of a matrix of curve values.
}
\usage{
sod_encode_sample(t, X, delta)
}
\arguments{
\item{t}{Strictly increasing grid of times, starting at 0 and ending at 1.}
\item{X}{Matrix of curve values, one row per curve and one column per time.}
\item{delta}{Threshold \eqn{\delta > 0}{delta > 0}.}
}
\details{
Each record is the exact record of the linear interpolant of a row of
\code{X}; see \code{\link{sod_encode}}.
}
\value{
A list of \code{"sod_record"} objects, one per row of \code{X}.
}
\seealso{
\code{\link{sod_encode}}, \code{\link{sim_records}}
}
\examples{
\dontrun{
## curves of design D6 are piecewise linear on 1001 points, so encoding them
## from the grid gives exactly the records produced by sim_records()
set.seed(2026)
knots <- seq(0, 1, length.out = 1001)
cf <- sim_coefficients(n = 100, design = "D6")
recs <- sod_encode_sample(knots, sim_curves(cf, "D6", knots), delta = 0.05)
same <- sim_records(cf, "D6", delta = 0.05)
all.equal(lapply(recs, function(r) r$times), lapply(same, function(r) r$times))
}
}
