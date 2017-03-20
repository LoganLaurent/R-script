#plot of MM beta value density
setwd("~/ALBA/Minfi training")
all <- read.csv("FinalDNAmethylationData_peaksin.txt",sep = " ", header = TRUE)
subset(all, all$in_MM_peak>0) -> allpeakmm
summary(allpeakmm$MM_mean) -> mmsu
mmsu[2] -> hypolimitmm
mmsu[5] -> interlimitmm
subset(allpeakmm, allpeakmm$MM_mean<hypolimitmm) -> mmpeakmmhypo
subset(allpeakmm, allpeakmm$MM_mean<interlimitmm) -> mmpeakmminter
subset(mmpeakmminter, mmpeakmminter$MM_mean>hypolimitmm) -> mmpeakmminter
subset(allpeakmm, allpeakmm$MM_mean>interlimitmm) -> mmpeakmmhyper
hypo <- hist(mmpeakmmhypo$MM_mean)
hypo$density = hypo$counts/sum(hypo$counts)*100
inter <- hist(mmpeakmminter$MM_mean)
inter$density = inter$counts/sum(inter$counts)*100
hyper <- hist(mmpeakmmhyper$MM_mean)
hyper$density = hyper$counts/sum(hyper$counts)*100
NULL -> pt
data.frame("hypo","inter","hyper") -> pt
attach(pt)
par(mfrow=c(3,1))
plot(hypo,freq=FALSE)
plot(inter,freq=FALSE)
plot(hyper,freq=FALSE)
