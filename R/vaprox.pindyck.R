vaprox.pindyck <- function(param,
                           growthfun = c("logistic", "gompertz", "sqroot"),
                           covmat    = NULL,
                           itermax   = 300,
                           tol       = 1e-8) {
  
  ## net growth function
  growthfun <- match.arg(growthfun)
  
  gfun <- switch(
    growthfun,
    logistic = function(param, s) {
      param$r * s * (1 - s / param$K)
    },
    gompertz = function(param, s) {
      param$r * s * log(param$K / s)
    },
    sqroot = function(param, s) {
      param$r * sqrt(s) - (param$r * s) / sqrt(param$K)
    }
  )
  
  ## profit function
  wfun <- function(param, s, q) {
    cost <- (param$c / s^param$gamma) * q
    
    if (param$eta == 1) {
      param$b * log(q) - cost
    } else {
      (param$b^(1 / param$eta)) /
        (1 - 1 / param$eta) *
        q^(1 - 1 / param$eta) - cost
    }
  }
  
  ## drift term
  mufun <- function(param, s, q) {
    gfun(param, s) - q
  }
  
  ## q-optimum
  qfun <- function(param, s, Vs) {
    param$b * (Vs + param$c / s^param$gamma)^(-param$eta)
  }
  
  ## Approximation setup
  stock  <- chebnodegen(param$nodes, param$lowerK, param$upperK)
  Aspace <- aproxdef(param$order, param$lowerK, param$upperK, param$delta)
  
  ## initialization
  iter  <- 0
  error <- Inf
  
  q   <- qfun(param, stock, rep(0, length(stock)))
  w   <- wfun(param, stock, q)
  mus <- mufun(param, stock, q)
  
  cv <- vaprox(Aspace, stock, mus, w, covmat)
  cv$coefficient <- numeric(length(cv$coefficient))
  
  vout <- vsim(cv, stock)
  
  ## value function iteration
  while (error > tol && iter < itermax) {
    
    vin <- vout
    Vs <- vin$shadowp
    v0 <- vin$vfun
    
    q <- qfun(param,stock,Vs)
    w <- wfun(param,stock,q)
    mus <- mufun(param,stock,q)
    
    cv <- vaprox(Aspace,stock,mus,w,covmat)  ## do not put sigs value here!!
    vout <- vsim(cv,stock)
    
    v <- vout$vfun 
    error <- max(abs(v-v0))
    iter <- iter+1
    
    message('iteration:',iter,'   error:',error)
  }
  
  cv$gfun <- gfun
  cv$qfun <- qfun
  cv$wfun <- wfun
  return(cv)
}