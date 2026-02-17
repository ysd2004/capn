\name{chebnodegen}
\alias{chebnodegen}
\title{Unidimensional Chebyshev Nodes}
\usage{
chebnodegen(n, a, b)
}
\arguments{
  \item{n}{An integer specifying the number of nodes.}
  \item{a}{The lower bound of the interval \eqn{[a, b]}.}
  \item{b}{The upper bound of the interval \eqn{[a, b]}.}
}
\value{
A numeric vector of length \eqn{n} containing Chebyshev nodes.
}
\description{
Generate unidimensional Chebyshev nodes over a bounded interval.
}
\details{
A polynomial approximant \eqn{s_{i}} over a bounded interval \eqn{[a, b]} is constructed using Chebyshev nodes as:\cr
\cr
\eqn{
s_{i} = \frac{b + a}{2} + \frac{b - a}{2} 
\cos \left( \frac{n - i + 0.5}{n} \pi \right)
}
for \eqn{i = 1, 2, \ldots, n}. \cr
\cr
Further details can be found in Miranda and Fackler (2002, p.~119).
}
\examples{
## 10 Chebyshev nodes in [-1, 1]
chebnodegen(10, -1, 1)

## 5 Chebyshev nodes in [1, 5]
chebnodegen(5, 1, 5)
}
\references{
Miranda, Mario J. and Paul L. Fackler (2002).
\emph{Applied Computational Economics and Finance}.
Cambridge: MIT Press.
}