sod_band <- function(records, B, L, alpha = 0.05, grid = seq(0, 1, length.out = 101)) {
  delta <- check_sample(records)
  check_positive(L, "L")
  if (!is.numeric(B) || length(B) != 1 || !is.finite(B) || B < 0)
    stop("'B' must be a nonnegative number.", call. = FALSE)
  if (alpha <= 0 || alpha >= 1) stop("'alpha' must lie in (0, 1).", call. = FALSE)
  check_grid(grid, "grid")
  compatible <- vapply(records, sod_compatible, logical(1), L = L, B = B)
  if (!all(compatible))
    stop(sum(!compatible), " record(s) contradict the bounds B and L.", call. = FALSE)
  n <- length(records)
  env <- lapply(records, sod_envelopes, L = L)
  lower <- path_simplify(path_combine(lapply(env, function(e) e$lower), rep(1 / n, n)))
  upper <- path_simplify(path_combine(lapply(env, function(e) e$upper), rep(1 / n, n)))
  r <- (B + L) * sqrt(2 * log(2 * length(grid) / alpha) / n)
  mesh <- L * max(diff(grid))
  gap <- path_combine(list(upper, lower), c(1, -1))
  widths <- vapply(env, function(e) e$integrated_width, numeric(1))
  margin <- delta * sqrt(2 * log(2 / alpha) / n)
  out <- list(grid = grid,
              lower = path_eval(lower, grid) - r - mesh,
              upper = path_eval(upper, grid) + r + mesh,
              lower_path = path_shift(lower, -r - mesh),
              upper_path = path_shift(upper, r + mesh),
              lower_grid = path_eval(lower, grid) - r,
              upper_grid = path_eval(upper, grid) + r,
              mean_lower = lower, mean_upper = upper,
              center = path_combine(list(lower, upper), c(0.5, 0.5)),
              radius = sqrt(max(0, path_inner(gap, gap))) / 2,
              width = mean(widths),
              width_interval = c(lower = max(0, mean(widths) - margin),
                                 upper = min(2 * delta, mean(widths) + margin)),
              record_widths = widths, sampling_margin = r, mesh_margin = mesh,
              alpha = alpha, B = B, L = L, delta = delta, n = n)
  class(out) <- "sod_band"
  out
}
