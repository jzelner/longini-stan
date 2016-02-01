require(rstan)
require(readr)

## Load simulated data
d <- read_csv("multilevel/output/multileveltestdata.csv")


## Format as input data
data_in <- list(N = nrow(d),
                G = max(d$group),
                j = d$j,
                k = d$k,
                group = d$group)

## Run model
m <- stan("multilevel/longini.stan",
          iter = 1000,
          chains = 1,
          sample_file = "multilevel/output/testtraces.csv",
          data = data_in)
