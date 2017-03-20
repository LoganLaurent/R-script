#Compute delta beta value density
setwd("~/ALBA/Minfi training")
all <- read.csv("FinalDNAmethylationData_peaksin.txt",sep = " ", header = TRUE)
subset(all, all$in_MM_peak>0) -> peakmmbm
subset(peakmmbm, peakmmbm$in_BM_peak<1) -> peakmmbm
subset(peakmmbm, peakmmbm$qval<0.05) -> peakmmbm
summary(peakmmbm$beta) -> su
su[2] -> hypolimit
su[5] -> interlimit
subset(peakmmbm, peakmmbm$beta<hypolimit) -> peakmmbmhypo
subset(peakmmbm, peakmmbm$beta<interlimit) -> peakmmbminter
subset(peakmmbminter, peakmmbminter$beta>hypolimit) -> peakmmbminter
subset(peakmmbm, peakmmbm$beta>interlimit) -> peakmmbmhyper
dhypo <- hist(peakmmbmhypo$beta)
dhypo$density = dhypo$counts/sum(dhypo$counts)*100
dinter <- hist(peakmmbminter$beta)
dinter$density = dinter$counts/sum(dinter$counts)*100
dhyper <- hist(peakmmbmhyper$beta)
dhyper$density = dhyper$counts/sum(dhyper$counts)*100
NULL -> dpt
data.frame("dhypo","dinter","dhyper") -> dpt
attach(dpt)
par(mfrow=c(3,1))
plot(dhypo,freq=FALSE)
plot(dinter,freq=FALSE)
plot(dhyper,freq=FALSE)
