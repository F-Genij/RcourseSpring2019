# Create demographic data
matthews.df <- read.table(file = "http://journal.sjdm.org/15/15909/data1.csv", 
                          sep = ",",
                          header = TRUE)

# Create demo.df
set.seed(100)
demo.df <- data.frame(id = matthews.df$id)
demo.df$height <- round(rnorm(n = nrow(demo.df), mean = 170, sd = 10), 0)
demo.df$race <- sample(c("white", "hispanic", "black", "asian"), size = nrow(demo.df), prob = c(.5, .1, .2, .2), replace = TRUE)

demo.df <- demo.df[sample(nrow(demo.df)),]
rownames(demo.df) <- 1:nrow(demo.df)

write.csv(x = demo.df, file = "~/git/RcourseSpring2019/data/data_wpa4.csv")