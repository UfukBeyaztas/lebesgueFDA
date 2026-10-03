\name{sod_readings}
\alias{sod_readings}
\title{Readings of a Send-on-Delta Record}
\description{
Returns the reading times and the recorded values of a record: the initial
reading at time 0 and one reading per event.
}
\usage{
sod_readings(record)
}
\arguments{
\item{record}{An object of class \code{"sod_record"}.}
}
\value{
A data frame with columns \code{time} and \code{value}, where the values are
\eqn{v_k = v_0 + \delta(p_1 + \dots + p_k)}{v[k] = v[0] + delta (p[1] + ... + p[k])}.
}
\seealso{
\code{\link{sod_record}}
}
\examples{
\dontrun{
set.seed(2026)
sim <- sim_sod(n = 1, design = "D1", delta = 0.05)
sod_readings(sim$records[[1]])
}
}
