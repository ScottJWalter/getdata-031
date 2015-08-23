# run_analysis.R

library(plyr)
library(knitr)

# Make sure the working data directory exists.  If it doesn't assume
# the data set doesn't exist either (i.e. create directory, and download
# data set)
#
if( !file.exists("./data") )
{
    dir.create("./data")

    # Get data set
    #
    download.file( "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
                   , destfile = "./data/Dataset.zip"
                   , method = "curl"
    )
    
    # Extract data set
    #
    unzip( zipfile = "./data/Dataset.zip"
           , exdir = "./data"
    )
}

# Set up working path variable and file list
#
thePath <- file.path ("./data" , "UCI HAR Dataset" )
# files <- list.files( thePath, recursive = TRUE )

# Load data into workspace (Activity, Subject, and Features)
#
d.Activity.Test  <- read.table( file.path( thePath, "test" , "Y_test.txt" )
                              , header = FALSE 
                              )
d.Activity.Train <- read.table( file.path( thePath, "train", "Y_train.txt")
                              , header = FALSE 
                              )
d.Activity.Labels <- read.table( file.path( thePath, "activity_labels.txt")
                               , header = FALSE
                               )
# d.Activity.Labels.cnt <- sum( count( unique( d.Activity.Labels ))$freq )

d.Subject.Test  <- read.table( file.path( thePath, "test" , "subject_test.txt")
                               , header = FALSE 
                               )
d.Subject.Train <- read.table( file.path( thePath, "train", "subject_train.txt")
                             , header = FALSE 
                             )

d.Features.Test  <- read.table( file.path( thePath, "test" , "X_test.txt" )
                              , header = FALSE 
                              )
d.Features.Train <- read.table( file.path( thePath, "train", "X_train.txt")
                              , header = FALSE 
                              )
d.Features.Names <- read.table( file.path( thePath, "features.txt" )
                                , head = FALSE 
                                )

# 1.  Merge the test and training data into a single data set.
#
# First, merge test and training sets for each variable
#
d.Subject <- rbind(  d.Subject.Train, d.Subject.Test )
names( d.Subject ) <- c( "Subject" )
# d.Subject.cnt <- sum( count( unique( d.Subject ) )$freq )

d.Activity <- rbind( d.Activity.Train, d.Activity.Test )
names( d.Activity ) <- c( "Activity" )

d.Features <- rbind( d.Features.Train, d.Features.Test )
names( d.Features ) <- d.Features.Names$V2

# Apply activity labels
#
d.Activity$ActivityName <- d.Activity.Labels[ d.Activity$Activity, 2 ]

# Now, merge the 3 variables into a single data frame
#
theData <- cbind( d.Features, cbind( d.Subject, d.Activity ) )


# 2.  Extract only the measurements on the mean and standard deviation for 
#     each measurement. 
theData <- subset( theData
                   , select = c( as.character(
                                    d.Features.Names$V2[ grep( "mean\\(\\)|std\\(\\)", d.Features.Names$V2 ) ]
                                 )
                               , "Subject"
                               , "Activity" 
                               )
                   )

# Apply descriptive activity names
#
theData$Activity <- factor(theData$Activity, labels = d.Activity.Labels$V2 )

# Name housekeeping
#
names( theData ) <- gsub( "Acc"       , "Accelerometer" , names( theData ) )
names( theData ) <- gsub( "BodyBody"  , "Body"          , names( theData ) )
names( theData ) <- gsub( "Gyro"      , "Gyroscope"     , names( theData ) )
names( theData ) <- gsub( "Mag"       , "Magnitude"     , names( theData ) )
names( theData ) <- gsub( "^t"        , "time"          , names( theData ) )
names( theData ) <- gsub( "^f"        , "frequency"     , names( theData ) )
names( theData ) <- gsub( "[(),]"     , ""              , names( theData ) )
names( theData ) <- gsub( "[-]"       , " "             , names( theData ) )
names( theData ) <- gsub( "mean$"     , "(mean)"        , names( theData ) )
names( theData ) <- gsub( "mean X$"   , "(mean X)"      , names( theData ) )
names( theData ) <- gsub( "mean Y$"   , "(mean Y)"      , names( theData ) )
names( theData ) <- gsub( "mean Z$"   , "(mean Z)"      , names( theData ) )
names( theData ) <- gsub( "std$"      , "(stDev)"       , names( theData ) )
names( theData ) <- gsub( "std X$"    , "(stDev X)"     , names( theData ) )
names( theData ) <- gsub( "std Y$"    , "(stDev Y)"     , names( theData ) )
names( theData ) <- gsub( "std Z$"    , "(stDev Z)"     , names( theData ) )

# Workspace housekeeping
#
rm( d.Activity, d.Activity.Labels, d.Activity.Test, d.Activity.Train )
rm( d.Features, d.Features.Names, d.Features.Test, d.Features.Train )
rm( d.Subject, d.Subject.Test, d.Subject.Train )

# Write out the tidy data set
#
theData2 <- aggregate( . ~ Subject + Activity, theData, mean )
theData2 <- theData2[ order( theData2$Subject, theData2$Activity ), ]

write.table( theData2, file = "tidydata.txt", row.name = FALSE )

# Done

