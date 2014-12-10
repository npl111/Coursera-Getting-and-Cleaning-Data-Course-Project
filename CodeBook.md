Process:

	Read Test and Training Data in to 6 separated tables (3 test and 3 train)

	Rename the Y Variables in each "y" data tables to "Activity" as it represents the activity that needs to be predicted/identified in an eventual model

	Combine the test and training data in to one data set (down to three tables)

	Extract only the features that are realted to mean and standard deviation by finding these in the features data file and then renaming the data with the names of these features

	Name the activities by linking to the activity name file

	Combine the three tables and name the collumns

	Create and output tidy data set with the average of each variable for each activity and each subject

Final Data Set Variables:

	The final data set contains four collumns of data (Activity, Subject, Variable, x)

	Activity = the type of Activity that the Subject is engaging when measurement is taken

	Subject = the person that is performing the activity

	Variable = the particular measurement type that is taken for the specific subject and activity

	X = the measurement itself which is actually the mean of numerous measurements taken for that subject, activity and measurement type




