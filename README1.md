#Readme 


# Getting and Cleaning Data Course Project

The **Course Project** uses data from this URL: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

To reproduce the steps described below, and to use the *run_analysis.R* file, you need to download the above zip file, decompress the file, extract all the required files into thee top level folder and have the run_analysis.R file in the top level folder of the unzipped package.

The codebook for this project is available within this repository: https://github.com/skmgowda27/GetData_CourseProject/blob/master/Codebook.md

## Overall Process

The five essential tasks to complete the Course Project are as follows.

-Merges the training and the test sets to create one data set.

-Extracts only the measurements on the mean and standard deviation for each measurement.

-Uses descriptive activity names to name the activities in the data set

-Appropriately labels the data set with descriptive variable names.

-Creates a second, independent tidy data set with the average of each variable for each activity and each subject.

These five steps will be accomplished via the process described below. Readers should also examine the codebook, and the full comments in the run_analysis.R file.

1 . *Merge training and test sets to create one data set*.

First, I read in the data, label set, and subject codes for the test data.

###### Reading all the Train Data

a1 <- read.table("subject_train.txt")  #Subjects

a2 <- read.table("y_train.txt")        #Labels

a3 <- read.table("X_train.txt")        #Data

###### Reading all the Test Data

b1 <- read.table("subject_test.txt")  #Subjects

b2 <- read.table("y_test.txt")        #Labels

b3 <- read.table("X_test.txt")         #Data

###### Reading Feature Data

feature <- read.table("features.txt")


###### Reading Lables Data

labels <- read.table("activity_labels.txt")

I then merge the two raw raw data tables together, row-wise. 

combined_data <- rbind(a3,b3)

2 . *Extracts only the measurements on the mean and standard deviation for each measurement*.

I identify all the features that are either standard deviations or means of measurements, via a grep transformation. I've assumed that the measures of interest are those containing either a "-std()" or a "-mean()" text string within the original feature names.

mean_std_features  <- grepl("(-std()|-mean())",feature$V2)

Finally, I remove columns that are not means or standard deviation features

combined_data_filtered <-combined_data[, which(mean_std_features == TRUE)]

3 . *Uses descriptive activity names to name the activities in the data set*.

I merge the two raw data tables together, row-wise.

combined_activity <- rbind(a2,b2)

Then merging the tables col-wise. This will append the activity column to the end of the table combined_data_filtered

combined_data_filtered_activity <- cbind(combined_data_filtered,combined_activity)

Finally I transform the activity label factors into human readable activity descriptions 


4 . *Appropriately label the data set with descriptive variable names*.

In this step, the mean and standard deviation feature names attached as column names to the data set. The previously used mean_std_features true/false vector is used to capture the names of all the mean and standard deviation features.

sub_feat <- feature[which(mean_std_features == TRUE), ]

columns(variable names) are renamed to their respective descriptive variable names

names(combined_data_filtered_activity) <- factor(sub_feat$V2)

The Last coolumn is named as the activity column

colnames(combined_data_filtered_activity)[67] <- "Activity"

Columns are rearranged so as to have the activity column in the begining
combined_data_filtered_activity <- combined_data_filtered_activity[ ,c(67,1:66)]


combined_subject <- rbind(a1,b1)

merging the tables col-wise. This will append the subject column to the begining of the table combined_data_filtered_activity table

combined_data_filtered_activity_subject <- cbind(combined_subject,combined_data_filtered_activity)

colnames(combined_data_filtered_activity_subject)[1] <- "Subject"

5 . *Creates a second, independent tidy data set with the average of each variable for each activity and each subject*.

Using the reshape2 library, we use the melt function to collapse the filteredActivityData dataframe. I create a molten dataset with the melt function, and then use the dcast function to collapse the molten set into a new collapsed and tidy data frame. Finally, I write the tidy dataset to a txt file.

library(reshape2)
molten <- melt(combined_data_filtered_activity_subject,id.vars=c("Subject","Activity"))

tidy <- dcast(molten,Subject + Activity ~ variable,mean)

write.table(tidy, "dataset2.txt", sep="\t", row.name=FALSE)
