source("lib/longini.R")
N_HH <- 3000
## Sample household sizes
#hh_size <- rpois(N_HH,5) + 1 ## Poisson-distributed number of contacts
hh_size <- rep(6, N_HH)
## Break households into groups
G <- 100

group <- sample(1:G, N_HH, replace=TRUE)

group_sd <- 1.0

Q_log_rate <- log(0.1)
group_log_Q <- Q_log_rate + rnorm(G, mean = 0, sd = group_sd)
Q <- exp(-exp(group_log_Q[group]))
B <- 0.9


rv <- rep(0,N_HH)
for (i in 1:N_HH) {
    rv[i] <- rlongini_zero(B,Q[i],hh_size[i])
}

simdata <- data.frame(j = rv, k = hh_size, group = group)

write_csv(simdata, "multilevel/output/multileveltestdata.csv")
