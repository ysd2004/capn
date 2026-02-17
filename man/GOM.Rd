\docType{data}
\name{GOM}
\alias{GOM}
\title{Gulf of Mexico Reef Fish Example Data (1-D Deterministic)}

\format{
A list with two elements:

\describe{
  \item{\strong{param}}{
    A data.frame of model and approximation parameters:
    \itemize{
      \item \code{r}: Intrinsic growth rate (= 0.3847)
      \item \code{k}: Carrying capacity (= 359016000)
      \item \code{q}: Catchability coefficient (= 0.00031729344157311126)
      \item \code{price}: Output price (= 2.70)
      \item \code{cost}: Unit cost (= 153.0)
      \item \code{alpha}: Technology parameter (= 0.5436459179063678)
      \item \code{gamma}: Pre-ITQ management parameter (= 0.7882)
      \item \code{y}: System equivalence parameter (= 0.15745573410462155)
      \item \code{delta}: Discount rate (= 0.02)
      \item \code{order}: Chebyshev polynomial order (= 50)
      \item \code{upperK}: Upper bound of Chebyshev nodes (= \code{k})
      \item \code{lowerK}: Lower bound of Chebyshev nodes (= \eqn{5 \times 10^{6}})
      \item \code{nodes}: Number of Chebyshev nodes (= 50)
    }
  }

  \item{\strong{simData}}{
    A data.frame of simulated values evaluated at approximation nodes:
    \itemize{
      \item \code{stock}: Approximation nodes
      \item \code{profit}: Profit evaluated at \code{stock}
      \item \code{sdot}: Evaluated stock dynamics \eqn{\frac{ds}{dt}}
      \item \code{dsdotds}: Evaluated \eqn{\frac{d}{ds}\left( \frac{ds}{dt} \right)}
      \item \code{dsdotdss}: Evaluated \eqn{\frac{d^2}{ds^2}\left( \frac{ds}{dt} \right)}
      \item \code{dwds}: Evaluated \eqn{\frac{dw}{ds}}
      \item \code{dwdss}: Evaluated \eqn{\frac{d^2 w}{ds^2}}
    }
  }
}
}

\usage{
data("GOM")
}

\description{
\code{GOM} contains parameters and simulated data used to replicate the
Gulf of Mexico reef fish example from Fenichel and Abbott (2014).
The dataset illustrates the natural capital asset pricing (CAPN)
framework in a one-dimensional deterministic setting.
A detailed simulation example is provided in \code{GOMdemo}.
}

\details{
From Fenichel and Abboott(2014),\cr
\cr
catch effort: \eqn{x(s)=ys^\gamma},\cr
\cr
harvest: \eqn{h(s,x)=q((ys^\gamma)^\alpha)s=q(y^\alpha)(s^{\gamma\alpha})},\cr
\cr
profit: \eqn{w(s,x)=price \cdot h(s,x) - cost \cdot x(s)}, and\cr
\cr
sdot: \eqn{\dot{s} = rs \left( 1 - \frac{s}{k} \right) - q(y^\alpha)(s^{\gamma \alpha + 1})}.\cr

The biological parameters are:
\itemize{
  \item \eqn{r = 0.3847}: Intrinsic growth rate
  \item \eqn{K = 359016000}: Carrying capacity
}

The economic parameters are:
\itemize{
  \item \eqn{q = 0.00031729344157311126}: Catchability coefficient
  \item \eqn{price = 2.70}: Output price
  \item \eqn{cost = 153.0}: Unit cost
  \item \eqn{alpha = 0.5436459179063678}: Technology parameter
  \item \eqn{gamma = 0.7882}: Pre-ITQ management parameter
  \item \eqn{y = 0.15745573410462155}: System equivalence parameter
  \item \eqn{delta = 0.02}: Discount rate
}
}
\references{
Fenichel, Eli P. and Joshua K. Abbott. (2014).
\href{http://www.journals.uchicago.edu/doi/abs/10.1086/676034}{
Natural Capital: From Metaphor to Measurement}.
\emph{Journal of the Association of Environmental Economists}, 1(1/2), 1--27.
}