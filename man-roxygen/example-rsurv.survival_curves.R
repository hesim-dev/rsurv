# Survival curves for multiple subjects based on exponential distributions
set.seed(21)
N <- 1000 # 1000 individuals
rates <- runif(N, .2, .5)
sc <- example_survival_curves(n = N, rates = rates)
  
# Random number generation of 1000 individuals from (1) arbitrary survival
# curves and (2) exponential distributions
sim_rsurv <- rsurv(sc)
sim_rexp <- rexp(N, rate = rates)

summary(sim_rsurv)
summary(sim_rexp)

# Random number generation of 1000 individuals replicated 2 times
sim_rsurv <- rsurv(sc, n_rep = 2)
summary(sim_rsurv)
