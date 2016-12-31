library(dplyr)

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
  mutate(Date = as.Date(strptime(Date, '%d/%m/%Y')))

png('plot4.png', width=480, height=480)
par(mfrow=c(2,2))
## Plot 1
plot(Global_active_power ~ Datetime,
     data=data,
     type='l',
     main='',
     xlab='',
     ylab='Global Active Power')
## Plot 2
plot(Voltage ~ Datetime,
     data=data,
     type='l',
     main='')
## Plot 3
plot(Sub_metering_1 ~ Datetime,
     data=data,
     type='l',
     main='',
     xlab='',
     ylab='Energy sub metering')
lines(x=data$Datetime, y=data$Sub_metering_2, col=2)
lines(x=data$Datetime, y=data$Sub_metering_3, col=4)
legend('topright', legend=names(data)[7:9], col=c(1,2,4), lwd=1)
## Plot 4
plot(Global_reactive_power ~ Datetime,
     data=data,
     type='l',
     main='')
with(data,
     points(x=Datetime,
            y=Global_reactive_power,
            cex=0.5,
            pch=19))
dev.off()
