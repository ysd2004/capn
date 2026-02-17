\docType{data}
\name{LV}
\alias{LV}
\title{Prey--Predator (Lotka--Volterra) Example Data (2-D Deterministic)}

\format{
A list with two elements:

\describe{
  \item{\strong{lvaproxdata}}{
    A data.frame of approximation data evaluated on a
    \eqn{20 \times 20} Chebyshev grid:
    \itemize{
      \item \code{xs}: Prey stock
      \item \code{ys}: Predator stock
      \item \code{xdot}: Evaluated prey dynamics \eqn{\frac{dx}{dt}}
      \item \code{ydot}: Evaluated predator dynamics \eqn{\frac{dy}{dt}}
      \item \code{wval}: Profit (objective value \eqn{W} in Fenichel and Abbott (2014))
    }
  }

  \item{\strong{lvsimdata}}{
    A data.frame of time-series simulation output from solving the ODE system:
    \itemize{
      \item \code{tseq}: Time sequence from 0 to 100
      \item \code{xs}: Prey stock
      \item \code{ys}: Predator stock
    }
  }
}
}

\usage{
data("LV")
}

\description{
\code{LV} contains simulated data for a prey--predator (Lotka--Volterra)
bioeconomic model used to illustrate multi-dimensional natural capital
asset pricing (CAPN) methods.
This example corresponds to a two-dimensional deterministic setting.
The dataset includes both approximation data on a Chebyshev grid and
time-series simulation output from the underlying dynamic system.
A detailed simulation example is provided in \code{LVdemo}.
}

\details{
The prey--predator system is given by:

\strong{Prey} (\eqn{X}):
\eqn{
\dot{X} = r X \left( 1 - \frac{X}{K} \right) - a X Y - \theta X
}

\strong{Predator} (\eqn{Y}):
\eqn{
\dot{Y} = b X Y - m Y - \gamma Y
}

The biological parameters are:
\itemize{
  \item \eqn{r = 0.025}: Intrinsic growth rate of prey
  \item \eqn{K = 1}: Carrying capacity of prey
  \item \eqn{a = 0.08}: Predation effect on prey
  \item \eqn{b = 0.05}: Prey-to-predator conversion parameter
  \item \eqn{m = 0.01}: Natural mortality rate of predator
  \item \eqn{\gamma = 0.005}: Predator harvest control slope
  \item \eqn{\theta = 0.005}: Prey harvest control slope
}

The economic objective is defined as:
\eqn{
W =
\text{harv.prey} \, (p_{\text{prey}} - c_{\text{prey}} / X) \, \theta X
+
\text{harv.pred} \, (p_{\text{pred}} - c_{\text{pred}} / Y) \, \gamma Y
}

The economic parameters are:
\itemize{
  \item \eqn{p_{\text{pred}} = 0}: Price per unit harvest of predator
  \item \eqn{p_{\text{prey}} = 25}: Price per unit harvest of prey
  \item \eqn{c_{\text{prey}} = 0.1 \, p_{\text{prey}}}:
        Cost per unit of prey effort (Schaefer model, with \eqn{q = 1})
  \item \eqn{c_{\text{pred}} = c_{\text{prey}}}:
        Cost per unit of predator effort (Schaefer model, with \eqn{q = 1})
}
}