\name{sod_eigenfunctions}
\alias{sod_eigenfunctions}
\title{Estimated Eigenfunctions}
\description{
Evaluates the eigenfunctions estimated by \code{\link{sod_fpca}}.
}
\usage{
sod_eigenfunctions(fit, t)
}
\arguments{
\item{fit}{An object of class \code{"sod_fpca"}.}
\item{t}{Evaluation times in \eqn{[0, 1]}.}
}
\details{
The eigenfunctions are exact linear combinations of the centered
reconstructed paths. The sign of each is chosen so that its largest value in
absolute terms is positive. For a positive and simple eigenvalue
\eqn{\lambda_j}{lambda[j]} with spectral gap \eqn{g_j}{g[j]},
\eqn{\|\hat\phi_j - \phi_j\| \le 2^{3/2}\|\hat C - C\|_{HS}/g_j}{||phi.hat[j] - phi[j]|| <= 2^(3/2) ||C.hat - C||/g[j]},
after aligning signs (Corollary 4.19).
}
\value{
A matrix with one row per time and one column per retained component.
}
\seealso{
\code{\link{sod_fpca}}
}
\examples{
\dontrun{
## design D4, whose eigenfunctions are 1, sqrt(2) sin(2 pi t) and
## sqrt(2) cos(2 pi t), with eigenvalues 0.5, 0.3 and 0.1
set.seed(2026)
sim <- sim_sod(n = 300, design = "D4", delta = 0.05)
fit <- sod_fpca(sim$records, method = "chord", npc = 3)
fit$eigenvalues
grid <- seq(0, 1, length.out = 201)
phi <- sod_eigenfunctions(fit, grid)
truth <- cbind(1, sqrt(2) * sin(2 * pi * grid), sqrt(2) * cos(2 * pi * grid))
matplot(grid, phi, type = "l", lty = 1, xlab = "t", ylab = "eigenfunctions")
matlines(grid, truth, lty = 2)
}
}
