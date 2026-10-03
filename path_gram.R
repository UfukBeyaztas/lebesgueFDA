path_gram <- function(A, B = NULL, lower = 0, upper = 1) {
  symmetric <- is.null(B)
  PA <- lapply(A, path_pieces)
  PB <- if (symmetric) PA else lapply(B, path_pieces)
  nA <- length(PA)
  nB <- length(PB)
  first_piece <- function(P) vapply(P, function(p) findInterval(lower, p$left), numeric(1))
  jA <- first_piece(PA)
  jB <- first_piece(PB)
  aA <- mapply(function(p, j) p$intercept[j], PA, jA)
  bA <- mapply(function(p, j) p$slope[j], PA, jA)
  aB <- mapply(function(p, j) p$intercept[j], PB, jB)
  bB <- mapply(function(p, j) p$slope[j], PB, jB)
  events <- function(P, set) {
    size <- vapply(P, function(p) length(p$left), numeric(1))
    time <- unlist(lapply(P, function(p) p$left))
    keep <- time > lower & time < upper
    list(time = time[keep], id = rep(seq_along(P), size)[keep],
         intercept = unlist(lapply(P, function(p) p$intercept))[keep],
         slope = unlist(lapply(P, function(p) p$slope))[keep],
         set = rep(set, sum(keep)))
  }
  eA <- events(PA, 1)
  eB <- if (symmetric) NULL else events(PB, 2)
  time <- c(eA$time, eB$time)
  set <- c(eA$set, eB$set)
  id <- c(eA$id, eB$id)
  new_intercept <- c(eA$intercept, eB$intercept)
  new_slope <- c(eA$slope, eB$slope)
  J_last <- numeric(nB)
  K_last <- numeric(nB)
  t_last <- rep(lower, nB)
  JA <- matrix(0, nA, nB)
  KA <- matrix(0, nA, nB)
  G <- matrix(0, nA, nB)
  for (e in order(time, set)) {
    tau <- time[e]
    if (set[e] == 1) {
      i <- id[e]
      dt <- tau - t_last
      J <- J_last + dt * (aB + bB * (tau + t_last) / 2)
      K <- K_last + dt * (aB * (tau + t_last) / 2 +
                            bB * (tau^2 + tau * t_last + t_last^2) / 3)
      G[i, ] <- G[i, ] + aA[i] * (J - JA[i, ]) + bA[i] * (K - KA[i, ])
      JA[i, ] <- J
      KA[i, ] <- K
      aA[i] <- new_intercept[e]
      bA[i] <- new_slope[e]
      if (symmetric) {
        J_last[i] <- J[i]
        K_last[i] <- K[i]
        t_last[i] <- tau
        aB[i] <- new_intercept[e]
        bB[i] <- new_slope[e]
      }
    } else {
      j <- id[e]
      dt <- tau - t_last[j]
      J_last[j] <- J_last[j] + dt * (aB[j] + bB[j] * (tau + t_last[j]) / 2)
      K_last[j] <- K_last[j] + dt * (aB[j] * (tau + t_last[j]) / 2 +
                                       bB[j] * (tau^2 + tau * t_last[j] + t_last[j]^2) / 3)
      t_last[j] <- tau
      aB[j] <- new_intercept[e]
      bB[j] <- new_slope[e]
    }
  }
  dt <- upper - t_last
  J <- J_last + dt * (aB + bB * (upper + t_last) / 2)
  K <- K_last + dt * (aB * (upper + t_last) / 2 +
                        bB * (upper^2 + upper * t_last + t_last^2) / 3)
  G <- G + aA * sweep(-JA, 2, J, "+") + bA * sweep(-KA, 2, K, "+")
  if (symmetric) G <- (G + t(G)) / 2
  G
}