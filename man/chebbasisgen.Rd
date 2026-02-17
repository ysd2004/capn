\name{chebbasisgen}
\alias{chebbasisgen}
\title{Generate Unidimensional Chebyshev Polynomial Basis}
\usage{
chebbasisgen(nodes, npol, a, b, dorder = NULL)
}
\arguments{
\item{nodes}{A numeric vector of Chebyshev nodes \eqn{s_{i}} 
(an array of nodes in the \code{capn} package).}

\item{npol}{An integer specifying the number of polynomials 
(\eqn{n} polynomials correspond to degree \eqn{n-1}).}

\item{a}{The lower bound of the interval \eqn{[a, b]}.}

\item{b}{The upper bound of the interval \eqn{[a, b]}.}

\item{dorder}{Order of the partial derivative of the basis. 
The default \code{NULL} returns the basis itself. 
If \code{dorder = 1}, the first derivative is returned. 
Higher-order derivatives can be requested with \code{dorder >= 2}.}
}
\value{
A numeric matrix of dimension \eqn{m \times n}, where \eqn{m} is the number of nodes 
and \eqn{n = npol}, containing the Chebyshev polynomial basis (Vandermonde matrix) 
or its derivatives.
}
\description{
Compute the monomial basis of Chebyshev polynomials for given unidimensional nodes 
\eqn{s_{i}} over a bounded interval \eqn{[a, b]}.
}
\details{
Suppose there are \eqn{m} Chebyshev nodes over a bounded interval \eqn{[a, b]}:\cr
\cr
\eqn{s_{i} \in [a, b],} for \eqn{i = 1, 2, \ldots, m}.\cr
\cr
These nodes are normalized to the standard Chebyshev domain \eqn{[-1, 1]} as:\cr
\cr
\eqn{z_{i} = \frac{2(s_{i} - a)}{b - a} - 1}.\cr
\cr
With normalized Chebyshev nodes, the recurrence relations for Chebyshev polynomials are:\cr
\cr
\eqn{T_{0}(z_{i}) = 1},\cr
\eqn{T_{1}(z_{i}) = z_{i}}, and\cr
\eqn{T_{n}(z_{i}) = 2 z_{i} T_{n-1}(z_{i}) - T_{n-2}(z_{i})}.\cr
\cr
The interpolation (Vandermonde) matrix of Chebyshev polynomials of degree up to \eqn{n-1}
with \eqn{m} nodes, \eqn{\Phi_{mn}}, is:\cr
\cr
\eqn{ \Phi_{mn} = \left[ \begin{array}{ccccc}
1 & T_{1}(z_{1}) & \cdots & T_{n-1}(z_{1})\\
1 & T_{1}(z_{2}) & \cdots & T_{n-1}(z_{2})\\
\vdots & \vdots & \ddots & \vdots\\
1 & T_{1}(z_{m}) & \cdots & T_{n-1}(z_{m})
\end{array} \right] }.\cr
\cr
Derivatives of the basis are computed using the identity:\cr
\cr
\eqn{(1 - z_{i}^{2}) T'_{n}(z_{i}) 
= n \left[ T_{n-1}(z_{i}) - z_{i} T_{n}(z_{i}) \right].}\cr
\cr
Further technical details on Chebyshev polynomial bases can be found in 
Amparo et al. (2007) and Miranda and Fackler (2002).
}
\examples{
## Reef-fish example: see Fenichel and Abbott (2014)
data("GOM")
param <- GOM$param
nodes <- chebnodegen(
  param$nodes,
  param$lowerK,
  param$upperK
)

## Chebyshev polynomial basis
chebbasisgen(nodes, 20, 0.1, 1.5)

## First derivative of the Chebyshev polynomial basis
chebbasisgen(nodes, 20, 0.1, 1.5, dorder = 1)
}
\references{
Amparo, Gil, Javier Segura, and Nico Temme (2007).
\emph{Numerical Methods for Special Functions}.
Cambridge: Cambridge University Press.\cr

Fenichel, Eli P. and Joshua K. Abbott. (2014).
\href{http://www.journals.uchicago.edu/doi/abs/10.1086/676034}{
Natural Capital: From Metaphor to Measurement}.
\emph{Journal of the Association of Environmental Economists}, 1(1/2), 1--27. \cr

Miranda, Mario J. and Paul L. Fackler (2002).
\emph{Applied Computational Economics and Finance}.
Cambridge: MIT Press.
}
\seealso{
\code{\link{chebnodegen}}
}
