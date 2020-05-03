#setwd and load lubridate
        setwd("Documents/GitHub/ExData_Plotting1/")
        library(lubridate)
        pwr = file("~/Documents/Exploratory Data Analysis/household_power_consumption.txt")
        
#Prepare datset
##read in table
        pwrcon = as.data.frame(read.table(pwr, header = TRUE, sep = ";", stringsAsFactors = FALSE))
##select smaller dataset to work with 
        pwrcon1 =pwrcon[pwrcon$Date == "1/2/2007",]
        pwrcon2 =pwrcon[pwrcon$Date == "2/2/2007",]
        pwrcon = rbind(pwrcon1,pwrcon2)
##check that data being plotted is numeric and change to numeric if necessary
        class(pwrcon$Global_active_power)
        pwrcon$Global_active_power = as.numeric(pwrcon$Global_active_power)
        class(pwrcon$Global_reactive_power)
        pwrcon$Global_reactive_power = as.numeric(pwrcon$Global_reactive_power)
        class(pwrcon$Voltage)
        pwrcon$Voltage = as.numeric(pwrcon$Voltage)
        class(pwrcon$Sub_metering_1)
        pwrcon$Sub_metering_1 = as.numeric(pwrcon$Sub_metering_1)
        pwrcon$Sub_metering_2 = as.numeric(pwrcon$Sub_metering_2)
        pwrcon$Sub_metering_3 = as.numeric(pwrcon$Sub_metering_3)
##change the format of the date and time column to be usable by R
        pwrcon$Date2 = dmy(pwrcon$Date)#this rearranges the order of year, day and month to POSIXct order
        pwrcon$Day = weekdays(pwrcon$Date2)#this is actually not needed for the assignment
##build the combined date-time column for converting to POSIXct format
        pwrcon$Date_hms = paste(pwrcon$Date2, pwrcon$Time)
        pwrcon$Date_hms = ymd_hms(pwrcon$Date_hms)
##check that we have the right format
        class(pwrcon$Date_hms)

##create plot
        with(pwrcon, plot(Date_hms, Sub_metering_1, ylab = "Energy sub metering", xlab = "", type = "n"))
        lines(pwrcon$Date_hms,pwrcon$Sub_metering_1)
        lines(pwrcon$Date_hms,pwrcon$Sub_metering_2, col = "red")
        lines(pwrcon$Date_hms,pwrcon$Sub_metering_3, col = "blue")
        legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty = c(1,1,1), lwd = c(1,1,1), col = c("black", "red", "blue"))

##open png connection
        png(filename = "plot3.png", width = 480, height = 480)
##create plots
        with(pwrcon, plot(Date_hms, Sub_metering_1, ylab = "Energy sub metering", xlab = "", type = "n"))
        lines(pwrcon$Date_hms,pwrcon$Sub_metering_1)
        lines(pwrcon$Date_hms,pwrcon$Sub_metering_2, col = "red")
        lines(pwrcon$Date_hms,pwrcon$Sub_metering_3, col = "blue")
        legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty = c(1,1,1), lwd = c(1,1,1), col = c("black", "red", "blue"))
##turn device off
        dev.off()
        