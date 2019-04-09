# Plot3.R comprises of a series of functions and commands to download and subset Electrical 
# power consumption data from the UC Irvine Machine Learning Repositor and then create 
# certain plots using the Base plotting system.
# enjoy!


# This step Initiates necessary folders to be checked if they exist in the next step 
Datafolder <- 'Electric power consumption'
Raw_data <- 'E_power_consumption_Dataset.zip'


# This step checks if the folder with the data already exists, if not it downloads and unzips the data
# this is necessary because otherwise everytime the scripts runs it will download the data again
if(!file.exists("./Electric power consumption")) 
  if(!file.exists("E_power_consumption_Dataset.zip")) {
    Raw_data <-"E_power_consumption_Dataset.zip"
    fileUrl <- 'https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip'
    download.file(fileUrl, Raw_data)
  }

unzip(Raw_data)

#Read, name and subset a certain set of the data based on dates
Raw_dataset <- read.table("household_power_consumption.txt",skip=1, sep=";")
Feb2007_power <- subset(Raw_dataset,Raw_dataset$V1=="1/2/2007" | Raw_dataset$V1 =="2/2/2007")
names(Feb2007_power) <- c("Date","Time","Global_active_power","Global_reactive_power","Voltage","Global_intensity","Sub_metering_1","Sub_metering_2","Sub_metering_3")

# Transforming Time variable from character into objects 
Feb2007_power$Date <- as.Date(Feb2007_power$Date, format="%d/%m/%Y")
Feb2007_power$Time <- strptime(Feb2007_power$Time, format="%H:%M:%S")

# Format using rows 1:441 for 2007-02-01 and rows 1441:2880 for 2007-02-02
Feb2007_power[1:1440,"Time"] <- format(Feb2007_power[1:1440,"Time"],"2007-02-01 %H:%M:%S")
Feb2007_power[1441:2880,"Time"] <- format(Feb2007_power[1441:2880,"Time"],"2007-02-02 %H:%M:%S")

# plot with legend (in top right corner)
plot(Feb2007_power$Time,Feb2007_power$Sub_metering_1,type="n",xlab="",ylab="Energy sub metering",main="Energy sub-metering")
with(Feb2007_power,lines(Time,as.numeric(as.character(Sub_metering_1))))
with(Feb2007_power,lines(Time,as.numeric(as.character(Sub_metering_2)),col="red"))
with(Feb2007_power,lines(Time,as.numeric(as.character(Sub_metering_3)),col="blue"))
legend("topright", lty=1, col=c("black","red","blue"),legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))

