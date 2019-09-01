## Plot Energy sub-metering for the dates 2007-02-01 and 2007-02-02

## Read the power consumption data from the file into elefile. 
##  NA is stored as ?. So, na.strings is set to "?"
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
png(filename = "plot3.png")

# plot the sub_metering_1 and add labels
# Add the sub_metering_2 and sub_metering_3 with relevant colors
# Add legend
with(elesub,plot(Sub_metering_1~Date,type="l",ylab="Energy Sub metering",xlab=""))

with(elesub,points(Sub_metering_2~Date,type="l",col="red"))

with(elesub,points(Sub_metering_3~Date,type="l",col="blue"))

legend("topright",lty=1,col=c("black","red","blue"),
       legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))

## close the device
dev.off()

