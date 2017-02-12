library("forecast")
library("Matrix")
library("caret")
#Getting product data from product_distribution_training_set
product_distribution_training_set <- read.delim(file.choose(new=FALSE), header=FALSE)
#Calculating the sum of sales of Products for each day
sumcol<-colSums(product_distribution_training_set[,-1])
#Generating the Matrix 
smatrix<-data.matrix(sumcol,rownames.force = NA)
#Generating the time series data for the obtained data set
y <- ts(ts(data.frame(smatrix[c(1:118),1])), frequency=1)
#Applying the fourier transform and getting the fourier Regressor
z <- fourier(ts(data.frame(smatrix[c(1:118),1]), frequency=91.3125), K=5)
#Implementing Arima with automatic model selection with external Regressor 
fit <- auto.arima(y,  xreg=z, seasonal=TRUE)
#Applying the fourier transform and getting the fourier Regressor
yfc <- forecast(fit, xreg=z,h=100)
#plot(yfc)
#Forecasting or predicting the future value
z1 <- fourier(ts(data.frame(smatrix[c(1:118),1]), frequency=365.25), K=5)
#Implementing Arima with automatic model selection with external Regressor 
fit1 <- auto.arima(y,  xreg=z1, seasonal=TRUE,allowdrift = TRUE,allowmean = TRUE)
#Forecasting or predicting the future value
yfc1 <- forecast(fit1, xreg=z1,h=29)
#plot(yfc1)
#Implementing Neural Networks
fit2 <- nnetar(y,size = 30,xreg=z,repeats = 100)
#Forecasting or predicting the future value
nfc<-forecast(fit2,xreg=z,h=29)

#plot(yfc1)
#calculating the accuracy for each model
ac1<-accuracy(yfc)
ac2<-accuracy(yfc1)
ac3<-accuracy(nfc)


#Choosing the most accurate model
if(ac1[1,2]<=ac2[1,2] && ac1[1,2]<=ac3[1,2] && ac1[1,2]<=ac4[1,2] )
{
  wc<-yfc$mean
  wc[wc<0]<-fc$upper[,1]
}else if(ac2[1,2]<=ac1[1,2] && ac2[1,2]<=ac3[1,2] && ac2[1,2]<=ac4[1,2])
{
  wc<-yfc1$mean
  wc[wc<0]<-yfc1$upper[,1]
}else
{
  wc<-nfc$mean
  wc[wc<0]<-nfc$upper[,1]
}
#wc<-fc$mean

#making all the values less than zero as zero
wc[wc<0]<-0
#rounding the prediction values
wc<-round(wc)
wmatrix<-matrix(c(0,as.numeric(wc)),1,119)
fmatrix<-matrix(0,101,119)
fmatrix[1,]<-wmatrix
#Getting the values of all the products in a matrix
pmatrix<-data.matrix(product_distribution_training_set,rownames.force = NA)
pmatrix<-t(pmatrix)
#Looping the code to get the sales data for each product
for(i in 1:100){
  #converting the sales data into time series data
  y <- ts(ts(data.frame(pmatrix[c(2:119),i])), frequency=1)
  #Applying the fourier function
  z <- fourier(ts(ts(data.frame(pmatrix[c(2:119),i])), frequency=91.3125), K=5)
  #Applying the Automatic arima function to use the best arima model and get the best fit
  fit <- auto.arima(y,  xreg=z, seasonal=FALSE)
  #Predicting the future values
  fc <- forecast(fit, xreg=z,h=100)
  #Applying the fourier function
  z1 <- fourier(ts(data.frame(pmatrix[c(2:119),i]), frequency=365.25), K=5)
  #Applying the Automatic arima function to use the best arima model and get the best fit
  fit1 <- auto.arima(y,  xreg=z1, seasonal=FALSE)
  #Predicting the future values
  yfc1 <- forecast(fit1, xreg=z1,h=100)

  #Implementing Neural Networks
  fit2 <- nnetar(y,xreg=z)
  nfc<-forecast(fit2,xreg=z)
  #calculating the accuracy for each function
  #plot(yfc1)
  ac1<-accuracy(yfc)
  ac2<-accuracy(yfc1)
  ac3<-accuracy(nfc)

  #calculating the most accurate the function
  if(ac1[1,2]<=ac2[1,2] && ac1[1,2]<=ac3[1,2] && ac1[1,2]<=ac4[1,2] )
  {
    wc<-yfc$mean
    wc[wc<0]<-fc$upper[,1]
  }else if(ac2[1,2]<=ac1[1,2] && ac2[1,2]<=ac3[1,2] && ac2[1,2]<=ac4[1,2])
  {
    wc<-yfc1$mean
    wc[wc<0]<-yfc1$upper[,1]
  }else
  {
    wc<-nfc$mean
    wc[wc<0]<-0
  }
  #replacing all the prediction with negative values with 0
  wc[wc<0]<-0
  #rounding each value 
  wc<-round(wc)
  wmatrix<-matrix(c(pmatrix[1,i],as.numeric(wc)),1,119)
  #sending the data to the sollution matrix
  fmatrix[i+1,]<-wmatrix
  #plot(nfc)
}
#Printing only for the next 28 days of prediction
output<-fmatrix[,c(1:28)]
#Writing the output into the output
write.table(output,file="output.txt",sep = "\t",quote = F,row.names = F,col.names = F)

