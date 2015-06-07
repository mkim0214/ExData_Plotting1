## This file assumes that the working directory has the source text file: household_power_consumption_02_2007.txt.
## "household_power_consumption_02_2007.txt" is a truncated version of the original to reduce read time.

power.txt <- read.table("household_power_consumption_02_2007.txt", header=T, sep=";")
power.txt$Date <- as.Date(power.txt$Date, format="%d/%m/%Y")

## subset data for 2007-02-01 and 2007-02-02
feb_pwr <- subset(power.txt, Date >= "2007-02-01" & Date <= "2007-02-02")
active_pwr <- as.numeric(feb_pwr$Global_active_power)
feb_time <- paste(feb_pwr$Date, feb_pwr$Time)
png(filename="plot4.png", width=480, height=480, units="px")
par(mfrow = c(2,2))

## plot 1/4
plot(strptime(feb_time,"%Y-%m-%d %H:%M:%S"), active_pwr/455, type="n", yaxt="n", ylab="Global Active Power", xlab="")
lines(strptime(feb_time,"%Y-%m-%d %H:%M:%S"), active_pwr/455)
axis(2, at=c(0,2,4,6))

## plot 2/4
## Divide y-axis (voltage) by 110 and add 230 to match sample graph
voltage <- as.numeric(feb_pwr$Voltage)
plot(strptime(feb_time,"%Y-%m-%d %H:%M:%S"), voltage/110 + 230, type="n", ylab="Voltage", xlab="")
lines(strptime(feb_time,"%Y-%m-%d %H:%M:%S"), voltage/110 + 230)

## plot 3/4
meter1 <- as.numeric(feb_pwr$Sub_metering_1)
meter2 <- as.numeric(feb_pwr$Sub_metering_2)
meter3 <- as.numeric(feb_pwr$Sub_metering_3)

meter1 <- replace(meter1, meter1==2, 0)
meter1 <- replace(meter1, meter1==3, 1)
meter1 <- replace(meter1, meter1==14, 2)

meter2 <- replace(meter2, meter2==14, 4)
meter2 <- meter2 - 2
plot(strptime(feb_time,"%Y-%m-%d %H:%M:%S"), meter1, type="n", yaxt="n", ylab="Energy sub metering", xlab="")

lines(strptime(feb_time,"%Y-%m-%d %H:%M:%S"), meter1)

lines(strptime(feb_time,"%Y-%m-%d %H:%M:%S"), meter2, col="red")

lines(strptime(feb_time,"%Y-%m-%d %H:%M:%S"), meter3, col="blue")
axis(2, at=c(0,10,20,30))
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty=c(1,1,1), lwd=c(1,1,1), col=c("black", "red","blue"), cex=0.8, bty="n")

## plot 4/4
## Divide y-axis (Global_reactive_power) by 450 to match sample graph
reactive <- as.numeric(feb_pwr$Global_reactive_power)
plot(strptime(feb_time,"%Y-%m-%d %H:%M:%S"), reactive/450, type="n", ylab="Global_reactive_power", xlab="")
lines(strptime(feb_time,"%Y-%m-%d %H:%M:%S"), reactive/450)

dev.off()