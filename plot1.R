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
png(file="plot1.png",width=480,height=480)

## Frequency of Global Active Power over two days
hist(as.numeric(plot_data$Global_active_power),breaks=round(max(as.numeric(plot_data$Global_active_power))+0.5)*2,freq=TRUE,col="red",main ="Global Active Power",xlab="Global Active Power (kilowatts)")

## close png device
dev.off()
