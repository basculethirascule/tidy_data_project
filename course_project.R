activity.labels <- read.table('/Users/platypus/Coursera/3_Getting_and_cleaning_data/UCI HAR Dataset/activity_labels.txt', header=F)
features <- read.table('/Users/platypus/Coursera/3_Getting_and_cleaning_data/UCI HAR Dataset/features.txt', header=F)

#####TEST DATA
#list files in data directory
dir('/Users/platypus/Coursera/3_Getting_and_cleaning_data/UCI HAR Dataset/test')

sub.test <- read.table('/Users/platypus/Coursera/3_Getting_and_cleaning_data/UCI HAR Dataset/test/subject_test.txt', header=F) #2947 rows, 1 column
test.x <- read.table('/Users/platypus/Coursera/3_Getting_and_cleaning_data/UCI HAR Dataset/test/X_test.txt', header=F) #2947 rows, 561 columns
test.y <- read.table('/Users/platypus/Coursera/3_Getting_and_cleaning_data/UCI HAR Dataset/test/y_test.txt', header=F) #2947 rows, 1 column

colnames(test.x) <- features[,2] #give the test data the column headers associated with the features
test.x$group <- rep('test', dim(test.x)[1]) #added a column to indicate the data were from the test group
test.x$activity.label <- test.y[,1] #assigned the activity labels to the data
test.x$subject <- sub.test[,1] #assigned the subjects to test (n = 9 subjects)


#####TRAINING DATA
dir('/Users/platypus/Coursera/3_Getting_and_cleaning_data/UCI HAR Dataset/train')

sub.train <- read.table('/Users/platypus/Coursera/3_Getting_and_cleaning_data/UCI HAR Dataset/train/subject_train.txt', header=F) #7352 rows, 1 column
train.x <- read.table('/Users/platypus/Coursera/3_Getting_and_cleaning_data/UCI HAR Dataset/train/X_train.txt', header=F) #7352 rows, 561 columns
train.y <- read.table('/Users/platypus/Coursera/3_Getting_and_cleaning_data/UCI HAR Dataset/train/y_train.txt', header=F) #7352 rows, 1 column

colnames(train.x) <- features[,2] #give the test data the column headers associated with the features
train.x$group <- rep('train', dim(train.x)[1]) #added a column to indicate the data were from the training group
train.x$activity.label <- train.y[,1] #assigned the activity labels to the data
train.x$subject <- sub.train[,1] #assigned the subjects to train (n = 21 subjects)


######BIND DATA BY ROW INTO DATA FRAME
#BIND (rbind) the data frames
data <- rbind(test.x, train.x) #creates a data frame of 10299 rows, 564 columns


######ADD DESCRIPTIVE ACTIVITY NAMES TO NAME THE ACTIVITIES IN THE DATASET (IN A NEW COLUMN)
data$activity <- sub('1', activity.labels[,2][1], data$activity)
data$activity <- sub('2', activity.labels[,2][2], data$activity)
data$activity <- sub('3', activity.labels[,2][3], data$activity)
data$activity <- sub('4', activity.labels[,2][4], data$activity)
data$activity <- sub('5', activity.labels[,2][5], data$activity)
data$activity <- sub('6', activity.labels[,2][6], data$activity)

#remove -(), characters from column headers to avoid any potential computational problems associated with headers
colnames(data) <- gsub('-', '_', colnames(data))
colnames(data) <- gsub(',', '_', colnames(data))
colnames(data) <- gsub('\\(', '', colnames(data)) #( is a special character
colnames(data) <- gsub(')', '', colnames(data))

write.table(data, 'tidy_data.txt', sep='\t', row.names = F)

#####EXTRACT ONLY THE MEASUREMENTS ON THE MEAN AND STANDARD DEVIATION FOR EACH MEASUREMENT
x <- grep('_mean', colnames(data)) #find all columns that were formerly labelled -mean()
y <- grep('_std', colnames(data)) #find all columns that were formerly labelled -std()

mean.sd <- data[,c(x,y)]
z <-grep('meanFreq', colnames(mean.sd)) #remove unwanted columns from the subset data frame
mean.sd <- mean.sd[,-z] #data frame containing only -mean() and -std() information
mean.sd <- mean.sd[,order(colnames(mean.sd))] #order the columns by variable name
write.table(mean.sd, 'mean_sd.txt', sep='\t', row.names = F)


#####DATA FRAME WITH THE AVERAGE OF EACH VARIABLE FOR EACH ACTIVITY AND EACH SUBJECT
x <- which(colnames(data) %in% colnames(mean.sd))
new.data <- data[,x]
wanted.data <- data.frame(subject = data$subject, activity = data$activity, new.data)
#use aggregate to collapse data and produce average values for each variable based on subject and activity
agg_data <- aggregate(wanted.data[,c(3:dim(wanted.data)[2])], by=list(wanted.data$subject, wanted.data$activity), FUN=mean)
colnames(agg_data)[1:2] <- c('subject', 'activity') #give ID columns names
colnames(agg_data)[3:dim(agg_data)[2]] <- paste('Avg_', colnames(agg_data)[3:dim(agg_data)[2]], sep='') #add information to variable columnns to indicate they represent averages of variables
write.table(agg_data, 'average_activity_subject.txt', sep='\t', row.names = F) #output aggregate data without row numbers in file