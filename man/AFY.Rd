\docType{data}
\name{AFY}
\alias{AFY}
\title{Abbott--Fenichel--Yun Data (1-D Stochastic Example)}

\format{
A data.frame containing simulation and approximation data for a one-dimensional
stochastic renewable resource model:

\describe{
  \item{\strong{simData}}{
    A data.frame with the following components:
    \itemize{
      \item \code{stock}: Stock levels.
      \item \code{mu.d}: Deterministic stock growth rate.
      \item \code{profit.d}: Deterministic profit.
      \item \code{mu.s}: Drift term of the stochastic stock process.
      \item \code{profit.s}: Profit under stochastic dynamics.
      \item \code{sigs}: Variance term of the stochastic process.
    }
  }
  
  \item{\strong{param}}{
    A data.frame of model and approximation parameters:
    \itemize{
      \item \code{r}: Intrinsic growth rate (=0.5)
      \item \code{K}: Carrying capacity (=100)
      \item \code{b}: Demand parameter (=1)
      \item \code{eta}: elasticity of demand (=1/2)
      \item \code{c}: cost parameter (=5)
      \item \code{gamma}: elasticity of marginal cost (=2)
      \item \code{delta}: discount rate (=0.05)
      \item \code{order}: Chebyshev polynomial order (=30)
      \item \code{upperK}: Upper bound of Chebyshev nodes (= 114.3)
      \item \code{lowerK}: Lower bound of Chebyshev nodes (= 20)
      \item \code{nodes}: Number of Chebyshev nodes (= 30)
    }
  }
}
}

\usage{
data("AFY")
}

\description{
\code{AFY} contains approximation and simulation data used to replicate the
one-dimensional stochastic example in Abbott, Fenichel, and Yun (2026),
which extends the classic renewable resource model of Pindyck (1984).
The dataset illustrates the natural capital asset pricing (CAPN) framework
under uncertainty.
A complete worked example is provided in \code{AFYdemo}.
}

\details{
Following Abbott, Fenichel, and Yun (2026) and Pindyck (1984), the model is defined as follows.

\strong{Demand function:}
\deqn{q(p) = b p^{-\eta}}

\strong{Cost function:}
\deqn{c(s) = c s^{-\gamma}}

\strong{Biological growth function:}
\deqn{f(s) = r s \left(1 - \frac{s}{K}\right)}

\strong{Stock dynamics:}
\deqn{
ds = \left[f(s) - q(s)\right] dt + \sigma s \, dz
}

\strong{Net benefit function:}
\deqn{
\int_0^{q} p(z) \, dz - c(s) q(s)
= -\frac{b^2}{q} - \frac{c}{s^2} q
}

\strong{Closed-form value function:}
\deqn{
V(s) = -\frac{\phi}{s} - \frac{\phi r}{\delta K}
}

where
\deqn{
\phi =
\frac{
2 b^2 + 2 b \sqrt{b^2 + c (r + \delta - \sigma^2)}
}{
(r + \delta - \sigma^2)^2
}
}

\strong{Optimal harvest (catch) function:}
\deqn{
q(s) = b (\phi + c)^{-1/2} s
}

\strong{Parameter values:}
\itemize{
  \item \eqn{r = 0.5}
  \item \eqn{K = 1} (=100\% in the percentage replication)
  \item \eqn{b = 1}
  \item \eqn{\eta = 0.5}
  \item \eqn{c = 5}
  \item \eqn{\gamma = 2}
  \item \eqn{\delta = 0.05}
}
}

\references{
Abbott, Joshua K., Eli P. Fenichel, and Seong D. Yun. (2026).
\emph{Risky (Natural) Assets: Stochasticity, Nonconvexity, and the Value of Natural Capital}. \cr

Pindyck, Robert S. (1984).
\href{https://doi.org/10.2307/2297693}{Uncertainty in the Theory of Renewable Resource Markets}.
\emph{Review of Economic Studies}, 51(2), 289--303.
}

\seealso{
\code{\link{vaprox}},
\code{\link{vaprox.pindyck}},
\code{\link{vsim}}
}