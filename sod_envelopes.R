sod_envelopes <- function(record, L) {
  check_positive(L, "L")
  if (!sod_compatible(record, L))
    stop("The record contradicts L: an inter-event time is shorter than delta / L.",
         call. = FALSE)
  d <- record$delta
  m <- length(record$times)
  t0 <- c(0, record$times)
  v0 <- record_values(record)
  t1 <- c(record$times, 1)
  v1 <- c(v0[-1], v0[m + 1])
  terminal <- c(rep(FALSE, m), TRUE)
  candidates <- cbind(t0 + d / L,
                      (t0 + t1) / 2 + (v0 - v1) / (2 * L),
                      t1 - (v1 - v0 + d) / L,
                      (t0 + t1) / 2 + (v1 - v0) / (2 * L),
                      t1 - (v0 - v1 + d) / L)
  candidates[terminal, -1] <- NA
  inside <- !is.na(candidates) & candidates > t0 & candidates < t1
  knots <- sort(unique(c(0, record$times, 1, candidates[inside])))
  r <- length(knots) - 1
  left <- knots[-(r + 1)]
  half <- diff(knots) / 2
  k <- findInterval(left + half, t0)
  vk <- v0[k]
  tk <- t0[k]
  final <- k > m
  tn <- t0[pmin(k + 1, m + 1)]
  vn <- v0[pmin(k + 1, m + 1)]
  low <- cbind(vk - d, vk - L * (left - tk), ifelse(final, -Inf, vn - L * (tn - left)))
  up <- cbind(vk + d, vk + L * (left - tk), ifelse(final, Inf, vn + L * (tn - left)))
  low_slope <- c(0, -L, L)
  up_slope <- c(0, L, -L)
  il <- max.col(low + outer(half, low_slope), ties.method = "first")
  iu <- max.col(-(up + outer(half, up_slope)), ties.method = "first")
  lv <- low[cbind(seq_len(r), il)]
  uv <- up[cbind(seq_len(r), iu)]
  ls <- low_slope[il]
  us <- up_slope[iu]
  tail_width <- min(d, L * (1 - t0[m + 1]))
  vm <- v0[m + 1]
  list(lower = path_simplify(new_path(knots, lv, ls, vm - tail_width)),
       upper = path_simplify(new_path(knots, uv, us, vm + tail_width)),
       midpoint = path_simplify(new_path(knots, (lv + uv) / 2, (ls + us) / 2, vm)),
       width = path_simplify(new_path(knots, uv - lv, us - ls, 2 * tail_width)),
       integrated_width = sod_width(record, L))
}