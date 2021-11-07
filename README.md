# ProjectAssignment3
## Description
The flow of the script follows the tasks that must be carried out in the assigment.
### 1. Merging test and train sets
Subjects, activities and feature observations are loaded in several data.frames and then merged with merge()
### 2. Extract only mean and std features
Combine grepl and select to get only the desired features
### 3. Use descriptive activity names
The activity column is factorized using the information in "activity_labels.txt"
### 4. Label de data set with descriptive names
With the information in "features.txt" and using make.names() to avoid duplicated
### 5. Summarize
Combining group_by() and summarise_all()
