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

###########PLOT2
png(file="plot2.png")
wkdays<-weekdays((s_dt$fulldate))
with(s_dt, plot(y=Global_active_power, x=fulldate, type="l", ylab="Global Active Power (kilowatts)",
                xlab=""))

dev.off()
