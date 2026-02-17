\name{vsim}
\alias{vsim}
\title{Simulation of Value Function Approximation}

\usage{
vsim(vcoeff, stock, wval = NULL)
}

\arguments{
  \item{vcoeff}{
    An approximation object returned by the \code{\link{vaprox}} function.
  }
  \item{stock}{
    A numeric vector, matrix, or \code{data.frame} containing stock values
    \eqn{\mathbf{S}} at which the value function and shadow prices are evaluated.
  }
  \item{wval}{
    (Optional; used by \code{\link{plotgen}}) A vector or array of instantaneous
    welfare values \eqn{W(\mathbf{S})}.
  }
}

\value{
A list containing simulation results. Individual elements can be accessed using
\code{results$item} or \code{results[["item"]]}.
  \item{shadowp}{
    Matrix of shadow (accounting) prices for each stock.
  }
  \item{iweach}{
    Inclusive wealth contribution of each stock (multi-stock case).
  }
  \item{iw}{
    Inclusive wealth.
  }
  \item{vfun}{
    Approximated value function.
  }
  \item{stock}{
    Stock values used in the simulation.
  }
  \item{wval}{
    Welfare values if \code{wval} is provided.
  }
  \item{model.type}{
    Either \code{"deterministic"} or \code{"stochastic"}.
  }
}

\description{
Simulates the value function and shadow (accounting) prices using the Chebyshev
polynomial approximation obtained from \code{\link{vaprox}}, 
\code{\link{vaprox.pindyck}}, and \code{\link{vaprox.pjump}}.
}

\details{
Let \eqn{\hat{\boldsymbol{\beta}}} denote the vector of approximation coefficients
obtained from \code{\link{vaprox}}.
For stock vector \eqn{s}, the estimated
shadow (accounting) price of stock is given by
\deqn{
\hat{p}(s) =
\frac{\partial {\Phi (s)}}{\partial s}
\hat{\beta},
}
where \eqn{\Phi(s)} denotes the Chebyshev polynomial basis.

The approximated value function is
\deqn{
\hat{V}(s) =
\Phi (s) \hat{\beta}.
}

Inclusive wealth is computed as the inner product of shadow prices and stock
levels.

For further theoretical details, see Abbott, Fenichel, and Yun (2026), Fenichel and Abbott (2014), and Yun et al. (2017).
}

\examples{
# 1-D Deterministic: Reef-fish example (Fenichel and Abbott, 2014)
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

GOMSimV <- vsim(vC,
  simData$stock,
  simData$profit)

# plot shadow (accounting) price: Figure 4 in Fenichel and Abbott (2014)
plotgen(GOMSimV, xlabel="Stock size, s", ylabel="Shadow price")

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

lvsim <- vsim(vCLV,LV$lvsimdata[,c('xs','ys')])

# plot Biomass
plot(LV$lvsimdata[,"tseq"], LV$lvsimdata[,"xs"], type='l', lwd=2, col="blue",
     xlab="Time",
     ylab="Biomass")
lines(LV$lvsimdata[,"tseq"], LV$lvsimdata[,"ys"], lwd=2, col="red")
legend("topright", c("Prey", "Predator"), col=c("blue", "red"),
       lty=c(1,1), lwd=c(2,2), bty="n")

# plot shadow (accounting) prices
plot(LV$lvsimdata[,"tseq"],lvsim[["shadowp"]][,1],type='l', lwd=2, col="blue",
     ylim = c(-5,7),
     xlab="Time",
     ylab="Shadow price")
lines(LV$lvsimdata[,"tseq"],lvsim[["shadowp"]][,2], lwd=2, col="red")
legend("topright", c("Prey", "Predator"), col=c("blue", "red"),
       lty=c(1,1), lwd=c(2,2), bty="n")

# plot inclusive weath and value function
plot(LV$lvsimdata[,"tseq"],lvsim[["iw"]],type='l', lwd=2, col="blue",
     ylim = c(-0.5,1.2),
     xlab="Time",
     ylab="Inclusive Wealth / Value Function ($)")
lines(LV$lvsimdata[,"tseq"],lvsim[["vfun"]], lwd=2, col="red")
legend("topright", c("Inclusive Wealth", "Value Function"),
       col=c("blue", "red"), lty=c(1,1), lwd=c(2,2), bty="n")
       
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

simVd <- vsim(vCd,simData$stock)

# plot value function
plotgen(simVd,ftype="vw",xlabel="Stock Size", ylabel="Value Function")

# plot shadow (accounting) prices
plotgen(simVd,ftype="p",xlabel="Stock Size", ylabel="Shadow Price")

## stochastic
vCs <- vaprox(
  Aspace,
  AFY$simData$stock,
  AFY$simData$mus.s,
  AFY$simData$profit.s,
  AFY$simData$sigs
)

simVs <- vsim(vCs,simData$stock)

# plot value function
plotgen(simVs,ftype="vw",xlabel="Stock Size", ylabel="Value Function")

# plot shadow (accounting) prices
plotgen(simVs,ftype="p",xlabel="Stock Size", ylabel="Shadow Price")
}
\references{
Abbott, Joshua K., Eli P. Fenichel, and Seong D. Yun. (2026).
\emph{Risky (Natural) Assets: Stochasticity, Nonconvexity, and the Value of Natural Capital}. \cr

Fenichel, Eli P. and Joshua K. Abbott. (2014).
\href{http://www.journals.uchicago.edu/doi/abs/10.1086/676034}{
Natural Capital: From Metaphor to Measurement}.
\emph{Journal of the Association of Environmental Economists}, 1(1/2), 1--27. \cr

Yun, Seong D., Barbara Hutniczak, Joshua K. Abbott, and Eli P. Fenichel. (2017).
\href{https://doi.org/10.1073/pnas.1617666114}{
Ecosystem-Based Management and the Wealth of Ecosystems}.
\emph{Proceedings of the National Academy of Sciences}, 114(25), 6539--6544.
}
\seealso{
\code{\link{AFY}}
\code{\link{aproxdef}},
\code{\link{GOM}},
\code{\link{LV}},
\code{\link{plotgen}},
\code{\link{vaprox}},
\code{\link{vaprox.pindyck}},
\code{\link{vaprox.pjump}},
\code{\link{vaprox.split}}
}
