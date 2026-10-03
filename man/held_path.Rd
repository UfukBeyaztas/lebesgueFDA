\name{held_path}
\alias{held_path}
\title{Held Path of a Record}
\description{
Returns the last-value reconstruction of a record.
}
\usage{
held_path(record)
}
\arguments{
\item{record}{An object of class \code{"sod_record"}.}
}
\details{
The held path is \eqn{H(t) = v_k}{H(t) = v[k]} for
\eqn{t_k \le t < t_{k+1}}{t[k] <= t < t[k+1]}, with \eqn{t_0 = 0}{t[0] = 0}.
It depends on the curve only through the record and satisfies
\eqn{\sup_t |H(t) - x(t)| \le \delta}{sup |H(t) - x(t)| <= delta} for every
continuous curve \eqn{x} that produces the record (Lemma 4.1(a)). Integrals
against the held path weight each recorded value by the time during which it
remains current, which is why held-path averages estimate the mean, whereas
pooling the readings weights them by the variation of the curve. It is the
only reconstruction available in real time.
}
\value{
An object of class \code{"sod_path"}: a right-continuous step function.
}
\seealso{
\code{\link{chord_path}}, \code{\link{midpoint_path}}, \code{\link{sod_fpca}}
}
\examples{
\dontrun{
## a curve of design D1 recorded with delta = 0.05
set.seed(2026)
grid <- seq(0, 1, length.out = 501)
sim <- sim_sod(n = 1, design = "D1", delta = 0.05, t = grid)
h <- held_path(sim$records[[1]])
max(abs(path_eval(h, grid) - sim$curves[1, ]))   # at most delta
plot(grid, sim$curves[1, ], type = "l", xlab = "t", ylab = "")
lines(grid, path_eval(h, grid), type = "s", col = 2)
}
}
