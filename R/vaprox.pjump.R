vaprox.pjump <- function (aproxspace, stock, sdot, wb, hs, zs){
 
  ## Extract approximation space
  deg   <- aproxspace[["degree"]]
  lb    <- aproxspace[["lowerB"]]
  ub    <- aproxspace[["upperB"]]
  delta <- aproxspace[["delta"]]
  dd <- length(deg)
  
  ## Model type
  model.type <- "Poisson Jump"
  
  ## RHS of the HJB
  w <- wb + hs*zs
  
  ## Combine and check data
  sdata <- as.matrix(cbind(stock,sdot,w),ncol=(dd*2)+1)
  
  if (ncol(sdata) != (2 * dd + 1)) {
    stop("Inconsistent dimensions: stock and sdot do not match deg.")
  }
  
  ## Order by stock states
  if (dd > 1) {
    ordername <- paste0("sdata[,", dd, "]")
    for (di in 2:dd) {
      odtemp <- paste0("sdata[,", dd - di + 1, "]")
      ordername <- paste(ordername, odtemp, sep = ",")
    }
    ordername <- paste("sdata[order(", ordername, "),]", 
                       sep = "")
    sdata <- eval(parse(text = ordername))
  }
  else sdata <- sdata[order(sdata[, 1]), ]
  
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
  nsqr <- matrix(diag(as.vector(delta+hs)),ncol=deg)%*%fphi - sphi
  
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
