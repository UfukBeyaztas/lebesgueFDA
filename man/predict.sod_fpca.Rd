\name{predict.sod_fpca}
\alias{predict.sod_fpca}
\title{Scores and Reconstructions of New Records}
\description{
Projects new records on the mean and the eigenfunctions estimated by
\code{\link{sod_fpca}}.
}
\usage{
\method{predict}{sod_fpca}(object, newdata, npc = object$npc, t = NULL, \dots)
}
\arguments{
\item{object}{An object of class \code{"sod_fpca"}.}
\item{newdata}{A list of \code{"sod_record"} objects recorded with the
training threshold.}
\item{npc}{Number of components used, at most \code{object$npc}.}
\item{t}{Optional evaluation times in \eqn{[0, 1]} for the fitted curves.}
\item{\dots}{Not used.}
}
\details{
Each new record is reconstructed with the training method, giving a path
\eqn{Y}. Its scores are
\eqn{\hat\xi_j = \langle Y - \hat\mu, \hat\phi_j\rangle}{xi[j] = <Y - mu.hat, phi.hat[j]>},
computed exactly, and the fitted curve is
\eqn{\hat\mu + \sum_{j \le K}\hat\xi_j\hat\phi_j}{mu.hat + sum xi[j] phi.hat[j]}.
}
\value{
A list with the matrix \code{scores}, the fitted curves as a list of paths
\code{paths} and, when \code{t} is given, their values \code{values}, with
one row per record.
}
\seealso{
\code{\link{sod_fpca}}
}
\examples{
\dontrun{
## 150 test curves, as in experiment E1 of the paper
set.seed(2026)
grid <- seq(0.1, 0.9, length.out = 201)
train <- sim_sod(n = 300, design = "D4", delta = 0.05)
test <- sim_sod(n = 150, design = "D4", delta = 0.05, t = grid)
fit <- sod_fpca(train$records, method = "chord")
pred <- predict(fit, test$records, t = grid)
head(pred$scores)
## mean integrated squared reconstruction error on [0.1, 0.9]
mean(0.8 * rowMeans((pred$values - test$curves)^2))
}
}
