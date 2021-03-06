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


png('plot4.png')
par(mfrow=c(2,2))
with(Housepwr.sub,
{
      #plot1
      plot(Global_active_power~DtTime,
           data=Housepwr.sub,
           type='l',
           xlab='',
           ylab='Global Active Power (kilowatts)'
      )
      #plot2
      plot(Voltage~DtTime,type='l',xlab='datetime')
      #plot3
      plot(Sub_metering_1~DtTime,  type='l',ylab='Energy sub metering',xlab='')
      points(Sub_metering_2~DtTime,type='l',col='red')
      points(Sub_metering_3~DtTime,type='l',col='blue') 
      legend('topright',
             c('Sub_metering_1','Sub_metering_2','Sub_metering_3'),
             lty=c(1,1),
             col=c('black','red','blue'),
             bty='n'
             )
      #plot4
      plot(Global_reactive_power~DtTime,type='l',xlab='datetime')
      
}     
)

dev.off()
