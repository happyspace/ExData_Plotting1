datafile = "data/household_power_consumption.txt"

plot2 <- function(){
    
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
    
    
    png(filename = "plot2.png")
    plot(pcdates$dt, pcdates$Global_active_power, type = 'l', ylab = "Global Active Power (kilowatts)", xlab = "")
    dev.off()
}