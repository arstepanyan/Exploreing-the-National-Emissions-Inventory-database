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



###########################  PLOT 6  ###################################

# 1. Subset NEI dataframe so that there are only rows connected to motor
#    vehicle sources in Baltimore City (fips == "24510") and in Los Angeles County, 
#    California (fips == "06037"). In search of a good aproach for defining which
#    sources are motor vehicle sources I found an answer in Coursera forums (link below) 
#    from a mentor Leonard Greski and decided to stick to this aproach.
#    (https://www.coursera.org/learn/exploratory-data-analysis/discussions/weeks/4/threads/Eg_3QClTEeezyRLjKgAj0A?sort=createdAtDesc&page=1)
# 2. Change the numeric representations of Baltimore and Los Angeles with their acltual names.
# 3. Make a time series plot to see how the emissions from motor vehicle sources 
#    changed from 1999-2008 in Baltimore City and in Los Angeles County. 
# 4. Save the plot into .png file and close the device

library(dplyr)
library(ggplot2)
# 1
on_road <- NEI[grepl("^ON-ROAD", NEI$type),]
Baltimore_LA <- on_road %>% filter(fips == "24510" | fips == "06037") %>%
        group_by(fips, year) %>% summarise(total_emissions = sum(Emissions))
        
# 2
Baltimore_LA$fips <- gsub("06037", "Los Angeles", Baltimore_LA$fips)

Baltimore_LA$fips <- gsub("24510", "Baltimore City", Baltimore_LA$fips)

# 3
qplot(year, total_emissions, data = Baltimore_LA, col = fips,
      main = "Emissiont from Motor Vehicle Sources\nIncreased in Los Angeles and\nDecreased in Baltimore City") + 
        geom_smooth(method = "lm") 

# 4
dev.copy(png, file = "plot6.png")
dev.off()