\name{pdotaprox}
\alias{pdotaprox}
\title{Compute Pdot-Approximation Coefficients}
\usage{
pdotaprox(aproxspace, stock, sdot, dsdotds, dsdotdss, dwds, dwdss)
}
\arguments{
  \item{aproxspace}{An approximation space defined by the \code{aproxdef} function.}
  \item{stock}{A vector of stock values, \eqn{s}.}
  \item{sdot}{A vector of stock growth rates, 
    \eqn{\dot{s} = \frac{ds}{dt}}.}
  \item{dsdotds}{A vector of derivatives of stock growth with respect to stock, 
    \eqn{\frac{d \dot{s}}{d s}}.}
  \item{dsdotdss}{A vector of second derivatives of stock growth with respect to stock, 
    \eqn{ \frac{d}{ds} \left( \frac{d \dot{s}}{ds} \right)}.}
  \item{dwds}{A vector of marginal welfare with respect to stock, 
    \eqn{\frac{dW}{ds}}.}
  \item{dwdss}{A vector of second derivatives of marginal welfare with respect to stock, 
    \eqn{\frac{d}{ds} \left( \frac{dW}{ds} \right)}.}
}
\value{
A list containing the approximation results. Individual elements can be accessed
using \code{results$item} or \code{results[["item"]]}. The list includes:
  \item{degree}{Degree of the Chebyshev polynomial.}
  \item{lowerB}{Lower bound of the Chebyshev domain.}
  \item{upperB}{Upper bound of the Chebyshev domain.}
  \item{delta}{Discount rate.}
  \item{coefficient}{Estimated Chebyshev polynomial coefficients.}
}
\description{
Computes Pdot-approximation coefficients for the Chebyshev polynomial
representation of the shadow price derivative using the approximation
space defined by \code{aproxdef}.
Currently, only the one-dimensional case is supported.
}
\details{
The Pdot-approximation solves for the shadow price of a stock, \eqn{p(s)},
using the relationship:
\cr
\cr
\eqn{p(s) = \frac{W_{s}(s) + \dot{p}(s)}{\delta - \dot{s}_{s}}}, \cr
\cr
where \eqn{W_{s} = \frac{dW}{ds}}, 
\eqn{ \dot{p}(s) = \frac{dp}{dt}}, 
\eqn{\dot{s}_{s} = \frac{d\dot{s}}{ds}}, 
and \eqn{\delta} is the discount rate.
\cr
\cr
Taking the time derivative of this expression yields:
\cr
\cr
\eqn{
\dot{p} =
\frac{
\left( W_{ss} \dot{s} + \ddot{p} \right)
\left( \delta - \dot{s}_{s} \right)
+ \left( W_{s} + \dot{p} \right)
\left( \dot{s}_{ss} \dot{s} \right)
}{
\left( \delta - \dot{s}_{s} \right)^2
}
}.
\cr
\cr
Let the approximation be
\eqn{ \dot{p}(s) = \mathbf{\Phi}(s)\mathbf{\beta} },
where \eqn{\mathbf{\Phi}(s)} is a vector of Chebyshev basis functions and
\eqn{\mathbf{\beta}} is the coefficient vector.
Then,
\cr
\cr
\eqn{ \ddot{p} =
\frac{d \dot{p}}{ds} \frac{ds}{dt}
= \mathrm{diag}(\dot{s}) \mathbf{\Phi}_{s}(s) \mathbf{\beta} }.
\cr
\cr
Substituting and rearranging yields the linear system:
\cr
\cr
\eqn{
\mathbf{\beta}
=
A^{-1} B,
}
\cr
where
\cr
\cr
\eqn{
A =
\mathrm{diag} \left( \delta - \dot{s}_{s} \right)^2 \mathbf{\mu}
- \mathrm{diag} \left( \dot{s} (\delta - \dot{s}_{s}) \right) \mathbf{\mu}_{s}
- \mathrm{diag} \left( \dot{s}_{ss} \dot{s} \right) \mathbf{\mu},
}
\cr
\cr
and
\cr
\cr
\eqn{
B =
W_{ss} \dot{s} (\delta - \dot{s}_{s})
+ W_{s} \dot{s}_{ss} \dot{s}.
}
\cr
\cr
In the over-determined case, coefficients are obtained via least squares:
\cr
\cr
\eqn{
\mathbf{\beta}
=
\left( A^{T} A \right)^{-1} A^{T} B.
}
\cr
\cr
For additional theoretical background, see Fenichel and Abbott (2014).
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
}
\references{
Fenichel, Eli P. and Joshua K. Abbott. (2014).
\href{http://www.journals.uchicago.edu/doi/abs/10.1086/676034}{
Natural Capital: From Metaphor to Measurement}.
\emph{Journal of the Association of Environmental and Resource Economists},
1(1/2): 1--27.
}
\seealso{
\code{\link{aproxdef}}, \code{\link{pdotsim}}
}
