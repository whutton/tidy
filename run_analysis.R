#   run_analysis.R
#   Bill Hutton    10-22-15
#   training data links

############################
#   get col names
############################

col_name <- read.delim("c:\\hutton\\r_class_2\\features.txt",sep="",
	header=FALSE,
    col.names=c("col_number","measure_name"))
col_name_vector <- as.vector(col_name[,2])
col_count <- length(col_name_vector)


############################
#   get subject numbers for each row
#              subject train with have the person associated with each of the event
#              y_train will have the type of activity for each event
############################

y_train_subject <- read.delim("c:\\hutton\\r_class_2\\train\\subject_train.txt")
y_train_activity <- read.delim("c:\\hutton\\r_class_2\\train\\y_train.txt")

train_x <- read.delim("c:\\hutton\\r_class_2\\train\\X_train.txt",
	col.names=col_name_vector,
	sep = "")

y_test_subject <- read.delim("c:\\hutton\\r_class_2\\test\\subject_test.txt")
y_test_activity <- read.delim("c:\\hutton\\r_class_2\\test\\y_test.txt")


for (ctr in 1:nrow(train_x)) {
	train_x$subject[ctr] <- y_train_activity[ctr,1]
	train_x$person[ctr] <- y_train_subject[ctr,1]
}

test_x <- read.delim("c:\\hutton\\r_class_2\\test\\X_test.txt",
      col.names=col_name_vector,
	sep = "")

for (ctr in 1:nrow(test_x)) {
	test_x$subject[ctr] <- y_test_activity[ctr,1]
	test_x$person[ctr] <- y_test_subject[ctr,1]
}


#   add columns for the "key" information

col_name_vector <- append(col_name_vector,"subject")
col_name_vector <- append(col_name_vector,"person")
col_count <- length(col_name_vector)


############################
#   This step will merge all of the data from test and train into a single data frame.
#   Not 100% sure why we are doing this.  If you would want to run this for just training data
#   then change the line to      new_test <- train_x
############################

new_test <- rbind(train_x,test_x)

############################
#   The following logic will look for the words "mean" or "std" in the title of the column.  We will
#   get these column numbers in vector, which we will use to extract the selected columns out of new_test
############################

first_row <- 0
for (i in 1:col_count)
{
	if(grepl("-mean()",col_name_vector[i]    )) {
		if (first_row == 1 ) {
			col_vector <- append(col_vector,i)
		}
		if (first_row == 0 ) {
			col_vector = i
			first_row = 1 
		}
      }
	if(grepl("-std()",col_name_vector[i]   )) {
		if (first_row == 1 ) {
			col_vector <- append(col_vector,i)
		}
		if (first_row == 0 ) {
			col_vector = i
			first_row = 1 
		}
      }

	if(grepl("person",col_name_vector[i]  )) {
		if (first_row == 1 ) {
			col_vector <- append(col_vector,i)
		}
		if (first_row == 0 ) {
			col_vector = i
			first_row = 1 
		}
      }

	if(grepl("subject",col_name_vector[i] )) {
		if (first_row == 1 ) {
			col_vector <- append(col_vector,i)
		}
		if (first_row == 0 ) {
			col_vector = i
			first_row = 1 
		}
      }
}

##############################
#      task_person will get the mean for a given measurement for all users.    If there are 60
#      measurements we want to get, then you would call this 60 times.
##############################

task_person <- function(x) {
	a <- by(new_test[,x],new_test[,c("person","subject")],mean)
}

##############################
#      run thru all of the measures and get a summarize view by person / measure.   In this case
#      we will be applying the function task_person which will calculate the means
##############################


first_time <- 1
df_out <- data.frame(1,2,1,2,3,4,5,6)

for (i in 1:79) {	
	mean_result <- task_person(i)
	num_rows = nrow(mean_result)
	for (row_num in 1:num_rows) {
		t_matrix <- mean_result[row_num,]

		nw <- c(row_num,col_name_vector[i],t_matrix)
		temprow <- matrix(nw)
		newrow <- t(data.frame(temprow))
            colnames(newrow) <- colnames(df_out)
		if (first_time == 0 ) {
			df_out <- rbind(df_out,newrow)
		}		
		if (first_time == 1 ) {
			df_out <- newrow
			first_time <- 0
		}

	}
}

##############################
#   attach some names to the various activites
##############################

colnames(df_out) <- c("Person","Measure","WALKING","WALKING_UPSTAIRS","WALKING_DOWNSTAIRS","SITTING","STANDING","LAYING")



