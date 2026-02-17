\name{plotgen}
\alias{plotgen}
\title{Plot Generator for Shadow Price and Value Function}

\usage{
plotgen(simres, ftype = NULL, whichs = NULL, tvar = NULL,
        xlabel = NULL, ylabel = NULL)
}

\arguments{
\item{simres}{
A simulation result from \code{vsim}, \code{psim}, or \code{pdotsim}.
}

\item{ftype}{
Plot type. If \code{NULL} (default) or \code{"p"}, plot shadow price.
If \code{"vw"}, plot value function (and W-value if available).
}

\item{whichs}{
An integer specifying which stock to plot in multi-stock cases.
Must satisfy \code{1 <= whichs <= number of stocks}.
If \code{NULL} (default), the first stock is used.
}

\item{tvar}{
Optional time variable. If provided, the x-axis is time instead of stock.
}

\item{xlabel}{
Optional character string for the x-axis label.
Defaults to \code{"Stock"} or \code{"Time"} depending on \code{tvar}.
}

\item{ylabel}{
Optional character vector for y-axis labels.
For \code{ftype = "p"}, provide one label.
For \code{ftype = "vw"}, provide one or two labels for the value function
and W-value, respectively.
}
}

\value{
Produces a plot of shadow prices, value function, and optionally W-values.
The function is called for its side effect of producing a plot.
}

\description{
Generate plots of shadow prices and value functions
based on simulation results from \code{vsim}, \code{psim}, or \code{pdotsim}.
}

\details{
This function produces one-dimensional plots for:

\itemize{
  \item Shadow price versus stock
  \item Shadow price versus time
  \item Value function versus stock
  \item Value function versus time
  \item Value function and W-value versus stock
  \item Value function and W-value versus time
}

The specific plot depends on the combination of \code{ftype},
\code{whichs}, and \code{tvar}.
}

\examples{
## 1-D Reef-fish example: see Fenichel and Abbott (2014)
data("GOM")

param <- GOM$param
simData <- GOM$simData

Aspace <- aproxdef(param$order, param$lowerK, param$upperK, param$delta)

pC <- paprox(
  Aspace,
  simData$stock,
  simData$sdot,
  simData$dsdotds,
  simData$dwds
)

## Without providing W-value
GOMSimP <- psim(
  pC,
  simData$stock
)

## With W-value
GOMSimP2 <- psim(pC,
  simData$stock,
  simData$profit,
  simData$sdot)

## Shadow price vs stock
plotgen(GOMSimP)
plotgen(GOMSimP, ftype = "p")
plotgen(GOMSimP,
        xlabel = "Stock Size, S",
        ylabel = "Shadow Price (USD/kg)")

## Value function and W-value vs stock
plotgen(GOMSimP2, ftype = "vw")
plotgen(GOMSimP2,
        ftype  = "vw",
        xlabel = "Stock Size, S",
        ylabel = c("Value Function", "Profit"))
}

\seealso{
  \code{\link{GOM}}
  \code{\link{pdotsim}}
  \code{\link{psim}}, 
  \code{\link{vsim}},
  \code{\link{vaprox.pindyck}}
}