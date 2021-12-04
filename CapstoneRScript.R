setwd("C:\\Users\\Ryan\\Documents\\Grad School\\MIS581-CapstoneMSDA")

library(dplyr)

#Import Complete Dataset
MPGManu.df <- read.csv("MPG_Manufacturer.csv")

#Display First 6 Rows of dataset
head(MPGManu.df)

#Show Variable types in dataset and summary values
summary(MPGManu.df)

#Display converted variables and values
summary(MPGManu.df)

#Subset Dataset
MPGManuAll.df <- filter(MPGManu.df, MPGManu.df$Vehicle.Type == "All")
MPGManuAll.df <- filter(MPGManuAll.df, MPGManuAll.df$Manufacturer == "All")
MPGManuCar.df <- filter(MPGManu.df, MPGManu.df$Vehicle.Type == "All Car")
MPGManuCar.df <- filter(MPGManuCar.df, MPGManuCar.df$Manufacturer == "All")
MPGManuTruck.df <- filter(MPGManu.df, MPGManu.df$Vehicle.Type == "All Truck")
MPGManuAllTruck.df <- filter(MPGManuTruck.df, MPGManuTruck.df$Manufacturer == "All")
MPGManuAll.df

regdata2.df <- MPGManuAll.df


regdata2.df = subset(MPGManuAll.df, select = -c(Manufacturer, Regulatory.Class, Vehicle.Type))

regdata2.df <- na.omit(regdata2.df)

regdata2car.df = subset(MPGManuCar.df, select = -c(Manufacturer, Regulatory.Class, Vehicle.Type))
regdata2car.df <- na.omit(regdata2car.df)

regdata2truck.df = subset(MPGManuTruck.df, select = -c(Manufacturer, Regulatory.Class, Vehicle.Type))
regdata2truck.df <- na.omit(regdata2truck.df)

summar(regdata2.df)

#coerse variables that are not numeric variable types but need to be using as.numeric function.

regdata2.df$Real0World.CO2_City..g.mi.<-as.numeric(regdata2.df$Real0World.CO2_City..g.mi.)
regdata2.df$ï..Model.Year<-as.numeric(regdata2.df$ï..Model.Year)

regdata2car.df$Real0World.CO2_City..g.mi.<-as.numeric(regdata2car.df$Real0World.CO2_City..g.mi.)
regdata2car.df$ï..Model.Year<-as.numeric(regdata2car.df$ï..Model.Year)

regdata2truck.df$Real0World.CO2_City..g.mi.<-as.numeric(regdata2truck.df$Real0World.CO2_City..g.mi.)
regdata2truck.df$ï..Model.Year<-as.numeric(regdata2truck.df$ï..Model.Year)


summary(regdata2.df)


#Create Linear Regression Model

logit2.reg <- lm(regdata2.df$Real0World.MPG ~ ., data = regdata2.df) 
options(scipen=999)
summary(logit2.reg)

#Plot Residuals
reg2.res = resid(logit2.reg)
reg2.res
plot(reg2.res, ylab = "Residual Values")
abline(0,0)
summary(reg2.res)

#Add prediction values

pred <- predict(logit2.reg, regdata2.df, type = "response") #create prediction values 

#Plot Predictions and Model Years
pred #display prediction values
plot(regdata2.df$ï..Model.Year,pred,xlab = "Model Year", ylab = "Prediction Values")

#plot gains chart for the Real World MPG Response Variable variable linear regression model
library(gains)
gain <- gains(as.numeric(regdata2.df$Real0World.MPG), pred)

regdata2.df$Real0World.MPG <- as.numeric(as.character(regdata2.df$Real0World.MPG)) #convert RESPONSE variable for graphing

plot(c(0,gain$cume.pct.of.total*sum(regdata2.df$Real0World.MPG))~
       c(0,gain$cume.obs), 
     xlab="# cases", ylab="Cumulative", main="", type="l")
lines(c(0,sum(regdata2.df$Real0World.MPG))~c(0, dim(regdata2.df)[1]), lty=2)

##ARIMA Model

install.packages('forecast', dependencies = TRUE)
library(forecast)

fit <- auto.arima(regdata2.df$Real0World.MPG)
fit
plot(forecast(fit, h=20))

##Electric Cars

plot(regdata2.df$ï..Model.Year, regdata2.df$Powertrain.0.Electric.Vehicle..EV., xlab = "Model Year", ylab ="Electric Car Percentage")
plot(regdata2.df$ï..Model.Year, regdata2.df$Powertrain.0.Plug0in.Hybrid.Electric.Vehicle..PHEV., xlab = "Model Year", ylab ="Plug In Hybrid Percentage")
plot(regdata2.df$ï..Model.Year, regdata2.df$Powertrain.0.Gasoline.Hybrid, xlab = "Model Year", ylab ="Gasoline Hybrid")




