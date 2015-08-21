####
# The five essential tasks to complete the Course Project are as follows.
#
# 1. Merges the training and the test sets to create one data set.
# 2. Extracts only the measurements on the mean and standard deviation for each measurement. 
# 3. Uses descriptive activity names to name the activities in the data set
# 4. Appropriately labels the data set with descriptive variable names. 
# 5. Creates a second, independent tidy data set with the average of each
#    variable for each activity and each subject.
#
# These five steps will be accomplished via the R code below.  Appropriate
# details concerning substeps related to these tasks will be included in the
# comments as well.
#---------------------------------------------------------------------------##

##Reading all the Train Data

a1 <- read.table("subject_train.txt")  #Subjects
a2 <- read.table("y_train.txt")        #Labels
a3 <- read.table("X_train.txt")        #Data

##Reading all the Test Data

b1 <- read.table("subject_test.txt")  #Subjects
b2 <- read.table("y_test.txt")        #Labels
b3 <- read.table("X_test.txt")         #Data

##Reading Feature Data

feature <- read.table("features.txt")

##Reading Lables Data

labels <- read.table("activity_labels.txt")

# 1. -- Merge training and test sets to create one data set.

##Step 1
##merge the two raw data tables together, row-wise.

combined_data <- rbind(a3,b3)


#--------------------------------------------------------------------------------------------##
# 2. -- Extracts only the measurements on the mean and standard deviation for each measurement.

##Step 2
# identify all the features that are either standard deviations or means of measurements.
# The following code identifies a vector of boolean values that correspond to the means and
# standard deviation measures.

mean_std_features  <- grepl("(-std\\(\\)|-mean\\(\\))",feature$V2)

# subsetting only the columns that are means or std.deviation features
combined_data_filtered <-combined_data[, which(mean_std_features == TRUE)]

#--------------------------------------------------------------------------------------------##
# 3. -- Uses descriptive activity names to name the activities in the data set.

##Step 3
##merge the two raw data tables together, row-wise.
combined_activity <- rbind(a2,b2)
##merging the tables col-wise. This will append the activity column to the end of the table combined_data_filtered
combined_data_filtered_activity <- cbind(combined_data_filtered,combined_activity)

##transform the activity label factors into human readable activity descriptions
combined_data_filtered_activity[,67] <- factor(combined_data_filtered_activity[,67],labels$V1,labels$V2)


#--------------------------------------------------------------------------------------------##
# 4. -- Appropriately label the data set with descriptive variable names.  


##step 4

# First, the previously used mean_std_features true/false vector is used to captue the 
# names of all the mean and std. dev. features.
sub_feat <- feature[which(mean_std_features == TRUE), ]

## columns(variable names) are renamed to their respective descriptive variable names 
names(combined_data_filtered_activity) <- factor(sub_feat$V2)
colnames(combined_data_filtered_activity)[67] <- "Activity"
#Columns are rearranged so as to have the activity column in the begining
combined_data_filtered_activity <- combined_data_filtered_activity[ ,c(67,1:66)]


combined_subject <- rbind(a1,b1)

##merging the tables col-wise. This will append the subject column to the begining of the table combined_data_filtered_activity table
combined_data_filtered_activity_subject <- cbind(combined_subject,combined_data_filtered_activity)
colnames(combined_data_filtered_activity_subject)[1] <- "Subject"


#--------------------------------------------------------------------------------------------
# 5.-- Creates a second, independent tidy data set with the average of each
#      variable for each activity and each subject. 

##Step 5

# using the reshape2 library, use the melt function to collapse the filteredActivityData dataframe.
library(reshape2)

# create the molten data set
molten <- melt(combined_data_filtered_activity_subject,id.vars=c("Subject","Activity"))

# cast the molten data set into a collapsed tidy dataset
tidy <- dcast(molten,Subject + Activity ~ variable,mean)

# write the dataset to a file
write.table(tidy, "dataset2.txt", sep="\t", row.name=FALSE)



