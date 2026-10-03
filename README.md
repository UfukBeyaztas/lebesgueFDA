# lebesgueFDA

Functional data analysis for curves recorded by send-on-delta sampling.

Many sensors store a value only when the signal has moved a fixed distance δ from the last stored value. This rule is known as send-on-delta, deadband reporting or Lebesgue sampling. The observation times are then first-exit times of the curve itself, and a record carries information in two forms: each event fixes the value of the curve at the event time, and each silence keeps the curve inside a band of half-width δ around the last recorded value.

`lebesgueFDA` estimates the mean, the covariance, and the functional principal components of a sample of curves recorded in this way. Under a known bound on the speed of the curves, it also describes what a fixed threshold leaves unidentified. The package implements the methods of

## Why the readings should not be pooled

The usual approach to irregularly observed curves pools the recorded values of all curves and smooths them in time. Under send-on-delta, a curve records more values where it moves faster, and pooling estimates the variation-weighted function

$$\mu_{\mathrm{ev}}(t) = \frac{E[X(t)\,|X'(t)|]}{E|X'(t)|}$$

instead of the mean $\mu(t) = E X(t)$. The gap equals $\mathrm{Cov}(X(t), |X'(t)|)/E|X'(t)|$, and it does not shrink as δ decreases. `lebesgueFDA` therefore reconstructs each record first and averages the reconstructions.

## Installation

The package is not on CRAN. Install the development version from GitHub with `remotes`:

```r
install.packages("remotes")
remotes::install_github("UfukBeyaztas/lebesgueFDA")
```

or, equivalently, with `devtools`:

```r
install.packages("devtools")
devtools::install_github("UfukBeyaztas/lebesgueFDA")
```

The package needs R 3.5.0 or later.

## Documentation

The reference manual is in [lebesgueFDA_0.1.0.pdf](lebesgueFDA_0.1.0.pdf). Every function has a help page with a short account of the theory behind it and examples taken from the simulation study of the paper:

```r
library(lebesgueFDA)
help(package = "lebesgueFDA")
?sod_fpca
```

The examples are wrapped in `\dontrun{}` because some of them take a few seconds. Run them with, for instance,

```r
example(sod_fpca, run.dontrun = TRUE)
```

## Estimation from records

The example below draws 300 curves from design D4 of the paper, a Gaussian process with a trend, records them with δ = 0.05, and estimates the mean, the covariance and three principal components from the held and the chord reconstructions.

```r
library(lebesgueFDA)

set.seed(2026)
grid <- seq(0.1, 0.9, length.out = 201)
sim <- sim_sod(n = 300, design = "D4", delta = 0.05, t = grid)
sim$records[[1]]

held <- sod_fpca(sim$records, method = "held", npc = 3)
chord <- sod_fpca(sim$records, method = "chord", npc = 3)
chord

# integrated squared errors of the mean on [0.1, 0.9]; the oracle uses the full curves
ise <- function(m) 0.8 * mean((m - sim$truth$mean(grid))^2)
c(held = ise(sod_mean(held, grid)),
  chord = ise(sod_mean(chord, grid)),
  oracle = ise(colMeans(sim$curves)))

# estimated eigenvalues; the population values are 0.5, 0.3 and 0.1
chord$eigenvalues

# the estimated mean, the true mean and the target of pooled smoothing (dashed)
plot(grid, sim$truth$mean(grid), type = "l", lwd = 2, xlab = "t", ylab = "mean")
lines(grid, sod_mean(chord, grid), col = "steelblue")
lines(grid, sim$truth$event_mean(grid), lty = 2)
```

The held path keeps the last recorded value and lies within δ of the curve at all times. The chord path joins consecutive readings and lies within 2δ. Averages of either reconstruction estimate the mean and the covariance with expected squared error of order 1/n + δ², and no estimator does better uniformly. With n = 300 the sampling error dominates here, so both reconstructions come close to the oracle that uses the full curves. In the simulations of the paper the chord path stays close to the oracle in all designs, whereas the held path loses accuracy at the larger thresholds. The principal components are computed from the n × n Gram matrix of the reconstructions, whose entries are exact integrals, so no quadrature error enters.

## Identification under a Lipschitz bound

At a fixed threshold the mean is not identified: different laws of the curves can produce the same law of the records. If the curves satisfy |X(0)| ≤ B and have Lipschitz constant at most L, every record confines its curve between two sharp envelopes. The averages of the envelopes estimate the identified interval of the mean at each time, and `sod_band()` adds a finite-sample margin so that the band covers that interval at all times with probability at least 1 − α.

```r
# design D3 of the paper satisfies |X(0)| <= 1/2 with Lipschitz constant 2 + pi/2
set.seed(2026)
sim3 <- sim_sod(n = 300, design = "D3", delta = 0.025)
grid <- seq(0, 1, length.out = 201)
band <- sod_band(sim3$records, B = sim3$truth$B, L = sim3$truth$L, grid = grid)
band
all(band$lower <= sim3$truth$mean(grid) & sim3$truth$mean(grid) <= band$upper)

# Chebyshev radius of the identified set and worst-case risk of the midpoint estimator
sod_midpoint_risk(sim3$records, L = sim3$truth$L)

# a single record: its envelopes, midpoint path and integrated width
rec <- sim3$records[[1]]
env <- sod_envelopes(rec, L = sim3$truth$L)
env$integrated_width
sod_width(rec, L = sim3$truth$L)
```

The width of the identified interval depends on where the events fall as well as on how many there are, and its integral has a closed form (`sod_width()`, `sod_width_range()`). The bounds B and L must come from outside the data, for example from the physical limits of the sensor or of the process. A record can contradict a bound that is too small (`sod_compatible()`), but it cannot confirm one.

## Your own records

The functions work on the time interval [0, 1]. If your times run over [a, b], divide them by b − a after subtracting a, and multiply a Lipschitz bound by b − a. A record stored by a logger as times and values becomes a `sod_record` object as follows:

```r
time <- c(0, 0.12, 0.31, 0.47, 0.80)
value <- c(1.0, 1.1, 1.2, 1.1, 1.0)
rec <- sod_record(initial = value[1], times = time[-1],
                  polarity = sign(diff(value)), delta = 0.1)
rec
path_eval(held_path(rec), c(0.2, 0.5, 0.9))
```

A signal stored on a dense grid can be recorded exactly with `sod_encode()`, which computes the record of its piecewise linear interpolant.

## Functions

| Task | Functions |
|---|---|
| Records | `sod_record()`, `sod_encode()`, `sod_encode_sample()`, `sod_encode_curve()`, `sod_readings()`, `sod_compatible()` |
| Reconstructions | `held_path()`, `chord_path()`, `midpoint_path()`, `sod_envelopes()`, `sod_paths()`, `sod_reconstruct()` |
| Mean, covariance, and principal components | `sod_fpca()`, `sod_mean()`, `sod_cov()`, `sod_eigenfunctions()`, `predict()` |
| Identification and bands | `sod_width()`, `sod_width_range()`, `sod_band()`, `sod_linear_bounds()`, `sod_midpoint_risk()` |
| Simulation designs | `sim_sod()`, `sim_coefficients()`, `sim_records()`, `sim_curves()`, `design_truth()` |
| Working with paths | `path_linear()`, `path_eval()`, `path_inner()` |

## Simulation designs

`sim_sod()` generates the six designs of the paper, and `design_truth()` returns their means, covariances, pooled targets and bounds.

| Design | Curves | Role in the paper |
|---|---|---|
| D1 | X(t) = Z + A t^(1+R) | level and speed are associated, so pooling overestimates the mean |
| D2 | X(t) = Z + 0.9 t | parallel lines; pooling is unbiased |
| D3 | X(t) = a0 + a1 t + a2 sin(πt) | bounded Lipschitz model used for identification |
| D4 | 2t + sin(2πt)/2 plus three Gaussian components | Gaussian process with a trend and a time-varying variance |
| D5 | X(t) = A + B t with Gaussian A and B | random lines; the pooled target is 1.1578 t |
| D6 | piecewise linear stationary Gaussian process | the pooled covariance smoother has the wrong sign at some pairs of times |

The simulations in the paper use n = 100, 300, and 900 curves, the thresholds δ = 0.10, 0.05, and 0.025, and losses on [0.1, 0.9]. Because `sim_coefficients()` and `sim_records()` are separate, the same curves can be recorded at several thresholds.

## License

GPL (>= 3)

## Contact

Ufuk Beyaztas, Department of Statistics, Marmara University (ufuk.beyaztas@marmara.edu.tr). Please report bugs and questions through the [issue tracker](https://github.com/UfukBeyaztas/lebesgueFDA/issues).
