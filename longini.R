longini_likelihood <- function(B,Q,j,k) {

    if (j == 0) {
        return(B^k)
    } else {
        t1 <- choose(k,j)*(B^(k-j))*(Q^(j*(k-j)))
        t2 <- 0
        for (i in 0:(j-1)) {
            t2 <- t2 + longini_likelihood(B,Q,i,j)
        }

        return(t1*(1-t2))
    }

}



N <- 100
tl <- rep(0,N+1)
for (i in 0:N) {
    tl[i+1] <- longini_likelihood(0.9,0.8,i,N)
}
