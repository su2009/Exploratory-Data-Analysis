setwd("d:/Users/yangsu/Desktop")
getwd()

# check the memory
library(pryr)
object_size("household_power_consumption.txt")

# read data
edata=read.table("household_power_consumption.txt",header=TRUE,sep=";",na.strings="?")
power=edata[edata$Date == "1/2/2007"|edata$Date == "2/2/2007",]
power$Date=as.Date(power$Date,format="%d/%m/%Y")

#plot 1
power$Global_active_power<-as.numeric(as.factor(power$Global_active_power))
png("plot1.png", width=480, height=480)
hist(power$Global_active_power,col="red",main="Global Active Power",xlab = "Global Active Power(kilowatts)", ylab="Frequency")
dev.off()


#plot 2
power$datetime <- strptime(paste(power$Date, power$Time, sep=" "),"%Y-%m-%d %H:%M:%S") 
png("Plot2.png",width=480,height=480)
plot(power$datetime,power$Global_active_power,type="l",xlab="Global Active Power(Kilowatts)")
dev.off()


#plot 3
par(mfrow=c(1,1))
png("Plot3.png",width=480,height=480)
with(power,{
  plot(datetime,Sub_metering_1,type="l",ylab="Energy sub metering")
  lines(datetime,Sub_metering_2,col="red")
  lines(datetime,Sub_metering_3,col="blue")})
)
legend("topright",c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),lty=1,col=c("black","red","blue"),bty="o")
dev.off()


#plot 4
png("Plot4.png",width=480,height=480)
par(mfrow=c(2,2))
plot(power$datetime,power$Global_active_power,type="l",ylab="Global Active Power")
plot(power$datetime,power$Voltage,type="l",xlab="datetime",ylab="Voltage")

plot(power$datetime,power$Sub_metering_1,type="l",ylab="Energy sub metering")
lines(power$datetime,power$Sub_metering_2,col="red")
lines(power$datetime,power$Sub_metering_3,col="blue")
legend("topright",c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),lty=1,col=c("black","red","blue"),bty="o")

plot(power$datetime,power$Global_reactive_power,type="l",xlab="datetime",ylab="Global_reactive_power")
dev.off()

