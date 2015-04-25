# Общие полезные функции

get.period <- function(start, end) {
  start <- strsplit(as.character(start), split="/")[[1]]
  end <- strsplit(as.character(end), split="/")[[1]]
  start.year  <- as.numeric(start[1])
  start.month <- as.numeric(start[2])
  end.year    <- as.numeric(end[1])
  end.month   <- as.numeric(end[2])
  return((end.year-start.year)*12 + (end.month - start.month))
}

#get.period(start = "2008/10", end = "2008/10") # 0
#get.period(start = "2007/10", end = "2008/10") # 12
#get.period(start = "2007/11", end = "2008/10") # 11
#get.period(start = "2007/09", end = "2008/10") # 13

plot.hists <- function(data, rdata, label.main)
{
  # "Пляски с бубном", чтобы совместить две гистограммы на одном графике
  nbreaks <- ceiling(max(data, rdata))%/%5
  breaks <- (0:(nbreaks+1))*5
  h1 <- hist(data,  plot=FALSE, breaks=breaks)
  h2 <- hist(rdata, plot=FALSE, breaks=breaks)
  xlim <- c(min(breaks), max(breaks)) 
  ylim <- c(0, max(max(h1$counts), max(h2$counts)) )
  par(new=FALSE)
  hist( data, xlim=xlim, ylim=ylim, xlab="Months", ylab="Repairs (white = factual, blue = predicted)", main=label.main,
    border=rgb(0, 0, 0, 1), col=rgb(1, 1, 1, 0),
    breaks=breaks)
  par(new=TRUE)
  hist(rdata, xlim=xlim, ylim=ylim, xlab="", ylab="", main="",
    border=rgb(0, 0, 1, 1), col=rgb(0, 0, 1, 0.2), 
    breaks=breaks)
}