\name{sod_record}
\alias{sod_record}
\alias{print.sod_record}
\title{Send-on-Delta Records}
\description{
Creates the send-on-delta record of a curve from its initial value, event
times and polarities.
}
\usage{
sod_record(initial, times = numeric(0), polarity = numeric(0), delta)

\method{print}{sod_record}(x, \dots)
}
\arguments{
\item{initial}{Initial value \eqn{x(0)}.}
\item{times}{Event times \eqn{0 < t_1 < \dots < t_m \le 1}{0 < t[1] < ... < t[m] <= 1}.}
\item{polarity}{Polarities, each equal to -1 or 1.}
\item{delta}{Threshold \eqn{\delta > 0}{delta > 0}.}
\item{x}{An object of class \code{"sod_record"}.}
\item{\dots}{Not used.}
}
\details{
The record of a continuous curve \eqn{x} is
\eqn{(x(0), m, t_1, \dots, t_m, p_1, \dots, p_m)}{(x(0), m, t[1], ..., t[m], p[1], ..., p[m])},
where \eqn{t_{k+1}}{t[k+1]} is the first time after \eqn{t_k}{t[k]} at which
\eqn{|x(t) - x(t_k)| \ge \delta}{|x(t) - x(t[k])| >= delta} and
\eqn{p_k = (v_k - v_{k-1})/\delta}{p[k] = (v[k] - v[k-1])/delta}. The
recorded values are
\eqn{v_k = v_0 + \delta(p_1 + \dots + p_k)}{v[k] = v[0] + delta (p[1] + ... + p[k])}
with \eqn{v_0 = x(0)}{v[0] = x(0)}. Between two events the curve stays in
the open band \eqn{|x(t) - v_k| < \delta}{|x(t) - v[k]| < delta}; this
silence is the second source of information in a record. The rule has a
hysteresis of width \eqn{2\delta}{2 delta}: a return of the curve to
\eqn{v_k}{v[k]} produces no event.

Records are usually produced by \code{\link{sod_encode}},
\code{\link{sod_encode_curve}} or \code{\link{sim_sod}}.
}
\value{
An object of class \code{"sod_record"}: a list with components
\code{initial}, \code{times}, \code{polarity} and \code{delta}.
}
\seealso{
\code{\link{sod_readings}}, \code{\link{held_path}}, \code{\link{sod_encode}}
}
\examples{
\dontrun{
## a record built by hand
rec <- sod_record(0.2, times = c(0.1, 0.3, 0.7), polarity = c(1, 1, -1), delta = 0.1)
rec
sod_readings(rec)

## the record of Figure 1 of the paper: design D3 with a0 = 0.2, a1 = 0.5
## and a2 = 0.5, recorded with delta = 0.1
rec <- sim_records(cbind(a0 = 0.2, a1 = 0.5, a2 = 0.5), "D3", delta = 0.1)[[1]]
rec
}
}
