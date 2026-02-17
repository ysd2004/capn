\name{aproxdef}
\alias{aproxdef}
\title{Define Approximation Space}
\usage{
aproxdef(deg, lb, ub, delta)
}
\arguments{
  \item{deg}{A vector specifying the number of polynomials (degrees of Chebyshev polynomials) 
  in each dimension.}
  \item{lb}{A vector of lower bounds for each dimension.}
  \item{ub}{A vector of upper bounds for each dimension.}
  \item{delta}{A numeric scalar specifying the discount rate.}
}
\value{
A list defining the approximation space, containing polynomial degrees, bounds, and discount rate.
}
\description{
Define an approximation space for the value function and price function approximation methods 
(\code{V}, \code{P}, and \code{Pdot}).
}
\details{
For the \eqn{i}-th dimension, \eqn{i = 1, 2, \ldots, d}, suppose a polynomial approximant
over a bounded interval \eqn{[a_{i}, b_{i}]} is defined using Chebyshev polynomials. 
Then, a \eqn{d}-dimensional approximation domain is defined as:\cr
\cr
\eqn{\mathbf{S} = \left\{ (s_{1}, s_{2}, \ldots, s_{d}) \mid 
a_{i} \leq s_{i} \leq b_{i}, \; i = 1, 2, \ldots, d \right\}. }\cr
\cr
Suppose \eqn{n_{i}} Chebyshev polynomials (i.e., degree \eqn{n_{i}-1}) are used for the \eqn{i}-th dimension.
The approximation space is defined by:\cr
\cr
\code{deg = c(}\eqn{n_{1}, n_{2}, \ldots, n_{d}}\code{)},\cr
\code{lb  = c(}\eqn{a_{1}, a_{2}, \ldots, a_{d}}\code{)}, and\cr
\code{ub  = c(}\eqn{b_{1}, b_{2}, \ldots, b_{d}}\code{)}.\cr
\cr
The argument \code{delta} is the constant discount rate used in the approximation.
}
\examples{
## Reef-fish example: see Fenichel and Abbott (2014)
delta <- 0.02          # discount rate
upper <- 359016000     # upper bound on approximation space
lower <- 5e+6          # lower bound on approximation space

myspace <- aproxdef(50, lower, upper, delta)

## Two-dimensional example
ub <- c(1.5, 1.5)
lb <- c(0.1, 0.1)
deg <- c(20, 20)
delta <- 0.03

myspace <- aproxdef(deg, lb, ub, delta)
}
\references{
Fenichel, Eli P. and Joshua K. Abbott (2014).
\emph{Natural Capital: From Metaphor to Measurement}.
Journal of the Association of Environmental and Resource Economists, 1(1--2), 1--27.
}