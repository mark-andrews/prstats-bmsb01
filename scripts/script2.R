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

prior_summary(M_6)
M_6
fixef(M_6)
fixef(M_5)

M_7 <- lm(weight ~ height + gender + race, data = weight_df)
summary(M_7)$coef
confint(M_7)
confint(M_7, parm = 'height')
M_8 <- lm(weight ~ height + race, data = weight_df)
anova(M_8, M_7)
AIC(M_8, M_7)
AIC(M_8) - AIC(M_7)
AIC(M_7)
logLik(M_7)

library(emmeans)
emmeans(M_7, specs = ~ gender)
M_7_emm <- emmeans(M_7, specs = pairwise ~ race)
summary(M_7_emm$contrasts, infer = TRUE)

# No adjustment for multiplicity
M_7_emm <- emmeans(M_7, specs = pairwise ~ race, adjust = 'none')
summary(M_7_emm$contrasts, infer = TRUE)

M_9 <- brm(weight ~ height + gender + race, data = weight_df)

emmeans(M_9, specs = ~ gender)
emmeans(M_9, specs = pairwise ~ race)$contrasts

loo(M_9)

M_10 <- brm(weight ~ height + race, data = weight_df)

M_10

loo(M_10)

loo(M_10, M_9)
c(-90.4 * -2, 12.6*2)


waic(M_10, M_9)

brms::bayes_R2(M_9)

# Posterior predictive check ----------------------------------------------

pp_check(M_9)
pp_check(M_9, ndraws = 100)

ggplot(weight_df, aes(x = weight)) + geom_density()

ggplot(weight_df, aes(x = height, y = weight, colour = gender)) + geom_point() + stat_smooth(method = 'lm', se = F, fullrange = TRUE)



M_11 <- brm(
  bf(weight ~ height + gender + race, 
     sigma ~ height + gender + race),
  family = student(),
  data = weight_df)

pp_check(M_11, ndraws = 100)


# M_11a <- brm(
#   bf(weight ~ height + gender + race, 
#      sigma ~ gender),
#   family = student(),
#   data = weight_df)

waic(M_11, M_9)



# Bayesian Poisson regression
M_12 <- brm(publications ~ gender + married + children + prestige + mentor,
            family = poisson(),
            data = biochemists_df)

# frequentist Poisson regression
M_13 <- glm(publications ~ gender + married + children + prestige + mentor,
            family = poisson(),
            data = biochemists_df)
summary(M_13)


pp_check(M_12)

M_14 <- brm(publications ~ gender + married + children + prestige + mentor,
            family = negbinomial(),
            data = biochemists_df)

waic(M_14, M_12)
loo(M_14, M_12)


# Linear mixed effects ----------------------------------------------------

library(lme4)
ggplot(sleepstudy, aes(x=Days,y=Reaction)) + 
  geom_point() +
  stat_smooth(method = 'lm', se = F) +
  facet_wrap(~Subject)


M_15 <- lmer(Reaction ~ Days + (Days|Subject), data = sleepstudy)
M_16 <- brm(Reaction ~ Days + (Days|Subject), data = sleepstudy)

ranef(M_15) # lmer model
coef(M_15)
residuals(M_15)

ranef(M_16) # Bayesian model

summary(M_15)
confint(M_15, signames = F)

prior_summary(M_16)

M_17 <- brm(Reaction ~ Days + (1|Subject), data = sleepstudy)

waic(M_17, M_16)
loo(M_17, M_16)

# no correlation
M_18 <- brm(Reaction ~ Days + (Days||Subject), data = sleepstudy)


