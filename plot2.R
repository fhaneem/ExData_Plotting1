zip_file  <- "exdata-data-household_power_consumption.zip"
text_file <- "household_power_consumption.txt"
colClasses <- c("character","character",rep("numeric",7)) 
df <- read.csv(unz(zip_file, text_file), header = TRUE, sep = ";", na.strings="?", colClasses=colClasses)
df$DateTime <- strptime(paste(df$Date, df$Time), "%d/%m/%Y %H:%M")
df$Date = as.Date(df$Date, "%d/%m/%Y")
df <- df[df$Date >= as.Date("2007/02/01") & df$Date <= as.Date("2007/02/02"),]


title_label = ""
x_label = ""
y_label = "Global Active Power (kilowatts)"

with(df, plot(1:length(Date), Global_active_power, type="l",xlab=x_label,ylab=y_label,xaxt="n"))

axis(1,at=c(0,length(df$Date)/2,length(df$Date)),labels=c("Thu","Fri","Sat"))

dev.copy(png,"plot2.png",width=480,height=480)
dev.off()
