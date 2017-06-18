# Course project for week 4 getting and cleaning data
Here we use Human Activity Recognition Using Smartphones data from
Samsung. The code is given in `run_analysis.R`, the Variables are in
`CodeBook.md` and the outcome is in `SecTidyFile.txt`
## Procedures
### 1. Download and load data
* We download data from [here](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip)
* Then we unzip the data using `unzip` command
### 2. Merge data
* Next we read features and activity labels and turn them to characters
  using `as.character` command.
* From features we subset the ones which contain `std` and `mean`
* After that we load training and testing data but we choose the columns
  which contain the words `std` and `mean`
* We merge all the test data and training data and store them
  to a `MegaData`
### 3 & 4. Giving descriptive activity names and labeling columns appropriately
* First, we substitute names such as `-mean` and `-std`
 with more readable names `Mean`,`Std` and remove characters like `[-()]`.We do all of that using `grep` command
* Then we give the cleaner and readable names to the columns in
  `MegaData`.
* Next we turn the `Activity` and `Subject` columns to factors
* After that we melt the hell out of data using `melt` command
### 5. Writing the second tiny data sets
* Now we just write the data to a new text file called `SecTidyFile.txt`
