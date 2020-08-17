library(tidyr)
library(RCurl)


#Read all the data and store in variables
#Note script and extracted data should be in directory called "Getting-and-Cleaning-Data-Course-Project"


x_test <- read.table("../Getting-and-Cleaning-Data-Course-Project/UCI HAR Dataset/test/X_test.txt", sep = "")
x_train <- read.table("../Getting-and-Cleaning-Data-Course-Project/UCI HAR Dataset/train/X_train.txt", sep = "")
y_test <- read.table("../Getting-and-Cleaning-Data-Course-Project/UCI HAR Dataset/test/y_test.txt", sep = "")
y_train <- read.table("../Getting-and-Cleaning-Data-Course-Project/UCI HAR Dataset/train/y_train.txt", sep = "")
s_test <- read.table("../Getting-and-Cleaning-Data-Course-Project/UCI HAR Dataset/test/subject_test.txt", sep = "")
s_train <- read.table("../Getting-and-Cleaning-Data-Course-Project/UCI HAR Dataset/train/subject_train.txt", sep = "")
features <- read.table("../Getting-and-Cleaning-Data-Course-Project/UCI HAR Dataset/features.txt", sep = "")
activity_labels <- read.table("../Getting-and-Cleaning-Data-Course-Project/UCI HAR Dataset/activity_labels.txt", sep = "")

#Merge test and train data

xdf <- rbind(x_test,x_train)
ydf <- rbind(y_test,y_train)
sdf <- rbind(s_test,s_train)

#Get better features names and filter just mean and std names.

filter_regex <- grep("mean+|std+", features$V2)
sby_regex <- features[filter_regex, 2]
sby_regex <- gsub("-mean", "Mean", sby_regex)
sby_regex <- gsub("-std", "Std", sby_regex)
sby_regex <- gsub("[-()]", "", sby_regex)


#Filter data on values and merge with Users and Activity data

xdf <- xdf[filter_regex]
data_merged <- cbind(sdf, ydf, xdf)
colnames(data_merged) <- c("User", "Activity", sby_regex)


#Get tiddy dataframe
gathered_data <- gather(data_merged, key, value, -User,-Activity)

#Get mean of values by Users, Activity, and feature
final_data <- gathered_data %>% 
  group_by(User, Activity, key) %>%   
  summarise(media = mean(value)) %>% 
  spread(key, media)

#Write data as txt to upload in git

write.table(final_data, "./tidy_data.txt", row.names = FALSE)
