sod_fpca <- function(records, method = c("held", "chord", "midpoint"), L = NULL,
                     npc = NULL, fve = 0.99, tol = 1e-10) {
  delta <- check_sample(records)
  method <- match.arg(method)
  if (!is.null(npc) && (npc < 0 || npc != floor(npc)))
    stop("'npc' must be a nonnegative whole number.", call. = FALSE)
  if (fve <= 0 || fve > 1) stop("'fve' must lie in (0, 1].", call. = FALSE)
  paths <- sod_paths(records, method, L)
  fit <- fpca_paths(paths, npc = npc, fve = fve, tol = tol)
  fit$method <- method
  fit$delta <- delta
  fit$L <- if (method == "midpoint") L else NULL
  fit$events <- vapply(records, function(r) length(r$times), numeric(1))
  class(fit) <- "sod_fpca"
  fit
}
