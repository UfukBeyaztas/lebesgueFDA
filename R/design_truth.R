design_truth <- function(design = c("D1", "D2", "D3", "D4", "D5", "D6")) {
  design <- match.arg(design)
  lambda <- c(0.5, 0.3, 0.1)
  switch(design,
         D1 = list(design = design,
                   mean = function(t) (t + t^2) / 2,
                   covariance = function(s, t = s) {
                     1 / 75 + 13 / 24 * (outer(s, t) + outer(s^2, t^2)) -
                       outer((s + s^2) / 2, (t + t^2) / 2)
                   },
                   event_mean = function(t) 13 * (t + 2 * t^3) / (12 * (1 + 2 * t)),
                   B = 0.2, L = 3),
         D2 = list(design = design,
                   mean = function(t) 0.9 * t,
                   covariance = function(s, t = s) matrix(0.12, length(s), length(t)),
                   event_mean = function(t) 0.9 * t,
                   B = 0.6, L = 1.5),
         D3 = list(design = design,
                   mean = function(t) t,
                   covariance = function(s, t = s) {
                     1 / 12 + outer(s, t) / 3 + outer(sin(pi * s), sin(pi * t)) / 12
                   },
                   event_mean = NULL,
                   B = 0.5, L = 2 + pi / 2),
         D4 = list(design = design,
                   mean = function(t) 2 * t + 0.5 * sin(2 * pi * t),
                   covariance = function(s, t = s) {
                     tcrossprod(sweep(d4_basis(s), 2, sqrt(lambda), "*"),
                                sweep(d4_basis(t), 2, sqrt(lambda), "*"))
                   },
                   event_mean = function(t) {
                     2 * t + 0.5 * sin(2 * pi * t) +
                       gaussian_mean_gap(2 + pi * cos(2 * pi * t),
                                         0.8 * pi * sin(4 * pi * t),
                                         sqrt(8 * pi^2 * (0.3 * cos(2 * pi * t)^2 +
                                                            0.1 * sin(2 * pi * t)^2)))
                   },
                   B = Inf, L = Inf),
         D5 = list(design = design,
                   mean = function(t) t,
                   covariance = function(s, t = s) 0.25 + 0.16 * outer(s, t),
                   event_mean = function(t) t + gaussian_mean_gap(1, 0.32 * t, 0.4),
                   B = Inf, L = Inf),
         D6 = list(design = design,
                   mean = function(t) rep(0, length(t)),
                   covariance = function(s, t = s) tcrossprod(d6_basis(s), d6_basis(t)),
                   event_mean = function(t) rep(0, length(t)),
                   B = Inf, L = Inf))
}
