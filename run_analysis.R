## set wd to downloaded file
setwd("D:/Users/jbasley/Documents/R Programming/getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset")

## read required files in r
x_test <- read.table("test/X_test.txt", header = FALSE)
y_test <- read.table("test/y_test.txt", header = FALSE)

x_train <- read.table("train/X_train.txt", header = F)
y_train <- read.table("train/y_train.txt", header = F)

features <- read.table("features.txt", header = F)

##  merge the x_test and x_train data sets and assign variable names from the features file

alldata <- rbind(x_test,x_train)

attrib <- as.character(features[,2])
attrib <- make.names(attrib, unique=T)
colnames(alldata) <- attrib

##delete unneeded dataframes
rm(list = c("features", "x_test", "x_train", "y_test", "y_train", "attrib"))

## refine the data set to contain mean and standard deviation for each measurement

library(dplyr)
means_std <- select(alldata, matches('mean|std'))

rm(alldata)

## assign descriptive activity names to name the activities in the data set

desc_names <- colnames(means_std)
      
      
    ## appropriatly label the dataset with descriptive variable names
      
      desc_names <- gsub("tBodyAcc", "T Body Acceleration", desc_names)
      desc_names <- gsub("fBodyAcc", "F Body Acceleration", desc_names)
      desc_names <- gsub(".mean", " Mean", desc_names)
      desc_names <- gsub(".std", " Standard Deviation", desc_names)
      desc_names <- gsub("...X", " X Axis", desc_names)
      desc_names <- gsub("...Y", " Y Axis", desc_names)
      desc_names <- gsub("...Z", " Z Axis", desc_names)
      desc_names <- gsub("tGravityAcc", "T Gravitational Acceleration", desc_names)
      desc_names <- gsub("tBodyGyro", "T Body Gyro", desc_names)
      desc_names <- gsub("Jerk", " Jerk", desc_names)
      desc_names <- gsub("Mag", " Magnitude", desc_names)
      desc_names <- gsub("Freq", " Frequency", desc_names)
      desc_names <- gsub("fBodyGyro", "F Body Gyro", desc_names)
      desc_names <- gsub("fBodyBodyGyro", "F Body Body Gyro", desc_names)
      desc_names <- gsub("fBodyBodyAcc", "F Body Body Acceleration", desc_names)
      desc_names <- gsub("angle.T", "Angular", desc_names)
      desc_names <- gsub("ang ", "Angular ", desc_names)
      desc_names <- gsub(".gravityMean", " Gravity Mean", desc_names)
      desc_names <- gsub("AccelerationMean", "Acceleration Mean", desc_names)
      desc_names <- gsub("GyroMean", "Gyro", desc_names)
      desc_names <- gsub("JerkMean", " Jerk", desc_names)
      desc_names <- gsub("Mean.", "Mean ", desc_names)
      desc_names <- gsub("T", "Time", desc_names)
      desc_names <- gsub("F", "Frequency", desc_names)

    ##reassign the vector to column names
    colnames(means_std) <- desc_names

## create a second, independant tidy data set with the average of each variable for each activity and subject

  ## create an empty dataframe called column_means which has the same colnames as the means_std table
  column_means <- data.frame(matrix(NA, nrow=1, ncol=86))
  
  column_means_names <- vector(mode = "character", length = 86)
  for (i in 1:86) {column_means_names[i] <- paste(desc_names[i], " Average") 
  }
  colnames(column_means) <- column_means_names
  rm(column_means_names)
  rm(desc_names)

  ## calculate the means for each column and add it to the empty data frame
  for (i in 1:86) 
  {column_means[1,i] <- mean(means_std[,i])
  }
  rm(i)
