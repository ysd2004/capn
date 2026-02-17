vsim <- function(vcoeff, stock, wval = NULL) {
  
  ## Extract approximation components
  deg   <- vcoeff[["degree"]]
  lb    <- vcoeff[["lowerB"]]
  ub    <- vcoeff[["upperB"]]
  delta <- vcoeff[["delta"]]
  coeff <- vcoeff[["coefficient"]]
  mtype <- vcoeff[["model.type"]]
  
  dd <- length(deg)
  
  ## Normalize stock input
  if (is.data.frame(stock)) {
    st <- as.matrix(stock)
  } else if (is.matrix(stock)) {
    st <- stock
  } else if (is.numeric(stock)) {
    st <- matrix(stock, ncol = dd)
  } else {
    stop("stock must be numeric, matrix, or data.frame.")
  }
  
  if (ncol(st) != dd) {
    stop("Number of stock dimensions does not match degree.")
  }
  
  nnodes <- nrow(st)
  ncoef  <- prod(deg)
  
  ## Allocate objects
  shadowp <- matrix(0, nnodes, dd)
  Phi     <- matrix(0, nnodes, ncoef)
  
  ## Loop over stock dimensions (shadow prices)
  for (di in seq_len(dd)) {
    
    Phi_s <- matrix(0, nnodes, ncoef)
    
    for (ni in seq_len(nnodes)) {
      
      sti <- st[ni, ]
      
      ## Basis construction
      phi  <- 1
      phi_s <- 1
      
      for (dj in seq_len(dd)) {
        
        if (dj == di) {
          b0 <- chebbasisgen(sti[dj], deg[dj], lb[dj], ub[dj])
          b1 <- chebbasisgen(sti[dj], deg[dj], lb[dj], ub[dj], dorder = 1)
        } else {
          b0 <- chebbasisgen(sti[dj], deg[dj], lb[dj], ub[dj])
          b1 <- b0
        }
        
        phi   <- kronecker(phi,  b0)
        phi_s <- kronecker(phi_s, b1)
      }
      
      Phi[ni, ]   <- phi
      Phi_s[ni, ] <- phi_s
    }
    
    shadowp[, di] <- Phi_s %*% coeff
  }
  
  ## Inclusive wealth
  iweach <- shadowp * st
  iw     <- matrix(rowSums(iweach), ncol = 1)
  
  ## Value function
  vhat <- Phi %*% coeff
  
  ## Labels
  colnames(shadowp) <- paste0("shadowp", seq_len(dd))
  colnames(iweach)  <- paste0("iw", seq_len(dd))
  colnames(iw)      <- "iw"
  
  if (is.null(wval)) {
    wval <- "wval is not provided"
  }
  
  ## Return
  res <- list(
    shadowp    = shadowp,
    iweach     = iweach,
    iw         = iw,
    vfun       = vhat,
    stock      = st,
    wval       = wval,
    model.type = mtype
  )
  
  return(res)
}
