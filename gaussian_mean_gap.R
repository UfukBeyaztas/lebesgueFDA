gaussian_mean_gap <- function(mean_slope, variance_slope, sd_derivative) {
  z <- mean_slope / sd_derivative
  sg <- 2 * pnorm(z) - 1
  0.5 * variance_slope * sg / (2 * sd_derivative * dnorm(z) + mean_slope * sg)
}