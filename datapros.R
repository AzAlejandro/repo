library(tidyr)
library(dplyr)
data_train <- read.csv("../Getting-and-Cleaning-Data-Course-Project/getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/test/X_test.txt", header =FALSE, sep ="\t")
separado <- strsplit(data_train[1,], " ")
separado[[1]][1]

separado[[1]][lengths(separado) != 0]

separado2 <- unlist(separado)
separado2[lengths(separado2) != 1]

separado3 <- as.numeric(separado2)
separado3 <- separado3[!is.na(separado3)]

sepyord <- function(x){
  x <- strsplit(x," ")
  x <- unlist(x)
  x <- as.numeric(x)
  x <- x[!is.na(x)]
  x
}
empty_df <-  df[FALSE,]

for (i in data_train$V1){
  empty_df <- rbind(empty_df,sepyord(i))
}
  


empty_df <- rbind(empty_df,j)

test_meth <- data.frame(X=data_train[1:2,] )
test_meth$X <- sapply(test_meth$X,  function(x){gsub("//","/",gsub(" ","/", x))})
test_meth <- test_meth %>% separate(X,into= as.character(1:563), sep = "/")
  
empty_df2 <- data.frame(X=data_train)
empty_df2$X <- sapply(empty_df2,function(x){gsub("//","/",gsub(" ","/", x))})
empty_df2 <- empty_df2 %>% separate(X,into= as.character(1:562), sep = "/") %>% select("1":"562")

#  separate(X,into= as.character(1:561), sep = " ")



full_df <- data_train %>%
  unnest(V1)


Y <- gsub("//","/",gsub(" ","/", data_train[1,]))

separate(Y, into =as.character(1:561), sep =  "/")
