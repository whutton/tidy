
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
file2 <- subset (file1, Date >= "2007-02-01" & Date <= "2007-02-02")

#    plot 1

png(file="plot1.png", bg = "transparent")
hist(file2$Global_active_power, col="red" ,
            main="Global Active Power", 
            xlab="Global Active Power (kilowatts)")
dev.off()



