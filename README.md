# Getting-and-Cleaning-Data-
Coursera project

The main file with code is run_analysis.R

It contains the function run_analysis, which returns the list of 2 data frames. First, consisting of the training data featuring the appropriate variables. The second one contains data with averages of features across (subject, activity) pairs (there are 30 * 6 = 180 of them, i. e., this data frame has 180 rows).

Here is the description of steps performed in run_analysis.R:

1. Merge the train abd test data sets to create one data set.
2. Give appropriate labels to the data set with descriptive variable names which we take from the file features.txt.
3. Extract only the measurements on the mean and standard deviation for each measurement.
4. Merge the training and test labels.
5. Merge the labels with the features and give descriptive activity names.
6. Make the labels which are in the first column (1, 2, 3, 4, 5, 6) a factor variable. We change the names of the levels to the names of activities from activity_labels.
7. Merge subject labels.
8. Add subject labels to the running data.
9. Split the data set by two factor variables: subject and activity (to get 30 * 6 = 180 subdatasets). 
10. Form a data set with means of each variables in each of the data frames above.
11. Give appropriate names to the columns in averages_across_subj_act data frame.
12. Return the list of 2 tidy data frames.
