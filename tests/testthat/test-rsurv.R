context("rsurv.R unit tests")
library("data.table")

# Replication of exponential distribution --------------------------------------
test_that("rsurv() produces correct output for exponential distribution" , {
  
  set.seed(10)
  
  N_REP <- 10000
  rates <- c(.25, .5, 2)
  N <- length(rates)
  MAX_T <- 50
  sc <- example_survival_curves(n = N, rates = rates,
                                times = seq(0, MAX_T, 1/52))
  sim <- data.table(
    id = rep(1:N, times = N_REP),
    time = pmin(rsurv(sc, n_rep = N_REP), MAX_T)
  )
  sim_summary <- sim[, .(mean = mean(time)),
                     by = "id"]
  expect_equal(
    sim_summary$mean,
    1/rates,
    tolerance = .03
  )
})