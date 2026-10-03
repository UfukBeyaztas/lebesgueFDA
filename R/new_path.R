new_path <- function(breaks, value, slope, endpoint) {
  structure(list(breaks = as.numeric(breaks), value = as.numeric(value),
                 slope = as.numeric(slope), endpoint = as.numeric(endpoint)),
            class = "sod_path")
}
