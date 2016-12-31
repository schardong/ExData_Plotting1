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

png('plot2.png', width=480, height=480)
with(data,
     plot.ts(Global_active_power,
             main='',
             xlab='',
             ylab='Global Active Power (kilowatts)'))
dev.off()
