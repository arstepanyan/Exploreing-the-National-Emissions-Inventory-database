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

###########################  PLOT 3  ###################################

# 1. Create a new data frame to have emissions from four types of sources 
#    (indicated by the variable type) in Baltimore City (fips = "24510")
# 2. Make a time series plot using ggplot2 to check which of four sources 
#    have seen decreases in emissions and which of four sources have seen 
#    increases in emissions from 1999 to 2008 in Baltimore City 
# 3. Save the plot into .png file and close the device

library(dplyr)
library(ggplot2)
# 1 
sub_Baltimore_source <- NEI %>% group_by(fips, year, type) %>%
        filter(fips == "24510") %>% summarise(total_emissions = sum(Emissions))


# 2
qplot(year, total_emissions, data = sub_Baltimore_source, col = type, 
      main = "Total Emissions By Four Types of Sources \nIn Baltimore City") + 
        geom_smooth(method = "lm")

# 3 
dev.copy(png, file = "plot3.png")
dev.off()


