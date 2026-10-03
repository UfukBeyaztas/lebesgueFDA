sod_paths <- function(records, method = c("held", "chord", "midpoint"), L = NULL) {
  check_sample(records)
  method <- match.arg(method)
  if (method == "midpoint" && is.null(L))
    stop("The midpoint reconstruction needs 'L'.", call. = FALSE)
  switch(method,
         held = lapply(records, held_path),
         chord = lapply(records, chord_path),
         midpoint = lapply(records, midpoint_path, L = L))
}