
## Overview

`rsurv` is a lightweight package with minimal dependencies for randomly
generating survival times efficiently and flexibly. Survival times can
be randomly drawn from any survival distribution and all code is
vectorized so that each individual can have their own survival function.
Monte Carlo simulation studies that aim to simulate realistic data
generating processes based on empirical data are an intended use case.

## Installation

The package can be installed from GitHub with:

``` r
devtools::install_github("hesim-dev/rsurv")
```

## Usage

Survival times can be randomly drawn from arbitrary survival curves
using the `rsurv()` function. Survival curves for multiple individuals
are stored in objects of class `survival_curves`, which are just data
frames in the format shown here:

``` r
library("rsurv")
sc <- example_survival_curves(n = 1000)
head(sc)
```

    ##         time id  survival
    ## 1 0.00000000  1 1.0000000
    ## 2 0.08333333  1 0.9797898
    ## 3 0.16666667  1 0.9599881
    ## 4 0.25000000  1 0.9405866
    ## 5 0.33333333  1 0.9215772
    ## 6 0.41666667  1 0.9029520

Random survival times for each individual can then be easily drawn:

``` r
sim <- rsurv(sc)
length(sim)
```

    ## [1] 1000

``` r
summary(sim)
```

    ##     Min.  1st Qu.   Median     Mean  3rd Qu.     Max. 
    ##  0.08333  0.83333  2.08333  3.14350  4.41667 26.58333
