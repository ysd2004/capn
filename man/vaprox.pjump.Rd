\name{vaprox.pjump}
\alias{vaprox.pjump}
\title{Value Function Approximation with Poisson Jump Risk}
\encoding{UTF-8}

\usage{
vaprox.pjump(aproxspace, stock, sdot, wb, hs, zs)
}

\arguments{
  \item{aproxspace}{
    An approximation space defined by the \code{\link{aproxdef}} function.
  }
  \item{stock}{
    A vector or matrix of stock states \eqn{s}.
  }
  \item{sdot}{
    A vector or matrix of stock dynamics \eqn{\dot{s} = ds/dt}.
  }
  \item{wb}{
    A vector of net benefits (profits or economic program values) without a shock,
    \eqn{W(s)}.
  }
  \item{hs}{
    A vector of stock-dependent hazard rates, \eqn{h(s)}.
  }
  \item{zs}{
    A vector of infinite-horizon net benefits following a jump event, \eqn{Z(s)}.
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
  \item \code{model.type}: \code{"Poisson Jump"}.
}
}

\description{
Computes Chebyshev polynomial coefficients for approximating the value function
\eqn{V(s)} in a dynamic optimization problem with Poisson jump risk.
The function is designed for one-dimensional natural capital asset pricing
applications.
}

\details{
The value function \eqn{V(s)} with Poisson jump risk satisfies the
Hamilton--Jacobi--Bellman equation derived in Abbott, Fenichel, and Yun (2026),
building on Reed and Heras (1992):

\deqn{
\left[ \delta + h(s) \right] V(s) - h(s) Z(s)
= W(s) + V_{s}(s)\, \dot{s},
}

where \eqn{\delta} is the discount rate,
\eqn{W(s)} denotes net benefits in the absence of a jump,
\eqn{V_{s}(s) = \partial V(s) / \partial s = p(s)} is the shadow (accounting) price,
\eqn{h(s)} is the stock-dependent hazard rate, and
\eqn{Z(s)} is the post-jump infinite-horizon value.

Rearranging terms yields:
\deqn{
\left[ \delta + h(s) \right] V(s) - V_{s}(s)\, \dot{s}
= W(s) + h(s) Z(s).
}

The value function is approximated as:
\deqn{
V(s) = \Phi(s)\boldsymbol{\beta},
}
where \eqn{\Phi(s)} is the Chebyshev basis evaluated at \eqn{s} and
\eqn{\boldsymbol{\beta}} is the vector of unknown coefficients.

Substituting this approximation into the HJB equation produces the linear system:
\deqn{
\left[
(\delta + h(s)) \Phi(s) - \mathrm{diag}(\dot{s}) \Phi_{s}(s)
\right] \boldsymbol{\beta}
= W(s) + h(s) Z(s).
}

In exactly identified cases, the system is solved directly.
In over-determined cases (more nodes than basis terms), the coefficients are
obtained via least squares:
\deqn{
\boldsymbol{\beta} = (A^{\top} A)^{-1} A^{\top} (W + h Z),
}
where \eqn{A} collects the terms multiplying \eqn{\boldsymbol{\beta}}.
}

\examples{
## Example from Abbott, Fenichel, and Yun (2026)
data("AFY")

param <- AFY$param

## Deterministic benchmark
cvDET <- vaprox.pindyck(param, "logistic")

slow <- 0.1
vlow <- vsim(cvDET, slow)
qlow <- cvDET$qfun(param, slow, vlow$shadowp)
zs   <- cvDET$wfun(param, slow, qlow) / param$delta

s <- chebnodegen(param$nodes, param$lowerK, param$upperK)

qopt <- cvDET$qfun(param, s, vsim(cvDET, s)$shadowp)
mus  <- cvDET$gfun(param, s) - qopt

alpha <- 0.5
hs <- alpha / (alpha + s)

wb <- cvDET$wfun(param, s, qopt)

Aspace <- aproxdef(param$order, param$lowerK, param$upperK, param$delta)

cvPSS <- vaprox.pjump(Aspace, s, mus, wb, hs, zs)

vPSS <- vsim(cvPSS, s)

## Plot value function
plotgen(vPSS, ftype = "vw",
        xlabel = "Stock Size",
        ylabel = "Value Function")

## Plot shadow (accounting) price
plotgen(vPSS, ftype = "p",
        xlabel = "Stock Size",
        ylabel = "Shadow Price")
}

\references{
Abbott, Joshua K., Eli P. Fenichel, and Seong D. Yun. (2026).
\emph{Risky (Natural) Assets: Stochasticity, Nonconvexity, and the Value of Natural Capital}. \cr

Reed, William J. and Hector E. Heras. (1992).
\href{https://doi.org/10.1007/BF02464829}{The Conservation and Exploitation of Vulnerable Resources}.
\emph{Bulletin of Mathematical Biology}, 54, 185--207.
}

\seealso{
\code{\link{AFY}},
\code{\link{aproxdef}},
\code{\link{vaprox}},
\code{\link{vsim}}
}
