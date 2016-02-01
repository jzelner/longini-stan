require(rstan)
require(readr)

## Load simulated data
d <- read_csv("testdata.csv")

## Format as input data
data_in <- list(N = nrow(d),
                j = d$j,
                k = d$k)

## Run model

m <- stan("longini.stan",
          iter = 1000,
          chains = 1,
          sample_file = "testtraces.csv",
          data = data_in)
