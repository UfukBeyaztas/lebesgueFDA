\name{path_eval}
\alias{path_eval}
\title{Evaluate a Path}
\description{
Evaluates a reconstruction, an estimated mean, an estimated eigenfunction or
any other object of class \code{"sod_path"}.
}
\usage{
path_eval(path, t)
}
\arguments{
\item{path}{An object of class \code{"sod_path"}.}
\item{t}{Evaluation times in \eqn{[0, 1]}.}
}
\details{
Pieces are closed on the left, so held paths are right-continuous; the value
at \eqn{t = 1} is stored separately.
}
\value{
A numeric vector of values at \code{t}.
}
\seealso{
\code{\link{path_linear}}, \code{\link{held_path}}
}
\examples{
\dontrun{
rec <- sod_record(0, times = c(0.2, 0.5), polarity = c(1, -1), delta = 0.1)
path_eval(held_path(rec), seq(0, 1, by = 0.1))
path_eval(chord_path(rec), seq(0, 1, by = 0.1))
}
}
