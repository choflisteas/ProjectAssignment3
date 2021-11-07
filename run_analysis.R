##Download and unzip the dataset

fileurl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileurl, destfile = "dataset.zip")
unzip("dataset.zip", overwrite = TRUE)
setwd("./UCI HAR Dataset")

## 1.Merges the training and the test sets to create one data set.
train_set <- read.csv("./train/X_train.txt", sep = "", header = F)
train_sub <- read.csv("./train/subject_train.txt", sep = "", header = F)
train_act <- read.csv("./train/y_train.txt", sep = "", header = F)

train_set <- train_set %>%
        mutate("subject" = train_sub[[1]]) %>%
        mutate("activity" = train_act[[1]])

test_set <- read.csv("./test/X_test.txt", sep = "", header = F)
test_sub <- read.csv("./test/subject_test.txt", sep = "", header = F)
test_act <- read.csv("./test/y_test.txt", sep = "", header = F)

test_set <- test_set %>%
        mutate("subject" = test_sub[[1]]) %>%
        mutate("activity" = test_act[[1]])

global_set <- merge(train_set, test_set, all = T)

## 2.Extracts only the measurements on the mean and standard deviation for each measurement. 
features <- read.csv("features.txt",sep = "", header = F)
f <- grepl("std\\(\\)$|mean\\(\\)$", features[[2]])
stdmain <- filter(features, f) 
stdmain <- select(global_set,stdmain[[1]])

## 3.Uses descriptive activity names to name the activities in the data set
act_names <- read.csv("activity_labels.txt", sep = "", header = F)
global_set$activity <- factor(global_set$activity, labels = act_names[[2]], ordered = T)
global_set <- mutate(global_set, activity = factor(activity, labels = act_names[[2]], ordered = T))

## 4.Appropriately labels the data set with descriptive variable names.
## Some features contain odd characters and will result in duplicated names
valid_feature_names <- make.names(names=features[[2]], unique=TRUE, allow_ = TRUE)
names(global_set) <-c(valid_feature_names, "subject", "activity") 

## 5.From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
global_set_by <- group_by(global_set, subject, activity)
global_set_by <- summarise_all(global_set_by, mean)