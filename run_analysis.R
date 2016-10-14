run_analysis<-function(){
        
        ## reading files ...
        library(dplyr)
        library(data.table)
        library(reshape2)
        library(plyr)
        library(stringr)
        setwd("C:/Users/Abdalla _Hn/Documents/UCI HAR Dataset")
        features<-fread("features.txt")
        activity_labels<-fread("activity_labels.txt",col.names = c("activity_id","activity_name"))
        
        ## training sets
        
        setwd("C:/Users/Abdalla _Hn/Documents/UCI HAR Dataset/train")
        xtrain<-fread("X_train.txt",col.names =features$V2 )
        ytrain_id<-fread("y_train.txt",col.names = "activity_id")
        subject_train<-fread("subject_train.txt")
        
        ## test sets
        
        setwd("C:/Users/Abdalla _Hn/Documents/UCI HAR Dataset/test")
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
        
        Y<-merge(y_id,activity_labels,by="activity_id",all=T)
        
        ## all data
        Data<-cbind(extracted_X,Y)
        Data$subject<-as.character(unlist(subject))
        Data<-as.data.frame(Data)
        
        ## step (4) : ALREDY DONE :)
        
        ## STEP (5) :
        d2<-as.data.frame(dcast(melt(Data), subject ~ variable, mean))
        d1<-as.data.frame(dcast(melt(Data),activity_name ~ variable, mean))
        
        
        d12<-join(y = d1,x = Data,by="activity_name",type="left")
        
        d22<-join(x = Data , y = d2 , by="subject",type="left")
        
        names(d12)<-str_replace(pattern =  "y$",replacement = " mean by activity_name",string = names(d12))
        names(d22)<-str_replace(pattern="y$",replacement=" mean by subject",string=names(d22))
        
        Data2<-join(x = Data,y = d22,by="subject",type="left")
        
        Data1<-join(x = Data,y = d12,by="activity_name",type="left")
        
        Data<-cbind(Data1,Data2)
        
        
        
       
        
        
}