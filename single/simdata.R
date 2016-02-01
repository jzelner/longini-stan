source("lib/longini.R")

## Sample household sizes
hh_size <- rpois(3000,5) + 1 ## Poisson-distributed number of contacts
rv <- rep(0,3000)
for (i in 1:3000) {
    rv[i] <- rlongini_zero(0.9,0.9,hh_size[i])
}

simdata <- data.frame(j = rv, k = hh_size)

write_csv(simdata, "testdata.csv")
