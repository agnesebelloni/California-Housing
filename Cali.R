#Applicazione sul dataset housing
library(readr)
library(dplyr)
library(ggplot2)
library("visdat")
library("naniar")
library(gridExtra)
library(tidyr)

cali_houses<-read_csv("/Users/computer/Desktop/TESI/Codice/housing.csv")

dim(cali_houses)
#20640    10
 
#visualizziamo un summary del dataset
summary(cali_houses)
#  longitude         latitude    
#Min.   :-124.3   Min.   :32.54  
#1st Qu.:-121.8   1st Qu.:33.93  
#Median :-118.5   Median :34.26  
#Mean   :-119.6   Mean   :35.63  
#3rd Qu.:-118.0   3rd Qu.:37.71  
#Max.   :-114.3   Max.   :41.95  

#housing_median_age  total_rooms   
#Min.   : 1.00      Min.   :    2  
#1st Qu.:18.00      1st Qu.: 1448  
#Median :29.00      Median : 2127  
#Mean   :28.64      Mean   : 2636  
#3rd Qu.:37.00      3rd Qu.: 3148  
#Max.   :52.00      Max.   :39320  

#total_bedrooms     population   
#Min.   :   1.0   Min.   :    3  
#1st Qu.: 296.0   1st Qu.:  787  
#Median : 435.0   Median : 1166  
#Mean   : 537.9   Mean   : 1425  
#3rd Qu.: 647.0   3rd Qu.: 1725  
#Max.   :6445.0   Max.   :35682  
#NA's   :207                     
#   households     median_income    
# Min.   :   1.0   Min.   : 0.4999  
# 1st Qu.: 280.0   1st Qu.: 2.5634  
# Median : 409.0   Median : 3.5348  
# Mean   : 499.5   Mean   : 3.8707  
# 3rd Qu.: 605.0   3rd Qu.: 4.7432  
# Max.   :6082.0   Max.   :15.0001  
                                   
# median_house_value ocean_proximity   
# Min.   : 14999     Length:20640      
# 1st Qu.:119600     Class :character  
# Median :179700     Mode  :character  
# Mean   :206856                       
# 3rd Qu.:264725                       
# Max.   :500001  

#FASE DI PREPROCESSING

#per prima cosa vado a vedere se ci sono valori mancanti

colSums(is.na(cali_houses))

#longitude           latitude 
#0                  0 
#housing_median_age        total_rooms 
#0                  0 
#total_bedrooms         population 
#207                  0 
#households      median_income 
#0                  0 
#median_house_value    ocean_proximity 
#0                  0 

#visualizzo i dati mancanti
vis_miss(cali_houses)

#eliminiamo le righe con i dati mancanti
cali_houses<-na.omit(cali_houses)

#procediamo ora rappresentando i dati con un boxplot
#per gli outlier 

numeric_cali_houses<-cali_houses%>%select(-ocean_proximity)
numeric_cali_houses<-scale(numeric_cali_houses)
numeric_cali_houses<-as.data.frame(numeric_cali_houses)
long_format<-pivot_longer(numeric_cali_houses, cols=everything(), 
                          names_to="Variable", values_to="Value")

ggplot(long_format, aes(x=Variable, y=Value, fill=Variable))+
  geom_boxplot()+
  labs(title="Boxplot delle variabili numeriche del dataset California Housing",
       x="Variabile",
       y="Valore")+
  theme_minimal()+
  theme(legend.position="none",  
    plot.title=element_text(hjust=0.5, size=10, face="bold", color="black",
      margin=margin(10, 0, 10, 0)),
    axis.title.x=element_text(size = 14, face = "bold"),
    axis.title.y=element_text(size = 14, face = "bold"),
    axis.text.x=element_text(angle = 45, hjust = 1))


#faccio ora gli istogrammi di ogni varibile per vedere come si distribuiscono
long<-ggplot(cali_houses, aes(x=longitude, y=..density..))+
  geom_histogram(color="white", fill="#F8766D")+
  labs(title="Istogramma della variabile longitude",
       x="longitude",
       y="Valore")+
  theme_minimal()+
  theme(legend.position="none",  
        plot.title=element_text(hjust=0.5, size=10, face="bold", color="black",
                                margin=margin(10, 0, 10, 0)),
        axis.title.x=element_text(size = 10, face = "bold"),
        axis.title.y=element_text(size = 10, face = "bold"),
        axis.text.x=element_text(angle = 45, hjust = 1))

