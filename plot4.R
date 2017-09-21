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


###########################  PLOT 4  ###################################


# 1. Subset SCC dataframe so that there are only rows connected to
#    coal combustion-related sources (search for rows with both "Coal" and 
#    "Comb" or both "Coal" and "Fire" in Short.Name variable)
# 2. From NEI create a new data frame to have emissions only from coal   
#    combustion-related sources (extracted from SCC in previous step)
# 3. Make a time series plot to check how the emissions from coal   
#    combustion-related sources changed from 1999 to 2008 
# 4. Save the plot into .png file and close the device

library(dplyr)
# 1
sub_coal_comb <- 
        SCC[grepl("Coal.*Comb|Comb.*Coal|Coal.*Fire|Fire.*Coal", 
                  SCC$Short.Name),]

# 2
coal_comb_df <- NEI %>% group_by(year) %>% 
        filter(SCC %in% sub_coal_comb$SCC) %>% 
        summarize(emissions = sum(Emissions))

# 3
par(mfrow = c(1,1))
plot(coal_comb_df$year, coal_comb_df$emissions, type = "l",
     xlab = "Year", ylab = "Emission",
     main = "Emissions From \nCoal Combustion-Related Sources")

# 4
dev.copy(png, file = "plot4.png")
dev.off()






