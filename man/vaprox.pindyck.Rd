\name{vaprox.pindyck}
\alias{vaprox.pindyck}
\title{Computing Value Function (V) Approximation Coefficients for examples in Pindyck (1984)}
\encoding{UTF-8}

\usage{
vaprox.pindyck(param, 
               growthfun = c("logistic", "gompertz", "sqroot"), 
               covmat    = NULL,
               itermax   = 300,
               tol       = 1e-8)
}

\arguments{
  \item{param}{
    A data.frame of parameters adopted in three examples in pindyck (1984)
  }
  \item{growthfun}{
    A net growth function: one of the three net growth function in Pindyck (1984)
    \code{"logistic"} (Logistic: example 1), 
    \code{"gompertz"} (Gompertz: example 2), and 
    \code{"sqroot"} (Sqaure-root: example 3).
  }
  \item{covmat}{
    An optional variance–covariance matrix of the state dynamics.
    Columns must correspond to the unique \eqn{(i,j)} combinations of state variables.
    Set to \code{NULL} for deterministic problems.
  }
  \item{itermax}{
    Maximum number of iterations. Default is 300.
  }
  \item{tol}{
    Tolerance of the error size. Default is 1e-8.
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
  \item \code{gfun}: net growth function decleared in the argument
  \item \code{wfun}: profit (net benefit) function with the decleared \code{"gfun"}
  \item \code{qfun}: catch (harvest) function with the decleared \code{"gfun"}
}
}

\description{
Computes Chebyshev polynomial coefficients for approximating the value function
\eqn{V(s)} over a bounded state space using value function iteration described in
Pindyck (1984) and Abbott, Fenicehl, and Yun (2026).
The function supports one-dimensional deterministic and stochastic
dynamic optimization problems within the natural capital asset pricing (CAPN)
framework.
}

\details{
The V-approximation with value function iteration solves for the value function
\eqn{V(s)} in Pindyck (1984) and Abbott, Fenichel, and Yun (2026).

A state equation in the examples in Pindyck (1984) is defined as:

\deqn{
ds = [f(s) - q(t)]dt + \theta s dz
}
where \eqn{dz} is a Weiner process.

The net growth functions are:

\strong{Logistic net growth function:}
\deqn{
f(s) = rs \left( 1- \frac{s}{K} \right) 
}

\strong{Gompertz net gorwth function:}
\deqn{
f(s) = rs ln \left( \frac{K}{s} \right)
}

\strong{Square-root net gorwth function:}
\deqn{
f(s) =  rs^{1/2} - \frac{rs}{K^{1/2}}
}

where \eqn{r} is the instrinsic growth rate,
\eqn{K} the carrying capacity
\eqn{p(s) = \partial V(s) / \partial s} is the shadow (accounting) price.


\strong{The catch (harvest) function:}
\deqn{
q(s,V_{s}) = b \left( V_{s} + cs^{-\gamma} \right)^{-\eta}
}

\strong{The profit (net benefit) function:}

If \eqn{\eta = 1}: \eqn{b ln(q) - cs^{-\gamma}q}

if \eqn{\eta \neq 1}: \eqn{ \frac{b^{1/\eta}}{(1 - 1/\eta)}q^{(1 - 1/\eta)} - cs^{-\gamma}q } 

where \eqn{b} is the demand parameter,
\eqn{c} is the cost parameter,
\eqn{\eta} is the elasticity of demand, and
\eqn{\gamma} is the elasticity of marginal cost.

More details are available in Pindyck (1984).
}

\examples{
################################################################################
## Logistic net growth function: Example 1 in Pindyck (1984)
data("AFY")

## parameters used in Abbott, Fenichel, and Yun (2026)
param <- AFY$param

## approximation and simulation range
stock <- chebnodegen(param$nodes,param$lowerK,param$upperK)

## volatility term
theta <- 0.1
sigsGBM <- as.matrix((theta*stock)^2,col=1)

cvlogistic <- vaprox.pindyck(param,'logistic',sigsGBM)
vlogistic <- vsim(cvlogistic,stock)

## plot value function
plotgen(vlogistic,ftype="vw",xlabel="Stock Size", ylabel="Value Function")

## plot shadow (accounting) prices
plotgen(vlogistic,ftype="p",xlabel="Stock Size", ylabel="Shadow Price")

################################################################################
## Gompertz net growth function: Example 1 in Pindyck (1984)
data("AFY")

## parameter adjustment by Pindyck (1984)
param <- AFY$param
param$eta <- 1
param$gamma <- 1
param$lowerK <- 15  # reflecting more left-skwed than logistic

## approximation and simulation range
stock <- chebnodegen(param$nodes,param$lowerK,param$upperK)

## volatility term
theta <- 0.1
sigsGBM <- as.matrix((theta*stock)^2,col=1)

cvgompertz <- vaprox.pindyck(param,'logistic',sigsGBM)
vgompertz <- vsim(cvgompertz,stock)

## plot value function
plotgen(vgompertz,ftype="vw",xlabel="Stock Size", ylabel="Value Function")

## plot shadow (accounting) prices
plotgen(vgompertz,ftype="p",xlabel="Stock Size", ylabel="Shadow Price")
}

\references{
Abbott, Joshua K., Eli P. Fenichel, and Seong D. Yun. (2026).
\emph{Risky (Natural) Assets: Stochasticity, Nonconvexity, and the Value of Natural Capital}. \cr

Pindyck, Robert S. (1984).
\href{https://doi.org/10.2307/2297693}{Uncertainty in the Theory of Renewable Resource Markets}.
\emph{Review of Economic Studies}, 51(2), 289--303.
}

\seealso{
\code{\link{AFY}}
\code{\link{aproxdef}},
\code{\link{plotgen}}
\code{\link{vaprox}},
\code{\link{vsim}}
}
