

# Introduction ------------------------------------------------------------

# 
# This assignment uses data from the UC Irvine Machine Learning Repository, a popular repository for machine learning datasets. 
# In particular, we will be using the "Individual household electric power consumption Data Set" which I have made available on the course web site:
#         .
# Dataset: Electric power consumption [20Mb]
# 
# .
# Description: Measurements of electric power consumption in one household with a one-minute sampling rate over a period of almost 4 years. Different electrical quantities and some sub-metering values are available.
# 
# 
# The following descriptions of the 9 variables in the dataset are taken from the UCI web site:
# 1.Date: Date in format dd/mm/yyyy 
# 2.Time: time in format hh:mm:ss 
# 3.Global_active_power: household global minute-averaged active power (in kilowatt) 
# 4.Global_reactive_power: household global minute-averaged reactive power (in kilowatt) 
# 5.Voltage: minute-averaged voltage (in volt) 
# 6.Global_intensity: household global minute-averaged current intensity (in ampere) 
# 7.Sub_metering_1: energy sub-metering No. 1 (in watt-hour of active energy). It corresponds to the kitchen, containing mainly a dishwasher, an oven and a microwave (hot plates are not electric but gas powered). 
# 8.Sub_metering_2: energy sub-metering No. 2 (in watt-hour of active energy). It corresponds to the laundry room, containing a washing-machine, a tumble-drier, a refrigerator and a light. 
# 9.Sub_metering_3: energy sub-metering No. 3 (in watt-hour of active energy). It corresponds to an electric water-heater and an air-conditioner.
# 


#  Loading the data -------------------------------------------------------

# 
# When loading the dataset into R, please consider the following:
#         .
# The dataset has 2,075,259 rows and 9 columns. 
# First calculate a rough estimate of how much memory the dataset will require in memory before reading into R.
# Make sure your computer has enough memory (most modern computers should be fine).
# 
# .
# We will only be using data from the dates 2007-02-01 and 2007-02-02. 
# One alternative is to read the data from just those dates rather than reading in the entire dataset and subsetting to those dates.
# 
# .
# You may find it useful to convert the Date and Time variables to Date/Time classes 
# in R using the strptime() and as.Date() functions.
# 
# .
# Note that in this dataset missing values are coded as ?.
# 
setwd("C:/Users/lenov/Desktop/EDA")
data <- read.table("household_power_consumption.txt", header = TRUE, sep = ';')

data <- data[data$Date %in% c("2/1/2007","2/2/2007"),]

x <- paste(data$Date, data$Time)

data$Date2 <- as.POSIXlt(strptime(x, "%m/%d/%Y %H:%M:%S"))

# Making Plots ------------------------------------------------------------

# Our overall goal here is simply to examine how household energy usage varies over a 2-day period in February, 2007. 
# Your task is to reconstruct the following plots below, all of which were constructed using the base plotting system.
# 
# First you will need to fork and clone the following GitHub repository: https://github.com/rdpeng/ExData_Plotting1
# 
# For each plot you should.
# Construct the plot and save it to a PNG file with a width of 480 pixels and a height of 480 pixels.
# 
# Name each of the plot files as plot1.png, plot2.png, etc.
# 
# Create a separate R code file (plot1.R, plot2.R, etc.) that constructs the corresponding plot, 
# i.e. code in plot1.R constructs the plot1.png plot. Your code file should include code for reading the data so that the plot can be fully reproduced. You must also include the code that creates the PNG file.
# .
# Add the PNG file and R code file to your git repository
#  
# When you are finished with the assignment, push your git repository to GitHub 
# so that the GitHub version of your repository is up to date. There should be four PNG files and four R code files.
# 
# The four plots that you will need to construct are shown below. 
# 
# 
# 
png("plot4.png" )
par(mfrow = c(2, 2), cex = .75) 

plot(data$Date2, as.numeric(data$Global_active_power)/500, 
     ylab = "Global Active Power (kilowatts)",
     type = "l", 
     xlab = "")

plot(data$Date2, as.numeric(data$Voltage), 
     ylab = "Voltage",
     type = "l", 
     xlab = "datetime")
data2 <- data[, c("Date2","Sub_metering_1", "Sub_metering_2", "Sub_metering_3" )]
data2$Sub_metering_1 <- as.numeric(data$Sub_metering_1)
data2$Sub_metering_2 <- as.numeric(data$Sub_metering_2)
data2$Sub_metering_3 <- as.numeric(data$Sub_metering_3)

plot(data2$Date2,data2$Sub_metering_2, 
     type = "l", 
     ylim = c(min(data2[ ,-1]), (max(data2[ ,-1])+10)),
     ylab = "Energy sub metering", 
     xlab = "", 
     col = "red")

lines(data2$Date2, data2$Sub_metering_1, col = "black")
lines(data2$Date2, data2$Sub_metering_3, col = "blue")

legend("topright", 
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       col = c("black", "red", "blue"),
       ncol = 1, cex = .75, lwd = 3)

plot(data$Date2, as.numeric(data$Global_reactive_power)/500, 
     ylab = "Global Reactive Power",
     type = "l", 
     xlab = "datetime")

dev.off()


