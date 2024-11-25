
<!-- README.md is generated from README.Rmd. Please edit that file -->

# gghat

<!-- badges: start -->
<!-- badges: end -->

The goal of gghat is to add functionality to ggplot2, such that hat
plots are included in its repertoire. To this end, gghat includes
geom_hat() as well as compatible positions to be used with geom_text()
and geom_errorbar().

## Installation

You can install the development version of gghat from GitHub:

``` r
# install.packages("devtools")
# library devtools
devtools::install_github("eliashyde/gghat")
```

## Example

Below is an example of gghat’s functionality in the context of the
tidyverse:

``` r
library(tidyverse)
#> ── Attaching core tidyverse packages ──────────────────────── tidyverse 2.0.0 ──
#> ✔ dplyr     1.1.4     ✔ readr     2.1.5
#> ✔ forcats   1.0.0     ✔ stringr   1.5.1
#> ✔ ggplot2   3.5.1     ✔ tibble    3.2.1
#> ✔ lubridate 1.9.3     ✔ tidyr     1.3.1
#> ✔ purrr     1.0.2     
#> ── Conflicts ────────────────────────────────────────── tidyverse_conflicts() ──
#> ✖ dplyr::filter() masks stats::filter()
#> ✖ dplyr::lag()    masks stats::lag()
#> ℹ Use the conflicted package (<http://conflicted.r-lib.org/>) to force all conflicts to become errors
library(gghat)

my_data <- tibble(
  treatment = c("A", "B", "C", "D"),
  pre_treatment_means = c(50, 53, 48, 50),
  post_treatment_means = c(51, 49, 55, 52)
) |> 
  pivot_longer(!treatment, names_to = "condition", values_to = "mean") |> 
  mutate(condition = fct_relevel(condition, "pre_treatment_means", "post_treatment_means"))

ggplot(my_data, aes(x = treatment, y = mean, group = condition)) +
  geom_hat(backwards = FALSE, width = 0.75) +
  geom_text(aes(label = mean),
            position = position_dodgedifftext(width = 0.75, nudge = 0.6)) +
  coord_cartesian(ylim = c(40, 60)) +
  theme_minimal() +
  xlab("") +
  ylab("")
```

<img src="man/figures/README-example-1.png" width="100%" />
