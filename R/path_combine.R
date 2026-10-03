path_combine <- function(paths, weights) {
  pieces <- lapply(paths, path_pieces)
  time <- unlist(lapply(pieces, function(p) p$left))
  di <- unlist(Map(function(p, w) w * diff(c(0, p$intercept)), pieces, weights))
  ds <- unlist(Map(function(p, w) w * diff(c(0, p$slope)), pieces, weights))
  breaks <- sort(unique(c(time, 1)))
  left <- breaks[-length(breaks)]
  index <- match(time, left)
  intercept <- cumsum(sum_by(di, index, length(left)))
  slope <- cumsum(sum_by(ds, index, length(left)))
  endpoint <- sum(weights * vapply(paths, function(p) p$endpoint, numeric(1)))
  new_path(breaks, intercept + slope * left, slope, endpoint)
}
