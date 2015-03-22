library(dplyr)
library(reshape2)

setwd("C:/Users/sbangalore/R/RDataCleaning/UCI HAR Dataset")

########## FEATURES ########## 

# Load Features Data Set
features <- read.delim("features.txt", sep="", stringsAsFactors=FALSE, head=FALSE) [,2]

# Get only mean and std variables
needed_features <- grepl("mean|std", features)

########## ACTIVITY ########## 

# Load Activity Data Set
activity <- read.delim("activity_labels.txt", sep="", stringsAsFactors=FALSE, head=FALSE) [,2]

########## TEST ########## 

######## SUBJECT

# Load subject data set

subject_test <- read.delim("test/subject_test.txt" ,sep="\t", head=FALSE)
names(subject_test) <- "subject"

######## TEST SET AND LABELS

# Load test set and labels

test_set <- read.delim("test/X_test.txt", sep="", head=FALSE)
test_labels <- read.delim("test/y_test.txt", sep="", head=FALSE)

# Apply variable names to test set

names(test_set) <- features
head(test_set,n=3)

# Keep only mean and std variables in test set

test_set <- test_set[,needed_features]

# Add activity labels to test lables data

test_labels[,2] = activity[test_labels[,1]]
names(test_labels) = c("Activity_ID", "Activity_Label")
table(test_labels$Activity_ID,test_labels$Activity_Label)


######## FINAL TEST DATA

test <- cbind(subject_test, test_labels, test_set)
nrow(test)

########## TRAIN ########## 

######## SUBJECT

# Load subject data set

subject_train <- read.delim("train/subject_train.txt" ,sep="\t", head=FALSE)
names(subject_train) <- "subject"

######## TRAIN SET AND LABELS

# Load train set and labels

train_set <- read.delim("train/X_train.txt", sep="", head=FALSE)
train_labels <- read.delim("train/y_train.txt", sep="", head=FALSE)

# Apply variable names to train set

names(train_set) <- features
head(train_set,n=3)

# Keep only mean and std variables in train set

train_set <- train_set[,needed_features]

# Add activity labels to train lables data

train_labels[,2] = activity[train_labels[,1]]
names(train_labels) = c("Activity_ID", "Activity_Label")
table(train_labels$Activity_ID,train_labels$Activity_Label)


######## FINAL TRAIN DATA

train <- cbind(subject_train, train_labels, train_set)
nrow(train)

########## FINAL WIDE TRAIN & TEST DATA ########## 

# Merge final test and final train data sets
widedata = rbind(test, train)

########## RESHAPE FINAL TRAIN & TEST DATA TO LONG ########## 

id_labels   <-  c("subject", "Activity_ID", "Activity_Label")
data_labels <-  setdiff(colnames(data), id_labels)
longdata    <-  melt(widedata, id = id_labels, measure.vars = data_labels)

########## COLLAPSE FINAL LONG TRAIN & TEST DATA ########## 

clean_data <- dcast(longdata, subject + Activity_Label ~ variable, mean)

########## WRITE CLEAN DATA ########## 

write.table(clean_data, file = "clean_data.txt", row.name=FALSE)
