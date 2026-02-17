vaprox <- function(aproxspace, stock, sdot, w, covmat = NULL) {
  
  ## Extract approximation space
  deg   <- aproxspace[["degree"]]
  lb    <- aproxspace[["lowerB"]]
  ub    <- aproxspace[["upperB"]]
  delta <- aproxspace[["delta"]]
  dd <- length(deg)
  
  ## Model type
  model.type <- if (is.null(covmat)) "deterministic" else "stochastic"
  
  ## Combine and check data
  sdata2 <- as.matrix(cbind(stock, sdot, w, covmat))
  
  if (is.null(covmat)) {
    ## Deterministic case
    sdata2 <- as.matrix(cbind(stock, sdot, w))
    
    if (ncol(sdata2) != (2 * dd + 1)) {
      stop("Inconsistent dimensions: stock and sdot do not match deg.")
    }
    
  } else {
    ## Stochastic case
    sdata2 <- as.matrix(cbind(stock, sdot, w, covmat))
    
    if (ncol(sdata2) != (2 * dd + (dd^2) + 1)) {
      stop("Inconsistent dimensions: stock, sdot, and covmat do not match deg.")
    }
  }
  
  ## Order by stock states
  if (dd > 1) {
    ordername <- paste0("sdata2[,", dd, "]")
    for (di in 2:dd) {
      odtemp <- paste0("sdata2[,", dd - di + 1, "]")
      ordername <- paste(ordername, odtemp, sep = ",")
    }
    ordername <- paste("sdata2[order(", ordername, "),]", 
                       sep = "")
    sdata2 <- eval(parse(text = ordername))
  }
  else sdata2 <- sdata2[order(sdata2[, 1]), ]
  
  sdata <- sdata2[,1:(2*dd+1)]
  
  if (is.null(covmat)) {
    covmat <- NULL
  } else {
    covmat <- as.matrix(sdata2[,(2*dd+2):(2*dd+(dd^2)+1)],ncol=dd^2)
  }
  
  ## Extract unique grids and components
  st <- lapply(1:dd, function(k) unique(sdata[, k]))
  sdot <- lapply((dd + 1):(2 * dd), function(k) sdata[, k])
  w <- sdata[, (2 * dd + 1)]
  
  ## Basis matrices
  d0nodes <- lapply(1:dd, function(k) chebbasisgen(st[[k]], deg[k], lb[k], ub[k]))
  d1nodes <- lapply(1:dd, function(k) chebbasisgen(st[[k]], deg[k], lb[k], ub[k],dorder = 1))
  
  ## Construct Phi: Deterministic case as a base
  fphi <- matrix(1)
  sphi <- matrix(rep(0, prod(sapply(st, length)) * prod(deg)), 
                 ncol = prod(deg))
  
  for (di in dd:1) {
    ftemp <- d0nodes[[di]]
    fphi <- kronecker(fphi, ftemp)
    stempi <- d1nodes[[di]]
    sphitemp <- matrix(1)
    for (dj in dd:1) {
      if (dj != di) {
        stemp <- d0nodes[[dj]]
      }
      else stemp <- stempi
      sphitemp <- kronecker(sphitemp, stemp)
    }
    sphi <- sphi + sphitemp * sdot[[di]]
  }
  nsqr <- delta * fphi - sphi
  
  ## Stochastic case
  if (model.type == "stochastic"){
    
    d2nodes <- lapply(1:dd, function(k) chebbasisgen(st[[k]], deg[k], lb[k], ub[k],dorder = 2))
    
    tphi <- matrix(rep(0, prod(sapply(st, length)) * prod(deg)), 
                   ncol = prod(deg))
    cn <- (dd^2)+1
    
    if ((cn-1) != dim(covmat)[2]) 
      stop("The number of columns in covmat is not correct!")
    
    for (vi in dd:1){
      for (vj in dd:1){
        ttemp <- matrix(1)
        for (vk in dd:1){
          ttempi <- d0nodes[[vk]]
          if (vk %in% c(vi,vj)){
            ttempi <- d1nodes[[vk]]
          }
          if ((vk == vi) & (vk == vj)){
            ttempi <- d2nodes[[vk]]
          }
          ttemp <- kronecker(ttemp,ttempi)
        }
        cn <- cn-1
        tphi <- tphi + diag(covmat[,cn])%*%ttemp
      }
    }
    nsqr <- delta * fphi - sphi -(1/2)*tphi
  }
  
  if (dim(fphi)[1] == dim(fphi)[2]) {
    coeff <- solve(nsqr, w)
  }
  else if (dim(fphi)[1] != dim(fphi)[2]) {
    coeff <- solve(t(nsqr) %*% nsqr, t(nsqr) %*% w)
  }
  
  ## Return result
  res <- list(
    degree      = deg,
    lowerB      = lb,
    upperB      = ub,
    delta       = delta,
    coefficient = coeff,
    model.type  = model.type
  )
  
  return(res)
}