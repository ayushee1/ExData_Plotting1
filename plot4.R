if(!file.exists("exdata-data-household_power_consumption.zip")) {
        house_data_file <- tempfile()
        download.file("http://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",house_data_file)
        file <- unzip(house_data_file)
        unlink(house_data_file)
}
## read the data from file household_power_consumption 
house=read.table("household_power_consumption.txt",na.strings="?",header=TRUE,stringsAsFactors = FALSE,sep=";")
##format the Date and filter the date
house_f=house%>%mutate(date=as.Date(house$Date,"%d/%m/%Y"))%>%filter(date >= "2007-02-01" & date <="2007-02-02")
time=strptime(paste(house_f$Date,house_f$Time),"%d/%m/%Y %H:%M:%S")
r=cbind(house_f,time)
## getting the cases with complete data
r_comp=r[complete.cases(r),]
par(mfcol=c(2,2))
## plot 1
plot(r_comp$time,r_comp$Global_active_power,type="l",ylab="Global Active Power(kilowatts)",xlab="")
## plot 2
plot(r_comp$time,r_comp$Sub_metering_1, type="l", xlab="", ylab="Energy sub metering")
lines(r_comp$time,r_comp$Sub_metering_2,col="red")
lines(r_comp$time,r_comp$Sub_metering_3,col="blue")
legend("topright",legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),col=c("black","red","blue"),cex=.6,lty=c(1,1),bty="n")
## plot 3
plot(r_comp$time,r_comp$Voltage,type="l",ylab="Voltage",xlab="datetime")
## plot 4
plot(r_comp$time,r_comp$Global_reactive_power,type="l",ylab="Global_reactive_power",xlab="datetime",ylim=c(0.0,0.5))
## output as PNG
dev.copy(png,"plot4.png",height=480,width=480)
dev.off()