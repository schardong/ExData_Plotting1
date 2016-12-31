library(dplyr)

url.dataset <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
filepath = "household_power_consumption.zip"

if (!file.exists("household_power_consumption.txt")) {
  download.file(url=url.dataset, destfile=filepath)
  unzip(filepath)
  file.remove(filepath)
}

## Reading and subsetting the data to get only the rows with days 2007-02-01 and
## 2007-02-02.
input.data <- read.table(file='household_power_consumption.txt',
                         sep=';',
                         header=T,
                         na.strings='?',
                         colClasses=c('character',
                                      'character',
                                      'numeric',
                                      'numeric',
                                      'numeric',
                                      'numeric',
                                      'numeric',
                                      'numeric',
                                      'numeric'))

data <- filter(input.data, Date == '1/2/2007' | Date == '2/2/2007') %>%
  mutate(Datetime = paste(Date, Time, sep = ' ')) %>%
  mutate(Datetime = as.POSIXct(strptime(Datetime, '%d/%m/%Y %H:%M:%S')))

png('plot3.png', width=480, height=480)
plot(Sub_metering_1 ~ Datetime,
     data=data,
     type='l',
     main='',
     xlab='',
     ylab='Energy sub metering')
lines(x=data$Datetime, y=data$Sub_metering_2, col=2)
lines(x=data$Datetime, y=data$Sub_metering_3, col=4)
legend('topright', legend=names(data)[7:9], col=c(1,2,4), lwd=1)
dev.off()
