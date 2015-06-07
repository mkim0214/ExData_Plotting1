power.txt <- read.table("household_power_consumption_02_2007.txt", header=T, sep=";")
power.txt$Date <- as.Date(power.txt$Date, format="%d/%m/%Y")
feb_pwr <- subset(power.txt, Date >= "2007-02-01" & Date <= "2007-02-02")
meter1 <- as.numeric(feb_pwr$Sub_metering_1)
meter2 <- as.numeric(feb_pwr$Sub_metering_2)
meter3 <- as.numeric(feb_pwr$Sub_metering_3)
feb_time <- paste(feb_pwr$Date, feb_pwr$Time)
png(filename="plot3.png", width=480, height=480, units="px")

meter1 <- replace(meter1, meter1==14, 4)
meter1 <- meter1 - 2
meter2 <- replace(meter2, meter2==14, 4)
meter2 <- meter2 - 2
plot(strptime(feb_time,"%Y-%m-%d %H:%M:%S"), meter1, type="n", yaxt="n", ylab="Energy sub metering", xlab="")

lines(strptime(feb_time,"%Y-%m-%d %H:%M:%S"), meter1)

lines(strptime(feb_time,"%Y-%m-%d %H:%M:%S"), meter2, col="red")

lines(strptime(feb_time,"%Y-%m-%d %H:%M:%S"), meter3, col="blue")
axis(2, at=c(0,10,20,30))
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty=c(1,1,1), lwd=c(1,1,1), col=c("black", "red","blue"), cex=0.8)
dev.off()