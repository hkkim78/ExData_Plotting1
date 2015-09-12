# plot4.R

# Download household_power_consumption.zip and unzip it, unless it exists
if (!file.exists("./data/household_power_consumption.txt")) {
    # Make a sub-folder "data", unless it exists
    if (!dir.exists("./data")) {
        dir.create("./data")
    }
    url = "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
    download.file(url, destfile="./data/household_power_consumption.zip")
    unzip("./data/household_power_consumption.zip", exdir = "./data")
}

# select data from the dates 2007-02-01 and 2007-02-02
data <- read.table("./data/household_power_consumption.txt", header=TRUE, sep=";", na="?")
data$Date <- as.Date(data$Date, "%d/%m/%Y")
selectedData <- subset(data, (Date=="2007-02-01" | Date=="2007-02-02"))

# reformat 'Time' column from 'HH:MM:SS' to 'YYYY-MM-DD HH:MM:SS' 
selectedData$Time <- strptime(paste(selectedData$Date, selectedData$Time), "%Y-%m-%d %H:%M:%S")

png("plot4.png", width=480, height=480)
par(mfrow = c(2,2))
# top - left
plot(selectedData$Time, selectedData$Global_active_power,
        type="l",
        xlab="",
        ylab="Global Active Power"
)
# top - right
plot(selectedData$Time, selectedData$Voltage,
        type="l",
        xlab="datetime",
        ylab="Voltage"
)
# bottom - left
plot(selectedData$Time, selectedData$Sub_metering_1, 
        type="l",
        xlab="", 
        ylab="Energy sub metering",
        col="black" )
    lines(selectedData$Time, selectedData$Sub_metering_2, col="red")
    lines(selectedData$Time, selectedData$Sub_metering_3, col="blue")
    legend("topright", 
           legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
           col = c("black", "red", "blue"), lty=1, bty="n" )
# bottom - right
plot(selectedData$Time, selectedData$Global_reactive_power,
        type="l",
        xlab="datetime",
        ylab="Global_reactive_power" )

dev.off()
