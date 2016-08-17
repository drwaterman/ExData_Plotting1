plot3 <- function () {
  # Read and parse data from household_power_consumption.txt, then create a 
  # 480x480 png bitmap of 3 line graphs for the 3 Sub metering vectors
  
  # Read the datafile
  power <- read.csv("household_power_consumption.txt", sep=";")
  
  # Parse $Date and $Time ($Date will be redundant, it is part of $Time now)
  power[,"Date"] <- as.Date(power[,"Date"], "%d/%m/%Y")
  power$Time <- strptime(paste(power[,"Date"],power[,"Time"]), format="%Y-%m-%d %T")
  
  # Subset just the 2 days we are interested in
  date1 <- as.Date("2007-02-01")
  date2 <- as.Date("2007-02-02")
  plotdata <- power[power$Date %in% date1:date2,]
  
  # Parse the data we need for this plot
  plotdata[,"Sub_metering_1"] <- as.numeric(as.character(plotdata[,"Sub_metering_1"]))
  plotdata[,"Sub_metering_2"] <- as.numeric(as.character(plotdata[,"Sub_metering_2"]))
  plotdata[,"Sub_metering_3"] <- as.numeric(as.character(plotdata[,"Sub_metering_3"]))
  
  # Open the png file and draw the plot, then close the file
  png("plot3.png")
  yrange <- range(c(plotdata[,"Sub_metering_1"], plotdata[,"Sub_metering_2"], plotdata[,"Sub_metering_3"]))
  plot(plotdata[,"Time"], plotdata[,"Sub_metering_1"], type="l", col="black", xlab="", 
       ylab="Energy Sub Metering", ylim=yrange)
  lines(plotdata[,"Time"], plotdata[,"Sub_metering_2"], type="l", col="red")
  lines(plotdata[,"Time"], plotdata[,"Sub_metering_3"], type="l", col="blue")
  legend("topright", c("Sub_metering_1","Sub_metering_2", "Sub_metering_3"),
         lty=c(1,1), col=c("black", "red","blue")) 
  dev.off()
}