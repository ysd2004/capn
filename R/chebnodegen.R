chebnodegen <- function(n, a, b){
  
  da <- length(a)
  db <- length(b)
  
  # Check arguments
  if (da != db) {
    stop("Dimension mismatch: length(a) != length(b).")
  }
  if (n < 1) stop("'n' must be a positive integer.")
  
  # Generate Chebyshev nodes on [a, b]
  si <- (a+b)*0.5 + (b-a)*0.5*cos(pi*((seq((n-1),0,by=-1)+0.5)/n))
  
  return(si)
}