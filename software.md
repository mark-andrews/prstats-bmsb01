# Software Requirements and Installation

All software required for this course is free and open-source and runs identically on Windows, Mac OS X, and Linux.

## Installing R

Download and install R from <https://cran.r-project.org>.
On Windows the installer is at <https://cran.r-project.org/bin/windows/base/>.
On macOS the installer is at <https://cran.r-project.org/bin/macosx/>.

## Choosing an IDE

You need an editor that lets you run R interactively.
RStudio is the most widely used option and an excellent choice: download it from <https://posit.co/download/rstudio-desktop>.
Positron is a newer data science IDE from the same company and is equally capable: download it from <https://positron.posit.co>.
Either will work well for this course.

## R Packages

Once R is installed, open R or your IDE and run the following to install the required packages:

```r
install.packages("tidyverse")
install.packages("brms")
```

## Installing Stan

The `brms` package interfaces with Stan, a probabilistic programming language for Bayesian inference.
Stan is an external program that requires C++ build tools, which makes installation slightly more involved than a typical R package.

Detailed installation instructions for Stan (via the `rstan` package) on all platforms are at:

- <https://github.com/stan-dev/rstan/wiki/RStan-Getting-Started>

Follow the instructions for your operating system before installing `brms`.
Once the C++ toolchain is in place, `brms` can be installed and will bring in Stan automatically.

## Verifying the Stan and brms Installation

Run the following to confirm everything is working.
This fits a trivial model and should complete in about a minute:

```r
library(tidyverse)
library(brms)

data_df <- tibble(x = rnorm(10))
M <- brm(x ~ 1, data = data_df)
```

If that runs without error, Stan and `brms` are installed correctly.

## The `priorexposure` Package

The `priorexposure` package is a small package used in the first part of the course for illustrating prior and posterior distributions analytically.
It can be installed from GitHub using `devtools`:

```r
install.packages("devtools")
devtools::install_github("mark-andrews/priorexposure")
```

When prompted to update dependent packages, you do not need to update them unless they are very out of date.
You can also suppress the prompt with:

```r
devtools::install_github("mark-andrews/priorexposure", upgrade = "never")
```
