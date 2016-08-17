plot1 <- function () {
  # Read and parse data from household_power_consumption.txt, then create a 
  # 480x480 png bitmap of a histogram for Global Active Power (kW) in red with
  # 12 bars
  
  # Read the datafile
  power <- read.csv("household_power_consumption.txt", sep=";")
  
  # Parse $Date and $Time ($Date is now redundant, it is stored in $Time)
  power[,"Date"] <- as.Date(power[,"Date"], "%d/%m/%Y")
  power$Time <- strptime(paste(power[,"Date"],power[,"Time"]), format="%Y-%m-%d %T")
  
  # Subset the 2 days of interest
  date1 <- as.Date("2007-02-01")
  date2 <- as.Date("2007-02-02")
  plotdata <- power[power$Date %in% date1:date2,]
  
  # Parse the data needed for this plot
  plotdata[,"Global_active_power"] <- as.numeric(as.character(plotdata[,"Global_active_power"]))
  
  # Open the png file, draw the plot, and close the file
  png("plot1.png")
  hist(plotdata$Global_active_power, col="red", main="Global Active Power", 
       xlab="Global Active Power (kilowatts)", breaks=12)
  dev.off()
}