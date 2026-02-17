\name{chebgrids}
\alias{chebgrids}
\title{Generate Chebyshev Grids}
\usage{
chebgrids(nnodes, lb, ub, rtype = NULL)
}
\arguments{
  \item{nnodes}{A vector specifying the number of nodes in each dimension.}
  \item{lb}{A vector of lower bounds for each dimension.}
  \item{ub}{A vector of upper bounds for each dimension.}
  \item{rtype}{Type of return value. The default \code{NULL} returns a list. 
  If \code{rtype = "list"}, a list is returned. 
  If \code{rtype = "grid"}, a matrix is returned.}
}
\value{
A list with \eqn{d} elements of Chebyshev nodes, or a 
\eqn{ \left( \displaystyle \prod_{i=1}^{d} n_{i} \right) \times d} 
matrix of Chebyshev grid points.
}
\description{
Generate a multi-dimensional Chebyshev grid over bounded intervals.
}
\details{
For the \eqn{i}-th dimension, \eqn{i = 1, 2, \ldots, d}, suppose a polynomial approximant
\eqn{s_{i}} over a bounded interval \eqn{[a_{i}, b_{i}]} is defined using Chebyshev nodes. 
Then, a \eqn{d}-dimensional Chebyshev grid is defined as:\cr
\cr
\eqn{\mathbf{S} = \left\{ (s_{1}, s_{2}, \ldots, s_{d}) \mid 
a_{i} \leq s_{i} \leq b_{i}, \; i = 1, 2, \ldots, d \right\}. }\cr
\cr
This corresponds to all combinations of the marginal Chebyshev grids \eqn{s_{i}}. 
Two types of return values are provided. 
\code{rtype = "list"} returns a list of length \eqn{d} containing the marginal grids, 
whereas \code{rtype = "grid"} returns a 
\eqn{ \left( \displaystyle \prod_{i=1}^{d} n_{i} \right) \times d} matrix of all grid points.
}
\examples{
## Chebyshev grid with two dimensions
chebgrids(c(5, 3), c(1, 1), c(2, 3))

## Returns the same result explicitly as a list
chebgrids(c(5, 3), c(1, 1), c(2, 3), rtype = "list")

## Returns a matrix of grid points over the same domain
chebgrids(c(5, 3), c(1, 1), c(2, 3), rtype = "grid")

## Chebyshev grid with one dimension
chebgrids(5, 1, 2)
chebnodegen(5, 1, 2)

## Chebyshev grid with three dimensions
chebgrids(c(3, 4, 5), c(1, 1, 1), c(2, 3, 4), rtype = "grid")
}
\seealso{
\code{\link{chebnodegen}}
}
