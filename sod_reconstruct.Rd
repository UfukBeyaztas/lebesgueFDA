\name{sod_reconstruct}
\alias{sod_reconstruct}
\title{Reconstructed Curves Evaluated on a Grid}
\description{
Evaluates the held, chord or midpoint reconstructions of a sample of records
at given times.
}
\usage{
sod_reconstruct(records, t, method = c("held", "chord", "midpoint"), L = NULL)
}
\arguments{
\item{records}{A list of \code{"sod_record"} objects with a common threshold.}
\item{t}{Evaluation times in \eqn{[0, 1]}.}
\item{method}{Reconstruction: \code{"held"}, \code{"chord"} or \code{"midpoint"}.}
\item{L}{Bound on the Lipschitz constant; needed for \code{"midpoint"}.}
}
\value{
A matrix with one row per record and one column per time.
}
\seealso{
\code{\link{sod_paths}}
}
\examples{
\dontrun{
## the reconstruction errors of design D4 never exceed delta (held) and
## 2 delta (chord)
set.seed(2026)
grid <- seq(0, 1, length.out = 501)
sim <- sim_sod(n = 100, design = "D4", delta = 0.05, t = grid)
held <- sod_reconstruct(sim$records, grid, method = "held")
chord <- sod_reconstruct(sim$records, grid, method = "chord")
max(abs(held - sim$curves))
max(abs(chord - sim$curves))
}
}
