datafile = "data/household_power_consumption.txt"

plot4 <- function(){
    
    # format the date correctly
    # 
    setClass('myDate')
    setAs("character", "myDate", function(from) as.Date(from, format = "%d/%m/%Y"))
    
    # set column types to avoid conversion
    colClasses = c("myDate", "character", "numeric", 
                   "numeric", "numeric", "numeric",
                   "numeric", "numeric", "numeric")
    
    # read data
    pc <- read.table(datafile, header = TRUE, sep = ";", na.strings = "?", colClasses = colClasses)
    # dates we are interested in
    dates = as.Date(c("2007-02-01", "2007-02-02"))
    # subset
    pcdates <- subset(pc, pc$Date %in% dates)
    
    # create date - time
    pcdates$dt <- as.POSIXct(paste(pcdates$Date, pcdates$Time), format = "%Y-%m-%d %H:%M:%S", tz="GMT")
    
    png(filename = "plot4.png")
    
    par(mfrow = c(2,2))
    
    with(pcdates, {
        plot(pcdates$dt, pcdates$Global_active_power, type = 'l', ylab = "Global Active Power (kilowatts)", xlab = "Date Time")
        plot(pcdates$dt, pcdates$Voltage, type = 'l', ylab = "Voltage", xlab = "Date Time")
        
        plot(pcdates$dt, pcdates$Sub_metering_1, type = 'l', ylab = "Energy sub metering", xlab = "Date Time")
        with(pcdates, lines(dt, Sub_metering_2, col=2))
        with(pcdates, lines(dt, Sub_metering_3, col=3))
        legend("topright", lty=1, bty = "n", col = c("black", "red", "green"), legend = c("Sub metering 1", "Sub metering 2", "Sub metering 3"))
        
        plot(pcdates$dt, pcdates$Global_reactive_power, type = 'l', ylab = "Global Reactive Power (kilowatts)", xlab = "Date Time")
    })
    
    dev.off()
}