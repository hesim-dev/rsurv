# Generic function -------------------------------------------------------------
#' Random generation from survival curve
#' 
#' `rsurv()` is a generic function for randomly drawing survival times for multiple 
#' individuals very efficiently. The most flexible function is 
#' `rsurv.survival_curves()`, which will randomly draw survival times from 
#' survival curves.
#' 
#' @param object An object of the appropriate class.
#' @param ... Further arguments passed to or from other methods. Currently unused.
#' 
#' 
#' @return A vector with randomly sampled survival times for individuals 
#' (`id`s) in `object` repeated `n_rep` times. The returned vector is of length 
#' `length(unique(object$id))` times `n_rep`.
#' 
#' 
#' @seealso A `survival_curves` object can be constructed using the function
#' [survival_curves()] or converted from an existing data frame using 
#' [as_survival_curves.data.frame()].
#' 
#' @example man-roxygen/example-rsurv.survival_curves.R
#' 
#' @export
rsurv <- function(object, ...) {
  UseMethod("rsurv")
}

# Method for survival objects --------------------------------------------------
#' @param n_rep The number of times to randomly draw survival times per 
#' individual (`id`) in `object`. 
#' 
#' @details Survival times are randomly sampled from survival curves
#' by partitioning times into intervals and using the survival probabilities
#' to compute the probability of dying within each interval, conditional on 
#' survival up until that interval. Death is simulated within each interval from
#' a Bernoulli distribution and a given individual's observed death time is
#' the time at the end of the first interval for which that individual is 
#' simulated to have died. This process is repeated across all individuals. 
#' The code is written in `C++` so looping across individuals is fast.
#' @export
#' @rdname rsurv
rsurv.survival_curves <- function(object, n_rep = 1, ...) {
  if (n_rep < 1) {
    stop("'n_rep' must be an integer greater than or equal to 1.")
  }
  C_rsurv(time = object$time, prob = object$survival,
          n_times = attr(object, "n_times"),
          n_rep = n_rep)
}