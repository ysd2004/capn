pdotsim <- function(pdotcoeff, stock, sdot, dsdotds, wval, dwds) {
  
  ## Extract approximation space and coefficients
  deg   <- pdotcoeff[["degree"]]
  lb    <- pdotcoeff[["lowerB"]]
  ub    <- pdotcoeff[["upperB"]]
  delta <- pdotcoeff[["delta"]]
  coeff <- pdotcoeff[["coefficient"]]
  
  ## Coerce inputs to vectors for consistency
  if (is.matrix(stock))   stock   <- as.vector(stock)
  if (is.matrix(sdot))    sdot    <- as.vector(sdot)
  if (is.matrix(dsdotds)) dsdotds <- as.vector(dsdotds)
  if (is.matrix(wval))    wval    <- as.vector(wval)
  if (is.matrix(dwds))    dwds    <- as.vector(dwds)
  
  nnodes <- length(stock)
  dd     <- length(deg)
  
  ## Pre-allocate result matrices
  shadowp <- matrix(0, nnodes, dd)
  iw      <- matrix(0, nnodes, dd)
  vfun    <- matrix(0, nnodes, dd)
  
  ## Main loop
  for (ni in seq_len(nnodes)) {
    
    sti <- stock[ni]
    
    ## Approximate \dot{p}(s)
    pdot_i <- chebbasisgen(sti, deg, lb, ub) %*% coeff
    
    ## Shadow price p(s)
    shadowp[ni, ] <- (dwds[ni] + pdot_i) / (delta - dsdotds[ni])
    
    ## Iclusive wealth
    iw[ni, ] <- shadowp[ni, ] * sti
    
    ## Value function
    vfun[ni, ] <- (wval[ni] + shadowp[ni, ] * sdot[ni]) / delta
  }
  
  ## Return results
  res <- list(
    shadowp = shadowp,
    iw      = iw,
    vfun    = vfun,
    stock   = as.matrix(stock, ncol = 1),
    wval    = wval
  )
  
  return(res)
}