#######################  DOWNLOAD AND READ DATA  ###################################
# 1. Create a directory where the data files are going to be kept
# 2. Download the .zip data from the web (link provided from Coursera)
# 3. Unzip the data and look at the files in it
# 4. Read the two files we saw in step 3 into a data frame

# 1
if(!file.exists("emission_data")){dir.create("emission_data")}

# 2
fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
download.file(fileUrl, destfile = "./emission_data/emission_data.zip")

# 3
unzip("./emission_data/emission_data.zip", exdir = "./emission_data")
dir("emission_data")

# 4
NEI <- readRDS("./emission_data/summarySCC_PM25.rds")
SCC <- readRDS("./emission_data/Source_Classification_Code.rds")

###########################     PLOT 1     ###################################

# 1. Create a new data frame to have total emissions for each year (using dplyr)
# 2. Make a time series plot to check if the total emissions decreased 
#    or increased from 1999 to 2008
# 3. Save the plot into .png file and close the device

# 1
library(dplyr)
sub_year <- 
        NEI %>% group_by(year) %>% summarise(total_pm25 = sum(Emissions))

# 2
par(mfrow = c(1,1))
plot(sub_year$year, sub_year$total_pm25, type = "l",
     xlab = "Year", ylab = "Emission", main = "Total Emissions")

# 3
dev.copy(png, file = "plot1.png")
dev.off()
