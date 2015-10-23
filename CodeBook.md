#    CodeBook.md
Bill Hutton 10-23-15

Transformations:

The zip file associated with the assignment 
   https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

was download and expanded to the directory
	c:\\hutton\\r)class_2

For the test data the following 3 files were merged:
	subject_test.txt
	y_test.txt
	X_test.txt

	These where merged into the data frame test_x

	Values in the y_test_activity where merged in the test_x under "subject"
	Values in the y_test_subject  where merged in the test_x under "person"

The training data the followinng 3 files where merged
	subject_train.txt
	y_train.txt
	X_train.txt

	These were merged into the data frame train_x

	Values in the y_train_activity were merged in the train_x under "subject"
	Values in the y_train_subject  were merged in the train_x under "person"

The train_x and test_x where merged into the data frame new_test

The column used for the evaluation where limited to this with "-std" or "-mean" in the title.  The
vector holding the column numbers is col_vector.    Out of the some 530 or so columns there are
79 columns of measurements (plus 2 for key information - person, activity)

The output data frames is df_out.     The columsn are
	Person, Measure and then each of the activities
              "WALKING","WALKING_UPSTAIRS","WALKING_DOWNSTAIRS","SITTING","STANDING","LAYING")	

              The data files contain a number which correspond to a activity.   For example activty 2
              is associated with "WALKING_UPSTAIRS"		

The input file arrive as a zip file which I extracted in the directory r_class_2
