sod_eigenfunctions <- function(fit, t) {
  check_times(t)
  if (fit$npc == 0) return(matrix(0, length(t), 0))
  out <- vapply(fit$eigenfunctions, path_eval, numeric(length(t)), t = t)
  out <- matrix(out, length(t))
  colnames(out) <- paste0("PC", seq_len(fit$npc))
  out
}
