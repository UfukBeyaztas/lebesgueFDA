sod_cov <- function(fit, s, t = s) {
  check_times(s)
  check_times(t)
  xs <- matrix(vapply(fit$paths, path_eval, numeric(length(s)), t = s), length(s))
  xt <- matrix(vapply(fit$paths, path_eval, numeric(length(t)), t = t), length(t))
  xs <- xs - sod_mean(fit, s)
  xt <- xt - sod_mean(fit, t)
  tcrossprod(xs, xt) / fit$n
}