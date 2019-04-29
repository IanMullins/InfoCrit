library(data.table)

InfoCrit <- function(data_, column, lags, Type = "AIC") {
  
  #Helper function to generate the nth lag formula
  add_1 <- function(string, number, extra = "") {
    if (number > 0) {
      extra <- paste(paste(string, toString(number), sep = ""), extra, sep = "+")
      return(add_1(string, number - 1, extra))
    }
    else{
      return(substr(extra, start = 1, stop = nchar(extra) - 1))
    }
    
  }
  
  #Creating the lagged variables
  setDT(data_)[, paste0(column, 1:lags) := shift(get(column), 1:lags)]
  
  #Generating the formulas for each model
  v <- sapply(1:lags, add_1, string = column)
  
  regs <- vector("list", lags + 1)
  
  #prefilling the first regression to simplify looping logic
  f <- as.formula(paste(column, 1, sep = "~"))
  regs[[1]] <- lm(f, data = data_)
  
  for (i in 1:lags) {
    f <- as.formula(paste(column, v[i], sep = "~"))
    regs[[i + 1]] <- lm(formula = f , data = data_)
    
  }
  counter <- 0
  
  get_AIC <- function(x) {
    counter <<- counter + 1
    log(sum((x$residuals) ^ 2) / (x$df + x$rank)) + counter * (2 / (x$df + x$rank))
  }
  
  get_BIC <- function(x) {
    counter <<- counter + 1
    log(sum((x$residuals) ^ 2) / (x$df + x$rank)) + counter * (log((x$df + x$rank)) / (x$df + x$rank))
  }
  IC <- vector("list", lags)
  if (Type == "AIC") {
    IC <- sapply(regs, get_AIC)
  }
  if (Type == "BIC") {
    IC <- sapply(regs, get_BIC)
  }
  
  return(IC)
}
