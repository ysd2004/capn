\name{vaprox.split}
\alias{vaprox.split}
\title{Value Function Approximation with Inaction (Split) Management}
\encoding{UTF-8}

\usage{
vaprox.split(aproxspace, stock, sdot, profit,
             crit.stock, split.margp, split.time = NULL)
}

\arguments{
  \item{aproxspace}{
    An approximation space defined by the \code{\link{aproxdef}} function.
  }
  \item{stock}{
    A vector or matrix of stock states \eqn{s}.
  }
  \item{sdot}{
    A vector or matrix of stock dynamics \eqn{\dot{s} = ds/dt}
    evaluated at \code{stock} (without split management).
  }
  \item{profit}{
    A vector of net benefits (profit or economic program value)
    evaluated at \code{stock} (without split management).
  }
  \item{crit.stock}{
    Critical (boundary) stock level, \eqn{\bar{s}}, representing
    a moratorium or maximum waiting threshold.
  }
  \item{split.margp}{
    Marginal use value at the boundary stock,
    \eqn{\left.\frac{d\pi}{ds}\right|_{s=\bar{s}}}.
  }
  \item{split.time}{
    (Optional) Time of action \eqn{t(\bar{s})} at the boundary stock.
    If \code{NULL}, the standard boundary condition is used.
  }
}

\value{
A list containing the approximation results:
\itemize{
  \item \code{degree}: Degree of the Chebyshev polynomial.
  \item \code{lowerB}: Lower bound of the approximation interval.
  \item \code{upperB}: Upper bound of the approximation interval.
  \item \code{delta}: Discount rate.
  \item \code{coefficient}: Estimated Chebyshev polynomial coefficients.
  \item \code{shadow.stop}: Shadow price evaluated at the boundary stock \eqn{\bar{s}}.
  \item \code{alpha}: Estimated passive value parameter at \eqn{\bar{s}}.
  \item \code{model.type}: \code{"Split (Economic Program)"}.
}
}

\description{
Computes Chebyshev polynomial coefficients for approximating the value
function \eqn{V(s)} in a one-dimensional natural capital asset pricing
model with inaction (split) management.

The function allows for a boundary stock level at which management switches
from waiting (inaction) to active use, and estimates both the value function
and the associated passive value parameter.
}

\details{

Following Hashida and Fenichel (2022), management is characterized by an
indicator function:

\deqn{
x(s) =
\begin{cases}
1 & \text{if } s \ge \bar{s}, \\
0 & \text{if } s < \bar{s}.
\end{cases}
}

The benefit function can be decomposed as:

\deqn{
W(s, x(s)) = \pi(s, x(s)) + \alpha(s, x(s)),
}

where \eqn{\pi(s, x(s))} represents realized income when harvesting
occurs (\eqn{x(s)=1}), and \eqn{\alpha(s, x(s))} represents passive
(amenity) value when management remains inactive
(\eqn{x(s)=0}).

At the boundary \eqn{s=\bar{s}}, smooth pasting implies:

\deqn{
V_{s}(\bar{s}) = \pi_{s}(\bar{s}).
}

The Hamilton--Jacobi--Bellman equation becomes:

\deqn{
\delta V(s) = \pi(s) + \alpha(s) + \dot{s}\, V_{s}(s).
}

The value function is approximated by Chebyshev polynomials:

\deqn{
V(s) = \Phi(s)\boldsymbol{\beta},
}

where \eqn{\Phi(s)} is the Chebyshev basis evaluated at \eqn{s},
and \eqn{\boldsymbol{\beta}} is the vector of unknown coefficients.

Substituting into the HJB equation yields the linear system:

\deqn{
\left[
\delta \Phi(s) - \mathrm{diag}(\dot{s}) \Phi_{s}(s)
\right] \boldsymbol{\beta}
=
\pi(s) + \alpha(s).
}

The passive value is approximated by a first-order form
\eqn{\alpha(s) = \alpha s}, and \eqn{\boldsymbol{\beta}} and \eqn{\alpha}
are jointly determined using the boundary condition
\eqn{V_{s}(\bar{s}) = \pi_{s}(\bar{s})}.

In exactly identified cases, the system is solved directly.
In over-determined cases, a least-squares solution is used:

\deqn{
\boldsymbol{\beta}
=
(A^{\top}A)^{-1} A^{\top} \left( \pi(s) + \alpha(s) \right),
}

where \eqn{A = \delta \Phi(s) - \mathrm{diag}(\dot{s}) \Phi_{s}(s)}.
}

\examples{
## Example (industrial classite 3) from Hashida and Fenichel (2022)
data("forest")

param   <- forest$param
simData <- forest$simData

Aspace <- aproxdef(param$order,param$lowerK,param$upperK,param$delta)

vCsplit <- vaprox.split(Aspace, simData$vol, simData$growth, 
                        simData$profit, param$crit.vol, 
                        param$margp, param$splittime)

vsimsplit <- vsim(vCsplit, simData[,1])

## harvest node and its time
hnode <- min(which(simData$vol > param$crit.vol)) 
m <- hnode -1

## plot data generation
plotdata <- data.frame(stock = vsimsplit$stock[1:m],
            price = exp(-(simData$times[1:m]-simData$times[1])*param$delta)*vsimsplit$shadowp[1:m],
            vfun = exp(-(simData$times[1:m]-simData$times[1])*param$delta)*vsimsplit$vfun[1:m])

## plot shadow (accounting) prices
## 3p of Figure 4 in Hashida and Fenichel (2022)
plot(plotdata$stock,plotdata$price,type='l',col='blue',
     xlab = 'Forest Volue (MBF)',
     ylab = 'Shadow Price ($/MBF)')

## plot value function
plot(plotdata$stock,plotdata$vfun,type='l',
     xlab = 'Forest Volue (MBF)',
     ylab = 'Value Function ($)')
}

\references{
Hashida, Yukiko and Eli P. Fenichel. (2022).
\href{https://doi.org/10.1111/ajae.12250}{Valuing Natural Capital When Management Is Dominated by Periods of Inaction}.
\emph{American Journal of Agricultural Economics}, 104(2), 791--811.
}

\seealso{
\code{\link{aproxdef}},
\code{\link{forest}},
\code{\link{vsim}}
}