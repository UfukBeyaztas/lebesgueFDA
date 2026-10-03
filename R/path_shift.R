path_shift <- function(path, amount) {
  new_path(path$breaks, path$value + amount, path$slope, path$endpoint + amount)
}
