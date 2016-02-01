require(rstan)
require(readr)

## Load simulated data
d <- read_csv("tdata.csv")


## Format as input data
data_in <- list(N = nrow(d),
                j = d$j,
                k = d$k)

## Run model
m <- stan("longini.stan",
          iter = 2000,
          chains = 2,
          sample_file = "testtraces.csv",
          data = data_in)
