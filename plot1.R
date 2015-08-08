zip_file  <- "exdata-data-household_power_consumption.zip"
text_file <- "household_power_consumption.txt"
colClasses <- c("character","character",rep("numeric",7)) 
df <- read.csv(unz(zip_file, text_file), header = TRUE, sep = ";", na.strings="?", colClasses=colClasses)
df$DateTime <- strptime(paste(df$Date, df$Time), "%d/%m/%Y %H:%M")
df$Date = as.Date(df$Date, "%d/%m/%Y")
df <- df[df$Date >= as.Date("2007/02/01") & df$Date <= as.Date("2007/02/02"),]


title_label = "Global Active Power"
x_label = "Global Active Power (kilowatts)"
y_label = "Frequency"

hist(df$Global_active_power, freq=T,col = "red",main=title_label, xlab = x_label, ylab = y_label)

dev.copy(png,"plot1.png",width=480,height=480)
dev.off()
