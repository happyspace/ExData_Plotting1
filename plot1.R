

datafile = "data/household_power_consumption.txt"

plot1 <- function(){
    
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
    
    png(filename = "plot1.png")
    hist(pcdates$Global_active_power, col = "red", main = "Global Active Power", xlab = "Global Active Power (kilowatts)")
    dev.off()
    
    
}