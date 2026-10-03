\name{lebesgueFDA-package}
\alias{lebesgueFDA-package}
\alias{lebesgueFDA}
\docType{package}
\title{Functional Data Analysis under Send-on-Delta Sampling}
\description{
Estimation and identification for samples of curves recorded by send-on-delta
(Lebesgue) sampling: a curve is stored only when it has moved a fixed distance
\eqn{\delta}{delta} from its last stored value, so the observation times are
first-exit times of the curve itself.
}
\details{
For a continuous curve \eqn{x} on \eqn{[0, 1]} the event times are
\eqn{\tau_0 = 0}{tau[0] = 0} and
\deqn{\tau_{k+1} = \inf\,[\, t > \tau_k : |x(t) - x(\tau_k)| \ge \delta \,],}{tau[k+1] = inf[ t > tau[k] : |x(t) - x(tau[k])| >= delta ],}
and the record consists of \eqn{x(0)}, the event times and the directions of
the moves (\code{\link{sod_record}}). A record carries information in two
forms: the events fix the curve at the event times, and the silences confine
it to a band of half-width \eqn{\delta}{delta} around the last recorded value.

Smoothing the pooled recorded values of many curves, as is
usual for sparse functional data, estimates the variation-weighted function
\eqn{\mu_{ev}(t) = E[X(t)|X'(t)|]/E|X'(t)|}{mu_ev(t) = E[X(t)|X'(t)|]/E|X'(t)|}
rather than the mean. The gap equals
\eqn{\mathrm{Cov}(X(t), |X'(t)|)/E|X'(t)|}{Cov(X(t), |X'(t)|)/E|X'(t)|} and does
not shrink as \eqn{\delta \to 0}{delta -> 0}, so the package does not pool.

Averages of the held, chord or midpoint reconstructions
(\code{\link{held_path}}, \code{\link{chord_path}}, \code{\link{midpoint_path}})
estimate the mean and the covariance with expected squared error of order
\eqn{n^{-1} + \delta^2}{1/n + delta^2}, which is minimax. Principal
components are computed exactly from an \eqn{n \times n}{n x n} Gram matrix
(\code{\link{sod_fpca}}).

At a fixed threshold the mean is not identified. Under
a known Lipschitz bound \eqn{L} and a bound \eqn{B} on \eqn{|X(0)|}, the paths
compatible with a record lie between sharp envelopes
(\code{\link{sod_envelopes}}) whose integrated width has a closed form
(\code{\link{sod_width}}). The identified set of mean functions has an
explicit Chebyshev center and radius (\code{\link{sod_midpoint_risk}}), and
\code{\link{sod_band}} gives finite-sample simultaneous bands.

\code{\link{sim_sod}} and its building blocks generate the
six designs of the paper; \code{\link{design_truth}} gives their population
quantities.
}
\keyword{package}
