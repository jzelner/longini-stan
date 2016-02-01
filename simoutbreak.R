## Set the number of households
N_HH <- 1000

## Sample the number of household contacts
HH_CONTACTS <- rpois(N_HH, lambda = 5)

## Number of years
T <- 10

## Community acquisition prob
cp <- 0.5

## Household transmission prob per contact
hp <- 0.1

## Rate of community infection for each round
cr <- -log(1-cp)/T

## Rate of infection from each infectious household contact
hr <- -log(1-hp)


## Define function for simulating individual household
hh_trans <- function(cr,hr,N,T) {
    I <- 1
    S <- N
    total_I <- 0
    for (i in 1:T) {
        p_inf <- 1.0-exp(-(I*hr + cr))
        n_inf <- rbinom(1,S,p_inf)
        total_I <- total_I + n_inf
        I <- n_inf
        S <- S-n_inf

        if (S == 0) {
            break
        }
    }

    return(total_I)

}

sim_outbreak_sizes <- rep(0, N_HH)
for (i in 1:N_HH) {
    sim_outbreak_sizes[i] <- hh_trans(cr,hr,HH_CONTACTS[i],T)
}

sim_df <- data.frame(N = HH_CONTACTS, I = sim_outbreak_sizes)
