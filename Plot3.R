# Plot1.R
# Loading dataset
fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"

# Preliminary class of data for extraction. Date & times will be converted after
dataClass <- c("character","character",
               "numeric","numeric","numeric","numeric","numeric","numeric","numeric")

temp <- tempfile()
download.file(fileUrl,temp)
consumptionData <- read.table(unz(temp,"household_power_consumption.txt"),
                              sep=";",
                              header = TRUE, 
                              na.strings = "?",
                              colClasses =dataClass)
unlink(temp)
# subset only the relevant days
consumptionSet <- with(consumptionData, subset(consumptionData,Date=="1/2/2007" | Date=="2/2/2007"))
# convert date & times format
consumptionSet$Time <- strptime(paste(consumptionSet$Date,consumptionSet$Time),
                                format = "%d/%m/%Y %H:%M:%S")
consumptionSet$Date <- as.Date(consumptionSet$Date,
                               format="%d/%m/%Y")

# create plot 3
local <- Sys.getlocale("LC_TIME")
Sys.setlocale("LC_TIME", "en_US")
png("plot3.png")
color <- c("black","red","blue")
with(consumptionSet, plot(Time,Sub_metering_1, 
                          type="n",
                          xlab = "",
                          ylab = "Energy sub metering"))
with(consumptionSet, lines(Time,Sub_metering_1, col=color[1]))
with(consumptionSet, lines(Time,Sub_metering_2, col=color[2]))
with(consumptionSet, lines(Time,Sub_metering_3,col=color[3]))
legend("topright",col=color,lty=1,legend = names(consumptionSet)[7:9])
dev.off()
Sys.setlocale("LC_TIME", local)
