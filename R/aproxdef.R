aproxdef <- function(deg, lb, ub, delta) {
  
  if (delta < 0 || delta > 1) {
    stop("Argument 'delta' must be in the interval [0, 1].")
  }
  
  dn <- length(deg)
  dl <- length(lb)
  du <- length(ub)
  
  if (dn != dl) {
    stop("Dimension mismatch: length(deg) != length(lb).")
  }
  if (dn != du) {
    stop("Dimension mismatch: length(deg) != length(ub).")
  }
  
  param <- list(
    degree = deg,
    lowerB = lb,
    upperB = ub,
    delta  = delta
  )
  
  return(param)
}