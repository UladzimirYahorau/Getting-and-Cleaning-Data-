run_analysis <- function(){
        
        ## First we merge the train abd test data sets to create one data set.
        X_train <- read.table("train/X_train.txt")
        X_test <- read.table("test/X_test.txt")
        X <- rbind(X_train, X_test)
        
        
        ## Here we give appropriate labels to the data set with descriptive 
        ## variable names which we take from the file features.txt.
        features <- read.table("features.txt")
        colnames(X) <- features$V2
        
        
        ## Here we extract only the measurements on the mean and standard deviation
        ## for each measurement.
        good_columns <- as.logical(grepl('mean', colnames(X)) + grepl('std', colnames(X)))
        X <- X[ , colnames(X)[good_columns]]
        
        
        ## At the same time we merge the training and test labels.
        y_train <- read.table("train/y_train.txt")
        y_test <- read.table("test/y_test.txt")
        y <- rbind(y_train, y_test)
        
        
        ## Now we merge the labels with the features and give descriptive activity
        # names. 
        run_data <- cbind(y, X)
        activity_labels <- read.table("activity_labels.txt")
        # We make the labels which are in the first column (1, 2, 3, 4, 5, 6) a factor
        # variable. We change the names of the levels to the names of activities from
        # activity_labels.
        run_data[[1]] <- as.factor(run_data[[1]])
       
        levels(run_data[1]) <- levels(activity_labels[2])
        colnames(run_data)[1] <- "activity" 
        
        # Here we merge subject labels.
        subject_train <- read.table("train/subject_train.txt")
        subject_test <- read.table("test/subject_test.txt")
        subject <- rbind(subject_train, subject_test)
        # Add subject labels to the running data
        run_data <- cbind(subject, run_data)
        colnames(run_data)[1] <- "subject"
        run_data$subject <- as.factor(run_data$subject)
        
        # Here we first split the data set by two factor variables: subject and 
        # activity (to get 30 * 6 = 180 subdatasets). 
        subj_act_list <- split(run_data, list(run_data$activity, run_data$subject))
        # Form a data set with means of each variables in each of the data frames
        # above.
        averages_across_subj_act <- run_data[0, ]
        
        for (i in 1:length(subj_act_list)){
                averages_across_subj_act <- rbind(averages_across_subj_act, 
                                                  c(subj_act_list[[i]][1,1],
                                                    subj_act_list[[i]][1,2],
                                                    colMeans(subj_act_list[[i]][ ,3:81])))
        }
        # Here we slightly change the names of the columns in  averages_across_subj_act data frame.
        colnames(averages_across_subj_act) <- c(colnames(run_data)[1:2],
                                                paste('average_', colnames(run_data)[3:81], sep = ''))
        
        # The function return the list of 2 tidy data frames.
        return(list(run_data, averages_across_subj_act))
        
}