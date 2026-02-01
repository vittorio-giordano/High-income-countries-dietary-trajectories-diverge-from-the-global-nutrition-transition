library(quantreg)
library(ncdf4)

setwd("") #set working directory

country_name=read.csv('country_name.csv', header = TRUE, sep = ";") # countries names ordered as DES_share time series
country_name_GDP=read.csv('country_name_GDP.csv', header = FALSE, sep = ";") # countries names ordered as GDP time series

food_categories=read.csv("food_categories.csv", header = TRUE, sep = ";") #names of food categories (4) and food items (15)
food_category_4=food_categories[1:4,2]
food_item_15=food_categories[1:15,1]

GDP=as.matrix(read.csv("GDP_standard_2015_prices_capita.csv", header = TRUE, sep = ";")) # GDP data

# DES shares time series for every country and 4 food categories
nc <- nc_open("DES_data_share_4.nc") #switch to "_15" for 15 food items, "_total_" for total calories
DES_share <- ncvar_get(nc, "DES_share_4") #or "_15", "DES_4" for totals
dim(DES_share) # [1] 196  61   4 - countries x years x categories
nc_close(nc)

DES_share <- DES_share[, 10:dim(DES_share)[2], ] #start from 1970, as GDP data

All <- matrix(0, nrow = 196*52, ncol = 2) #collect every country DES, for performing regressions

for (ct in 1:dim(food_category_4)[1]) { #loop on categories
  
  for (cn in 1:dim(DES_share)[1]) { #loop on countries
    
    str1=as.character(country_name[cn,1]) #get name of country cn for DES_share
    str2 <- as.character(sapply(country_name_GDP[, 1], as.character)) #get all countries names for GDP
    X <- GDP[str1==str2,]  #pick GDP data for country cn
    Y2 <- DES_share[cn, , ct]*100 #pick DES data for country cn
   
    if (length(X) == 0) {
      X <- matrix(NaN, nrow=52, ncol=1)
    }
    
    All[(52*(cn-1)+1):(52*cn), 1] <- X #store and align all countries GDP data
    All[(52*(cn-1)+1):(52*cn), 2] <- Y2 #store and align all countries DES data
    
  } #end of countries loop
  
  All <- All[order(All[, 1]), ] #order by GDP, ascending
  All[, 1] <- log10(All[, 1]) # GDP in log 10 scale
  
  df_distrubution <- data.frame(gdp=All[, 1], #data frame with GDP and DES share distribution
                   diet=All[, 2])
  
  mdl2 <- lm(diet ~ poly(gdp, 2, raw=TRUE), data = df_distrubution) #linear regression model, 2nd order
  P2 <- predict(mdl2, newdata = df_distrubution) #predicted values from linear regression model
  
  # save into file that is not overwritten every loop on food categories/ items
  
  Q=seq(0.05, 0.95, by = 0.05) #quantiles to be estimated
  multi_rqfit <- rq(diet ~ poly(gdp, 2, raw=TRUE), data = df_distrubution, tau = Q) #multi-quantile regressions, quantiles set by Q
  multi_predict <- predict(multi_rqfit, newdata = df_distrubution)
  
  # save into file that is not overwritten every loop on food categories/ items
  
} # close loop on food categories/items

# save your files