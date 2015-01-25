#step 0 
## set working directory and clean the working space
if (!getwd() == "./workspace") {
    dir.create("./workspace")
    setwd ("./workspace")
    }
rm(list = ls(all=TRUE))

#Load required library
if (!require("data.table")) {
    install.packages("data.table")
}
if (!require("plyr")) {
    install.packages("plyr")
}
 
if (!require ("dplyr")){
    install.packages("dplyr")
}

require(plyr)
require(data.table)
require(dplyr)



## download and explode the data required
if(!file.exists("./data")){dir.create("./data")}

fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileUrl,destfile="./data/Dataset.zip")

file_list <- unzip ("./data/Dataset.zip", list=TRUE) 
#GIVE ME A LIST OF FILES FROM WICH CHOOSE THE FILE REQUIRED

unzip ("./data/Dataset.zip")


##########################################################
## Step 1
# Merge the training and test sets to create one data set

x_train <- read.table(file_list[31, "Name"])
y_train <- read.table(file_list[32, "Name"])
subject_train <- read.table(file_list[30, "Name"])

x_test <- read.table(file_list[17, "Name"])
y_test <- read.table(file_list[18, "Name"])
subject_test <- read.table(file_list[16, "Name"])

Features <- read.table(file_list[2, "Name"])

# create 'x' data set
x_data <- rbind(x_train, x_test)

# create 'y' data set
y_data <- rbind(y_train, y_test)

# create 'subject' data set
subject_data <- rbind(subject_train, subject_test)
##########################################################

##########################################################
## Step 2
# Extract the measurements of  mean and standard deviation 

# get only columns with mean or std in their names
mean_and_std_features <- grep("-(mean|std)", Features[, 2])


# subset the desired columns
x_data <- x_data[, mean_and_std_features]


##########################################################

###############################################################################
## Step 3
# Use descriptive activity names to name the activities in the data set

# correct the column names
names(x_data) <- Features[mean_and_std_features, 2]

activities <- read.table(file_list[1, "Name"])

# update values with correct activity names
y_data[, 1] <- activities[y_data[, 1], 2]

# correct column name
names(y_data) <- "activity"

###############################################################################

###############################################################################
## Step 4
# Appropriately label the data set with descriptive variable names

# correct column name
names(subject_data) <- "subject"

# bind all the data in a single data set
all_data <- cbind(x_data, y_data, subject_data)

# Remove parentheses
names(all_data) <- gsub('\\(|\\)',"",names(all_data), perl = TRUE)

# Make syntactically valid names
names(all_data) <- make.names(names(all_data))

names(all_data) <- gsub('Acc',"Acceleration",names(all_data))
names(all_data) <- gsub('GyroJerk',"AngularAcceleration",names(all_data))
names(all_data) <- gsub('Gyro',"AngularSpeed",names(all_data))
names(all_data) <- gsub('Mag',"Magnitude",names(all_data))
names(all_data) <- gsub('^t',"TimeDomain.",names(all_data))
names(all_data) <- gsub('^f',"FrequencyDomain.",names(all_data))
names(all_data) <- gsub('\\.mean',".Mean",names(all_data))
names(all_data) <- gsub('\\.std',".StandardDeviation",names(all_data))
names(all_data) <- gsub('Freq\\.',"Frequency.",names(all_data))
names(all_data) <- gsub('Freq$',"Frequency",names(all_data))

for (j in 1:30) {
    all_data$subject[all_data$subject == j] <- paste("Partecipant", toString(j))
}
write.table(all_data, "alldata.txt", row.name= FALSE )
###############################################################################

###############################################################################
## Step 5
# Create the finaltidy data set with the average of all variables but last two
# (activity and subject) and write on file txt 

averageDat <- ddply(all_data, .(subject, activity), function(x) colMeans(x[, 1:79]))

write.table(averageDat, "averageDat.txt", row.name=FALSE)
###############################################################################
##END


