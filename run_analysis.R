# including packages for access to useful functions
    library(dplyr)
    library(plyr)
    library(reshape2)

# Reading in activity types and their labels
    activity <- read.table("./UCI HAR Dataset/activity_labels.txt", stringsAsFactors = FALSE)
    names(activity) <- c("activity_ID","activity_label")

# Step 1. Merges the training and the test sets to create one data set.

# 1.1 To obtain complete test data

# 1.1.1 Read in subject_test data
    subject_test <- read.table("./UCI HAR Dataset/test/subject_test.txt")
    names(subject_test) <- "subject_ID"

# 1.1.2 Read in y_test data on activities performed by subject
    Y_test <- read.table("./UCI HAR Dataset/test/y_test.txt")
    names(Y_test) <- "activity_ID"

# 1.1.3 Read in X_test data on 561 feature measurements per subject per activity
    X_test <- read.table("./UCI HAR Dataset/test/X_test.txt")

# 1.1.4 Then name X_test columns based on feature names taken
# from 561 feature measurement types and their labels read from features.txt
    features <- read.table("./UCI HAR Dataset/features.txt", stringsAsFactors = FALSE)
    names(features) <- c("feature_ID", "feature_label")
    names(X_test) <- features$feature_label

# 1.1.5 Combine all test data
    test_Data <- cbind(subject_test, Y_test, X_test)

# 1.2 To obtain complete train data

# 1.2.1 Read in subject_train data
    subject_train <- read.table("./UCI HAR Dataset/train/subject_train.txt")
    names(subject_train) <- "subject_ID"

# 1.2.2 Read in y_train data on activities performed by subject
    Y_train <- read.table("./UCI HAR Dataset/train/y_train.txt")
    names(Y_train) <- "activity_ID"

# 1.2.3 Read in X_train data on 561 feature measurements per subject per activity
    X_train <- read.table("./UCI HAR Dataset/train/X_train.txt")

# 1.2.4 Name columns based on feature names
    names(X_train) <- features$feature_label

# 1.2.5 Combine all train data
    train_Data <- cbind(subject_train, Y_train, X_train)

# 1.3 Combine test and train data
    combined_Data <- rbind(test_Data, train_Data)

# Step 2. Extracts only the measurements on the mean and standard deviation for each measurement.

# 2.1 List feature types to be retained, i.e. those with "mean" or "std" in them
    retainList <- grep("mean|std", features$feature_label, value = TRUE)

# 2.2 Columns in combined_Data to be retained based on the retainList above
    retainColIndex <- match(retainList, names(combined_Data))

# 2.3 Extracted data set
    extract_Data <- combined_Data[, c(1, 2, retainColIndex)]

# Step 3. Uses descriptive activity names to name the activities in the data set

# 3.1 Join above extracted data set with activity dataset
# This will include into extract_Data a column activity_label to the end
    extract_Data <- join(extract_Data,activity,by="activity_ID")

# 3.2 We then reorder extract_Data to bring activity_label next to activity_ID
    lastCol <- ncol(extract_Data)
    lastbutoneCol <- lastCol-1
    extract_Data <- extract_Data[,c(1,2,lastCol,3:lastbutoneCol)]

# Step 4. Appropriately labels the data set with descriptive variable names

# Already achieved in steps 1.1.4 and 1.2.4 above
# We had altered column names based on data in "features.txt"

# Step 5. From the data set in step 4, creates a second, independent tidy data set 
# with the average of each variable for each activity and each subject.

# 5.1 Melt extract_Data to convert all feature measurements (4-82) into a single column
# identified by columns 1 to 3, i.e. subject ID, activity ID, and activity label
    melt_Data <- melt(extract_Data, id=1:3, measure.vars=4:82)

# 5.2 Group melted data by subject ID, activity ID, and activity label
    group_Data <- group_by(melt_Data,subject_ID,activity_ID,activity_label,variable)

# 5.3 Average each feature measurement / variable value for each activity and each subject
    avg_Data <- summarize(group_Data, average = mean(value, na.rm=TRUE))

# 5.4 Write the achieved tidy data set, avg_Data, into a .txt file in the working directory
    avg_Data$variable <- as.character(avg_Data$variable)
    names(avg_Data) <- c("subject","activity_type","activity_label","feature","mean_measure")
    write.table(avg_Data, file = "tidy_Data.txt", row.names = FALSE)