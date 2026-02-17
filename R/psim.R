psim <- function(pcoeff, stock, wval = NULL, sdot = NULL) {
  
  ## Extract approximation settings
  deg   <- pcoeff[["degree"]]
  lb    <- pcoeff[["lowerB"]]
  ub    <- pcoeff[["upperB"]]
  delta <- pcoeff[["delta"]]
  coeff <- pcoeff[["coefficient"]]
  
  nnodes <- length(stock)
  
  ## Input consistency check
  if (xor(is.null(wval), is.null(sdot))) {
    stop("Both 'wval' and 'sdot' must be provided together, or both must be NULL.")
  }
  
  dd <- length(deg)
  
  ## Pre-allocate result objects
  accp <- matrix(0, nrow = nnodes, ncol = dd)
  iw   <- matrix(0, nrow = nnodes, ncol = dd)
  
  vhat <- NULL
  
  ## Evaluate shadow price and investment wedge
  for (ni in seq_len(nnodes)) {
    sti <- stock[ni]
    
    accp[ni, ] <- chebbasisgen(sti, deg, lb, ub) %*% coeff
    iw[ni, ]   <- accp[ni, ] * sti
  }
  
  ## Compute value function if flow payoff and dynamics are provided
  if (!is.null(wval)) {
    vhat <- matrix(0, nrow = nnodes, ncol = dd)
    
    for (ni in seq_len(nnodes)) {
      vhat[ni, ] <- (wval[ni] + accp[ni, ] * sdot[ni]) / delta
    }
  }
  
  ## Assemble results
  res <- list(
    shadowp = accp,
    iw      = iw,
    vfun    = vhat,
    stock   = matrix(stock, ncol = 1),
    wval    = wval
  )
  
  return(res)
}