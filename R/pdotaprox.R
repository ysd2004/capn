pdotaprox <- function(aproxspace,
                      stock,
                      sdot,
                      dsdotds,
                      dsdotdss,
                      dwds,
                      dwdss) {
  
  ## Extract approximation space
  deg   <- aproxspace[["degree"]]
  lb    <- aproxspace[["lowerB"]]
  ub    <- aproxspace[["upperB"]]
  delta <- aproxspace[["delta"]]
  
  ## Coerce to vectors (robust to matrix input)
  stock     <- as.vector(stock)
  sdot      <- as.vector(sdot)
  dsdotds   <- as.vector(dsdotds)
  dsdotdss  <- as.vector(dsdotdss)
  dwds      <- as.vector(dwds)
  dwdss     <- as.vector(dwdss)
  
  ## Basis matrices
  fphi <- chebbasisgen(stock, deg, lb, ub)
  sphi <- chebbasisgen(stock, deg, lb, ub, dorder = 1)
  
  ## System matrices
  A <- (delta - dsdotds)
  
  nsqr <- (A^2) * fphi -
    sdot * A * sphi -
    dsdotdss * sdot * fphi
  
  rhs <- dwdss * sdot * A +
    dwds  * dsdotdss * sdot
  
  ## Solve system
  if (deg == length(stock)) {
    
    ## Exactly determined system
    coeff <- solve(nsqr, rhs)
    
  } else if (deg < length(stock)) {
    
    ## Over-determined system (least squares)
    coeff <- solve(t(nsqr) %*% nsqr,
                   t(nsqr) %*% rhs)
    
  } else {
    stop("Number of nodes must be >= degree of approximation.")
  }
  
  ## Return (coefficients as column vector)
  res <- list(
    degree      = deg,
    lowerB      = lb,
    upperB      = ub,
    delta       = delta,
    coefficient = coeff
  )
  
  return(res)
}