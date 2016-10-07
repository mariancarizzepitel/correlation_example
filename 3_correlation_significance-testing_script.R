#Finding bounds on a set of numbers
my.numbers <- c(4,0,-5,3,-4,-1,1,-3,2,-2)
print(my.numbers)
my.numbers.sorted <- sort(my.numbers)
print(my.numbers.sorted)
lower.bound <- my.numbers.sorted[2]
upper.bound <- my.numbers.sorted[9]
print(lower.bound)
print(upper.bound)
library(learnSampling)
samples.rho.zero <- get_cor_samples(rho= 0, n=100, number.of.samples = 10000,number.of.decimals = 4)
mean(samples.rho.zero$r)
sorted.samples.rho.zero <- sort_samples_by_r(samples.rho.zero)
head(sorted.samples.rho.zero,25)
tail(sorted.samples.rho.zero,25)
lower.bound <- sorted.samples.rho.zero[251, ]
upper.bound <- sorted.samples.rho.zero[9750, ]
print(lower.bound)
print(upper.bound)
##determining how pvalue is determined
number.more.extreme.one.side <- sum(sorted.samples.rho.zero$r>.21)
print(number.more.extreme.one.side)
#example 1
cor.test(example1$SelfEsteem,example1$Height)
#example 2
cor.test(example2$SelfEsteem,example2$Height)
#testing
samples.rho.zero <- example2
example.samples.rho.zero <- get_cor_samples(rho=0,n=100,number.of.samples = 1000,number.of.decimals = 4)
print(example.samples.rho.zero)
mean(example.samples.rho.zero$r)
sorted.example.samples.rho.zero <- sort_samples_by_r(example.samples.rho.zero)
head(sorted.example.samples.rho.zero$r,25)
tail(sorted.example.samples.rho.zero$r,25)
lower.bound <- sorted.example.samples.rho.zero[26,]
upper.bound <- sorted.example.samples.rho.zero[976,]
print(lower.bound)
print(upper.bound)
example.number.more.extreme.one.side <- sum(sorted.example.samples.rho.zero$r>.21)
print(example.number.more.extreme.one.side)
#didn't get same p value.. trouble shoot 
