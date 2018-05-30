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

# create plot 2
# with time as days
local <- Sys.getlocale("LC_TIME")
Sys.setlocale("LC_TIME", "en_US")
png(filename = "plot2.png")
with(consumptionSet, plot(Time,Global_active_power, 
                          type="l",
                          xlab = "",
                          ylab = "Global Active Power (kilowatts)"))
dev.off()
Sys.setlocale("LC_TIME", local)
