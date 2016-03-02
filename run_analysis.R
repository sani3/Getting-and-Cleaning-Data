# Download the data for the project
if(!file.exists("getdata_projectfiles_UCI HAR Dataset.zip")){
        download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip.", destfile = "getdata_projectfiles_UCI HAR Dataset.zip")
}

# in the working directory, unzip the downloaded ziped folder 
unzip("getdata_projectfiles_UCI HAR Dataset.zip", exdir = "getdata_projectfiles")

#Read necessary files to R

##read X_test.txt
X_test <- read.table("./getdata_projectfiles/UCI HAR Dataset/test/X_test.txt")

##read Y_test.txt
Y_test <- read.table("./getdata_projectfiles/UCI HAR Dataset/test/Y_test.txt")

##read the subject_train.txt file
subject_train <- read.table("./getdata_projectfiles/UCI HAR Dataset/train/subject_train.txt")

##read X_train.txt
X_train <- read.table("./getdata_projectfiles/UCI HAR Dataset/train/X_train.txt")

##read Y_train.txt
Y_train <- read.table("./getdata_projectfiles/UCI HAR Dataset/train/Y_train.txt")

##read activity labels
activity_labels <- read.table("./getdata_projectfiles/UCI HAR Dataset/activity_labels.txt")

##read the subject_test.txt file
subject_test <- read.table("./getdata_projectfiles/UCI HAR Dataset/test/subject_test.txt")

##read the features file
features <- read.table("./getdata_projectfiles/UCI HAR Dataset/features.txt")


#1 Merge the training and the test sets to create one data set
X <- rbind(X_test, X_train)
Y <- rbind(Y_test, Y_train)
subject <- rbind(subject_test, subject_train)



#2 Extract only the measurements on the mean and standard deviation for each measurement.
good_features <- sort(c(grep("std()", features[,2]), grep("mean()", features[,2])))
good_X <- X[, good_features]

#4 Column names for data set
##a. provide colnames for good_X
colnames(good_X) <- features$V2[good_features]

##b. provide colname for Y
colnames(Y) <- "activity.label"

##c. provide colname for subject_test and subject_train
colnames(subject) <- "subject"

##d. provide colnames for activity_label
colnames(activity_labels) <- c("label", "activity")



#3 Uses descriptive activity names to name the activities in the data set
##decode test activity label
for(i in 1:length(Y$activity.label)){
        if(Y$activity.label[i]==1){
                Y$activity[i] <- "WALKING"
        } else if(Y$activity.label[i]==2){
                Y$activity[i] <- "WALKING_UPSTAIRS"
        } else if(Y$activity.label[i]==3){
                Y$activity[i] <- "WALKING_DOWNSTAIRS"
        } else if(Y$activity.label[i]==4){
                Y$activity[i] <- "SITTING"
        } else if(Y$activity.label[i]==5){
                Y$activity[i] <- "STANDING"
        } else {
                Y$activity[i] <- "LAYING"
        }
}

activity <- Y$activity
samsung_data <- cbind(subject, activity, good_X[, (grep("mean()", colnames(good_X)))])


#5 create a second, independent tidy data set with the average of each variable for each activity and each subject.
library(reshape2)
melt_samsung_data <- melt(samsung_data, id = c("subject", "activity"))
independent_samsung_data<- dcast(melt_samsung_data, subject+activity~variable, mean)
write.table(independent_samsung_data, file = "Tidy_Samsung_Data Set.txt", row.names = FALSE)


