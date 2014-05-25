setwd("d:/rars/R/Getting and Cleaning Data/UCI HAR Dataset")

###### Parameters
N_ROWS=100
SKIP_ROWS=0

####### Labels
activity_labels<-read.table("activity_labels.txt",header=FALSE,sep=" ",col.names=c("tipActivity","descActivity"))
features<-read.table("features.txt",header=FALSE,sep=" ",col.names=c("tipFeatures","descFeatures"))

####All about test
tip_test<-as.data.frame(rep("TS",N_ROWS))
names(tip_test)[1]<-paste("Tip")
subject_test<-read.csv(".\\test\\subject_test.txt",skip = SKIP_ROWS,col.names=c("Subject"),header=FALSE,nrows=N_ROWS) 
activity_test<-read.csv(".\\test\\y_test.txt",skip = SKIP_ROWS,header=FALSE,col.names=c("Activity"),nrows=N_ROWS) 
features_test<-read.fwf(".\\test\\X_test.txt",skip = SKIP_ROWS,header=FALSE,widths=rep(16,561),col.names=features$descFeatures,n=N_ROWS)
features_test<-cbind(tip_test,activity_test,subject_test,features_test)
#features_test<-cbind(activity_test,subject_test,features_test)


####All about train
tip_train<-as.data.frame(rep("TR",N_ROWS))
names(tip_train)[1]<-paste("Tip")
subject_train<-read.csv(".\\train\\subject_train.txt",skip = SKIP_ROWS,col.names=c("Subject"),header=FALSE,nrows=N_ROWS) 
activity_train<-read.csv(".\\train\\y_train.txt",skip = SKIP_ROWS,header=FALSE,col.names=c("Activity"),nrows=N_ROWS) 
features_train<-read.fwf(".\\train\\X_train.txt",skip = SKIP_ROWS,header=FALSE,widths=rep(16,561),col.names=features$descFeatures,n=N_ROWS)
features_train<-cbind(tip_train,activity_train,subject_train,features_train)
#features_train<-cbind(activity_train,subject_train,features_train)

#1. Merges the training and the test sets to create one data set.
mall<-merge(features_train,features_test,all=TRUE)

#2. Extracts only the measurements on the mean and standard deviation for each measurement. 
p<-regexec("(*mean*)|(*std*)",as.character(features$descFeatures))
ll=NULL
for (i in 1:length(p)){
  if (p[[i]][1] > 0){
    ll<-c(ll,i)
  }
}

cmall<-NULL
#cmall<-cbind(mall[1])
cmall<-cbind(mall[2])
cmall<-cbind(cmall,mall[3])
for (i in 1:length(ll)){  
  cmall<-cbind(cmall,mall[ll[i]+3])
}

#3. Uses descriptive activity names to name the activities in the data set
#4. Appropriately labels the data set with descriptive activity names. 
df<-merge(cmall[1],activity_labels, by.x="Activity",by.y="tipActivity")
cmall[1]<-df[2]

#5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject.
by_act<-mall$Activity
by_sub<-mall$Subject
tidy_mall<-aggregate(mall,by=list(by_act,by_sub),mean)

##Writting the DATA SETS
write.table(tidy_mall, "tidy_mall.txt", sep="\t")
write.table(cmall, "cmall.txt", sep="\t")
write.table(mall, "mall.txt", sep="\t")


