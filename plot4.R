library(lubridate)
#Reading the data
dt <- read.table("household_power_consumption.txt", stringsAsFactors = FALSE, 
                 sep = ";", header = TRUE, na.strings = "?"
)
#Convering "Date" column from char to date format
dt[, "Date"] <- as.Date(dt[, "Date"], "%d/%m/%Y") 

#Subsetting the rows that fall between the two dates
startdate <- as.Date("2007-02-01")
enddate <- as.Date("2007-02-02")
s_dt <- subset(dt, Date>=startdate & Date<= enddate)

#Creating the fifth column that has the full date & time data
s_dt$fulldate<-s_dt$Date
hour(s_dt$fulldate)<-hour(strptime(s_dt$Time, "%H:%M:%S"))
minute(s_dt$fulldate)<-minute(strptime(s_dt$Time, "%H:%M:%S"))
second(s_dt$fulldate)<-second(strptime(s_dt$Time, "%H:%M:%S"))

##########PLOT4
png(file="plot4.png")
par(mfrow=c(2,2))

##1
wkdays<-weekdays((s_dt$fulldate))
with(s_dt, plot(y=Global_active_power, x=fulldate, type="l", ylab="Global Active Power",
                xlab=""))

##2
with(s_dt, plot(y=Voltage, x=fulldate, type="l", ylab="Voltage",
                xlab="datetime"))
##3
with(s_dt,plot(y=Sub_metering_1, x=fulldate, type="n", 
               ylab="Energy sub by metering", xlab = "", main="")) 
with(s_dt, lines(y=Sub_metering_1, x=fulldate, col="black"))  
with(s_dt, lines(y=Sub_metering_2, x=fulldate, col="red"))
with(s_dt, lines(y=Sub_metering_3, x=fulldate, col="blue"))
legend("toprigh", pch="_", col=c("black", "red", "blue"), 
       legend=c("Sub_metering_1", "Sub_metering_2","Sub_metering_3") )
##4
with(s_dt, plot(y=Global_reactive_power, x=fulldate, type="l", ylab="Globa_reactive_power",
                xlab="datetime"))

dev.off()
