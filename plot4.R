plot4 <- function () {
  # Read and parse data from household_power_consumption.txt, then create a 
  # 480x480 png bitmap of 4 separate plots in a 2x2 layout.
  
  
  # First read the data file
  power <- read.csv("household_power_consumption.txt", sep=";")
  
  ## Parse the date and time 
  ## (after this $Date is redundant because $Time also stores the date)
  power[,"Date"] <- as.Date(power[,"Date"], "%d/%m/%Y")
  power$Time <- strptime(paste(power[,"Date"],power[,"Time"]), format="%Y-%m-%d %T")
  date1 <- as.Date("2007-02-01")
  date2 <- as.Date("2007-02-02")
  plotdata <- power[power$Date %in% date1:date2,]
  
  ## Parse the Y variable data for each of the 4 plots
  plotdata[,"Global_active_power"] <- as.numeric(as.character(plotdata[,"Global_active_power"]))
  
  plotdata[,"Sub_metering_1"] <- as.numeric(as.character(plotdata[,"Sub_metering_1"]))
  plotdata[,"Sub_metering_2"] <- as.numeric(as.character(plotdata[,"Sub_metering_2"]))
  plotdata[,"Sub_metering_3"] <- as.numeric(as.character(plotdata[,"Sub_metering_3"]))
  
  plotdata[,"Global_reactive_power"] <- as.numeric(as.character(plotdata[,"Global_reactive_power"]))
  
  plotdata[,"Voltage"] <- as.numeric(as.character(plotdata[,"Voltage"]))
  
  
  ## Now configure the plotting area
  png("plot4.png")
  par(mfrow=c(2,2))
  attach(plotdata)
  
  ## Plot the top left
  plot(Time, Global_active_power, type="l", xlab="", 
       ylab="Global Active Power (kilowatts)")
  
  ## Plot the top right
  plot(Time, Voltage, type="l", xlab="datetime")
  
  ## Plot the bottom left
  yrange <- range(c(Sub_metering_1, Sub_metering_2, Sub_metering_3))
  plot(Time, Sub_metering_1, type="l", col="black", xlab="", 
       ylab="Energy Sub Metering", ylim=yrange)
  
  lines(Time, Sub_metering_2, type="l", col="red")
  lines(Time, Sub_metering_3, type="l", col="blue")
  legend("topright", c("Sub_metering_1","Sub_metering_2", "Sub_metering_3"),
         lty=c(1,1), col=c("black", "red","blue")) 
  
  ## Plot the bottom right
  plot(Time, Global_reactive_power, type="l", xlab="datetime")
  
  
  ## Close the bitmap file
  dev.off()
  detach(plotdata)
}