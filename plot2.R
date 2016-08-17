plot2 <- function () {
  # Read and parse data from household_power_consumption.txt, then create a 
  # 480x480 png bitmap of a line graph for Global Active Power (kW) 
  
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
  plotdata[,"Global_active_power"] <- as.numeric(
                                      as.character(plotdata[,"Global_active_power"]))
  
  # Open the png file and draw the plot, then close the file
  png("plot2.png")
  plot(plotdata[,"Time"], plotdata[,"Global_active_power"], type="l", xlab="", 
       ylab="Global Active Power (kilowatts)")
  dev.off()
}