lat<-ggplot(cali_houses, aes(x=latitude, y=..density..))+
  geom_histogram(color="white", fill="#A3A500")+
  labs(title="Istogramma della variabile latitude",
       x="latitude",
       y="Valore")+
  theme_minimal()+
  theme(legend.position="none",  
        plot.title=element_text(hjust=0.5, size=10, face="bold", color="black",
                                margin=margin(10, 0, 10, 0)),
        axis.title.x=element_text(size = 10, face = "bold"),
        axis.title.y=element_text(size = 10, face = "bold"),
        axis.text.x=element_text(angle = 45, hjust = 1))

hma<-ggplot(cali_houses, aes(x=housing_median_age, y=..density..))+
  geom_histogram(color="white", fill="#00BF7D")+
  labs(title="Istogramma della variabile housing_median_age",
       x="housing_median_age",
       y="Valore")+
  theme_minimal()+
  theme(legend.position="none",  
        plot.title=element_text(hjust=0.5, size=10, face="bold", color="black",
                                margin=margin(10, 0, 10, 0)),
        axis.title.x=element_text(size = 10, face = "bold"),
        axis.title.y=element_text(size = 10, face = "bold"),
        axis.text.x=element_text(angle = 45, hjust = 1))

tr<-ggplot(cali_houses, aes(x=total_rooms, y=..density..))+
  geom_histogram(color="white", fill="#00B0F6")+
  labs(title="Istogramma della variabile total_rooms",
       x="total_rooms",
       y="Valore")+
  theme_minimal()+
  theme(legend.position="none",  
        plot.title=element_text(hjust=0.5, size=10, face="bold", color="black",
                                margin=margin(10, 0, 10, 0)),
        axis.title.x=element_text(size = 10, face = "bold"),
        axis.title.y=element_text(size = 10, face = "bold"),
        axis.text.x=element_text(angle = 45, hjust = 1))

tb<-ggplot(cali_houses, aes(x=total_bedrooms, y=..density..))+
  geom_histogram(color="white", fill="#E76BF3")+
  labs(title="Istogramma della variabile total_bedrooms",
       x="total_bedrooms",
       y="Valore")+
  theme_minimal()+
  theme(legend.position="none",  
        plot.title=element_text(hjust=0.5, size=10, face="bold", color="black",
                                margin=margin(10, 0, 10, 0)),
        axis.title.x=element_text(size = 10, face = "bold"),
        axis.title.y=element_text(size = 10, face = "bold"),
        axis.text.x=element_text(angle = 45, hjust = 1))

pop<-ggplot(cali_houses, aes(x=population, y=..density..))+
  geom_histogram(color="white", fill="#F8766D")+
  labs(title="Istogramma della variabile population",
       x="population",
       y="Valore")+
  theme_minimal()+
  theme(legend.position="none",  
        plot.title=element_text(hjust=0.5, size=10, face="bold", color="black",
                                margin=margin(10, 0, 10, 0)),
        axis.title.x=element_text(size = 10, face = "bold"),
        axis.title.y=element_text(size = 10, face = "bold"),
        axis.text.x=element_text(angle = 45, hjust = 1))

hh<-ggplot(cali_houses, aes(x=households, y=..density..))+
  geom_histogram(color="white", fill="#A3A500")+
  labs(title="Istogramma della variabile households",
       x="households",
       y="Valore")+
  theme_minimal()+
  theme(legend.position="none",  
        plot.title=element_text(hjust=0.5, size=10, face="bold", color="black",
                                margin=margin(10, 0, 10, 0)),
        axis.title.x=element_text(size = 10, face = "bold"),
        axis.title.y=element_text(size = 10, face = "bold"),
        axis.text.x=element_text(angle = 45, hjust = 1))

mi<-ggplot(cali_houses, aes(x=median_income, y=..density..))+
  geom_histogram(color="white", fill="#00BF7D")+
  labs(title="Istogramma della variabile median_income",
       x="median_income",
       y="Valore")+
  theme_minimal()+
  theme(legend.position="none",  
        plot.title=element_text(hjust=0.5, size=10, face="bold", color="black",
                                margin=margin(10, 0, 10, 0)),
        axis.title.x=element_text(size = 10, face = "bold"),
        axis.title.y=element_text(size = 10, face = "bold"),
        axis.text.x=element_text(angle = 45, hjust = 1))

