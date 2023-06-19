![Stata](https://img.shields.io/badge/stata-2013-green) ![GitHub Starts](https://img.shields.io/github/stars/Daniel-Pailanir/tscb-ccv?style=social) ![GitHub license](https://img.shields.io/github/license/Daniel-Pailanir/sdid)

# Two-Stage Cluster Bootstrap and Causal Cluster Variance for Stata

## TSCB: Two-Stage Cluster Bootstrap
[tscb.ado](tscb.ado) - A post estimation program to compute the standard error for OLS and FE estimators. We consider the case when $q_k=1$ and $\frac{1}{q_k}=c$ where $c$ can take integer or non-integer values. We follow algorithm 1 of [Abadie et al (2023)](#references).

To install directly into Stata:
```s
net install tscb, from("https://raw.githubusercontent.com/daniel-pailanir/tscb-ccv/master") replace
```

### Syntax
```s
tscb Y W M [if] [in], qk() seed() reps() fe
```

Where Y is an outcome variable, W a binary treatment variable and M a variable indicating the cluster. We provide an example using the data available from the paper:

### OLS Estimates 
```s
webuse set www.damianclarke.net/stata/

webuse "census2000_5pc.dta", clear

* run TSCB
tscb ln_earnings college state, qk(1) seed(2022) reps(150)
```
The code returns the following results

```
Two-Stage Cluster Bootstrap replications (150).
----+--- 1 ---+--- 2 ---+--- 3 ---+--- 4 ---+--- 5
..................................................     50
..................................................     100
..................................................     150

OLS regression with Two-Stage Cluster Bootstrap Variance
                                                Number of obs     =  2,632,838
                                                R-squared         =     0.0567

------------------------------------------------------------------------------
 ln_earnings |      Coef.   Std. Err.      z    P>|z|     [95% Conf. Interval]
-------------+----------------------------------------------------------------
     college |  0.4656426  0.0034122   136.46   0.000    0.4589548   0.4723304
-------------+----------------------------------------------------------------
 Robust SE   |             0.0011619   400.76   0.000    0.4633653   0.4679199
 Cluster SE  |             0.0268800    17.32   0.000    0.4129588   0.5183264
------------------------------------------------------------------------------
```


## CCV: Causal Cluster Variance
[ccv.ado](ccv.ado) - A program to compute the standard error for OLS and FE estimators. 

To install directly into Stata:
```s
net install ccv, from("https://raw.githubusercontent.com/daniel-pailanir/tscb-ccv/master") replace
```

### Syntax
```s
ccv Y W M [if] [in], qk() pk() seed() reps() fe
```

Where Y is an outcome variable, W a binary treatment variable and M a variable indicating the cluster. We provide an example using the data availble from the paper:

### OLS Estimates
```s
webuse set www.damianclarke.net/stata/

webuse "census2000_5pc.dta", clear

* run CCV
ccv ln_earnings college state, pk(0.05) qk(1) seed(2022) reps(8)
```
The code returns the following results

```
Causal Cluster Variance with (8) sample splits.
----+--- 1 ---+--- 2 ---+--- 3 ---+--- 4 ---+--- 5
........
OLS regression with Causal Cluster Variance
                                                Number of obs     =  2,632,838
                                                R-squared         =     0.0567

------------------------------------------------------------------------------
 ln_earnings |      Coef.   Std. Err.      z    P>|z|     [95% Conf. Interval]
-------------+----------------------------------------------------------------
     college |  0.4656426  0.0035393   131.56   0.000    0.4587057   0.4725795
-------------+----------------------------------------------------------------
 Robust SE   |             0.0011619   400.76   0.000    0.4633653   0.4679199
 Cluster SE  |             0.0268800    17.32   0.000    0.4129588   0.5183264
------------------------------------------------------------------------------
```

## References
**When Should You Adjust Standard Errors for Clustering?**, Alberto Abadie, Susan Athey, Guido W Imbens, Jeffrey M Wooldridge, The Quarterly Journal of Economics, 138(1):1-35, 2023.


