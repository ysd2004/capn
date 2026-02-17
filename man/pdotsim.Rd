\name{pdotsim}
\alias{pdotsim}
\title{Simulation of Pdot-Approximation}
\usage{
pdotsim(pdotcoeff, stock, sdot, dsdotds, wval, dwds)
}
\arguments{
\item{pdotcoeff}{An approximation result from the \code{pdotaprox} function.}

\item{stock}{A numeric vector of stock values, \eqn{s}.}

\item{sdot}{A numeric vector of stock growth rates,
\eqn{\dot{s} = \frac{ds}{dt}}.}

\item{dsdotds}{A numeric vector of derivatives of stock growth with respect
to stock, \eqn{\frac{d \dot{s}}{d s}}.}

\item{wval}{A numeric vector of \eqn{W}-values.}

\item{dwds}{A numeric vector of marginal \eqn{W}-values,
\eqn{\frac{dW}{ds}}.}
}
\value{
A list of approximation results. Use \code{results$item}
(or \code{results[["item"]]}) to extract individual components:
\item{shadowp}{Estimated shadow (accounting) prices, \eqn{\hat{p}(s)}.}
\item{iw}{Inclusive wealth, \eqn{\hat{p}(s)\, s}.}
\item{vfun}{Estimated value function, \eqn{\hat{V}(s)}.}
\item{stock}{Stock values used in the simulation.}
\item{wval}{\eqn{W}-values used in the simulation.}
}
\description{
Simulates shadow prices and value functions using coefficients from
the Pdot-approximation obtained via \code{pdotaprox}.
}
\details{
Let \eqn{\hat{\beta}} denote the vector of approximation coefficients
from \code{pdotaprox}. Over the approximation interval
\eqn{s \in [a,b]}, the estimated shadow (accounting) price is given by:
\cr
\cr
\eqn{ \hat{p}(s) =
\frac{ W_{s}(s) + \mathbf{\mu}(s)\hat{\beta} }
     { \delta - \dot{s}_{s}(s) } }.
\cr
\cr
The corresponding estimated value function is:
\cr
\cr
\eqn{ \hat{V}(s) =
\frac{1}{\delta}
\left( W(s) + \hat{p}(s)\, \dot{s}(s) \right) }.
\cr
\cr
These expressions follow directly from the Pdot-approximation framework
developed in Fenichel and Abbott (2014) and Fenichel et al. (2016).
}
\examples{
## 1-D Reef-fish example: see Fenichel and Abbott (2014)
data("GOM")

param <- GOM$param
simData <- GOM$simData

Aspace <- aproxdef(param$order, param$lowerK, param$upperK, param$delta)

pdotC <- pdotaprox(
  Aspace,
  simData$stock,
  simData$sdot,
  simData$dsdotds,
  simData$dsdotdss,
  simData$dwds,
  simData$dwdss
)

GOMSimPdot <- pdotsim(
  pdotC,
  simData$stock,
  simData$sdot,
  simData$dsdotds,
  simData$profit,
  simData$dwds
)

## Shadow price
plotgen(GOMSimPdot,
        xlabel = "Stock size, s",
        ylabel = "Shadow price")

## Value function and profit
plotgen(GOMSimPdot,
        ftype  = "vw",
        xlabel = "Stock size, s",
        ylabel = c("Value Function", "Profit"))
}
\references{
Fenichel, Eli P. and Joshua K. Abbott. (2014) 
"\href{http://www.journals.uchicago.edu/doi/abs/10.1086/676034}{Natural Capital: From Metaphor to Measurement}."
\emph{Journal of the Association of Environmental Economists}. 1(1/2):1--27.\cr

Fenichel, Eli P., Joshua K. Abbott, Jude Bayham, Whitney Boone, Erin M. K. Haacker, and Lisa Pfeiffer. (2016) 
"\href{http://www.pnas.org/content/113/9/2382}{Measuring the Value of Groundwater and Other Forms of Natural Capital}."
\emph{Proceedings of the National Academy of Sciences}. 113:2382--2387.
}
\seealso{
\code{\link{aproxdef}}, \code{\link{pdotaprox}}, \code{\link{plotgen}}, \code{\link{GOM}}
}