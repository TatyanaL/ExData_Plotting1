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

########### PLOT1
png(file="plot1.png")

with(s_dt, hist(Global_active_power, xlab="Global Active Power (kilowatts)", 
                ylab="Frequency", col="red", main="Global Active Power"))
dev.off()
