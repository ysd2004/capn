# *capn*: Captial Asset Pricing for Nature

*Data and code are subject to change*

GitHub Repository maintained by: Seong Yun\
Department of Agricultural Economics\
Mississippi State University\
**<seong.yun@msstate.edu>**\
*Last updated: Dec 13, 2020*

------------------------------------------------------------------------

1 *capn* R-package
==========

A collection of functions that implements the approximation methods for natural capital asset prices suggested by Fenichel and Abbott (2014) in Journal of the Associations of Environmental and Resource Economists, Fenichel et al. (2016) in Proceedings of the National Academy of Sciences, and a third method, and its extensions to multiple stocks (where feasible): creating Chebyshev polynomial nodes and grids, calculating basis of Chebyshev polynomials, approximation and their simulations for: V-approximation (single and multiple stocks), P-approximation (single stock, PNAS), and Pdot-approximation (single stock, JAERE).

2 Getting started:
==================

2.1. Install the latest version (complete) of *capn* from the R-CRAN repository:
--------------------------------------------------

The latest version of *capn* is available from the R-CRAN repository. Users can install and use all functions and features directly installing it from the R-CRAN repository.

``` r
    ## In R
    install.packages("capn")
    library(capn)
```

2.2. Install *capn* testing version from the github repository:
---------------------------------

For your testing purpose, a version currently developing is available from this GitHub repository.


``` r
    ## Need to install devtools packages
    install.packages("devtools")
    ## Then use
    devtools::install_github("ysd2004/capn")
    library(capn)
```

3 Development History
====================================

Below are the development history of R-package *capn*.

* 12-13-2020: GiHub *capn* repository was activated

* 02-08-2020: Initiated to develop *capn* v.2.0.0 

* 11-25-2019: multiple stocks v-aproximation codes were completed

* 04-28-2019: multiple stocks v-aproximation for stochastic *capn* was coded

** *vaprox* was availble for multiple stocks

* 11-05-2018: Code error in v-aproximation for stochastic *capn* was corrected

* 05-21-2018: Single stock v-aproximation for stochastic *capn* was coded\
&nbsp;&nbsp;&nbsp; Major updates\
&nbsp;&nbsp;&nbsp;&nbsp; *chebbasisgen* was availble for a higher order derivatives
&nbsp;&nbsp;&nbsp;&nbsp; *vaprox* was available for a single stock case

* 03-20-2018: Initiated to develop stochstic capn model

* 06-15-2017: Official release of v.1.0.0 through R-CRAN repository

* 03-30-2016: The beta test version v.0.0.3 was released through Seong Yun and Eli Fenichel's website\
&nbsp;&nbsp;&nbsp; Major updates\
&nbsp;&nbsp;&nbsp;&nbsp; Changes of the order of input arguemnt in *aprox* and *sim* function\
&nbsp;&nbsp;&nbsp;&nbsp; e.g.) *vaprox(stada,aprodxspace)* -> *vaprox(aproxspace,sdata)*\
&nbsp;&nbsp;&nbsp;&nbsp; relevant functions: *pdotaprox*, *paprox*, *vaprox*, *pdotsim*, *psim*, and *vsim*\
&nbsp;&nbsp;&nbsp; Two new function\
&nbsp;&nbsp;&nbsp;&nbsp; *plotgen*: plot generator for shadow price or value function\
&nbsp;&nbsp;&nbsp;&nbsp; *unigirds*: generating uniform grids\
&nbsp;&nbsp;&nbsp; Two dimensional example is included\
&nbsp;&nbsp;&nbsp;&nbsp; LV example
&nbsp;&nbsp;&nbsp; Demonstration files are available\
&nbsp;&nbsp;&nbsp;&nbsp; GOM and LV\
&nbsp;&nbsp;&nbsp; Reported typos since v.0.0.2 were corrected\
&nbsp;&nbsp;&nbsp; Manual was updated for new updates and better reading

* 03-20-2016: The best test version v.0.0.2 was promoted at the 2016 Natural Capital Symposium at Stanford University

* 03-16-2016: The beta test version v.0.0.2 was released through Seong Yun and Eli Fenichel's website   

* 01-27-2016: The package name was changed to /{*capn*/} 

* 01-18-2016: The beta test version v.0.0.1 was released to the developing group. The package named /{*nsim*/}

* 08-17-2015: Team meeting at Yale University

* 08-03-2015: Development team launched to write an R-package


4 References
==================================================

