# 1) First let's download and unzip the data set
if (!file.exists("./Finall_assignment")){dir.create("./Finall_assignment/")}
if (!file.exists("./Finall_assignment/UCI HAR Dataset")){
        Url <- Url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
        download.file(Url,destfile = "./Finall_assignment/data.zip")
}

# Unzip the file to the created directory
unzip(zipfile = "./Finall_assignment/data.zip", exdir = "./Finall_assignment")

###################################################

# 2) Here we are going to read the data sets in and
#    merge them to a mega data


# Feature and activity labels and turning them to charcters 
features <- read.table("./Finall_assignment/UCI HAR Dataset/features.txt")
actibity_labels <- read.table("./Finall_assignment/UCI HAR Dataset/activity_labels.txt")
features[,2] <- as.character(features[,2])
activity_labels[,2] <- as.character(actibity_labels[,2])

# Now we are going to extract data with only mean and sandard deviation 
AcceptableFeatures <- grep("*.mean.*|.*std.*", features[,2])
AcceptableFeatures_names <- features[AcceptableFeatures,2]

# Training sets 
x_train <- read.table("./Finall_assignment/UCI HAR Dataset/train/X_train.txt")[AcceptableFeatures]
y_train <- read.table("./Finall_assignment/UCI HAR Dataset/train/y_train.txt")
subject_train <- read.table("./Finall_assignment/UCI HAR Dataset/train/subject_train.txt")

# Test sets
x_test <- read.table("./Finall_assignment/UCI HAR Dataset/test/X_test.txt")[AcceptableFeatures]
y_test <- read.table("./Finall_assignment/UCI HAR Dataset/test/y_test.txt")
subject_test <- read.table("./Finall_assignment/UCI HAR Dataset/test/subject_test.txt")

# Now let's merge data sets 

# Merging traing data sets 
TrainingSet <- cbind(subject_train,y_train,x_train)

# Merging testing data sets 
TestingSet <- cbind(subject_test, y_test, x_test)

# Merging them all to a mega data 
MegaData <- rbind(TrainingSet, TestingSet)

#####################################################################
# 3) Let's give descriptive activity names to name the activities in the data set
# And Also 
# 4)Here we appropriately label the data set with descriptive variable names

# Before giving names to columns let's clean the names a bit 
chars <- c("-mean", "-std", "[-()]")
chars_replace <- c("Mean", "Std", "")
for (i in seq_along(chars)){
        AcceptableFeatures_names <- gsub(chars[i], chars_replace[i], AcceptableFeatures_names)
}

# Now let's assign the names 
colnames(MegaData) <- c("Subject", "Activity", AcceptableFeatures_names)

# Let's give names to activities in the data set and 
# turn them and subjects to factors 

MegaData$Activity <- factor(MegaData$Activity, levels = activity_labels[,1],
                            labels = actibity_labels[,2])
MegaData$Subject <- as.factor(MegaData$Subject)

# Now to have a more compact and better lookin data set 
# let's melt the hell out of it!

MeltedMegaData <- melt(MegaData)

##############################################################
# 5) Now Let's  creates a second, independent tidy data set 
#    with the average of each variable for each activity and each subject. 

MeltedMegaData_mean <- dcast(MeltedMegaData, Subject + Activity ~ variable, mean)

# Let's write it to a data file
write.table(MeltedMegaData_mean, "SecTidyFile.txt", row.names = FALSE , quote = FALSE)
