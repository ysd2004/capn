\docType{data}
\name{forest}
\alias{forest}
\title{Dougles-Fir Forest Data in Western Oregon (1-D Example)}

\format{
A list with two elements:

\describe{
  \item{\strong{param}}{
    A data.frame of model and approximation parameters:
    \itemize{
      \item \code{delta}: Discount rate (= 0.07)
      \item \code{order}: Chebyshev polynomial order (= 400)
      \item \code{lowerK}: lower bound of Chebyshev nodes (= 1)
      \item \code{upperK}: Upper bound of Chebyshev nodes (= 80)
      \item \code{nodes}: Number of Chebyshev nodes (= 400)
      \item \code{crit.vol}: Boundary (Moratorium or Maximum Standing) Volume (= 18.6592)
      \item \code{margp}: Marginal use value \eqn{\frac{d \pi}{d s}} at \code{crit.vol} (= 743.439)
      \item \code{splittime}: Split time \eqn{t(s)} at \code{crit.vol} (= 57.21486)
    }
  }
  \item{\strong{simData}}{
    A data.frame of simulated values evaluated at approximation nodes:
    \itemize{
      \item \code{vol}: Forest volume (MBF) at Chevyshev nodes in \eqn{s \in } [1,80]
      \item \code{growth}: Evaluated stock dynamics \eqn{\frac{ds}{dt}} at \code{vol}
      \item \code{profit}: Profit evaluated at \code{vol}
      \item \code{times}: Evaluated time with \eqn{t(s)} at \code{vol}
    }
  }
}
}

\usage{
data("forest")
}

\description{
\code{forest} contains parameters and simulated data used to replicate the
Douglas-fir forest in Western Oregon example (industrial siteclass 3) from Hashida and Fenichel (2022).
The dataset illustrates the natural capital asset pricing (CAPN)
framework in a one-dimensional deterministic setting.
A detailed simulation example is provided in \code{forestdemo}.
}

\details{
See Hashida and Fenichel (2022).
}
\references{
Hashida, Yukiko and Eli P. Fenichel. (2022).
\href{https://doi.org/10.1111/ajae.12250}{Valuing Natural Capital When Management Is Dominated by Periods of Inaction}.
\emph{American Journal of Agricultural Economics}, 104(2), 791--811.
}