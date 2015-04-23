# Loads data if non-existent
if (!"NEI" %in% ls()) {
  NEI <- readRDS("summarySCC_PM25.rds")
}
if (!"SCC" %in% ls()) {
  SCC <- readRDS("Source_Classification_Code.rds")
}

# Subset data to Baltimore City only
BaltimoreNEI<-subset(NEI,fips == "24510")

par("mar"=c(5.1, 4.5, 4.1, 2.1))
png(filename = "plot2.png", 
    width = 480, height = 480, 
    units = "px")
totalBaltimoreEmissions <- aggregate(BaltimoreNEI$Emissions, list(BaltimoreNEI$year), FUN = "sum")

plot(totalBaltimoreEmissions, type = "l", xlab = "Year", 
     main = "Total Emissions in Balitmore City from 1999 to 2008", 
     ylab = expression('Total PM'[2.5]*" Emission"))
dev.off()
