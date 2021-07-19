# Compute survival probabilities by individual and time
id <- 1:3 # 3 individuals
n_id <- length(id)
times1 <- seq(0, 30, 1/12) # Times for 1 individual
n_times <- length(times1)
times <- rep(times1, length(id)) # Times for all individuals
rates <- rep(runif(n_id, .2, .5), each = n_times) 
surv <- 1 - pexp(times, rates) # Survival probabilities

# Construct a survival curves object
sc <- survival_curves(time = times, id = rep(id, each = n_times),
                      survival = surv)
class(sc)
head(sc)
tail(sc)
                
