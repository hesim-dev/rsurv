# Create a data frame storing survival curves
N <- 3 # Number of individuals
times <- rep(seq(0, 30, 1/12))
rates = runif(N, .2, .5)
sc_df <- data.frame(
  id = rep(1:N, each = length(times)),
  time = rep(times, times = length(rates)),
  rate = rep(rates, each = length(times))
)
sc_df$survival <- 1 - stats::pexp(sc_df$time, sc_df$rate)

# Convert the data frame to a "survival_curves" object
as_survival_curves(sc_df)