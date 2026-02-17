\name{psim}
\alias{psim}
\title{Simulation of P-Approximation}
\usage{
psim(pcoeff, stock, wval = NULL, sdot = NULL)
}
\arguments{
\item{pcoeff}{An approximation result object returned by \code{\link{paprox}}.}

\item{stock}{A numeric vector of stock values at which to evaluate the P-approximation.}

\item{wval}{(Optional) A numeric vector of flow payoff values, \eqn{W(s)}. Must be provided together with \code{sdot} in order to compute the value function.}

\item{sdot}{(Optional) A numeric vector of stock dynamics, \eqn{\dot{s} = \frac{ds}{dt}}. Must be provided together with \code{wval} in order to compute the value function.}
}
\value{
A list containing simulated P-approximation outputs. Use \code{result$item} (or \code{result[["item"]]}) to extract individual components.

\item{shadowp}{Estimated shadow (accounting) prices, \eqn{\hat{p}(s)}.}

\item{iw}{Inclusive wealth, defined as \eqn{\hat{p}(s) \cdot s}.}

\item{vfun}{Estimated value function, \eqn{\hat{V}(s)}. Returned only if both \code{wval} and \code{sdot} are provided; otherwise \code{NULL}.}

\item{stock}{Stock values used for evaluation, returned as a column matrix.}

\item{wval}{Flow payoff values, \eqn{W(s)}, if provided; otherwise \code{NULL}.}
}
\description{
Simulates the P-approximation by evaluating the estimated shadow price function and, optionally, the associated value function over a given set of stock values.
}
\details{
Let \eqn{\hat{\beta}} denote the vector of approximation coefficients returned by \code{\link{paprox}}.
The estimated shadow (accounting) price over the approximation interval
\eqn{s \in [a,b]} is given by:
\cr
\cr
\eqn{\hat{p}(s) = \boldsymbol{\Phi}(s) \, \hat{\boldsymbol{\beta}},}
\cr
\cr
where \eqn{\boldsymbol{\Phi}(s)} denotes the vector of Chebyshev basis functions.
\cr
\cr
If both \code{wval} and \code{sdot} are provided, the estimated value function is computed as:
\cr
\cr
\eqn{ \hat{V}(s) = \frac{1}{\delta} \left( W(s) + \hat{p}(s) \, \dot{s}(s) \right). }
\cr
\cr
For additional theoretical details, see Fenichel and Abbott (2014) and Fenichel et al. (2016).
}
\examples{
## 1-D Reef-fish example: see Fenichel and Abbott (2014)
data("GOM")

param <- GOM$param
simData <- GOM$simData

Aspace <- aproxdef(param$order, param$lowerK, param$upperK, param$delta)

pC <- paprox(
  Aspace,
  simData$stock,
  simData$sdot,
  simData$dsdotds,
  simData$dwds
)

GOMSimP <- psim(
  pC,
  simData$stock,
  simData$profit,
  simData$sdot
)

## Shadow price
plotgen(GOMSimP, xlabel = "Stock size, s", ylabel = "Shadow price")

## Value function and profit
plotgen(
  GOMSimP,
  ftype  = "vw",
  xlabel = "Stock size, s",
  ylabel = c("Value Function", "Profit")
)
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
\code{\link{aproxdef}}, \code{\link{paprox}}, \code{\link{plotgen}}, \code{\link{GOM}}
}