\name{sod_paths}
\alias{sod_paths}
\title{Reconstructed Paths of a Sample of Records}
\description{
Reconstructs every record of a sample by its held, chord or midpoint path.
}
\usage{
sod_paths(records, method = c("held", "chord", "midpoint"), L = NULL)
}
\arguments{
\item{records}{A list of \code{"sod_record"} objects with a common threshold.}
\item{method}{Reconstruction: \code{"held"}, \code{"chord"} or \code{"midpoint"}.}
\item{L}{Bound on the Lipschitz constant; needed for \code{"midpoint"}.}
}
\details{
See \code{\link{held_path}}, \code{\link{chord_path}} and
\code{\link{midpoint_path}} for the three reconstructions and their
guarantees.
}
\value{
A list of \code{"sod_path"} objects.
}
\seealso{
\code{\link{sod_reconstruct}}, \code{\link{sod_fpca}}
}
\examples{
\dontrun{
set.seed(2026)
sim <- sim_sod(n = 300, design = "D3", delta = 0.05)
held <- sod_paths(sim$records, method = "held")
mid <- sod_paths(sim$records, method = "midpoint", L = sim$truth$L)
path_eval(held[[1]], c(0.25, 0.5, 0.75))
path_eval(mid[[1]], c(0.25, 0.5, 0.75))
}
}
