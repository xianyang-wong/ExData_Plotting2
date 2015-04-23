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
png(filename = "plot5.png", 
    width = 480, height = 480, 
    units = "px")

#Selecting for just motor vehicle emissions
motor <- grep("motor", sccData$Short.Name, ignore.case = TRUE)
motor <- sccData[motor, ]
motorBaltimoreNEI <- BaltimoreNEI[BaltimoreNEI$SCC %in% motor$SCC, ]

totalmotorBaltimoreEmissions <- aggregate(motorBaltimoreNEI$Emissions, list(motorBaltimoreNEI$year), FUN = "sum")
# options(scipen=0)
# options(scipen=999)
plot(totalmotorBaltimoreEmissions, type = "l", xlab = "Year", 
     main = "Total Motor Vehicle Emissions in Baltimore City\n from 1999 to 2008", 
     ylab = expression('Total PM'[2.5]*" Emission"))

dev.off()