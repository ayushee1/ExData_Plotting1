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
## plot the graph
plot(r_comp$time,r_comp$Global_active_power,type="l",ylab="Global Active Power(kilowatts)",xlab="")
## output as PNG FILE
dev.copy(png,file="plot2.png",height=480,width=480)
dev.off()