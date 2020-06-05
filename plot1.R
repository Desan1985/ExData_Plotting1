##plot 1

##setnew working directory - need adjustment for our own directory
setwd("/Users/martinschultze/Desktop/R-stuff/ExData_Plotting1")
getwd()

##create data folder if non-existent
if (!file.exists("data")) {
        dir.create("data")
}

##preparing dataset
url<-"https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(url,destfile = "./data/power_consumption.zip", method = "curl")
unzip("./data/power_consumption.zip", exdir = "./data")

df_full <- read.csv("./data/household_power_consumption.txt", sep = ";", header = TRUE, quote = "", 
stringsAsFactors = FALSE, na.strings = "?")
str(df_full)

##transofmrming date and time and match
install.packages("lubridate")
library(lubridate)
df_full$Date2 <- format(as.Date(df_full$Date, format="%d/%m/%Y"),"%d/%m/%Y")
df_full$Time2 <- format(strptime(df_full$Time, format="%H:%M:%S"),"%H:%M:%S")
df_full$Date3<- as.POSIXct(df_full$Date2, format="%d/%m/%Y")
df_full$datetime <- paste(df_full$Date3,df_full$Time2)
df_full$datetime2 <- ymd_hms(df_full$datetime)

##subsetting the 2 days
df_2days <- df_full[(df_full$Date3 == "2007-02-01" | df_full$Date3 == "2007-02-02"),]

##Plot 1
hist(df_2days$Global_active_power, main = "Global Active Power", xlab = "Global Active Power (kilowatts)", col="red")
dev.copy(png, file= "plot1.png",width=480, height=480, units = "px")
dev.off()


##Plot2 - note that weekdays are in German on x-axis
with(df_2days, plot(datetime2,Global_active_power, type = "l",  ylab = "Global Active Power (kilowatts)", xlab= ""))
dev.copy(png, file= "plot2.png",width=480, height=480, units = "px")
dev.off()

