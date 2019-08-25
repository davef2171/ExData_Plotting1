library(data.table)

## Do we have a local copy of source data?
if( !file.exists("household_power_consumption.txt")) {
  
  ## do we have the source zip?
  if( !file.exists("exdata_data_household_power_consumption.zip")){
    
    ## get source zip
    download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip","exdata_data_household_power_consumption.zip",quiet=TRUE)
    ## don't have any options on error so don't check
  }
  
  ## unzip
  unzip("exdata_data_household_power_consumption.zip")
}

## Read Source Data
ep_data <- fread("household_power_consumption.txt")

## Extract Data to Plot
plot_data <- subset( ep_data, as.Date(Date,"%d/%m/%Y") == as.Date("2007-02-01") | as.Date(Date,"%d/%m/%Y") == as.Date("2007-02-02"))

## Tidy memory
rm(ep_data)

## open png device
png(file="plot4.png",width=480,height=480)
## setup for 2x2 plots by column in png file
par(mfcol=c(2,2))

##Plot 1 Global Active Power Samples
plot(c(1:length(plot_data$Global_active_power)),as.numeric(plot_data$Global_active_power),type="n",xlab="",ylab="Global Active Power",xaxt="n")
axis(1, at=c(0,1440,2880),labels=c("Thu","Fri","Sat"))
lines(c(1:length(plot_data$Global_active_power)),as.numeric(plot_data$Global_active_power))

## Plot 2 Sub-meter samples over the two days
plot(c(1:length(plot_data$Sub_metering_1)),as.numeric(plot_data$Sub_metering_1),type="n",xlab="",ylab="Energy sub metering",xaxt="n")
axis(1, at=c(0,1440,2880),labels=c("Thu","Fri","Sat"))
legend("topright", c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),col=c("black","red","blue"), lty=1,bty="n")
lines(c(1:length(plot_data$Sub_metering_1)),as.numeric(plot_data$Sub_metering_1),col="black")
lines(c(1:length(plot_data$Sub_metering_2)),as.numeric(plot_data$Sub_metering_2),col="red")
lines(c(1:length(plot_data$Sub_metering_3)),as.numeric(plot_data$Sub_metering_3),col="blue")

##Plot 3 Voltage Samples
plot(c(1:length(plot_data$Voltage)),as.numeric(plot_data$Voltage),type="n",xlab="datetime",ylab="Voltage",xaxt="n")
axis(1, at=c(0,1440,2880),labels=c("Thu","Fri","Sat"))
lines(c(1:length(plot_data$Voltage)),as.numeric(plot_data$Voltage))

##Plot 4 Global Reactive Power Samples
plot(c(1:length(plot_data$Global_reactive_power)),as.numeric(plot_data$Global_reactive_power),type="n",xlab="datetime",ylab="Global_reactive_power", xaxt="n")
axis(1, at=c(0,1440,2880),labels=c("Thu","Fri","Sat"))
lines(c(1:length(plot_data$Global_reactive_power)),as.numeric(plot_data$Global_reactive_power))

## Close png device
dev.off()