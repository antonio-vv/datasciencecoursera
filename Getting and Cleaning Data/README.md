# Getting and Cleaning Data Course Final Project
Antonio Vargas (2020)

### Packages needed
dplyr

### Procedure
This is a readme file to describe the process of transforming two datasets from the Human Activity Recognition Using Smartphones Dataset into only one tidy dataset. To achieve this goal we have go through the following procedure.
First, we load both files from the training set and from the test set. 
```
training_set = read.table("UCI HAR Dataset/train/X_train.txt")
test_set = read.table("UCI HAR Dataset/test/X_test.txt")
```
Then we pull them together into one larger dataset. Given that both dataframes have the same 561 variables. 
```
data_set = rbind(training_set, test_set)
```
Afterwards we load the variable names from the plane text archive called features. Then we use that table to label all of the 561 variables.
```
vars = read.table("UCI HAR Dataset/features.txt")
colnames(data_set) = vars[,2]
```
The next step is to extract only the variables that are requested for the purposes of the project. The ones that are means or standard deviations from any measurement done in this experiment. 
```
data_extract = cbind(mean_cols, std_cols)
```
Later we merge the selected varibales with one more, the activity. This variable specifies the action that was occuring at the same time those measurementes were done.
```
extract_labeled = cbind(data_extract, activity)
```
For the purpose of the project we need a summarised dataset that is tidy as well. That means that for each adtivity we needto have only one observation of each selected variable.
```
tidy_data = extract_labeled %>% group_by(activity) %>% summarise_all(mean)
```
After running that last line of code we will get a tidy data set saved in our object 'tidy_data' as a tibble. Finally we only have to write it in a csv format to save our work.