\name{chord_path}
\alias{chord_path}
\title{Chord Path of a Record}
\description{
Returns the linear interpolation of the readings of a record.
}
\usage{
chord_path(record)
}
\arguments{
\item{record}{An object of class \code{"sod_record"}.}
}
\details{
The chord path interpolates linearly between consecutive readings and keeps
the last recorded value after the last event. Between two events it lies
between \eqn{v_k}{v[k]} and \eqn{v_{k+1} = v_k \pm \delta}{v[k+1] = v[k] +/- delta},
while the curve stays within \eqn{\delta}{delta} of \eqn{v_k}{v[k]}, so
\eqn{\sup_t |q(t) - x(t)| \le 2\delta}{sup |q(t) - x(t)| <= 2 delta} for every
continuous curve. Chord averages therefore attain the minimax order
\eqn{n^{-1} + \delta^2}{1/n + delta^2}, like held-path averages. For a twice
differentiable curve whose speed is at least \eqn{s > 0} between two events,
the error there is at most
\eqn{\delta^2 \sup|x''|/(8s^2)}{delta^2 sup|x''|/(8 s^2)}, which explains the
accuracy of chord estimators for smooth curves.
}
\value{
An object of class \code{"sod_path"}: a continuous piecewise linear function.
}
\seealso{
\code{\link{held_path}}, \code{\link{midpoint_path}}, \code{\link{sod_fpca}}
}
\examples{
\dontrun{
## random lines of design D5: the chord path is exact up to the last event
set.seed(2026)
grid <- seq(0, 1, length.out = 501)
sim <- sim_sod(n = 1, design = "D5", delta = 0.05, t = grid)
rec <- sim$records[[1]]
error <- abs(path_eval(chord_path(rec), grid) - sim$curves[1, ])
max(error[grid <= max(c(0, rec$times))])
max(error)
}
}
