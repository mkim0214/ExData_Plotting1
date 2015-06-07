## This file assumes that the working directory has the source text file: household_power_consumption_02_2007.txt.
## "household_power_consumption_02_2007.txt" is a truncated version of the original to reduce read time.

power.txt <- read.table("household_power_consumption_02_2007.txt", header=T, sep=";")
power.txt$Date <- as.Date(power.txt$Date, format="%d/%m/%Y")

## subset data for 2007-02-01 and 2007-02-02
feb_pwr <- subset(power.txt, Date >= "2007-02-01" & Date <= "2007-02-02")
active_pwr <- as.numeric(feb_pwr$Global_active_power)
png(filename="plot1.png", width=480, height=480, units="px")

## Divide x-axis (active_pwr) by 455 to match sample graph
hist(active_pwr/455, xaxt="n", yaxt="n", main="Global Active Power", xlab="Global Active Power (kilowatts)", col="red")
axis(1, at=c(0,2,4,6))
axis(2, at=c(0,200,400,600,800,1000,1200))
dev.off()