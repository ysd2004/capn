# *capn*: Captial Asset Pricing for Nature

![CRAN/METACRAN](https://img.shields.io/cran/v/capn?color=blue) ![](http://cranlogs.r-pkg.org/badges/grand-total/capn?color=blue) 

* This repository develops and distributes a testing version of the R package capn.

* The latest stable release is available on CRAN.

* Data and code in this repository are subject to change.

GitHub Repository maintained by: Seong D. Yun\
Department of Agricultural Economics\
Mississippi State University\
**<yunsd2004@gmail.com>**\
**<https://sites.google.com/site/yunsd2004/>**\
*Last updated: Feb 16, 2026*

------------------------------------------------------------------------

1 *capn* R-package
==========

The capn package implements approximation methods for natural capital asset prices proposed in:

* Abbott, Fenichel, and Yun (2026)
* Fenichel and Abbott (2014)
* Fenichel, Abbott, and Yun (2018)
* Hashida and Fenichel (2022)
* Yun et al. (2017)
* Subsequent methodological extensions

2 Getting started:
==================

2.1. Install the Latest Stable Version from CRAN:
--------------------------------------------------

The official release of *capn* is available on CRAN:

``` r
    ## In R
    install.packages("capn")
    library(capn)
```

2.2. Install the Development (Testing) Version from GitHub:
---------------------------------

A development version is available for testing purposes.


``` r
    ## Need to install devtools packages
    install.packages("devtools")
    ## Then use
    devtools::install_github("ysd2004/capn")
    library(capn)
```

3 Authors
====================================
Seong D. Yun, Associate Professor, Mississippi State University (<yunsd2004@gmail.com>)

Eli P. Fenichel, Professor, Yale University (<eli.fenichel@yale.edu>)

Joshua K. Abbott, Professor, Arizona State Unviersity (<joshua.k.abbott@asu.edu>)

Maintainer and Bug Reports: Seong Yun (<yunsd2004@gmail.com>)

4 Citation
====================================
Please cite the software in academic publications.

4.1. *capn* (stable and latest) from CRAN
---------------------------------

use `citation()`;

```r
citation(package = "capn")
 
# To cite package 'capn' in publications use:

To cite package ‘capn’ in publications use:

  Seong D. Yun, Eli P. Fenichel and Joshua K. Abbott (2017). capn: Capital Asset Pricing for
  Nature. R package version 1.0.0. https://CRAN.R-project.org/package=capn

A BibTeX entry for LaTeX users is

  @Manual{,
    title = {capn: Capital Asset Pricing for Nature},
    author = {Seong Do Yun and Eli P. Fenichel and Joshua K. Abbott},
    year = {2017},
    note = {R package version 1.0.0},
    url = {https://CRAN.R-project.org/package=capn},
  }
```

4.2. *capn* (testing and development) version (GitHub)
---------------------------------
Seong D. Yun, Eli P. Fenichel and Joshua K. Abbott (year). capn: Capital Asset Pricing for Nature. R package version (version /#). https://github.com/ysd2004/capn

5 References
====================================
The methods and examples in *capn* are available from:

* Abbott, J. K., E. P. Fenichel, and S. D. Yun, 2026, "Risky (Natural) Assets: Stochasticity, Nonconvexity, and the Value of Natural Capital"

* Fenichel, E. P. and J. K. Abbott, 2014, "Natural Capital: From Metaphor to Measurement," *Journal of the Association of Environmental and Resource Economists*, 1:1-27. (<https://doi.org/10.1086/676034>)

* Fenichel, E. P., J. K. Abbott, and S. D. Yun, 2018, "The Nature of Natural Capital and Ecosystem Income", *Handbook of Environemntal Economics* (P. Daguta, S. K. Pattanayak, and V. K. Smith eds), 4: 85-142, Elsevier (<https://doi.org/10.1016/bs.hesenv.2018.02.002>) 

* Hashida, Y. and E. P. Fenichel, 2022, "Valuing Natural Capital When Management Is Dominated by Periods of Inaction", *American Journal of Agricultural Economics*, 104(2): 791-811. (<https://doi.org/10.1111/ajae.12250>)

* Yun, S. D., B. Huniczak, J. K. Abbott, and E. P. Fenichel, 2017, "Ecosystem-based Management and the Wealth of Ecosystems," *Proceedings of the National Academy of Sciences*, 114(25): 6539-6544. (<https://doi.org/10.1073/pnas.1617666114>)

6 Development History
====================================

Below is a chronological record of the development of the *capn* R package.

* 2-16-2026: Released *v2.0.0* on GitHub.

* 1-17-2026: Initiated public testing for *v2.0.0*.

* 12-13-2020: Activated the GitHub repository for *capn*.

* 02-08-2020: Development of *v2.0.0* initiated. 

* 11-25-2019: Completed multiple-stock *v*-approximation algorithms.

* 04-28-2019: Implemented multi-stock *v*-approximation for the stochastic *capn* model.\
&nbsp;&nbsp;&nbsp;&nbsp; `vaprox()` became available for multiple-stock cases.

* 11-05-2018: Corrected code errors in the stochastic multi-stock *v*-approximation.

* 05-21-2018: Implemented single-stock *v*-approximation for the stochastic *capn* model.\
&nbsp;&nbsp;&nbsp;&nbsp; - `chebbasisgen()` added for higher-order derivatives.\
&nbsp;&nbsp;&nbsp;&nbsp; - `vaprox()` available for the single-stock case.

* 03-20-2018: Initiated development of the stochastic **{capn}** model.

* 06-15-2017: Official release of *v1.0.0* on CRAN.

* 03-30-2016: Released beta version *v0.0.3* via Seong Yun and Eli Fenichel's website.

* 03-20-2016: Promoted beta version *v0.0.2* at the 2016 Natural Capital Symposium (Stanford University).

* 03-16-2016: Released beta version *v0.0.2* via Seong Yun and Eli Fenichel's website.  

* 01-27-2016: Package renamed to `{capn}` (previously `{nsim}`).

* 01-18-2016: Released beta version *v0.0.1* to the development group under the name `{nsim}`.

* 08-17-2015: Team meeting at Yale University.

* 08-03-2015: Development team formed to create the R package.