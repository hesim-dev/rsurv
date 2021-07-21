is_whole_number <- function(x, tol = .Machine$double.eps^0.5) {
  abs(x - round(x)) < tol
}

# Survival curves --------------------------------------------------------------
#' Survival curves
#' 
#' Create a survival curves object, which stores survival probabilities at
#' various time points for multiple individuals.
#' 
#' @param time The times at which the survival probabilities were computed at.
#' @param survival A vector of estimates of the survival probabilities.
#' @param id An identifier for each individual. May either be a numeric vector,
#' integer vector, character vector, or factor.
#' @param sort Whether to sort the returned data frame to ensure that 
#' rows are sorted by `id` and`time` as required by [rsurv.survival_curves()].
#' 
#' @seealso `survival_curves` objects can can also be constructed from 
#' a [`data.frame`] using [as_survival_curves()]. The purpose of the 
#' `survival_curves` class is for storing survival curves in a standardized
#' format so that survival times can be randomly drawn from them using 
#' [rsurv.survival_curves()].
#' 
#' @example man-roxygen/example-survival_curves.R
#' @export
survival_curves <- function(time, id, survival,
                            sort = TRUE) {
  
  # Create the table to return
  out <- data.table(
    time = time,
    id = id,
    survival = survival
  )
  if (sort) setorderv(out, cols = c("id", "time"))
  
  # Metadata: number of times, by group
  n_times_dt <- out[, .N, by = "id"]
  n_times <- n_times_dt$N
  names(n_times) <- n_times_dt$id
  
  # Create the class object
  out <- as.data.frame(out)
  class(out) <- c("survival_curves", class(out))
  attr(out, "n_times") <- n_times
  out
}

# Convert to survival curves ---------------------------------------------------
#' Convert to a `survival_curves` object
#' 
#' [as_survival_curves()] is a generic function for converting objects to
#' the `survival_curves` class. There is currently only a method for a 
#' `data.frame`.
#' @param x An object of the appropriate class.
#' @param ... Additional arguments to pass to [survival_curves()].
#'  
#' @return A [`survival_curves`] object.
#' 
#' @seealso See 
#' @export
as_survival_curves <- function(x, ...) {
  UseMethod("as_survival_curves")
}

#' @param time The name of the column containing the times a which survival
#' probabilities were computed.
#' @param id The name of the column containing an indentifier for each individual.
#' @param survival The name of the column containing survival probabilities.
#' @rdname as_survival_curves
#' 
#' @example man-roxygen/example-as_survival_curves.R
#' @export
as_survival_curves.data.frame <- function(x, time = "time", id = "id",
                                          survival = "survival", ...) {
  survival_curves(
    time = x[[time]],
    id = x[[id]],
    survival = x[[survival]], 
    ...
  )
}

# Example survival curves ------------------------------------------------------
#' Example survival curves
#' 
#' Create a [`survival_curves`] object for use in examples by generating survival 
#' probabilities from from exponential survival distributions.
#' 
#' @param n The number of individuals to create survival curves for.
#' @param rates Rate parameter for each individual. Must be a numeric vector
#' of length `n`.
#' @param times A vector of times at which to compute survival probabilities.
#' 
#' @seealso See [survival_curves()] for information about the `survival_curves`
#' class.
#' @export
example_survival_curves <- function(n = 1000, rates = stats::runif(n, .2, .5),
                                    times = seq(0, 30, 1/12)) {
  sc_df <- data.frame(
    id = rep(1:n, each = length(times)),
    time = rep(times, times = length(rates)),
    rate = rep(rates, each = length(times))
  )
  sc_df$survival <- 1 - stats::pexp(sc_df$time, sc_df$rate)
  as_survival_curves(sc_df)
}