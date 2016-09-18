library(plyr)

# Step-0
# Download and unzip the file
if (!file.exists(filename)){
  fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip "
  download.file(fileURL, filename, method="curl")
}  
if (!file.exists("UCI HAR Dataset")) { 
  unzip(filename) 
}


# Step-1
# Combine training and test sets to create one data set
###############################################################################

# Initialise Directories and files
uci_hard_dir <- "UCI\ HAR\ Dataset"
feature_file <- paste(uci_hard_dir, "/features.txt", sep = "")
activity_labels_file <- paste(uci_hard_dir, "/activity_labels.txt", sep = "")
x_train_file <- paste(uci_hard_dir, "/train/X_train.txt", sep = "")
y_train_file <- paste(uci_hard_dir, "/train/y_train.txt", sep = "")
subject_train_file <- paste(uci_hard_dir, "/train/subject_train.txt", sep = "")
x_test_file  <- paste(uci_hard_dir, "/test/X_test.txt", sep = "")
y_test_file  <- paste(uci_hard_dir, "/test/y_test.txt", sep = "")
subject_test_file <- paste(uci_hard_dir, "/test/subject_test.txt", sep = "")


################################################
# Read table data from training and test files

## Train file
x_train <- read.table(x_train_file)
y_train <- read.table(y_train_file)
subject_train <- read.table(subject_train_file)

## Test files
x_test <- read.table(x_test_file)
y_test <- read.table(y_test_file)
subject_test <- read.table(subject_test_file)

###############################################


######################################################
# creae x and y datasets combining test and train
# x data set
x_data_all <- rbind(x_train, x_test)

# y data set
y_data_all <- rbind(y_train, y_test)

# subject data set
subject_data_all <- rbind(subject_train, subject_test)
######################################################


# Step-2
# Extract measurements mean and standard deviation measurements 
################################################################

features <- read.table(feature_file)

# get only columns with mean() or std() in their names
mean_and_std_features <- grep("-(mean|std)\\(\\)", features[, 2])

# subset the desired columns
x_data_all <- x_data_all[, mean_and_std_features]

# correct the column names
# remove () and replace - with _
# names(x_data_all) <- features[mean_and_std_features, 2]
names(x_data_all) <- gsub("-","_", gsub("\\(\\)","", features[mean_and_std_features, 2]))

# Step-3
# Use descriptive activity names in the data set
###############################################################################

activities <- read.table(activity_labels_file)

# update with correct activity names
y_data_all[, 1] <- activities[y_data_all[, 1], 2]

# fix column name
names(y_data_all) <- "activity"

# Step-4
# label the data set with descriptive variable names
###############################################################################

# correct column name
names(subject_data_all) <- "subject"

# bind all the data in a single data set
all_data <- cbind(x_data_all, y_data_all, subject_data_all)

# Step-5
# Create a new, independent tidy data set with the average of each variable
# for each activity and each subject
###############################################################################

# 66,68 columns but last two (activity & subject)
averages_data <- ddply(all_data, .(subject, activity), function(x) colMeans(x[, 1:66]))

# Write as a csv file 
write.csv(averages_data, "tidy_averages_data.csv", row.names = FALSE)

# or a text file 
#write.table(averages_data, "tidy_averages_data.txt", row.name=FALSE)
