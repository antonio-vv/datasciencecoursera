# Merging the test and training set into one ####
training_set = read.table("UCI HAR Dataset/train/X_train.txt")
test_set = read.table("UCI HAR Dataset/test/X_test.txt")
data_set = rbind(training_set, test_set)

# Extracting only the measurements on the mean and standard deviation for each measurement ####
vars = read.table("UCI HAR Dataset/features.txt")
colnames(data_set) = vars[,2]
mean_cols = data_set[, which(grepl("mean", names(data_set)))]
std_cols = data_set[, which(grepl("std", names(data_set)))]
data_extract = cbind(mean_cols, std_cols)
head(data_extract)

# Naming the activities ####
training_labels = read.table("UCI HAR Dataset/train/y_train.txt")
test_labels = read.table("UCI HAR Dataset/test/y_test.txt")
labels = rbind(training_labels, test_labels)
activities = read.table("UCI HAR Dataset/activity_labels.txt")
data_labels = merge(labels, activities, by = "V1")
activity = factor(data_labels[,2])
extract_labeled = cbind(data_extract, activity)

# Tidy Data Set
library(dplyr)
tidy_data = extract_labeled %>% group_by(activity) %>% summarise_all(mean)
write.csv(tidy_data, "UCI HAR Dataset/tidy_dataset.csv")