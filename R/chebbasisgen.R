chebbasisgen <- function(nodes, npol, a, b, dorder = NULL) {
  
  nknots <- length(nodes)
  
  # Check arguments
  if (npol < 4) {
    stop("Degree of Chebyshev polynomial must be greater than 3.")
  }
  if (b <= a) stop("'b' must be greater than 'a'.")
  if (!is.numeric(nodes)) stop("'nodes' must be numeric.")
  
  # Map nodes to Chebyshev domain [-1, 1]
  z <- (2 * nodes - b - a) / (b - a)
  
  # Generate Chebyshev basis
  bvec <- cbind(
    matrix(1, nknots, 1),
    matrix(z, nknots, 1)
  )
  colnames(bvec) <- c("j=1", "j=2")
  
  for (j in 2:(npol - 1)) {
    Tj <- 2 * z * bvec[, j] - bvec[, j - 1]
    bvec <- cbind(bvec, Tj)
    colnames(bvec)[ncol(bvec)] <- paste0("j=", j + 1)
  }
  
  # No derivatives requested
  if (is.null(dorder)) {
    return(bvec)
  }
  
  # First derivative
  if (dorder >= 1) {
    
    bvecp <- cbind(
      matrix(0, nknots, 1),
      matrix(2 / (b - a), nknots, 1)
    )
    colnames(bvecp) <- c("j=1", "j=2")
    
    for (j in 2:(npol - 1)) {
      Tjp <- (4 / (b - a)) * bvec[, j] +
        2 * z * bvecp[, j] -
        bvecp[, j - 1]
      
      bvecp <- cbind(bvecp, Tjp)
      colnames(bvecp)[ncol(bvecp)] <- paste0("j=", j + 1)
    }
    
    # If only first derivative is requested
    if (dorder == 1) {
      return(bvecp)
    }
    
    # Higher-order derivatives (dorder >= 2)
    bvec <- bvecp
    
    for (d in 2:dorder) {
      
      bvecp <- cbind(
        matrix(0, nknots, 1),
        matrix(0, nknots, 1)
      )
      colnames(bvecp) <- c("j=1", "j=2")
      
      for (j in 2:(npol - 1)) {
        Tjp <- ((4 * d) / (b - a)) * bvec[, j] +
          2 * z * bvecp[, j] -
          bvecp[, j - 1]
        
        bvecp <- cbind(bvecp, Tjp)
        colnames(bvecp)[ncol(bvecp)] <- paste0("j=", j + 1)
      }
      
      bvec <- bvecp
    }
    
    return(bvecp)
  }
  
  stop("Argument 'dorder' must be NULL or a positive integer.")
}