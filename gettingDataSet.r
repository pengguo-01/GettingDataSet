library(dplyr)
library(reshape2)

setwd("c:\\Users\\pg000\\Desktop")

## download the data at website

if(!file.exists(".\\Download")){dir.create(".\\Download")}
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileUrl, destfile = ".\\Download\\dataset.zip")

## now unzip the file 
unzip(zipfile = ".\\Download\\dataset.zip", exdir = ".\\Download" )
## get the list of the file
##  showing the list of dataset

path_rf <- file.path(".\\Download", "UCI HAR Dataset")
files <- list.files(path_rf, recursive = TRUE )
files
## read data from the files into the variables
## read the Activitu files

dataActivityTest <- read.table(file.path(path_rf, "test", "y_test.txt"), header = FALSE)
dataActivityTrain <- read.table(file.path(path_rf, "train", "y_train.txt"), header = FALSE)
## read the subject files

dataSubjectTrain <- read.table(file.path(path_rf, "train","subject_train.txt"), header = FALSE)
dataSubjectTest <- read.table(file.path(path_rf, "test", "subject_test.txt"), header = FALSE)
## read features files
dataFeatureTest <- read.table(file.path(path_rf,"test", "x_test.txt"), header = FALSE)
dataFeatureTrain <- read.table(file.path(path_rf, "train", "x_train.txt"), header = FALSE)

## LOOK AT THE PROPERTIES OF THE ABOVE VARIBLES

str(dataActivityTest)
str(dataActivityTrain)
str(dataFeatureTest)
str(dataFeatureTrain)
str(dataSubjectTest)
str(dataSubjectTrain)

## merge the text and train data sets 
## concatenate the data tables by rows
dataSubject <- rbind(dataSubjectTrain, dataSubjectTest)
dataActivity <- rbind(dataActivityTrain, dataActivityTest)
dataFeature <- rbind (dataFeatureTrain, dataFeatureTest)

dataActivity <- na.omit(dataActivity)
## set names of each variables
names(dataSubject)<-c("subject")
names(dataActivity)<- c("activity")
dataFeaturesNames <- read.table(file.path(path_rf, "features.txt"),head=FALSE)
names(dataFeature)<- dataFeaturesNames$V2  

## Merge columns to get the data frame data for all data
dataCombine <- union_all(dataSubject, dataActivity , all =TRUE)
Data <- union_all(dataFeature, dataCombine)

nrow(dataSubject)
nrow(dataActivity)
length(dataActivity)
length(dataSubject)
nrow(dataSubject)=length(dataActivity)


## extract the mean and standard deviation for each columns 
## grep() within each element of a character vector: search for matches to argument pattern
## extract mean and standard deviation of each measurement
subdataFeaturesNames<-dataFeaturesNames$V2[grep("mean\\(\\)|std\\(\\)", dataFeaturesNames$V2)]
## subset the data frame DATA by select names of Feature
## as.character () attempts to coerce it argument to character type
##
selectedNames <- c(as.character(subdataFeaturesNames), "subject", "activity")
Data <- subset(Data, select = selectedNames)
## to showing the mean and standard deviation 
str(Data)


## descripetive activity 
## reading descriptive activity for activity_label text
activityLabels <- read.table(file.path(path_rf, "activity_labels.txt"), header = FALSE)
head(Data$activity,30)

## appropriately label the data set 
## gsup replace all matches of a string
names(Data)<-gsub("^t", "time", names(Data))
names(Data)<-gsub("^f", "frequency", names(Data))
names(Data)<-gsub("Acc", "Accelerometer", names(Data))
names(Data)<-gsub("Gyro", "Gyroscope", names(Data))
names(Data)<-gsub("Mag", "Magnitude", names(Data))
names(Data)<-gsub("BodyBody", "Body", names(Data))
names(Data)

library(dplyr)

Data2<-Data[order(Data$subject,Data$activity),]
write.table(Data2, file = "tidydata.txt",row.name=FALSE)
install.packages("knitr")


library(knitr)
knit2html("codebook.Rmd");
install.packages("dataMaid")
library(dataMaid)
makeCodebook(Data)
