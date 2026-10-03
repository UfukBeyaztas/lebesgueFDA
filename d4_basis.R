d4_basis <- function(t) {
  cbind(rep(1, length(t)), sqrt(2) * sin(2 * pi * t), sqrt(2) * cos(2 * pi * t))
}