\name{sim_coefficients}
\alias{sim_coefficients}
\title{Random Coefficients of Simulated Curves}
\description{
Draws the random coefficients that define the latent curves of a simulation
design.
}
\usage{
sim_coefficients(n, design = c("D1", "D2", "D3", "D4", "D5", "D6"))
}
\arguments{
\item{n}{Number of curves.}
\item{design}{One of \code{"D1"}, ..., \code{"D6"}; see \code{\link{design_truth}}.}
}
\details{
The columns are \eqn{(Z, A, R)} for D1, \eqn{Z} for D2,
\eqn{(a_0, a_1, a_2)}{(a0, a1, a2)} for D3,
\eqn{(\xi_1, \xi_2, \xi_3)}{(xi1, xi2, xi3)} for D4, \eqn{(A, B)} for D5 and
\eqn{(A_1, B_1, A_2, B_2)}{(A1, B1, A2, B2)} for D6. Separating the draw of
the coefficients from the recording lets several thresholds be compared on
the same curves, as in the paper.
}
\value{
A matrix with one row per curve and named columns.
}
\seealso{
\code{\link{sim_records}}, \code{\link{sim_curves}}, \code{\link{sim_sod}}
}
\examples{
\dontrun{
set.seed(2026)
cf <- sim_coefficients(n = 300, design = "D4")
head(cf)
apply(cf, 2, var)
}
}
