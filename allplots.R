library(readr)
library(dplyr)

power <- read_csv2("data/power.zip")
names(power)<-make.names(names(power))

power <- mutate(power, Date = as.Date(Date,format = "%d/%m/%Y"))
power$Time <- strptime (paste(power$Date,power$Time),format = "%Y-%m-%d %H:%M:%S")

powerfeb <- power[power$Date < "2007-02-03", ]
powerfeb <- powerfeb[powerfeb$Date > "2007-01-31", ]

# powerfeb <- filter(power,Date < "2007-02-03") %>% filter(Date > "2007-01-31")


png(filename = "plot1.png", width = 480, height = 480)
hist(powerfeb$Global_active_power,col = "red",xlab = "Global Active Power (kilowatts)",
     ylab="Frequency", main = "Global Active Power")
dev.off()

png(filename = "plot2.png", width = 480, height = 480)
plot(x = powerfeb$Time,y = powerfeb$Global_active_power,data = powerfeb,type = "line",
     xlab="",ylab="Global Active Power (kilowatts)")
dev.off()

png(filename = "plot3.png", width = 480, height = 480)
plot(x = powerfeb$Time,y = powerfeb$Sub_metering_1,data = powerfeb,type = "line",
     xlab="",ylab="Energy sub metering")
lines(x = powerfeb$Time,y = powerfeb$Sub_metering_2,col = "red")
lines(x = powerfeb$Time,y = powerfeb$Sub_metering_3,col = "blue")
legend("topright",legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),lty=1,col = c("black","blue","red"))
dev.off()


#combine plots
png(filename = "plot4.png", width = 480, height = 480)
par(mfrow=c(2,2))

plot(x = powerfeb$Time,y = powerfeb$Global_active_power,data = powerfeb,type = "line",
     xlab="",ylab="Global Active Power")

plot(x = powerfeb$Time,y = powerfeb$Voltage,data = powerfeb,type = "line",
     xlab="datetime",ylab="Voltage")

plot(x = powerfeb$Time,y = powerfeb$Sub_metering_1,data = powerfeb,type = "line",
     xlab="",ylab="Energy sub metering")
lines(x = powerfeb$Time,y = powerfeb$Sub_metering_2,col = "red")
lines(x = powerfeb$Time,y = powerfeb$Sub_metering_3,col = "blue")
legend("topright",legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),lty=1,col = c("black","blue","red"))

plot(x = powerfeb$Time,y = powerfeb$Global_reactive_power,data = powerfeb,type = "line",
     xlab="datetime",ylab="Global_reactive_power")
dev.off()
