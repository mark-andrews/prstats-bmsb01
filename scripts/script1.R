n <- 250 # number of coin flips
m <- 139 # number of heads

bernoulli_likelihood(n, m)

n1 <- 25
m1 <- 14

bernoulli_likelihood(n1, m1)

beta_plot(alpha = 3, beta = 5)
# mean of beta distrib: alpha / (alpha + beta)

beta_plot(alpha = 3 * 5, beta = 5 * 5)
(3 * 5)/(3 * 5 + 5 * 5)

beta_plot(alpha = 5, beta = 5)
beta_plot(alpha = 2, beta = 10)
beta_plot(alpha = 10, beta = 2)
beta_plot(alpha = 250, beta = 10)
beta_plot(alpha = 1, beta = 1) # unifor
beta_plot(alpha = 0.5, beta = 0.5) # unifor


# Posterior distribution --------------------------------------------------

n <- 250
m <- 139
alpha <- 3
beta <- 5

# this is our prior
beta_plot(alpha = alpha, beta = beta)

# this is our likelihood function
bernoulli_likelihood(n, m)

# our posterior distribution is
bernoulli_posterior_plot(n, m, alpha, beta)

# let's look at other priors ...
# e.g. a flat prior
alpha1 <- 1
beta1 <- 1

# this is our prior for that
beta_plot(alpha = alpha1, beta = beta1)

bernoulli_posterior_plot(n, m, alpha1, beta1)

# An extreme prior can compete with the data
alpha2 <- 250
beta2 <- 10

# this is our prior for that
beta_plot(alpha = alpha2, beta = beta2)

bernoulli_posterior_plot(n, m, alpha2, beta2)

# Compare posterior for different priors ----------------------------------

bernoulli_posterior_summary(n, m, alpha, beta)
bernoulli_posterior_summary(n, m, alpha1, beta1)
