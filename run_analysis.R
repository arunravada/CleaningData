
if(!file.exists("./data")){dir.create("./data")}
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileUrl,destfile="./data/Dataset.zip",method="curl")

###Unzip DataSet to /data directory
unzip(zipfile="./data/Dataset.zip",exdir="./data")

## Read the file from the current working directory
path<-file.path(getwd(),"UCI HAR Dataset")
#list all the files
list.files(path,recursive=TRUE)
#load all the Activity based test and Train set
ActTest<-read.table(file.path(path,"test" , "Y_test.txt" ),header = FALSE)
ActTrain<-read.table(file.path(path, "train", "Y_train.txt"),header = FALSE)
#Load all the subject releated Train and test set
SubjectTrain <- read.table(file.path(path, "train", "subject_train.txt"),header = FALSE)
SubjectTest  <- read.table(file.path(path, "test" , "subject_test.txt"),header = FALSE)
#load all the features related Test and training set
FeaturesTest  <- read.table(file.path(path, "test" , "X_test.txt" ),header = FALSE)
FeaturesTrain <- read.table(file.path(path, "train", "X_train.txt"),header = FALSE)
##Merge the training and test sets as mentioned below
dataSubject <- rbind(SubjectTrain, SubjectTest)
dataActivity<- rbind(ActTrain, ActTest)
dataFeatures<- rbind(FeaturesTrain, FeaturesTest)
##Assign names subject,activity and features
names(dataSubject)<-c("subject")
names(dataActivity)<- c("activity")
dataFeaturesNames <- read.table(file.path(path, "features.txt"),head=FALSE)
names(dataFeatures)<- dataFeaturesNames$V2
#Combine the dataset subject and activity
dataCombine <- cbind(dataSubject, dataActivity)
#merge them with features
Data <- cbind(dataFeatures, dataCombine)
##subsetting the data with names like mean and std
subdataFeaturesNames<-dataFeaturesNames$V2[grep("mean\\(\\)|std\\(\\)", dataFeaturesNames$V2)]
#include Subject and Activity names
selectedNames<-c(as.character(subdataFeaturesNames), "subject", "activity" )
#Subset data with selected names

Data<-subset(Data,select=selectedNames) 
activityLabels<- read.table(file.path(path,"activity_labels.txt"),header = FALSE, col.names = c("activity", "activity_name"))
#Adding a new column Activity_names and joining with id
Data<-join(Data, activityLabels, by = "activity", match = "first")
head(Data$activity_name,30)

#change the names to readable format
names(Data)<-gsub("^t", "time", names(Data))
names(Data)<-gsub("^f", "frequency", names(Data))
names(Data)<-gsub("Acc", "Accelerometer", names(Data))
names(Data)<-gsub("Gyro", "Gyroscope", names(Data))
names(Data)<-gsub("Mag", "Magnitude", names(Data))
names(Data)<-gsub("BodyBody", "Body", names(Data))
library(plyr);
Data2<-aggregate(. ~subject + activity, Data, mean)
Data2<-Data2[order(Data2$subject,Data2$activity),]
str(Data2)
write.table(Data2, file = "tidydata.txt",row.name=FALSE)
