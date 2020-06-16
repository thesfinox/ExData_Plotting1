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

# PLOT 4: 4 plots with sub metering, voltage and reactive power
############################################################################
par(mfrow = c(2,2), mar=c(4,4,2,1), oma=c(0,0,2,0))
with(data, {plot(Global_active_power ~ Full.Date, type = "l", ylab = "Global Active Power", xlab = "", cex = 0.7)
            plot(Voltage ~ Full.Date, type = "l", ylab = "Voltage", xlab = "datetime", cex = 0.7)
            plot(Sub_metering_1 ~ Full.Date, type = "l", ylab = "Energy sub metering", xlab = "", cex = 0.7)
            lines(Sub_metering_2 ~ Full.Date, col = "red")
            lines(Sub_metering_3 ~ Full.Date, col = "blue")
            legend("topright",
                   col = c("black", "red", "blue"),
                   lty = 1,
                   lwd = 1,
                   bty = "n",
                   pt.cex = 1,
                   cex = 0.7,
                   legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
            plot(Global_reactive_power ~ Full.Date, type = "l", xlab = "", cex = 0.7)
    }
    )
dev.copy(png, file = "plot4.png", width = 480, height = 480)
dev.off()



