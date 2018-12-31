# CODEBOOK.md
## Code book for final tidy data set written by the "run_analysis.R" script into "tidy_Data.txt" file

subject
  * Column 1
  * Data type: Integer
  * Description: values range from 1 to 30 - identifying the subjects whose smartphone measurements were collected
========================================================================================================

activity_type
  * Column 2
  * Data type: Integer
  * Description: values range from 1 to 6 - indicating the type of physical activity

========================================================================================================

activity_label
  * Column 3
  * Data type: Character
  * Description: values are WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, or LAYING depending on activity_ID in Column 2 - i.e. activity_type 1 corresponds to WALKING and so on until 6 for LAYING

========================================================================================================

feature
  * Column 4
  * Data type: Factor
  * Description: 79 possible type of measurements. 
    * The context of understanding the features is thus: The measurements are accelerometer and gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ. These are time domain signals (prefix 't' to denote time). The acceleration signal was then separated into body and gravity acceleration signals (tBodyAcc-XYZ and tGravityAcc-XYZ). Subsequently, the body linear acceleration and angular velocity were derived in time to obtain Jerk signals (tBodyAccJerk-XYZ and tBodyGyroJerk-XYZ). Also the magnitude of these three-dimensional signals were calculated (tBodyAccMag, tGravityAccMag, tBodyAccJerkMag, tBodyGyroMag, tBodyGyroJerkMag). Finally a Fast Fourier Transform (FFT) was applied to some of these signals producing fBodyAcc-XYZ, fBodyAccJerk-XYZ, fBodyGyro-XYZ, fBodyAccJerkMag, fBodyGyroMag, fBodyGyroJerkMag. (Note the 'f' to indicate frequency domain signals). These signals were used to estimate variables of the feature vector for each pattern: '-XYZ' is used to denote 3-axial signals in the X, Y and Z directions. Finally, the set of variables that were estimated from these signals are: mean() for Mean Value and std() for Standard Deviation.

========================================================================================================

mean_measure
  * Column 5
  * Data type: numeric
  * Description: average of measurements for each feature in column 4 for each activity in column 2/3 and each subject in column 1