vaprox.split <- function(aproxspace,
                         stock,
                         sdot,
                         profit,
                         crit.stock,
                         split.margp,
                         split.time = NULL) {
  
  ## Extract approximation space
  deg   <- aproxspace[["degree"]]
  lb    <- aproxspace[["lowerB"]]
  ub    <- aproxspace[["upperB"]]
  delta <- aproxspace[["delta"]]
  dd    <- length(deg)
  
  model.type <- "Split (Economic Program)"
  
  ## Combine and validate input data
  stock  <- as.matrix(stock)
  sdot   <- as.matrix(sdot)
  profit <- as.matrix(profit)
  
  if (ncol(stock) != dd || ncol(sdot) != dd) {
    stop("Dimensions of stock and sdot must match length(degree).")
  }
  
  sdata <- cbind(stock, sdot, profit)
  
  nnodes <- nrow(sdata)
  
  ## Identify split node
  split.idx <- which(stock[,1] > crit.stock)
  
  if (length(split.idx) == 0) {
    stop("crit.stock exceeds observed stock range.")
  }
  
  split.node <- min(split.idx)
  
  if (split.node <= 1) {
    stop("Split node occurs at boundary; insufficient waiting region.")
  }
  
  ## Construct Chebyshev basis
  phi.wait   <- chebbasisgen(stock[, 1], deg, lb, ub)
  phi.s.wait <- chebbasisgen(stock[, 1], deg, lb, ub, dorder = 1)
  
  ## Basis for stopping region
  if (!is.null(split.time)) {
    # brute force to Faustmann rotation
    phi.stop <- matrix(phi.wait[split.node, ]*exp(-delta*split.time), nrow = 1)
  } else {
    # Standard stopping basis
    phi.stop <- matrix(chebbasisgen(stock[1, 1], deg, lb, ub),
                       nrow = 1)
  }
  
  ## Construct linear system
  
  
  # Waiting region (HJB equation)
  gmat.wait <- delta * phi.wait[1:split.node, ]
  hmat.wait <- diag(sdot[1:split.node]) %*% phi.s.wait[1:split.node, ]
  
  # Stopping region
  n.stop <- nnodes - split.node
  if (n.stop > 0) {
    gmat.stop <- phi.wait[(split.node + 1):nnodes, ]
    hmat.stop <- kronecker(matrix(1,1,n.stop), t(phi.stop))
  } else {
    gmat.stop <- NULL
    hmat.stop <- NULL
  }
  
  gmat <- rbind(gmat.wait, gmat.stop)
  hmat <- rbind(hmat.wait, t(hmat.stop))
  
  ymat <- gmat - hmat
  
  ## Solve for alpha (amenity flow) and beta
  find.w <- function(w){
    kvec <- c(stock[1:split.node, 1]*w, profit[(split.node + 1):nnodes])
    beta <- solve(t(ymat) %*% ymat, t(ymat) %*% kvec)
    vs1 <- phi.s.wait[split.node-1,] %*% beta
    tol.obj <- (vs1-split.margp)^2
    return(tol.obj)
  }
  
  w.out <- optim(par = 0,
                 fn = find.w,
                 control = list(maxit = 5000),
                 method = "BFGS")
  
  alpha <- w.out$par 
  
  ## Final beta using optimal alpha
  kvec <- c(stock[1:split.node, 1] * alpha,
            profit[(split.node + 1):nnodes])
  
  coeff <- solve(t(ymat) %*% ymat, t(ymat) %*% kvec)
  
  ## Shadow value at stopping point
  shadow.stop <- phi.s.wait[split.node - 1, ] %*% coeff
  
  ## Return results
  res <- list(
    degree      = deg,
    lowerB      = lb,
    upperB      = ub,
    delta       = delta,
    coefficient = coeff,
    shadow.stop = shadow.stop,
    alpha       = alpha,
    model.type  = model.type
  )
  
  return(res)
}