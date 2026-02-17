plotgen <- function(simres,
                    ftype  = NULL,
                    whichs = NULL,
                    tvar   = NULL,
                    xlabel = NULL,
                    ylabel = NULL) {
  
  ## Plot type
  if (is.null(ftype)) {
    ftype <- "p"
  }
  
  ## Stock index handling
  nums <- dim(simres[["stock"]])[2]
  
  if (is.null(whichs)) {
    sidx <- 1
  } else {
    if (length(whichs) != 1 || whichs < 1 || whichs > nums) {
      stop("`whichs` must be a single integer between 1 and the number of stocks.")
    }
    sidx <- whichs
  }
  
  ## Shadow price vs stock/time
  if (ftype == "p") {
    
    xval <- simres[["stock"]][, sidx]
    yval <- simres[["shadowp"]][, sidx]
    
    xname <- "Stock"
    yname <- "Shadow Price"
    
    ## Time variable overrides stock on x-axis
    if (!is.null(tvar)) {
      xval  <- tvar
      xname <- "Time"
    }
    
    if (!is.null(xlabel)) {
      xname <- xlabel
    }
    if (!is.null(ylabel)) {
      yname <- ylabel
    }
    
    plot(
      xval, yval,
      xlab = xname,
      ylab = yname,
      type = "l",
      lwd  = 2
    )
    
    ## Value function and W-value
  } else if (ftype == "vw") {
    
    if (is.null(simres[["vfun"]])) {
      stop("Value function is not available: provide both `wval` and `sdot` in psim().")
    }
    
    xval  <- simres[["stock"]][, sidx]
    y1val <- simres[["vfun"]][, 1]
    y2val <- simres[["wval"]]
    
    xname  <- "Stock"
    y1name <- "Value Function"
    y2name <- "W-value"
    
    if (!is.null(tvar)) {
      xval  <- tvar
      xname <- "Time"
    }
    
    if (!is.null(xlabel)) {
      xname <- xlabel
    }
    
    if (!is.null(ylabel)) {
      if (length(ylabel) >= 1) {
        y1name <- ylabel[1]
      }
      if (length(ylabel) >= 2) {
        y2name <- ylabel[2]
      }
    }
    
    ## Only plot value function if W is unavailable
    if (is.null(y2val) || is.character(y2val)) {
      
      plot(
        xval, y1val,
        xlab = xname,
        ylab = y1name,
        type = "l",
        lwd  = 2
      )
      
    } else {
      
      ## Dual-axis plot: V and W
      op <- par(no.readonly = TRUE)
      on.exit(par(op))
      
      par(mar = c(5, 4, 4, 5) + 0.1)
      
      plot(
        xval, y1val,
        xlab = xname,
        ylab = y1name,
        type = "l",
        lwd  = 2
      )
      
      par(new = TRUE)
      
      plot(
        xval, y2val,
        type = "l",
        lwd  = 2,
        xaxt = "n",
        yaxt = "n",
        xlab = "",
        ylab = ""
      )
      
      axis(4)
      mtext(y2name, side = 4, line = 3)
      
      legend(
        "topleft",
        lty    = 1,
        legend = c("Value Function", "W"),
        bty    = "n"
      )
    }
    
  } else {
    stop("`ftype` must be NULL, 'p', or 'vw'.")
  }
  
  invisible(NULL)
}