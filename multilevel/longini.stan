functions {

  real longini_pdf(real B, real Q, int j, int k);
  
  real longini_pdf(real B, real Q, int j, int k) {
    
    if (j == 0) {
      return B^k;
    } else {
      real t1;
      real t2;
      t1 <- exp(binomial_coefficient_log(k,j))*(B^(k-j))*(Q^(j*(k-j)));
      t2 <- 0;
        for (i in 0:(j-1)) {
          t2 <- t2 + longini_pdf(B,Q,i,j);
        }

        return t1*(1-t2);
    }
  }

  real longini_zero_log(real B, real Q, int j, int k) {
    real a;
    real b;

    a <- 1.0- longini_pdf(B,Q,0,k);
    b <- longini_pdf(B,Q,j,k);
    return log(b)-log(a);
  }


}

data {
  int N; //Number of households
  int G; // Number of groups
  int k[N]; // Household sizes
  int j[N]; // Number of cases per household
  int<lower=1,upper=G> group[N]; //Groups for each household
  
}

parameters {
  real<lower=0,upper=1> B;
  vector[G] q_ranef;
  real<lower=0> q_sd;
  real log_q_mu;
}

transformed parameters {
  vector<lower=0,upper=1>[G] Q;
  vector[G] q_ranef_c;

  q_ranef_c <- q_ranef - mean(q_ranef);

    
  for (i in 1:G) {
    Q[i] <- exp(-exp(log_q_mu + q_ranef_c[i]*q_sd));
  }


}

model {

  vector[N] pdf_vals;

  q_sd ~ cauchy(0,2);
  q_ranef ~ normal(0,1);
  log_q_mu ~ normal(0,8);

  for (i in 1:N) {
    pdf_vals[i] <- longini_zero_log(B,Q[group[i]],j[i],k[i]);
  }

  increment_log_prob(sum(pdf_vals));
}
