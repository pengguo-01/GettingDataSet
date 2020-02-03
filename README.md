# GettingDataSet

The Purpose of the project is collect data set and clean the data set;
for my project that has five steps 
1 
extact the data set from online set in data folder 

if(!file.exists(".\\Download")){dir.create(".\\Download")}
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileUrl, destfile = ".\\Download\\dataset.zip")

check the variable properties of each dataset 
2:
merges the two dataset within trainning and test set concatenate with one data 
set.
rename the new dataset 
and then extract the data we want to measures such mena and standard deviation 

subdataFeaturesNames<-dataFeaturesNames$V2[grep("mean\\(\\)|std\\(\\)", dataFeaturesNames$V2)]

3 
read descriptive activity names to another data set 
4
set each lable with data set within descprictive variable names

5 
recreate and output it in "tidydata.txt"
