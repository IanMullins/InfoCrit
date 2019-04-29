
# How to use:
# x <- InfoCrit(Your dataframe,"Name of the column of interest",\
#               number of lags, "AIC" or "BIC")
# x now holds Your Information criteria value in a vector


library(data.table)
#setDT(data_)[,paste0(column,1:lags):= shift(column,1:lags)]

InfoCrit <- function(data_, column, lags,Type="AIC"){
  
  
  
  #Helper function to generate the nth lag formula
  add_1 <- function(string,number,extra=""){
    
    if (number>0){
      extra <- paste(paste(string,toString(number), sep = ""),extra,sep = "+")
      #print(number)
      return(add_1(string,number-1,extra))
    }
    else{
      return(substr(extra,start=1,stop = nchar(extra)-1))
    }
    
  }
  
  
  
  
  
  
  #"I wrote this part to make the fuction self contained
  #For the purposes of this homework that is probably not necessary"
  setDT(data_)[,paste0(column,1:lags):= shift(get(column),1:lags)]
  
  
  
  
  v <- sapply(1:lags,add_1,string=column)
  
  regs <- vector("list",lags+1)
  
  f <- as.formula(paste(column,1,sep = "~"))
  
  regs[[1]] <- lm(f,data = data_) 
  f
  
  for (i in 1:lags){
    f <- as.formula(
      paste(column,
            v[i],sep = "~")
    )
    
    regs[[i+1]] <- lm(formula = f , data = data_)
    f
    
  }
  counter <- 0
  
  get_AIC <- function(x){
    counter<<- counter+1;
    
    
    log(sum((x$residuals)^2)/(x$df + x$rank))+ counter*(2/(x$df+x$rank))
  }
  
  get_BIC <- function(x){
    counter<<- counter+1;
    log(sum((x$residuals)^2)/(x$df + x$rank))+counter*(log((x$df + x$rank))/(x$df + x$rank))
  }
  
  
  
  IC <- vector("list", lags)
  if (Type == "AIC"){
    IC <- sapply(regs,get_AIC)
  }
  if(Type == "BIC"){
    IC <- sapply(regs,get_BIC)
  }
  
  return(IC)
}

