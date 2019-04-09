set.seed(100)
# Study 1
N <- 100

df <- data.frame(sex = sample(c("m", "f"), size = N, replace = TRUE),
                 age = round(rnorm(N, mean = 23, sd = 2), 0),
                 major = sample(c("psychology", "economics", "biology", "chemistry"), 
                                size = N, replace = TRUE, 
                                prob = c(.7, .2, .05, .05)),
                 haircolor = sample(c("brown", "black", "red", "blonde"), size = N, replace = TRUE, prob = c(.4, .2, .05, .35)),
                 iq = round(rnorm(N, mean = 110, sd = 5), 0),
                 country = sample(c("switzerland", "germany", "austria", "italy"), size = N, replace = TRUE, prob = c(.6, .3, .05, .05)),
                 logic = round(rnorm(N, mean = 10, sd = 2), 2),
                 stringsAsFactors = FALSE
)


# siblings
#  ~ major

df$siblings[df$major == "psychology"] <- round(rnorm(sum(df$major == "psychology"), 
                                                     mean = 2.5, 
                                                     sd = 1), 0)

df$siblings[df$major != "psychology"] <- round(rnorm(sum(df$major != "psychology"), 
                                                     mean = 1.5, 
                                                     sd = 1), 0)

df$siblings[df$siblings < 0] <- 0

# multitasking
# ~ haircolor

df$multitasking <- NA
df$multitasking[df$haircolor == "blonde"] <- rnorm(n = sum(df$haircolor == "blonde"),
                                                   mean = 50, sd = 10)

df$multitasking[df$haircolor != "blonde"] <- rnorm(n = sum(df$haircolor != "blonde"),
                                                   mean = 45, sd = 10)

df$multitasking <- round(df$multitasking, 0)

# Parterns
#  ~ major
df$partners <- NA
df$partners <- df$age + df$iq / 5 + rnorm(N, mean = -38, sd = 2)

df$partners[df$major == "chemistry"] <- df$partners[df$major == "chemistry"] + 1
df$partners[df$major == "economics"] <- df$partners[df$major == "economics"] - .5

df$partners <- round(df$partners, 0)
df$partners[df$partners < 0] <- 0



# marijuana
# ~ major

df$marijuana <- NA
df$marijuana[df$major %in% c("biology", "chemistry")] <- sample(c(0, 1), size = sum(df$major %in% c("biology", "chemistry")), prob = c(.2, .8), replace = TRUE)
df$marijuana[df$major %in% c("psychology", "economics")] <- sample(c(0, 1), size = sum(df$major %in% c("psychology", "economics")), prob = c(.5, .5), replace = TRUE)


# risk
#  ~ age + iq

risk.prob <- 1 / (1 + exp(-(df$iq / 10 + df$age / 10 - 12)))

df$risk <- sapply(1:nrow(df), FUN = function(x) {sample(c(0, 1), 1, replace = TRUE, prob = c(risk.prob[x], 1 - risk.prob[x]))})
df$risk <- round(df$risk, 1)


# logic~iq
z.iq=(df$iq-110)/5


df$logic=10+2*(-0.4*z.iq+rnorm(N,0,1))


write.csv(df, file = "~/git/RcourseSpring2019/data/data_wpa6.csv", row.names = FALSE)