# Bayesian Statistical Modelling with Stan and brms

This intensive workshop provides a comprehensive introduction to Bayesian data analysis for empirical researchers.
The course covers both theoretical foundations and practical implementation, teaching participants how to conduct Bayesian statistical inference using Stan via the brms package in R.
Starting from fundamental concepts of Bayesian reasoning, the course progresses through a complete analytical treatment of a simple statistical model before moving to practical Bayesian modelling using modern computational methods.
Participants will learn to fit and interpret Bayesian linear regression models, generalised linear models, and mixed effects models, with emphasis on prior specification, model comparison, and understanding what Bayesian inference offers beyond classical statistical approaches.

### Topics

**Foundations of Bayesian Inference**

- The Bayesian approach as an alternative school of statistics and how it differs from classical frequentist methods
- The role of subjective probability and prior information
- Using Bayes' rule to calculate probabilities of causes from observed effects
- Likelihood functions, prior distributions (beta distributions), posterior distributions
- Point estimates (MAP), interval estimates (credible intervals, HPD intervals)
- Posterior predictive distributions
- Model comparison via marginal likelihoods and Bayes factors
- Understanding conjugacy and analytical solutions

**Bayesian Linear Regression with MCMC**

- Why numerical methods are needed beyond analytical approaches
- Markov Chain Monte Carlo as a general solution for Bayesian inference
- Introduction to Stan via the brms package
- First models with brm and comparison with lm
- MCMC output: trace plots, effective sample size, Rhat
- Interpreting posterior distributions over regression coefficients
- Categorical predictors and varying intercepts and slopes
- Default priors in brms and setting informative priors
- Prior sensitivity analysis and prior and posterior predictive checks
- Model comparison using WAIC, LOO, and Bayes factors

**Extending the Bayesian Framework**

- Robust regression using Student-t distributions
- Modelling heteroskedasticity through distributional regression
- Bayesian logistic regression for binary outcomes
- The logit link and interpreting coefficients
- Other GLM families: Poisson, ordinal regression
- Varying intercepts and varying slopes for grouped data
- Mixed effects extensions of linear and generalised linear models

### Format

- Hands-on workshop with live coding demonstrations and guided practice
- Day 1 focuses on conceptual foundations through analytical examples
- Subsequent sessions focus on practical Bayesian modelling with brms
- All examples use real research datasets from diverse domains
- Complete R code and materials provided for independent learning after the course

### Software

Software requirements and installation instructions are in [software.md](software.md).
