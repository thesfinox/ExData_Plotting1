library(data.table)

# download the file and unzip it
url     <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
outfile <- "power_consumption.zip"

if(!file.exists(outfile)) {
    download.file(url, outfile, method = "curl")
    unzip(outfile)
}

# read the table
txt_dat <- "household_power_consumption.txt"
data    <- fread(txt_dat, stringsAsFactors = FALSE, na.strings = "?")
data    <- data[(data$Date == "1/2/2007" | data$Date == "2/2/2007"),]

# convert to date class
data$Date      <- as.Date(data$Date, format = "%d/%m/%Y")
data$Full.Date <- as.POSIXct(paste(data$Date, data$Time))

# PLOT 3: Day of the week vs sub metering
############################################################################
png(file = "plot3.png", width = 480, height = 480)
with(data, {plot(Sub_metering_1 ~ Full.Date, type = "l", ylab = "Energy sub metering", xlab = "")
            lines(Sub_metering_2 ~ Full.Date, col = "red")
            lines(Sub_metering_3 ~ Full.Date, col = "blue")
    }
    )
legend("topright",
       col = c("black", "red", "blue"),
       lty = 1,
       lwd = 1,
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
dev.off()


