\name{paprox}
\alias{paprox}
\title{Calculate P-Approximation Coefficients}
\usage{
paprox(aproxspace, stock, sdot, dsdotds, dwds)
}
\arguments{
\item{aproxspace}{An approximation space defined by the \code{aproxdef} function.}

\item{stock}{A vector or array of stock values, \eqn{s}.}

\item{sdot}{A vector or array of stock dynamics, \eqn{\dot{s} = \frac{ds}{dt}}.}

\item{dsdotds}{A vector or array of derivatives of stock dynamics with respect to stock,
\eqn{\frac{d \dot{s}}{d s}}.}

\item{dwds}{A vector or array of marginal value of the flow payoff with respect to stock,
\eqn{\frac{dW}{ds}}.}
}
\value{
A list containing the P-approximation results. Components can be accessed using
\code{results$item} or \code{results[["item"]]}. The list includes:
\item{degree}{Degree of the Chebyshev polynomial approximation.}
\item{lowerB}{Lower bound of the approximation domain.}
\item{upperB}{Upper bound of the approximation domain.}
\item{delta}{Discount rate.}
\item{coefficient}{Estimated Chebyshev polynomial coefficients for the shadow price function.}
}
\description{
Computes the P-approximation coefficients for the shadow price function using
Chebyshev polynomial approximation as defined by \code{aproxdef}.
Currently, only the one-dimensional deterministic case is supported.
}
\details{
The P-approximation solves for the shadow price of a stock, \eqn{p(s)}, from:
\cr
\cr
\eqn{p(s) = \frac{W_{s}(s) + \dot{p}(s)}{\delta - \dot{s}_{s}(s)}}, \cr
\cr
where \eqn{W_{s} = \frac{dW}{ds}}, \eqn{\dot{p}(s) = \frac{dp}{ds}},
\eqn{\dot{s}_{s} = \frac{d\dot{s}}{ds}}, and \eqn{\delta} is the discount rate.
\cr
\cr
The shadow price function is approximated as:
\cr
\eqn{p(s) = \boldsymbol{\Phi}(s) \boldsymbol{\beta}}, \cr
\cr
where \eqn{\boldsymbol{\Phi}(s)} is a vector of Chebyshev basis functions and
\eqn{\boldsymbol{\beta}} is the vector of unknown coefficients.
\cr
\cr
Using the chain rule and Chebyshev basis properties:
\cr
\eqn{\dot{p}(s) = \mathrm{diag}(\dot{s}) \, \boldsymbol{\Phi}_{s}(s) \boldsymbol{\beta}}.
\cr
\cr
Substituting into the pricing equation yields:
\cr
\eqn{
\boldsymbol{\beta}
=
\left(
\mathrm{diag}(\delta - \dot{s}_{s}) \boldsymbol{\Phi}
-
\mathrm{diag}(\dot{s}) \boldsymbol{\Phi}_{s}
\right)^{-1}
W_{s}
}.
\cr
\cr
In the over-determined case (more nodes than approximation degrees), the function
uses a least-squares solution:
\cr
\eqn{
\boldsymbol{\beta}
=
\left( A^{T} A \right)^{-1} A^{T} W_{s},
}
\cr
where:
\cr
\eqn{
A =
\mathrm{diag}(\delta - \dot{s}_{s}) \boldsymbol{\mu}
-
\mathrm{diag}(\dot{s}) \boldsymbol{\mu}_{s}.
}
\cr
\cr
See Fenichel et al. (2016) for additional theoretical background.
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
}
\references{
Fenichel, Eli P. and Joshua K. Abbott. (2014)
"\href{http://www.journals.uchicago.edu/doi/abs/10.1086/676034}{Natural Capital: From Metaphor to Measurement}."
\emph{Journal of the Association of Environmental Economists}. 1(1/2): 1--27.\cr

Fenichel, Eli P., Joshua K. Abbott, Jude Bayham, Whitney Boone,
Erin M. K. Haacker, and Lisa Pfeiffer. (2016)
"\href{http://www.pnas.org/content/113/9/2382}{Measuring the Value of Groundwater and Other Forms of Natural Capital}."
\emph{Proceedings of the National Academy of Sciences}. 113: 2382--2387.
}
\seealso{
\code{\link{aproxdef}}, \code{\link{psim}}, \code{\link{GOM}}
}
