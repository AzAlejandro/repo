library(tidyr)
library(RCurl)


#Read all the data and store in variables
x_test <- read.table(sep = "", "../Getting-and-Cleaning-Data-Course-Project/getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/test/X_test.txt")
x_train <- read.table(paste(sep = "", "../Getting-and-Cleaning-Data-Course-Project/getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/train/X_train.txt"))
y_test <- read.table(paste(sep = "", "../Getting-and-Cleaning-Data-Course-Project/getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/test/y_test.txt"))
y_train <- read.table(paste(sep = "", "../Getting-and-Cleaning-Data-Course-Project/getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/train/y_train.txt"))
s_test <- read.table(paste(sep = "", "../Getting-and-Cleaning-Data-Course-Project/getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/test/subject_test.txt"))
s_train <- read.table(paste(sep = "", "../Getting-and-Cleaning-Data-Course-Project/getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/train/subject_train.txt"))
features <- read.table(paste(sep = "", "../Getting-and-Cleaning-Data-Course-Project/getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/features.txt"))
activity_labels <- read.table(paste(sep = "", "../Getting-and-Cleaning-Data-Course-Project/getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/activity_labels.txt"))

#Tune some dataframes

filter_regex <- grep("mean+|std+", features$V2)
sby_regex <- features[filter_regex, 2]
sby_regex <- gsub("-mean", "Mean", sby_regex)
sby_regex <- gsub("-std", "Std", sby_regex)
sby_regex <- gsub("[-()]", "", sby_regex)
#activity_labels$V2 <- as.character(activity_labels$V2)

#Merge all data

xdf <- rbind(x_test,x_train)
ydf <- rbind(y_test,y_train)
sdf <- rbind(s_test,s_train)


#4. extract data by cols & using descriptive name
xdf <- xdf[filter_regex]
data_merged <- cbind(sdf, ydf, xdf)
colnames(data_merged) <- c("User", "Activity", sby_regex)

#data_merged$Activity <- factor(data_merged$Activity, levels = activity_labels[,1], labels = activity_labels[,2])
#data_merged$User <- as.factor(data_merged$User)


#5. generate tidy data set
gathered_data <- gather(data_merged, key, value, -User,-Activity)
final_data <- gathered_data %>% group_by(User, Activity, key) %>%   summarise(media = mean(value)) %>% spread(key, media)

#tidyData <- dcast(gathered_data, User + Activity ~ key, mean)

23
write.table(final_data, "./tidy_data.txt", row.names = FALSE)
