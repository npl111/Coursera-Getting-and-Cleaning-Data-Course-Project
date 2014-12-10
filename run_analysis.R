# Step 1 - Merge the Training and Test Sets

library(plyr)
library(dplyr)

# Read Test Data
test_x <- read.table("test/X_test.txt")
test_y <- read.table("test/y_test.txt")
test_subj <- read.table("test/subject_test.txt")

# Read Traiing Data
train_x = read.table("train/X_train.txt")
train_y = read.table("train/y_train.txt")
train_subj <- read.table("train/subject_train.txt")

# Rename Y Collumn to "Activity" 
test_y <- rename(test_y,c("V1" = "Activity"))
train_y <- rename(train_y,c("V1" = "Activity"))

# Add Test or Train Indicator Collumn
# train_x2 <- cbind(TT_Ind = "Train", train_x)
# test_x2 <- cbind(TT_Ind = "Test", test_x)

# combine test and train sets in to one set for each of X,Y and Subject
comb_x <- rbind(train_x, test_x)
comb_y <- rbind(train_y, test_y)
comb_subj <- rbind(train_subj, test_subj)

#Extract only features with mean and standard deviation variable names
features <- read.table("features.txt")
selected_features <- grep("-mean()|-std()", features[, 2])
comb_x_sel <- comb_x[,selected_features]

#Assigns Descriptive Variable Names
names(comb_x_sel) <- features[selected_features, 2]

#Name the Actvities
activity_labels <- read.table("activity_labels.txt")
names(activity_labels) <- c("Activity", "Activity_Label")
comb_y2 <- cbind((1:10299),comb_y)
names(comb_y2) <- c("OrderID","Activity")
comb_y_labeled <- merge(x = comb_y2, y = activity_labels, by = "Activity", all.x=TRUE)
comb_y_sorted <- comb_y_labeled[order(comb_y_labeled[,2]),]

#Combine All Data
comb_data <- cbind(comb_subj, comb_x_sel, comb_y_sorted[,3])
names(comb_data)[names(comb_data) == 'comb_y_sorted[, 3]'] <- 'Activity'
names(comb_data)[names(comb_data) == 'V1'] <- 'Subject'

#creates independent tidy data set with the average of each variable for each activity and each subject
library(reshape2)
melted_data <- melt(comb_data,id.vars = c('Activity', 'Subject'), measure.vars = features[selected_features,2])
tidy_data <- aggregate(melted_data$value, list(Actvity=melted_data$Activity,Subject=melted_data$Subject,Variable=melted_data$variable), FUN=mean)
write.table(tidy_data, "tidy_data.txt", row.name=FALSE)