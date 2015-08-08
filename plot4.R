
zip_file  <- "exdata-data-household_power_consumption.zip"
text_file <- "household_power_consumption.txt"
colClasses <- c("character","character",rep("numeric",7)) 
df <- read.csv(unz(zip_file, text_file), header = TRUE, sep = ";", na.strings="?", colClasses=colClasses)
df$DateTime <- strptime(paste(df$Date, df$Time), "%d/%m/%Y %H:%M")
df$Date = as.Date(df$Date, "%d/%m/%Y")
df <- df[df$Date >= as.Date("2007/02/01") & df$Date <= as.Date("2007/02/02"),]

par(mfrow = c(2,2))

#FIRST PLOT

title_label = ""
x_label = ""
y_label = "Global Active Power (kilowatts)"

with(df, plot(1:length(Date), Global_active_power, type="l", xlab=x_label,ylab=y_label,xaxt="n"))

axis(1,at=c(0,length(df$Date)/2,length(df$Date)),labels=c("Thu","Fri","Sat"))

#SECOND PLOT

x_label = "datetime"
y_label = "Voltage"

with(df, plot(1:length(Date), Voltage, type="l", xlab=x_label,ylab=y_label,xaxt="n"))

axis(1,at=c(0,length(df$Date)/2,length(df$Date)),labels=c("Thu","Fri","Sat"))

#THIRD PLOT

title_label = ""
x_label = ""
y_label = "Energy sub metering"

with(df, plot(1:length(Date), df$Sub_metering_1, type="l", xlab=x_label,ylab=y_label,xaxt="n",col="black")
)

with(df, lines(1:length(Date), df$Sub_metering_2, type="l", xlab=x_label,ylab=y_label,xaxt="n",col="red")
)

with(df, lines(1:length(Date), df$Sub_metering_3, type="l", xlab=x_label,ylab=y_label,xaxt="n",col="blue")
)

# add x vs. 1/x 
#lines(x, z, type="b", pch=22, col="blue", lty=2)

axis(1,at=c(0,length(df$Date)/2,length(df$Date)),labels=c("Thu","Fri","Sat"))

legend("topright", lty = 1, col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2","Sub_metering_3"), bty = "n")


#FOURTH PLOT
y_label = "Global_reactive_power"
x_label = "datetime"
with(df, plot(1:length(Date), Global_reactive_power, type="l",  xlab=x_label,ylab=y_label,xaxt="n"))

axis(1,at=c(0,length(df$Date)/2,length(df$Date)),labels=c("Thu","Fri","Sat"))

dev.copy(png,"plot4.png",width=480,height=480)
dev.off()
