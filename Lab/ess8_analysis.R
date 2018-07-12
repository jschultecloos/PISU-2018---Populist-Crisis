

pacman::p_load(
  tidyverse, 
  randomizr, 
  estimatr, 
  ri2, 
  here, 
  ess, 
  sjmisc, 
  haven,
  knitr, 
  xtable, 
  stargazer)

wd <- here()

setwd(wd)

# dl_dir <- file.path(tempdir(), "denmark/")
# ess_all_cntrounds(
#   "Denmark",
#   "j.schulte-cloos@web.de",
#   only_download = TRUE,
#   output_dir = dl_dir
# )


library(lodown)
lodown( "ess" , output_dir = file.path( path.expand( "~" ) , "ESS" ) , 
        your_email = "j.schulte-cloos@web.de")


ess_data <- read_dta("./lab/ESS8e02.dta")

# the following functions are specifically written for the recoding of the ESS data (part of the ESS package)
ess_data = recode_missings(ess_data) 


# how many countries are included in our dataset? 
kable(ess_data %>% group_by(cntry) %>% summarise(N= n()))

countryobs = ess_data %>% group_by(cntry) %>% summarise(N= n())




# how to navigate in a large dataset with 536 observations? 

find_var(ess_data, pattern="gender") 
find_var(ess_data, pattern="immigrant")


# shortly weighting 

# weight is coefficient that is used to make up for the composition of the sample not being truly 
# representative of the composition of the population. 
# For example, if the census indicates that 30% of the population live in region A and 70% in region B, 
# but your sample is 50%-50% across the two regions, then you want to apply weights so that the 
# sample "looks like" 30% are in region A and 70% are in region B.


# The second weight is the Population Size weight (pweight). This is used when examining data for two or more countries 
# combined. This weight corrects for the fact that most countries taking part in the ESS had very similar sample sizes, 
# no matter how large or small their population. The mathematics of probability proves that a sample of, for example, 
# 1000 respondents is equally useful in examining the opinions in a country with 10 million inhabitants as it would be 
# in a country with a population of only 1 million




library(essurvey)
show_countries()
set_email("your.ess.registred.email.adress@email.com")

eight_round =
  import_rounds(8) %>%
  recode_missings()
write.csv(eight_round, file="ess8.csv")

kosovo_ess = import_country("Kosovo", 6)
write.csv(kosovo_ess, file="kosovo_ess.csv")  

