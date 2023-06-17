{smcl}
{* *! version 1.0.0 November 15, 2022}
{title:Title}

{p 4 4 2}
{cmdab:tscb} {hline 2} Two-Stage Cluster Bootstrap Estimator

{marker syntax}{...}
{title:Syntax}

{p 4 4 2}
{opt tscb} {opt depvar} {opt treatment} {opt groupvar} {ifin}{cmd:,} {it:qk(#)} [{it:options}]

{synoptset 29 tabbed}{...}
{synopthdr}
{synoptline}
{synopt :{opt qk}({it:#})} proportion of cluster from population.{p_end}
{synopt :{opt seed}({it:#})} set random-number seed to #.{p_end}
{synopt :{opt reps}({it:#})} repetitions for bootstrap.{p_end}
{pstd}
{p_end}
{synoptline}
{p2colreset}{...}
{p 4 6 2}

{marker description}{...}
{title:Description}
{pstd}

{pstd}
 {cmd:tscb} implements the Two-Stage Cluster Bootstrap Estimator (TSCB), a bootstrap variance
 estimator proposed by {help tscb##TSCB:Abadie et al. (2022)}, for models where average treated
 effects are desired, and where standard error estimates need to account for clustering.
 The TSCB is a variance estimate which considers both the standard sampling component which
 induces variance in estimated regression coefficients, but also incorporates a design-based
 component, accounting for variability in estimates owing to treatment assignment mechanisms.
 When the data which is used to estimate treatment effects includes an important proportion of
 clusters in the full population, standard cluster-robust standard errors can be significantly
 inflated, and the CCV produces a correction for this.
{p_end}

{pstd}
The TSCB work in two stages. First, the fraction treated for each cluster is drawn from empirical distribution of cluster-specific treatment fraction. Second, we samples the treated and control units from each cluster, with their number of units determined in the first stage. The algorithm is explained in detail in {help tscb##TSCB:Abadie et al. (2022)}.
{p_end}

{pstd}
  The {cmd:tscb} command is closely related to the {cmd:ccv} (Causal Cluster
   Variance) command.  {cmd:ccv}
   (provided that it is installed) implements an analytic version of the cluster
   variance formula of {help tscb##TSCB:Abadie et al. (2022)}, and shares quite a
   similar syntax and logic.
{p_end}


{marker options}{...}
{title:Options}
{dlgtab:Main}
{phang}
{opt qk}({it:#}) proportion of cluster from population. This is required.

{pstd}
{p_end}
{phang}
{opt seed}({it:#}) seed define for pseudo-random numbers.

{pstd}
{p_end}
{phang}
{opt reps}({it:#}) repetition of bootstrap. Default is 50.

{pstd}
{p_end}


{title:Stored results}

{synoptset 15 tabbed}{...}

{cmd:tscb} stores the following in {cmd:e()}:

{synoptset 20 tabbed}{...}
{p2col 5 20 24 2: Scalars}{p_end}
{synopt:{cmd:e(se_ols)}}Standard error of the OLS estimator{p_end}
{synopt:{cmd:e(se_fe)}}Standard error of the FE estimator {p_end}
{synopt:{cmd:e(reps)}}Number of bootstrap {p_end}
{synopt:{cmd:e(N_clust)}}Number of clusters {p_end}


{synoptset 20 tabbed}{...}
{p2col 5 20 24 2: Macros}{p_end} 
{synopt:{cmd:e(cmd)}}tscb{p_end}
{synopt:{cmd:e(cmdline)}}command as typed{p_end}
{synopt:{cmd:e(depvar)}}name of dependent variable{p_end}
{synopt:{cmd:e(clustvar)}}name of cluster variable{p_end}


{pstd}
{p_end}

{marker examples}{...}
{title:Examples}

{pstd}
Load data from 1% extract from 2000 US Census (20-50 years old) Abadie et al., (2020).

{pstd}
 . {stata webuse set www.damianclarke.net/stata/}
 
{pstd}
 . {stata webuse "census2000_1pc.dta", clear}
 
{pstd}
Run regression without FE.

{pstd}
 . {stata tscb ln_earnings college state, qk(1)}
 
{pstd}
Using FE at state level.

{pstd}
 . {stata tscb ln_earnings college state, fe qk(1)}
 
{pstd}
Over another dependent variable.

{pstd}
 . {stata tscb hours college state, qk(1)}

{pstd}
Using FE at state level.

{pstd}
 . {stata tscb hours college state, fe qk(1)}
 
{pstd}
Using a bigger sample at 5 percent.

{pstd}
 . {stata webuse "census2000_5pc.dta", clear}
 
{pstd}
 . {stata tscb ln_earnings college state, qk(1)}

{pstd}
 . {stata tscb ln_earnings college state, fe qk(1)}
 
{marker references}{...}
{title:References}

{marker TSCB}{...}
{phang} Alberto Abadie, Susan Athey, Guido W Imbens, Jeffrey M Wooldridge. 2022.
{browse "https://academic.oup.com/qje/advance-article-abstract/doi/10.1093/qje/qjac038/6750017?redirectedFrom=fulltext&login=false":{it:When Should You Adjust Standard Errors for Clustering?}.} The Quarterly Journal of Economics.
{p_end}


{title:Author}


