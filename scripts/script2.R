library(tidyverse)
library(brms)

# get some data
source("https://raw.githubusercontent.com/mark-andrews/ibdar/refs/heads/ibdar25/data/dl_data.R")
source("https://raw.githubusercontent.com/mark-andrews/ibdar/refs/heads/ibdar25/data/sim_data.R")

M_1 <- lm(y ~ x_1 + x_2, data = data_df1)
summary(M_1)
summary(M_1)$coef
confint(M_1)
sigma(M_1)

M_2 <- brm(y ~ x_1 + x_2, data = data_df1)

M_2
summary(M_2)

plot(M_2)
mcmc_plot(M_2)
mcmc_plot(M_2, type = 'intervals')
mcmc_plot(M_2, type = 'hist')
mcmc_plot(M_2, type = 'hist', variable = 'sigma')
mcmc_plot(M_2, type = 'hist', variable = 'b_x_1')
mcmc_plot(M_2, type = 'hist', variable = c('b_x_1', 'b_x_2'))
mcmc_plot(M_2, type = 'areas')
mcmc_plot(M_2, type = 'areas_ridges')
mcmc_plot(M_2, type = 'dens')
mcmc_plot(M_2, type = 'dens_chains')

# the samples themselves
as_draws_df(M_2)

stancode(M_2)

# see the priors
prior_summary(M_2)


# weight as function of height and sex
M_3 <- lm(weight ~ height + gender, data = weight_df)
summary(M_3)

M_4 <- brm(weight ~ height + gender, 
           chains = 4,
           cores = 4,
           iter = 10000,
           warmup = 2000,
           save_pars = save_pars(all = TRUE), # for e.g. bayes factors
           data = weight_df)

# check out the priors
prior_summary(M_4)

M_5 <- brm(weight ~ height + gender, 
           chains = 4,
           cores = 4,
           prior = set_prior("normal(0, 10)"),
           iter = 10000,
           warmup = 2000,
           save_pars = save_pars(all = TRUE), # for e.g. bayes factors
           data = weight_df)

# see the priors that *will* be used
get_prior(weight ~ height + gender, data = weight_df)

#get_prior(weight ~ height + gender, data = weight_df, prior = set_prior("normal(0, 10)"))

prior_summary(M_5)


M_4
M_5

# posterior plot over non-intercept coefficients
mcmc_plot(M_4, type = 'hist', variable = c("b_height", "b_gendermale"))
mcmc_plot(M_5, type = 'hist', variable = c("b_height", "b_gendermale"))

# posterior summary for coefs
fixef(M_4)
fixef(M_5)


new_priors <- c(
  set_prior('normal(0, 50)', class = 'b', coef = 'gendermale'),
  set_prior('normal(0, 20)', class = 'b', coef = 'height'),
  set_prior('normal(0, 100)', class = 'Intercept'),
  set_prior('student_t(1, 0, 50)', class = 'sigma')
)

M_6 <- brm(weight ~ height + gender, 
           chains = 4,
           cores = 4,
           prior = new_priors,
           iter = 10000,
           warmup = 2000,
           save_pars = save_pars(all = TRUE), # for e.g. bayes factors
           data = weight_df)
