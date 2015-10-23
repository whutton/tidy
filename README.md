#    README.md
Bill Hutton 10-22-15

The input file arrive as a zip file which I extracted in the directory r_class_2

The files were merged the X_train.txt to the subject_train.txt and y_train.txt file.  A 
similar operation with performed on the test data  ( X_test.txt, subject_test.txt , y_test.txt )

The instructions called for these 2 to be merge.   The layout of the 2 data frames was identical so
this wasn't an issue.  I just wasn't sure why the test and train datasets were merge.   If you need to
change this then the following command
	new_test <- rbind(train_x,test_x)
Can be changed to
	new_text <- train_x   ( for example)

Measures that were to be evaluated

Overall there were 563 unique measurements in the results table (col_count)  This was reduced to 79 
by looking for "std" or "mean" in the title of the measure.    The program created a matrix of the
measures that were to be evaluated.  This resulted in the vector col_vector which has the 79 measures and
then key information of person and subject

Evaluation of a measure

The function task_person is the method used to evaulate a given measure and come up with a mean of the 
values.    This functionn returns a data frame that has 1 row for each person (in this case 30) and 1
column for each activity (6)

There is a loop that will process over all of the measures (79) and call the function task_person for each
measures.   The results are summarizzed in the table df_out.

df_out will have 1 row for a person / measure / activity.   So if there are 79 different measures then there will
be 79 rows for a given person.   In this case 2,370 total rows



df_out is the sannitized data frame

This was written to the output file using   
	write.table(df_out,file="...\\wh_tidy.txt", row.names=FALSE)
	