mhv<-ggplot(cali_houses, aes(x=median_house_value, y=..density..))+
  geom_histogram(color="white", fill="#00B0F6")+
  labs(title="Istogramma della variabile median_house_value",
       x="median_house_value",
       y="Valore")+
  theme_minimal()+
  theme(legend.position="none",  
        plot.title=element_text(hjust=0.5, size=10, face="bold", color="black",
                                margin=margin(10, 0, 10, 0)),
        axis.title.x=element_text(size = 10, face = "bold"),
        axis.title.y=element_text(size = 10, face = "bold"),
        axis.text.x=element_text(angle = 45, hjust = 1))

op<-ggplot(cali_houses, aes(x=ocean_proximity))+
  geom_bar(color="white", fill="#FF8C00")+
  labs(title="Istogramma della variabile ocean_proximity",
       x="ocean_proximity",
       y="Valore")+
  theme_minimal()+
  theme(legend.position="none",  
        plot.title=element_text(hjust=0.5, size=20, face="bold", color="black",
                                margin=margin(10, 0, 10, 0)),
        axis.title.x=element_text(size = 15, face = "bold"),
        axis.title.y=element_text(size = 15, face = "bold"),
        axis.text.x=element_text(angle = 45, hjust = 1))

grid.arrange(long, lat, hma, tr, tb, pop, hh, mi, mhv, ncol=3)
op 


#facciamo ora un grafico che rappresenti la correlazione tra le variabili
library(ggcorrplot)
numeric_cali_houses<-cali_houses%>%select(-ocean_proximity)
matr_corr<-cor(numeric_cali_houses)
ggcorrplot(matr_corr, hc.order=T, lab=T,
           title="Correlazione tra le variabili",
           ggtheme=ggplot2::theme_minimal())+
  ggtitle("Correlazione tra le variabili") +
  theme(plot.title=element_text(hjust=0.5, size=20, face="bold", color="black",
                              margin=margin(10, 0, 10, 0))
  )

#passo all'addestramento un modello di previsione
#scelgo la regressione lineare

library(stats)

#addestro un modello di regressione lineare per predire 
#la variabile median_house_value

model<-lm(median_house_value ~ ., data=cali_houses)

summary(model)

#Call:
#  lm(formula = median_house_value ~ ., data = cali_houses)

#Residuals:
#  Min      1Q  Median      3Q     Max 
#-556980  -42683  -10497   28765  779052 

#Coefficients:
# Estimate Std. Error
#(Intercept)               -2.270e+06  8.801e+04
#longitude                 -2.681e+04  1.020e+03
#latitude                  -2.548e+04  1.005e+03
#housing_median_age         1.073e+03  4.389e+01
#total_rooms               -6.193e+00  7.915e-01
#total_bedrooms             1.006e+02  6.869e+00
#population                -3.797e+01  1.076e+00
#households                 4.962e+01  7.451e+00
#median_income              3.926e+04  3.380e+02
#ocean_proximityINLAND     -3.928e+04  1.744e+03
#ocean_proximityISLAND      1.529e+05  3.074e+04
#ocean_proximityNEAR BAY   -3.954e+03  1.913e+03
#ocean_proximityNEAR OCEAN  4.278e+03  1.570e+03
#t value Pr(>|t|)    
#(Intercept)               -25.791  < 2e-16 ***
#  longitude                 -26.296  < 2e-16 ***
#  latitude                  -25.363  < 2e-16 ***
#  housing_median_age         24.439  < 2e-16 ***
#  total_rooms                -7.825 5.32e-15 ***
#  total_bedrooms             14.640  < 2e-16 ***
#  population                -35.282  < 2e-16 ***
#  households                  6.659 2.83e-11 ***
#  median_income             116.151  < 2e-16 ***
#  ocean_proximityINLAND     -22.522  < 2e-16 ***
#  ocean_proximityISLAND       4.974 6.62e-07 ***
#  ocean_proximityNEAR BAY    -2.067  0.03879 *  
#  ocean_proximityNEAR OCEAN   2.726  0.00642 ** 
#  ---
#  Signif. codes:  
#  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1

#Residual standard error: 68660 on 20420 degrees of freedom
#Multiple R-squared:  0.6465,	Adjusted R-squared:  0.6463 
#F-statistic:  3112 on 12 and 20420 DF,  p-value: < 2.2e-16

#verifichiamo ora i risultati ottenuti con il bootstrap
library(boot)

bootstrap<-function(data, indices, var_name) {
  train_data<-data[indices,]
  model<-lm(median_house_value ~ ., data=train_data)
  coef(model)[var_name]
}

