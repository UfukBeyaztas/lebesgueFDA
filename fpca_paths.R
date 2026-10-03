fpca_paths <- function(paths, npc = NULL, fve = 0.99, tol = 1e-10) {
  n <- length(paths)
  first <- paths[[1]]
  work <- lapply(paths, function(p) path_combine(list(p, first), c(1, -1)))
  U <- path_gram(work)
  row_mean <- rowMeans(U)
  G <- (U - outer(row_mean, rep(1, n)) - outer(rep(1, n), row_mean) + mean(row_mean)) / n
  G <- (G + t(G)) / 2
  work_mean <- path_combine(work, rep(1 / n, n))
  mean_path <- path_simplify(path_combine(list(first, work_mean), c(1, 1)))
  e <- eigen(G, symmetric = TRUE)
  positive <- which(e$values > tol * max(e$values[1], 0) & e$values > 0)
  lambda <- e$values[positive]
  K <- if (length(lambda) == 0) {
    0
  } else if (!is.null(npc)) {
    min(npc, length(lambda))
  } else {
    which(cumsum(lambda) / sum(lambda) >= fve * (1 - 1e-12))[1]
  }
  phi <- vector("list", K)
  scores <- matrix(0, n, K)
  for (j in seq_len(K)) {
    v <- e$vectors[, positive[j]]
    scale <- sqrt(n * lambda[j])
    f <- path_combine(c(work, list(work_mean)), c(v, -sum(v)) / scale)
    mid <- f$value + f$slope * diff(f$breaks) / 2
    s <- sign(mid[which.max(abs(mid))])
    if (s == 0) s <- 1
    phi[[j]] <- path_simplify(new_path(f$breaks, s * f$value, s * f$slope, s * f$endpoint))
    scores[, j] <- s * scale * v
  }
  if (K > 0) colnames(scores) <- paste0("PC", seq_len(K))
  list(n = n, mean = mean_path, values = lambda, eigenvalues = lambda[seq_len(K)],
       eigenfunctions = phi, scores = scores, npc = K, gram = G, paths = paths,
       fve = if (sum(lambda) > 0) sum(lambda[seq_len(K)]) / sum(lambda) else 1)
}