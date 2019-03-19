set.seed(100)

df <- data.frame("id" = 1:500,
                 "sex" = sample(c("m", "f"), size = 500, replace = TRUE),
                 "age" = round(rnorm(n = 500, mean = 22, sd = 1)),
                 "attention" = sample(c(0, 1), size = 500, replace = TRUE, prob = c(.1, .9)),
                 "prime" = sample(c("elderly", "neutral", "asdf"), size = 500, replace = TRUE),
                 "prime.duration" = sample(c(1, 5, 10, 30), size = 500, replace = TRUE),
                 "grandparents" = sample(c("no", "yes", "none"), size = 500, replace = TRUE),
                 "walk" = 0,
                 stringsAsFactors = FALSE
)

sex.lu <- data.frame(sex = c("m", "f"),
                     sex.num = c(-5, 5),
                     stringsAsFactors = F)

prime.lu <- data.frame(prime = c("elderly", "neutral", "asdf"),
                       prime.num = c(10, 0, 0),
                       stringsAsFactors = F
)

grandparents.lu <- data.frame(prime = c("no", "yes"),
                              prime.num = c(0, 10),
                              stringsAsFactors = F
)


for(i in 1:nrow(df)) {
  
  sex.i <- df$sex[i]
  prime.i <- df$prime[i]
  grandparents.i <- df$grandparents[i]
  
  
  sex.i.num <- subset(sex.lu, sex == sex.i)$sex.num
  prime.i.num <- subset(prime.lu, prime == prime.i)$prime.num
  
  if(prime.i == "elderly") {
    
    if(grandparents.i == "no") {grandparents.i.num <- 0}
    if(grandparents.i == "yes") {grandparents.i.num <- 5}
    if(grandparents.i == "none") {grandparents.i.num <- 0}
    
  }
  
  if(prime.i == "neutral") {grandparents.i.num <- 0}
  if(prime.i == "asdf") {grandparents.i.num <- 0}
  
  walk.i <- round(rnorm(1, mean = sex.i.num + prime.i.num + grandparents.i.num + 30, sd = 1), 1)
  
  df$walk[i] <- walk.i
  
}



# Screw up some variables

df$walk[sample(nrow(df), size = 20)] <- runif(10, min = -100, max = -10)
df$prime.duration[sample(nrow(df), size = 15)] <- sample(c(20, 60), size = 15, replace = TRUE)


# Change names

names(df) <- letters[1:ncol(df)]

write.csv(df, '~/git/RcourseSpring2019/data/data_wpa3.csv')