#eseguo il bootstrap per stimare l'intervallo di confidenza del coefficiente di una variabile
set.seed(123)
var_boot<-cali_houses%>%select(longitude, latitude, housing_median_age, total_rooms, total_bedrooms, population, households, median_income)
variabili<-colnames(var_boot)

bootstrap_results<-list()
for (variabile in variabili) {
  boot_result<-boot(data=cali_houses, statistic=bootstrap, R=1000, var_name=variabile)
  
  }
  
  #calcolo gli intervalli di confidenza 
  ci_lower<-quantile(boot_result$t, 0.025, na.rm=TRUE)
  ci_upper<-quantile(boot_result$t, 0.975, na.rm=TRUE)
  
  # Salva i risultati
  bootstrap_results[[variabile]]<-list(
    original=boot_result$t0,
    bias=boot_result$bias,
    std_error=boot_result$t,
    ci_lower=ci_lower,
    ci_upper=ci_upper
  )
}


#stampo i risultati
for (variabile in variabili) {
  if (is.null(bootstrap_results[[variabile]])) {
    next
  }
  cat("Variable:", variabile, "\n")
  cat("Original Estimate:", bootstrap_results[[variabile]]$original, "\n")
  cat("Bias:", bootstrap_results[[variabile]]$bias, "\n")
  cat("Standard Error:", mean(bootstrap_results[[variabile]]$std_error), "\n")
  cat("95% Confidence Interval: [", bootstrap_results[[variabile]]$ci_lower, ",", bootstrap_results[[variabile]]$ci_upper, "]\n\n")
}

#Variable: longitude 
#Original Estimate: -26812.99 
#Bias: 
#  Standard Error: -26824.9 
#95% Confidence Interval: [ -28754.42 , -24857.02 ]

#Variable: latitude 
#Original Estimate: -25482.18 
#Bias: 
#  Standard Error: -25542.75 
#95% Confidence Interval: [ -27602.87 , -23476.08 ]

#Variable: housing_median_age 
#Original Estimate: 1072.52 
#Bias: 
#  Standard Error: 1071.285 
#95% Confidence Interval: [ 964.7019 , 1182.649 ]

#Variable: total_rooms 
#Original Estimate: -6.193264 
#Bias: 
#  Standard Error: -6.151762 
#95% Confidence Interval: [ -8.552914 , -3.603958 ]

#Variable: total_bedrooms 
#Original Estimate: 100.5563 
#Bias: 
#  Standard Error: 101.4627 
#95% Confidence Interval: [ 81.61493 , 120.9127 ]

#Variable: population 
#Original Estimate: -37.96908 
#Bias: 
#  Standard Error: -38.49102 
#95% Confidence Interval: [ -46.16534 , -30.04934 ]

#Variable: households 
#Original Estimate: 49.61733 
#Bias: 
#  Standard Error: 50.59051 
#95% Confidence Interval: [ 18.83925 , 77.36987 ]

#Variable: median_income 
#Original Estimate: 39259.57 
#Bias: 
#  Standard Error: 39253.43 
#95% Confidence Interval: [ 38207.27 , 40316.56 ]

#faccio i grafici che rappresentano l'intervallo di confidenza e la stima originale deli coefficenti

data_plot <- data.frame(
  variable=variabili,
  original_estimate=sapply(bootstrap_results[variabili], function(x) x$original),
  ci_lower=sapply(bootstrap_results[variabili], function(x) x$ci_lower),
  ci_upper=sapply(bootstrap_results[variabili], function(x) x$ci_upper)
)


ggplot(data_plot, aes(x=variable, y=original_estimate )) +
  geom_point(color="black", fill="blue", size=3, shape=21) +  
  geom_errorbar(aes(ymin=ci_lower, ymax=ci_upper), color="red", width=0.5) +  
  geom_hline(yintercept=0, linetype="dashed", color="gray") +  
  coord_flip() +  
  scale_fill_manual(values=color_palette) + 
  labs(
    x="Variabile",
    y="Valore del coefficente",
    title="Stima originale e intervalli di confidenza al 95%",
    subtitle="Risultati bootstrap"
  ) +
  theme_minimal() +  
  theme(plot.title=element_text(size= 14, face="bold"),
        plot.subtitle=element_text(size=12),
        axis.text.y=element_text(size=10),
        axis.title.x=element_text(size=12),
        axis.title.y=element_text(size=12))

