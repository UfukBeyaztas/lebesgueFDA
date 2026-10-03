predict.sod_fpca <- function(object, newdata, npc = object$npc, t = NULL, ...) {
  delta <- check_sample(newdata)
  if (abs(delta - object$delta) > 1e-12 * object$delta)
    stop("'newdata' must be recorded with the training threshold.", call. = FALSE)
  if (npc > object$npc)
    stop("'npc' exceeds the number of fitted components.", call. = FALSE)
  paths <- sod_paths(newdata, object$method, object$L)
  k <- seq_len(npc)
  if (npc > 0) {
    phi <- object$eigenfunctions[k]
    centre <- path_gram(list(object$mean), phi)
    scores <- path_gram(paths, phi) - matrix(centre, length(paths), npc, byrow = TRUE)
    colnames(scores) <- paste0("PC", k)
  } else {
    scores <- matrix(0, length(paths), 0)
  }
  basis <- c(list(object$mean), object$eigenfunctions[k])
  fitted <- lapply(seq_along(paths), function(i) path_combine(basis, c(1, scores[i, ])))
  out <- list(scores = scores, paths = fitted)
  if (!is.null(t)) out$values <- do.call(rbind, lapply(fitted, path_eval, t = t))
  out
}
