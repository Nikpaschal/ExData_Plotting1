# Plot1.R comprises of a series of functions and commands to download and subset Electrical 
# power consumption data from the UC Irvine Machine Learning Repositor and then create 
# certain plots using the Base plotting system.
# enjoy!

# (Optional) calculation of memory usage for this dataset
# rows <- 2075259
# columns <- 9
# dataset_size <- rows * columns
# dataset_size_GB <- round(dataset_size * 8/2^{20}/1024, 2)
# dataset_size_GB


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

#plot function to create frequency histogram 
hist(as.numeric(as.character(Feb2007_power$Global_active_power)),col="red",main="Global Active Power - February 2017",xlab="Global Active Power(kilowatts)")

