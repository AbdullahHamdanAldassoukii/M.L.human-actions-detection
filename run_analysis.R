run_analysis<-function(){
        
        ## reading files ...
        library(dplyr)
        library(plyr)
        library(data.table)
        library(reshape2)
        library(stringr)
        
        ## PUT YOUR WORKING DIRECTORY THAT CONTAIN THE DATA FOLDER HERE:
        WD<-"~/"
        
        setwd(WD)
        setwd("./UCI HAR Dataset")
        features<-fread("features.txt")
        activity_labels<-fread("activity_labels.txt",col.names = c("activity_id","activity_name"))
        
        ## read training sets
        
        setwd("./train")
        xtrain<-fread("X_train.txt",col.names =features$V2 )
        ytrain_id<-fread("y_train.txt",col.names = "activity_id")
        subject_train<-fread("subject_train.txt")
        
        ## read test sets
        
        setwd("../test")
        xtest<-fread("X_test.txt",col.names =features$V2 )
        ytest_id<-fread("y_test.txt",col.names = "activity_id")
        subject_test<-fread("subject_test.txt")
        
        ## step (1) : merge tarain and test sets ...
        
        X<-rbind(xtrain,xtest)  ## merge X
        X<-as.data.frame(X)
        y_id<-rbind(ytrain_id,ytest_id)  ## merge Y id
        subject<-rbind(subject_train,subject_test) ## merge subjects
        
        ## step (2) : Extracting only the measurements on the mean and standard deviation for each measurement
        
        extracted_X<-as.data.table(X[,grep("[Mm]ean[\\(]|[Ss]td",names(X),value = T)])
        
        
        ## step (3) : naming activities in the data set
        
        Y<-left_join(y_id,activity_labels,by="activity_id")
        
        ## all data
        
        All_Data<-cbind(extracted_X,Y)
        All_Data$subject<-as.character(unlist(subject))
        
        ## step (4): 
        ## descriptive variable names into dataset
        names(All_Data) <- sub("^t","time",names(All_Data))
        names(All_Data) <- sub("^f","frequency",names(All_Data))
        names(All_Data) <- sub("Acc","Accelerometer",names(All_Data))
        names(All_Data) <- sub("Gyro","Gyroscope",names(All_Data))
        names(All_Data) <- sub("Mag","Magnitude",names(All_Data))
        
        ## STEP (5) :
        
        tidy_data<-All_Data%>%
                group_by(activity_name,subject) %>%
                summarise_each(funs(mean(., na.rm=TRUE)),-(activity_id:subject))
       
        
        write.table(tidy_data,"../tidydata.txt",row.names = F)
}
