\name{sod_width}
\alias{sod_width}
\title{Integrated Identification Width of a Record}
\description{
Computes the integral of the distance between the envelopes of a record in
closed form.
}
\usage{
sod_width(record, L)
}
\arguments{
\item{record}{An object of class \code{"sod_record"}, compatible with \code{L}.}
\item{L}{Bound on the Lipschitz constant.}
}
\details{
With normalized durations
\eqn{D_k = L(t_k - t_{k-1})/\delta \ge 1}{D[k] = L (t[k] - t[k-1])/delta >= 1}
between events and \eqn{D_* = L(1 - t_m)/\delta}{D* = L (1 - t[m])/delta}
after the last event,
\deqn{W(o) = \frac{\delta^2}{L}\Big(\sum_{k=1}^m \Omega(D_k) + \Omega_*(D_*)\Big),}{W(o) = (delta^2/L) (sum Omega(D[k]) + Omega*(D*)),}
where \eqn{\Omega(D) = (D - 1)(D + 3)/4}{Omega(D) = (D - 1)(D + 3)/4} for
\eqn{D \le 3}{D <= 3} and \eqn{2D - 3} otherwise, and
\eqn{\Omega_*(D) = D^2}{Omega*(D) = D^2} for \eqn{D \le 1}{D <= 1} and
\eqn{2D - 1} otherwise (Theorem 4.15). The expected width \eqn{E W(O)} is the
length of the identified interval of \eqn{\int_0^1 \mu(t)\,dt}{the integral of mu}.
The width depends on where the events fall as well as on how many there are:
unused speed budget widens the envelopes more between two events than after
the last event.
}
\value{
A number.
}
\seealso{
\code{\link{sod_width_range}}, \code{\link{sod_envelopes}}
}
\examples{
\dontrun{
## mean identification width in design D1 at the three thresholds of the
## paper, with n = 300 and the valid bound L = 3 (experiment E3)
set.seed(2026)
cf <- sim_coefficients(300, "D1")
L <- design_truth("D1")$L
sapply(c(0.10, 0.05, 0.025), function(delta)
  mean(sapply(sim_records(cf, "D1", delta), sod_width, L = L)))
}
}
