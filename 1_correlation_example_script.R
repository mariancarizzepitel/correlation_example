library(tidyverse)
#Loading data from a website
my.data <- read_csv("https://jeroenooms.github.io/multilevel/data/chapter2/popular2.csv")
#Saving data from website
##So we can load in the future
write_csv(my.data,path="hox_data_chapter2.csv")

#Creating analytic data
analytic.data <- select(my.data,class,extrav,popular,texp)

#Running single correlation
##First, extract specific columns from analytic data set
analytic.data$extrav
analytic.data$popular
##Second, we run the correlation
cor.test(x=analytic.data$extrav,y=analytic.data$popular)
##APA report: r = .32, 95% CI [.28,.35], p < .001

#Understanding how R returns info - NOT PART OF STANDARD CORRELATIONAL ANALYSIS
##This "saves" the results as my.cor.result
my.cor.result <- cor.test(x=analytic.data$extrav,y=analytic.data$popular)
##This allows you to see the structure of the resulting info with the str function 
str(my.cor.result)
##Notice that correlation is under "Estimate" e.g., 
#"$ estimate   : Named num 0.316
#..- attr(*, "names")= chr "cor"
#Determine just the correlation by typing the following: 
my.cor.result$estimate

##Plotting a single correlation between two variables
my.scatter <- qplot(x=extrav,y=popular,data=analytic.data)
print(my.scatter)
###Adding a regression line (with confidence interval around the regression line. To do without, 
###simply change se=TRUE to se=FALSE)
my.scatter <- qplot(x=extrav,y=popular,data=analytic.data)
my.scatter <- my.scatter+geom_smooth(method = "lm",se= TRUE, color="black")
print(my.scatter)

#Calculating several correlations across variables
library(apaTables)
apa.cor.table(as.data.frame(analytic.data))

##Plotting several correlations 
psych::pairs.panels(as.data.frame(analytic.data),lm=TRUE)

#Single subgroup correlational analysis- use the filter tool to choose, say, a specific study 
analytic.data.class.is.5 <- filter(analytic.data, class==5)
cor.test(x=analytic.data.class.is.5$extrav,y=analytic.data.class.is.5$popular)

#Correlations for several/multiple subgroups 
analytic.data.grouped.by.class <- group_by(analytic.data,class)
cor.by.group <- summarise(analytic.data.grouped.by.class,cor.test(x=extrav,y=popular)$estimate)
print(cor.by.group)
#to print ALL the rows and not just first 10, do this: 
print(as.data.frame(cor.by.group))
##Plotting for several groups
analytic.data.groups.15.to.30 <- filter(analytic.data.grouped.by.class,class>=15 & class<=30)
my.scatter <- qplot(x=extrav,y=popular,data=analytic.data.groups.15.to.30)
my.scatter <- my.scatter + geom_smooth(method="lm",se=TRUE,color="black")
my.scatter <- my.scatter + facet_wrap(~class)
print(my.scatter)
##saving ggplot2 
ggsave("groupScatterPLotwithCI.pdf",plot=my.scatter,width=6,height=6)
