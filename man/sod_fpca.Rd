\name{sod_fpca}
\alias{sod_fpca}
\alias{print.sod_fpca}
\title{Mean, Covariance and Principal Components from Send-on-Delta Records}
\description{
Estimates the mean function, the covariance function and the functional
principal components from send-on-delta records, through the held, chord or
midpoint reconstructions and an exact Gram matrix.
}
\usage{
sod_fpca(records, method = c("held", "chord", "midpoint"), L = NULL,
         npc = NULL, fve = 0.99, tol = 1e-10)

\method{print}{sod_fpca}(x, \dots)
}
\arguments{
\item{records}{A list of \code{"sod_record"} objects with a common threshold.}
\item{method}{Reconstruction: \code{"held"}, \code{"chord"} or \code{"midpoint"}.}
\item{L}{Bound on the Lipschitz constant; needed for \code{"midpoint"}.}
\item{npc}{Number of components; if \code{NULL}, chosen by \code{fve}.}
\item{fve}{Fraction of variance explained, used when \code{npc} is \code{NULL}.}
\item{tol}{Eigenvalues below \code{tol} times the largest are treated as zero.}
\item{x}{An object of class \code{"sod_fpca"}.}
\item{\dots}{Not used.}
}
\details{
Each record \eqn{O_i} is reconstructed by a path \eqn{Y_i}, and
\deqn{\hat\mu = \frac{1}{n}\sum_{i=1}^n Y_i, \qquad \hat C = \frac{1}{n}\sum_{i=1}^n (Y_i - \hat\mu)\otimes(Y_i - \hat\mu).}{mu.hat = (1/n) sum Y[i],   C.hat = (1/n) sum (Y[i] - mu.hat) x (Y[i] - mu.hat).}
The positive eigenvalues of \eqn{\hat C}{C.hat} coincide with those of the
Gram matrix \eqn{G = (n^{-1}\langle Z_i, Z_j\rangle)}{G = (<Z[i], Z[j]>/n)} of
the centered paths \eqn{Z_i = Y_i - \hat\mu}{Z[i] = Y[i] - mu.hat}. An
eigenvector \eqn{v} of \eqn{G} with eigenvalue \eqn{\lambda}{lambda} gives
the eigenfunction
\eqn{(n\lambda)^{-1/2}\sum_i v_i Z_i}{sum(v[i] Z[i])/sqrt(n lambda)} and the
scores \eqn{(n\lambda)^{1/2} v_i}{sqrt(n lambda) v[i]} (Proposition 3.1). The
paths are piecewise affine, so \eqn{G} is computed exactly and no quadrature
error enters.

The held path is within \eqn{\delta}{delta} of the curve and the chord path
within \eqn{2\delta}{2 delta}, for any continuous curve. If
\eqn{E\|X\|^2 \le M}{E||X||^2 <= M}, the held mean satisfies
\eqn{E\|\hat\mu - \mu\|^2 \le 2\delta^2 + 2M/n}{E||mu.hat - mu||^2 <= 2 delta^2 + 2M/n},
and the covariance has expected squared Hilbert--Schmidt error of order
\eqn{n^{-1} + \delta^2}{1/n + delta^2}; no estimator does better uniformly
(Theorem 4.18). If \eqn{\delta = o(n^{-1/2})}{delta = o(n^(-1/2))}, the
estimators are asymptotically equivalent to those computed from fully
observed curves (Theorem 4.20). Chord estimators satisfy the same bounds with
\eqn{2\delta}{2 delta} in place of \eqn{\delta}{delta} and are more accurate
for smooth curves. The midpoint estimator of the mean has worst-case risk
\eqn{\rho^2 + \sigma_M^2/n}{rho^2 + sigma_M^2/n} over the laws that produce
the same record law (Theorem 4.17; see \code{\link{sod_midpoint_risk}}).

Smoothing the pooled recorded values instead would estimate
\eqn{\mu_{ev}(t) = E[X(t)|X'(t)|]/E|X'(t)|}{mu_ev(t) = E[X(t)|X'(t)|]/E|X'(t)|}
(Theorem 4.3), which differs from the mean whenever level and speed are
correlated.
}
\value{
An object of class \code{"sod_fpca"}: a list with the mean path \code{mean},
the retained \code{eigenvalues}, all positive eigenvalues \code{values}, the
\code{eigenfunctions} (a list of paths), the matrix of \code{scores}, the
number of components \code{npc}, the fraction of variance explained
\code{fve}, the Gram matrix \code{gram}, the reconstructed \code{paths}, the
number of events of each record \code{events}, and the settings
\code{method}, \code{delta} and \code{L}. The covariance returned by
\code{\link{sod_cov}} is the full sample covariance, not its truncated
expansion.
}
\seealso{
\code{\link{sod_mean}}, \code{\link{sod_cov}}, \code{\link{sod_eigenfunctions}},
\code{\link{predict.sod_fpca}}
}
\examples{
\dontrun{
## design D4 with n = 300 and delta = 0.05 (experiment E1)
set.seed(2026)
sim <- sim_sod(n = 300, design = "D4", delta = 0.05)
fit <- sod_fpca(sim$records, method = "held", npc = 3)
fit
## integrated squared errors on [0.1, 0.9], as in the paper
grid <- seq(0.1, 0.9, length.out = 201)
0.8 * mean((sod_mean(fit, grid) - sim$truth$mean(grid))^2)
0.64 * mean((sod_cov(fit, grid) - sim$truth$covariance(grid))^2)

## midpoint estimator for the bounded design D3 with its valid bound
sim3 <- sim_sod(n = 300, design = "D3", delta = 0.05)
fit3 <- sod_fpca(sim3$records, method = "midpoint", L = sim3$truth$L)
fit3$eigenvalues
}
}
