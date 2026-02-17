chebgrids <- function(nnodes, lb, ub, rtype = NULL) {
  
  dn <- length(nnodes)
  dl <- length(lb)
  du <- length(ub)
  
  # Check arguments
  if (dn != dl) {
    stop("Dimension mismatch: length(nnodes) != length(lb).")
  }
  if (dn != du) {
    stop("Dimension mismatch: length(nnodes) != length(ub).")
  }
  if (any(nnodes < 1)) stop("'nnodes' must be positive integers.")
  if (any(lb > ub)) stop("Each element of 'lb' must be <= corresponding element of 'ub'.")
  
  # Generate marginal Chebyshev grids for each dimension
  chebknots <- mapply(
    chebnodegen,
    nnodes,
    lb,
    ub,
    SIMPLIFY = FALSE
  )
  
  # Return marginal grids (default and explicit list)
  if (is.null(rtype) || rtype == "list") {
    return(chebknots)
  }
  
  # Return full grid as a matrix
  if (rtype == "grid") {
    gridcomb <- as.matrix(do.call(expand.grid, chebknots), ncol = dn)
    return(gridcomb)
  }
  
  stop("Argument 'rtype' must be one of: NULL, 'list', or 'grid'.")
}