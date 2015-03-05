library(data.table)
library(lubridate)
library(grDevices)


Read.Dt <- function () {
      Housepwr=fread('household_power_consumption.txt',na.strings="?")
      Housepwr[,DtTime:=dmy_hms(paste(Date,Time))]
      Housepwr.sub=subset(Housepwr,
                          DtTime>=ymd('2007-02-01') & 
                                DtTime<ymd('2007-02-03'))
      Housepwr.sub$Global_active_power=as.numeric(Housepwr.sub$Global_active_power)
      Housepwr.sub$Sub_metering_1=as.numeric(Housepwr.sub$Sub_metering_1)
      Housepwr.sub$Sub_metering_2=as.numeric(Housepwr.sub$Sub_metering_2)
      Housepwr.sub$Sub_metering_3=as.numeric(Housepwr.sub$Sub_metering_3)
      Housepwr.sub$Voltage=as.numeric(Housepwr.sub$Voltage)
      Housepwr.sub$Global_reactive_power=as.numeric(Housepwr.sub$Global_reactive_power)
      return(Housepwr.sub)
}


Housepwr.sub=Read.Dt()

png('plot2.png')
plot(Global_active_power~DtTime,
     data=Housepwr.sub,
     type='l',
     xlab='',
     ylab='Global Active Power (kilowatts)'
     )
dev.off()