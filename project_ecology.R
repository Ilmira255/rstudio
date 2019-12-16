library("readtext")
library("ggplot2")
library("httr")
library("downloader")

download.file('http://api.worldbank.org/v2/en/indicator/EN.ATM.CO2E.PC?downloadformat=csv', dest = 'dataco21.zip', mode = 'wb')
unzip(zipfile="dataco21.zip",exdir="./data")
setwd("C:/Users/Èëüìèðà/Documents/data")

raw_d <- readChar("API_EN.ATM.CO2E.PC_DS2_en_csv_v2_566534.csv", file.info("API_EN.ATM.CO2E.PC_DS2_en_csv_v2_566534.csv")$size)
raw_d <- gsub('"', ' ', raw_d)
read.csv(raw_d)
fileConn <- file("co2clean.csv")
writeLines(raw_d, fileConn)
close(fileConn)
World_emissions_CO2 <- read.csv("co2clean.csv", skip=1)
World_emissions_CO2 <- data.frame(World_emissions_CO2)

year <- seq(1960,2014,1)
data2 <- data.frame(year, World_emissions_CO2)
palet=colorRampPalette(c("green","red")) 
colors=palet(62)
options(scipen = 999)
ggplot(data=data2, aes(x = year, y = World_emissions_CO2)) + 
  geom_line(color = "green", size = 2) +
  geom_point(size = 2, shape = 15, color = colors) +
  geom_area(alpha = 0.5) +
  ggtitle('Динамика выбросов СО2 в мире, 1960 - 2014 гг.',
          subtitle = 'За последние 54 года выбросы значительно увеличились')+
  xlab('Год') +
  ylab('Тонны СО2') +
  annotate("rect", xmin = 2000, xmax = 2014, ymin = 25000000, ymax = 38000000,  alpha = .2, color = 'red3', size = 0.1) +
  annotate("text", x = 2007, y = 40000000, label = "Ðåçêîå ïîâûøåíèå", color = 'red3', size=5) +
  theme_bw() 

