\name{vaprox}
\alias{vaprox}
\title{Computing Value Function (V) Approximation Coefficients}
\encoding{UTF-8}

\usage{
vaprox(aproxspace, stock, sdot, w, covmat = NULL)
}

\arguments{
  \item{aproxspace}{
    An approximation space defined by the \code{\link{aproxdef}} function.
  }
  \item{stock}{
    A vector or matrix of stock states \eqn{s}. For multi-dimensional problems,
    each column corresponds to one state variable.
  }
  \item{sdot}{
    A vector or matrix of stock dynamics \eqn{\dot{s} = ds/dt} (deterministic case)
    or drift terms \eqn{\mu(s)} (stochastic case), with the same dimension as \code{stock}.
  }
  \item{w}{
    A vector of net benefits (profits or economic program values), \eqn{W(s)}.
  }
  \item{covmat}{
    An optional variance–covariance matrix of the state dynamics.
    Columns must correspond to the unique \eqn{(i,j)} combinations of state variables.
    Set to \code{NULL} for deterministic problems.
  }
}

\value{
A list containing the approximation results:
\itemize{
  \item \code{degree}: Degree of the Chebyshev polynomial in each dimension.
  \item \code{lowerB}: Lower bounds of the approximation domain.
  \item \code{upperB}: Upper bounds of the approximation domain.
  \item \code{delta}: Discount rate.
  \item \code{coefficient}: Estimated Chebyshev polynomial coefficients.
  \item \code{model.type}: Either \code{"deterministic"} or \code{"stochastic"}.
}
}

\description{
Computes Chebyshev polynomial coefficients for approximating the value function
\eqn{V(s)} over a bounded state space.
The function supports multi-dimensional deterministic and stochastic
dynamic optimization problems within the natural capital asset pricing (CAPN)
framework.
}

\details{
The V-approximation solves for the value function \eqn{V(s)} from the
Hamilton--Jacobi--Bellman equation.

\strong{Deterministic case:}
\deqn{
\delta V(s) = W(s) + p(s) \dot{s}
}

\strong{Stochastic case:}
\deqn{
\delta V(s) = W(s) + p(s)\mu(s)
+ \frac{1}{2} \sigma^{2}(s) p_{s}(s)
}

where \eqn{\delta} is the discount rate,
\eqn{W(s)} denotes net benefits,
\eqn{p(s) = \partial V(s) / \partial s} is the shadow (accounting) price,
\eqn{\mu(s)} is the drift term, and
\eqn{\sigma^{2}(s)} is the variance of the stochastic process.

The value function is approximated as
\deqn{
V(s) = \Phi(s) \boldsymbol{\beta},
}
where \eqn{\Phi(s)} denotes the Chebyshev basis evaluated at \eqn{s}
and \eqn{\boldsymbol{\beta}} is the vector of unknown coefficients.

Substituting this approximation into the HJB equation yields a linear system:
\cr
\strong{Deterministic:}
\deqn{
\delta \Phi(s)\boldsymbol{\beta}
= W(s) + \mathrm{diag}(\dot{s}) \Phi_{s}(s)\boldsymbol{\beta}
}

\strong{Stochastic:}
\deqn{
\delta \Phi(s)\boldsymbol{\beta}
= W(s)
+ \mathrm{diag}(\mu(s)) \Phi_{s}(s)\boldsymbol{\beta}
+ \frac{1}{2} \sigma^{2}(s)\Phi_{ss}(s)\boldsymbol{\beta}
}

In exactly identified cases, the system is solved directly.
In over-determined cases (more nodes than basis terms),
the coefficients are obtained via least squares:
\deqn{
\boldsymbol{\beta} = (A^{\top}A)^{-1} A^{\top} W,
}
where \eqn{A} collects the terms multiplying \eqn{\boldsymbol{\beta}}.

The formulation extends naturally to multi-dimensional state spaces
using tensor products of Chebyshev bases.
}

\examples{
## 1-D Deterministic: Reef-fish example (Fenichel and Abbott, 2014)
data("GOM")

param <- GOM$param
simData <- GOM$simData

Aspace <- aproxdef(param$order, param$lowerK, param$upperK, param$delta)

vC <- vaprox(
  Aspace,
  simData$stock,
  simData$sdot,
  simData$profit
)

## 2-D Deterministic: Prey--Predator example
data("LV")

lvspace <- aproxdef(
  deg = c(20, 20),
  lb = c(0.1, 0.1),
  ub = c(1.5, 1.5),
  delta  = 0.03
)

vCLV <- vaprox(
  lvspace,
  LV$lvaproxdata[, c("xs", "ys")],
  LV$lvaproxdata[, c("xdot", "ydot")],
  LV$lvaproxdata[, "wval"]
)

## 1-D Stochastic: Pindyck (1984) extension (Abbott et al., 2026)
data("AFY")

Aspace <- aproxdef(35, 0.2, 1.4, 0.05)

## deterministic
vCd <- vaprox(
  Aspace,
  AFY$simData$stock,
  AFY$simData$mus.d,
  AFY$simData$profit.d
)

## stochastic
vCs <- vaprox(
  Aspace,
  AFY$simData$stock,
  AFY$simData$mus.s,
  AFY$simData$profit.s,
  AFY$simData$sigs
)
}

\references{
Abbott, Joshua K., Eli P. Fenichel, and Seong D. Yun. (2026).
\emph{Risky (Natural) Assets: Stochasticity, Nonconvexity, and the Value of Natural Capital}. \cr

Fenichel, Eli P. and Joshua K. Abbott. (2014).
\href{http://www.journals.uchicago.edu/doi/abs/10.1086/676034}{
Natural Capital: From Metaphor to Measurement}.
\emph{Journal of the Association of Environmental Economists}, 1(1/2), 1--27. \cr

Yun, Seong D., Barbara Hutniczak, Joshua K. Abbott, and Eli P. Fenichel. (2017).
Ecosystem-Based Management and the Wealth of Ecosystems.
\emph{Proceedings of the National Academy of Sciences}, 114(25), 6539--6544.
}

\seealso{
\code{\link{aproxdef}},
\code{\link{vsim}},
\code{\link{GOM}},
\code{\link{LV}},
\code{\link{AFY}}
}
