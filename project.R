library(dplyr)
setwd("/Users/caixinlei/Desktop/2023fall/406/project")
shooting = read.csv("shooting.csv")

# two different response

set.seed(123)
data <- shooting %>% 
  select(injured = Total.Injured.Killed.Victims, 
         feature = Bullied..Y.N..N.A.)

reponse = c("Y", "N")
data <- subset(data, feature == reponse[1] | feature == reponse[2])
head(data)
summary(data)

data.feature.one = data[data$feature == reponse[1],]
data.feature.two = data[data$feature == reponse[2],]
if (nrow(data.feature.one) < nrow(data.feature.two))
  data.feature.two = data.feature.two[sample(nrow(data.feature.two), nrow(data.feature.one)), ]
if (nrow(data.feature.one) > nrow(data.feature.two))
  data.feature.one = data.feature.one[sample(nrow(data.feature.one), nrow(data.feature.two)), ]

diff = data.feature.one$injured - data.feature.two$injured

t.test(data.feature.one$injured, data.feature.two$injured, alternative = "two.sided",
       paired = TRUE)$p.value

