
#
#   Read in the file.   When I do this, I will also convert the day and
#   time.    The time function though will put in today's date for the date
#   portion.   I will later merge the date / time together in a new column
#   called Combo which will be used for the graphs
#
setClass('mmddyy')
setAs("character","mmddyy",function(from)  as.Date(from,"%d/%m/%Y"))

setClass('clock1')
setAs("character","clock1",function(from) 
      { 
	#format(strptime(from,"%H:%M:%S"), format="%H:%M:%S" )
	strptime(from,"%H:%M:%S")
      }
)

file1 <- read.table("household_power_consumption.txt",sep=";",
			as.is=FALSE,na.strings="?",
			header=TRUE,
                  colClasses=c('mmddyy',
                      'clock1','numeric','numeric',
                      'numeric','numeric','numeric','numeric','numeric')
)

#
#    get a working subset of the data.  This will be the data frame
#    used going forward
#

file2 <- subset (file1, Date >= "2007-02-01" & Date <= "2007-02-02")

#
#    create a list of days that we will have on this graph.   This will be
#    on the lower axis on the finished graph

shortdays <- function(inV) {
	a <- weekdays(inV)
	substring(a,1,3)
}

#
#     add a column to the data frame with the date / time merged together.  This
#     will be the value used for the graph
#
file2 <- cbind(file2,combo=1)

timeadd <- function(inRow) {
   as.POSIXct(strptime(sprintf("%s-%s",
            format(file2[inRow,1],"%m/%d/%Y"),
            format(file2[inRow,2],"%H:%M:%S") ),
      "%m/%d/%Y-%H:%M:%S"))
}

total_rows <- nrow(file2)
for(i in 1:total_rows ) {
	file2[i,"combo"] = timeadd(i)
}

#
#    get a list of all of the days in the data frame.  I then add
#    1 at the end to complete the range.
#
dd1 <- c(unique(file2$Date),max(file2$Date)+1)
dayVector <- as.vector(sapply(dd1,shortdays))

#   get middle point in date range.   This will be used on the x
#   axis on the graph

secondDate <- subset (file2, Date == "2007-02-02")

#
#    create the graph
#
png(file="plot3.png", bg = "transparent")

plot( file2$combo, file2$Sub_metering_1, type = "l",
	xaxt="n",
	yaxt="n",
	ann=FALSE )

points(file2$combo, file2$Sub_metering_2, col="red",type="l")
points(file2$combo, file2$Sub_metering_3, col="blue",type="l")
legend("topright", col=c("black","red","blue"),  lty=c(1,1),
    legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3")
    )

title(ylab="Engergy sub metering")
axis(2, las=1, at=10*0:g_range[2])

v1 <- c(min(file2$combo),secondDate[1,"combo"],max(file2$combo))
axis(side=1,at=v1,labels=dayVector)

dev.off()

