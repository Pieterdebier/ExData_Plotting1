library(readr)
library(dplyr)

power <- read_csv2("data/power.zip")
names(power)<-make.names(names(power))

power <- mutate(power, Date = as.Date(Date,format = "%d/%m/%Y"))
power$Time <- strptime (paste(power$Date,power$Time),format = "%Y-%m-%d %H:%M:%S")

powerfeb <- power[power$Date < "2007-02-03", ]
powerfeb <- powerfeb[powerfeb$Date > "2007-01-31", ]

png(filename = "plot1.png", width = 480, height = 480)
hist(powerfeb$Global_active_power,col = "red",xlab = "Global Active Power (kilowatts)",
     ylab="Frequency", main = "Global Active Power")
dev.off()