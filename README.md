# Homework 3
BIOE 498/598 PJ, Spring 2020

*Due Wednesday, April 8th by 5pm CDT.*

### Overview

Your goal is to optimize production of acetoin, a byproduct secreted by an
engineered strain of the Gram
positive bacterium *Lactococcus lactis*. A previous screening experiment
identified five factors that affect the titers of acetoin. You will vary these
factors over the following ranges:

Factor | Coded Variable | Low Level (-1) | High Level (+1) | Units
-------|----------------|----------------|-----------------|------
pH  | `x1`   |  6.0 |  7.2 |
stirring rate  | `x2`  | 40  | 60  | RPM
[lactose]  | `x3` | 80  | 120  | mM
[casamino acids]  |  `x4` | 0.4  | 0.6  | g/L
[nisin]  | `x5`  | 0.2  | 0.4  | mM

 * Lactose is the preferred carbon source for *L. lactis*.
 * Casamino acids are a nitrogen source made from digested soy protein.
 * Nisin is a peptide that induces expression of the acetoin production pathway.
 * The units of the response variable (acetoin titer) are mg/L.

### Setup

Rather than run the experiments yourself, you will add the response data
using this R package. If you haven't already, install the `devtools` package:

```{r}
install.packages("devtools")
```
If you have a Windows machine you may need to install the [`Rtools` package](https://cran.r-project.org/bin/windows/Rtools/)
before installing `devtools`

Next, install and load this package:

```{r}
devtools::install_github("bioe498/bioe498pj.hw3")
library("bioe498pj.hw3")
```

This package includes a function `run_experiments` that adds the responses
to your design object. The function returns a new design object with the
`titer` column filled in. If your CCD is stored in a variable named `design`, then
```{r}
design <- run_experiments(design, block=1)
```
will add the responses for the first block of runs (the factorial points).

### Procedure

1. Using the `rsm` package, set up a full-factorial, rotatable CCD.
Do not randomize the run order. Set the variable codings using the names in
the above table and name the response variable `titer`. Make sure your
design includes a blocking factor so you can perform the factorial and axial
runs separately.

2. Use the `run_experiments` function with `block=1` to add the responses for the
factorial experiments.

3. Build a RSM model using FO and TWI terms. Does the FO and TWI surface fit the
data well? Does this model have a reasonable stationary point? If so, is it
a minimum, maximum, or a saddle point?

4. Use the `run_experiments` function with `block=2` to add the responses for the
axial experiments.

5. Build an SO RSM model. Do the second-order terms improve the model?
Does this model have a reasonable stationary point? If so, is it
a minimum, maximum, or a saddle point?

6. Use the `steepest` function to find the conditions with the maximum acetoin titer
within the design space. What are the optimal operating conditions?

7. Repeat the above steps using a CCD with a 2^5-1 Fractional Factorial Design.

### Submission

Submit your code, R output, and your answers to every question as a PDF on Gradescope.
