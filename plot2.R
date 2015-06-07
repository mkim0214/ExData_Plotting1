## This file assumes that the working directory has the source text file: household_power_consumption_02_2007.txt.
## "household_power_consumption_02_2007.txt" is a truncated version of the original to reduce read time.

power.txt <- read.table("household_power_consumption_02_2007.txt", header=T, sep=";")
power.txt$Date <- as.Date(power.txt$Date, format="%d/%m/%Y")

## subset data for 2007-02-01 and 2007-02-02
feb_pwr <- subset(power.txt, Date >= "2007-02-01" & Date <= "2007-02-02")
active_pwr <- as.numeric(feb_pwr$Global_active_power)
feb_time <- paste(feb_pwr$Date, feb_pwr$Time)
png(filename="plot2.png", width=480, height=480, units="px")

## Divide y-axis (active_pwr) by 425 to match sample graph
plot(strptime(feb_time,"%Y-%m-%d %H:%M:%S"), active_pwr/455, type="n", yaxt="n", ylab="Global Active Power (kilowatts)", xlab="")
lines(strptime(feb_time,"%Y-%m-%d %H:%M:%S"), active_pwr/455)
axis(2, at=c(0,2,4,6))
dev.off()