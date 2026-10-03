d6_template <- function(t) {
  cbind(sqrt(0.4) * cos(t), sqrt(0.4) * sin(t), sqrt(0.6) * cos(3 * t), sqrt(0.6) * sin(3 * t))
}