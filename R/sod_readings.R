sod_readings <- function(record) {
  check_record(record)
  data.frame(time = c(0, record$times), value = record_values(record))
}
