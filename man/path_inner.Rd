\name{path_inner}
\alias{path_inner}
\title{Exact Inner Product of Two Paths}
\description{
Computes the integral of the product of two paths over an interval exactly.
}
\usage{
path_inner(f, g, lower = 0, upper = 1)
}
\arguments{
\item{f, g}{Objects of class \code{"sod_path"}.}
\item{lower, upper}{Limits of integration, with
\eqn{0 \le lower < upper \le 1}{0 <= lower < upper <= 1}.}
}
\details{
On a piece of length \eqn{d} on which both paths are affine, with midpoint
\eqn{m},
\deqn{\int f g = d\,f(m)g(m) + d^3 f'g'/12.}{integral of f g = d f(m) g(m) + d^3 f' g'/12.}
Summing over the merged breakpoints gives the integral without quadrature
error (Proposition 3.1(iii)).
}
\value{
A number.
}
\seealso{
\code{\link{path_linear}}, \code{\link{sod_fpca}}
}
\examples{
\dontrun{
p <- path_linear(c(0, 1), c(0, 1))
path_inner(p, p)
set.seed(2026)
sim <- sim_sod(n = 2, design = "D1", delta = 0.05)
path_inner(held_path(sim$records[[1]]), held_path(sim$records[[2]]), 0.1, 0.9)
}
}
