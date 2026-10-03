design_record <- function(cf, design, delta) {
  switch(design,
         D1 = power_record(cf[1], cf[2], 1 + cf[3], delta),
         D2 = power_record(cf[1], 0.9, 1, delta),
         D5 = power_record(cf[1], cf[2], 1, delta),
         D3 = {
           turning <- c(0, 1)
           if (cf[3] != 0) {
             ratio <- -cf[2] / (pi * cf[3])
             if (abs(ratio) < 1) turning <- c(0, acos(ratio) / pi, 1)
           }
           curve <- function(t) cf[1] + cf[2] * t + cf[3] * sin(pi * t)
           sod_encode_curve(curve, turning, delta)
         },
         D4 = {
           b <- 0.5 + sqrt(2) * cf[2]
           d <- sqrt(2) * cf[3]
           amplitude <- sqrt(b^2 + d^2)
           turning <- c(0, 1)
           if (pi * amplitude > 1) {
             angle <- acos(-1 / (pi * amplitude))
             roots <- (outer(c(angle, -angle), 2 * pi * (-2:2), "+") - atan2(d, b)) / (2 * pi)
             turning <- sort(unique(c(0, 1, roots[roots > 0 & roots < 1])))
           }
           curve <- function(t) cf[1] + 2 * t + b * sin(2 * pi * t) + d * cos(2 * pi * t)
           sod_encode_curve(curve, turning, delta)
         },
         D6 = {
           knots <- d6_knots()
           sod_encode(knots, as.vector(d6_template(knots) %*% cf), delta)
         })
}