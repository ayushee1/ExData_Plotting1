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
## getting the cases with complete data
housef=house_f[complete.cases(house_f),]
## creating a histogram
hist(housef$Global_active_power,col="red",xlab="Global Active Power(kilowatts)",ylab="Frequency",main="Global Active Power")
## output as PNG FILE
dev.copy(png,file="plot1.png",height=480,width=480)
dev.off()