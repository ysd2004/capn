paprox <- function(aproxspace, stock, sdot, dsdotds, dwds) {
  
  deg   <- aproxspace[["degree"]]
  lb    <- aproxspace[["lowerB"]]
  ub    <- aproxspace[["upperB"]]
  delta <- aproxspace[["delta"]]
  
  ## Coerce to vectors if matrices are supplied
  if (is.matrix(stock))    stock    <- as.vector(stock)
  if (is.matrix(sdot))     sdot     <- as.vector(sdot)
  if (is.matrix(dsdotds))  dsdotds  <- as.vector(dsdotds)
  if (is.matrix(dwds))     dwds     <- as.vector(dwds)
  
  ## Basic length checks
  n <- length(stock)
  if (length(sdot) != n)
    stop("Length mismatch: 'sdot' must have the same length as 'stock'.")
  if (length(dsdotds) != n)
    stop("Length mismatch: 'dsdotds' must have the same length as 'stock'.")
  if (length(dwds) != n)
    stop("Length mismatch: 'dwds' must have the same length as 'stock'.")
  
  ## Chebyshev basis and first derivative
  fphi <- chebbasisgen(stock, deg, lb, ub)
  sphi <- chebbasisgen(stock, deg, lb, ub, dorder = 1)
  
  ## Construct normal equations
  nsqr <- (delta - dsdotds) * fphi - sdot * sphi
  
  ## Solve for coefficients
  if (deg == n) {
    ## Square system
    coeff <- solve(nsqr, dwds)
  } else if (deg < n) {
    ## Overdetermined system (least squares)
    coeff <- solve(t(nsqr) %*% nsqr, t(nsqr) %*% dwds)
  } else {
    stop("Degree of approximation must not exceed the number of observations.")
  }
  
  res <- list(
    degree      = deg,
    lowerB      = lb,
    upperB      = ub,
    delta       = delta,
    coefficient = as.vector(coeff)
  )
  
  return(res)
}