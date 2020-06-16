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

# PLOT 2: Day of the week vs global active power (kW)
############################################################################
png(file = "plot2.png", width = 480, height = 480)
with(data, plot(Global_active_power ~ Full.Date,
                type = "l",
                ylab = "Global Active Power (kilowatts)",
                xlab = ""
               )
    )
dev.off()

