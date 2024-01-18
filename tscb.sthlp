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
{synopt :{opt fe}} indicates that a fixed effects model is desired.{p_end}
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
 estimator proposed by {help tscb##TSCB:Abadie et al. (2023)}, for models where average treated
 effects are desired, and where standard error estimates need to account for clustering.
 The TSCB is a variance estimate which considers both the standard sampling component which
 induces variance in estimated regression coefficients, but also incorporates a design-based
 component, accounting for variability in estimates owing to treatment assignment mechanisms.
 When the data which is used to estimate treatment effects includes an important proportion of
 clusters in the full population, standard cluster-robust standard errors can be significantly
 inflated, and the CCV produces a correction for this.
{p_end}

{pstd}
The TSCB work in two stages. First, the fraction treated for each cluster is drawn from empirical distribution of cluster-specific treatment fraction. Second, we samples the treated and control units from each cluster, with their number of units determined in the first stage. The algorithm is explained in detail in {help tscb##TSCB:Abadie et al. (2023)}.
{p_end}

{pstd}
  The {cmd:tscb} command is closely related to the {cmd:ccv} (Causal Cluster
   Variance) command.  {cmd:ccv}
   (if installed) implements an analytic version of the cluster
   variance formula of {help tscb##TSCB:Abadie et al. (2023)}, and shares quite a
   similar syntax and logic.
{p_end}


{marker options}{...}
{title:Options}
{dlgtab:Main}
{phang}
{opt qk}({it:#})  Indicates the proportion of clusters from the population which are
sampled in the data. This value should be strictly greater than 0, and less than
or equal to 1.  Values of 1 imply that all clusters are observed in the data,
whereas values less than 1 imply that only this proportion of clusters were sampled.
This is required. 

{pstd}
{p_end}
 {phang}
{opt fe} Indicates that the underlying estimator desired is a fixed effects estimator
where the dependent variable is regressed on treatment exposure as well as {opt groupvar}
fixed effects.  In this case, the CCV estimator defined in {help ccv##CCV:Abadie et al. (2023)}
section V will be implemented.  If not specified, OLS regressions are implemented.

{pstd}
{p_end} 
{phang}
{opt seed}({it:#})  seed define for pseudo-random numbers. This ensures that variance
estimates can be replicated exactly if desired, despite bootstrap resampling.

{pstd}
{p_end}
{phang}
{opt reps}({it:#}) number of repetitions used for conducting bootstrap resamples. Default is 50.

{pstd}
{p_end}


{title:Stored results}

{synoptset 15 tabbed}{...}

{cmd:tscb} stores the following in {cmd:e()}:

{synoptset 20 tabbed}{...}
{p2col 5 20 24 2: Scalars}{p_end}
{synopt:{cmd:e(ATE)}}Average Treatment Effect {p_end}
{synopt:{cmd:e(se_tscb)}}Two-Stage Cluster Bootstrap (TSCB) standard error {p_end}
{synopt:{cmd:e(se_robust)}}Heteroskedasticity robust standard error {p_end}
{synopt:{cmd:e(se_cluster)}}Cluster robust standard error {p_end}
{synopt:{cmd:e(reps)}}Number of bootstrap resamples {p_end}
{synopt:{cmd:e(N_clust)}}Number of units (groups) observed in the original panel {p_end}


{synoptset 20 tabbed}{...}
{p2col 5 20 24 2: Macros}{p_end}
{synopt:{cmd:e(cmd)}}Returns command name (tscb){p_end}
{synopt:{cmd:e(cmdline)}}Returns command as typed {p_end}
{synopt:{cmd:e(depvar)}}Lists name of dependent variable {p_end}
{synopt:{cmd:e(clustvar)}}Provides the name of the unit (group) variable {p_end}


{pstd}
{p_end}

{marker examples}{...}
{title:Examples}

{pstd}
Load data from 1% extract from 2000 US Census (20-50 years old) {help tscb##TSCB:Abadie et al. (2023)}.

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
{phang} Alberto Abadie, Susan Athey, Guido W Imbens, Jeffrey M Wooldridge (2023).
{browse "https://academic.oup.com/qje/advance-article-abstract/doi/10.1093/qje/qjac038/6750017?redirectedFrom=fulltext&login=false":{it:When Should You Adjust Standard Errors for Clustering?}.} The Quarterly Journal of Economics, 138(1):1-35.
{p_end}


{title:Author}
Damian Clarke, Universidad de Chile.
Email {browse "mailto:dclarke@fen.uchile.cl":dclarke@fen.uchile.cl}
Website {browse "http://www.damianclarke.net/"}

Daniel Pailañir, Universidad de Chile.
Email {browse "mailto:dpailanir@fen.uchile.cl":dpailanir@fen.uchile.cl}
Website {browse "https://daniel-pailanir.github.io/"}

{title:Website}
{cmd:tscb} is maintained at {browse "https://github.com/Daniel-Pailanir/TSCB-CCV": https://github.com/Daniel-Pailanir/TSCB-CCV} 
