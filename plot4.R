## Plot the 4 graphs for household electricity consumption for dates 2007-02-01 and 2007-02-02

## Read the power consumption data from the file into elefile. 
## NA is stored as ?. So, na.strings is set to "?"
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
png(filename = "plot4.png")

# Set the number of graphs and margin
par(mfcol=c(2,2),mar=c(5,4,4,4))

#plot1 - Global_active_power vs Date
with(elesub,plot(Global_active_power~Date,type="l",ylab="Global active power",xlab="")) 

#plot2 - Sub-metering vs Date
with(elesub,plot(Sub_metering_1~Date,type="l",ylab="Energy Sub metering",xlab=""))  
with(elesub,points(Sub_metering_2~Date,type="l",col="red"))
with(elesub,points(Sub_metering_3~Date,type="l",col="blue"))

legend("topright",lty=1,col=c("black","red","blue"),
       legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),bty="n",cex=0.8)

#plot3 - Voltage vs Date
with(elesub,plot(Voltage~Date,type="l",ylab="Voltage",xlab="datetime"))

#plot4 - Global_reactive_power vs Date
with(elesub,plot(Global_reactive_power~Date,type="l",ylab="Global_reactive_power",
                 xlab="datetime"))

## close the device
dev.off()

