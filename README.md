# R_get_clean_data

# The script run_analysis.R 
  - Loads Labels : activity and features
  - Loads Train Data Sets : subject_train, x_train, y_train
  - Loads Test Data Sets : subject_test, x_test, y_test
  - Applies variable names to the train and test set data
  - Keeps only mean and std variables in the train and test set data
  - Combine the test data sets and train data sets separately
  - Merge the combined test and train data sets
  - Reshape merged data to long
  - Collapse to get means by subject and activity
  - Output/Write clean data set
  
