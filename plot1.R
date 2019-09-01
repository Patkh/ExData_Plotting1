## Plot an histogram for Global Active Power (kilowatts)
## for the dates 2007-02-01 and 2007-02-02

## Read the power consumption data from the file into elefile. NA is stored as ?. So, na.strings
## is set to "?"
elefile <-read.table("household_power_consumption.txt",header=TRUE, sep=";",na.strings="?");

## Modify the table so that the date and time portions are part of the same Date column
## as POSIXct type
elefile <- transform(elefile, Date=as.POSIXct(with(elefile, paste(Date, Time)), 
                                              format ="%d/%m/%Y %H:%M:%S"))

##set date varibales 
dt1 <- as.POSIXct("2007-02-01 00:00:00",format = "%Y-%m-%d %H:%M:%S")
dt2 <- as.POSIXct("2007-02-03 00:00:00",format = "%Y-%m-%d %H:%M:%S")

## Create a subset of the data for the date range
elesub <- subset(elefile, Date >=  dt1 & Date < dt2)

## plot the histogram and write to PNG file
## default width and height of 480x480 is enough
png(filename = "plot1.png")
hist(elesub$Global_active_power, col="red", xlab="Global Active Power (kilowatts)", 
     main = "Global Active Power");
## close the device
dev.off()

