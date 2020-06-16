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

# PLOT 1: Global Active Power (kW) vs Frequency
############################################################################
png(file = "plot1.png", width = 480, height = 480)
with(data, hist(Global_active_power,
                col = "red",
                xlab = "Global Active Power (kilowatts)",
                ylab = "Frequency",
                main = "Global Active Power"
               )
    )
dev.off()
