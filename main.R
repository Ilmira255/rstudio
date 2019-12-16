library("readtext")
library("ggplot2")
library("httr")

raw_d <- readChar("dataco2.csv", file.info("dataco2.csv")$size)
raw_d <- gsub('"', ' ', raw_d)
read.csv(raw_d)
fileConn <- file("co2clean.csv")
writeLines(raw_d, fileConn)
close(fileConn)
World_emissions_CO2 <- read.csv("co2clean.csv", skip=1)
World_emissions_CO2 <- World_emissions_CO2[-c(23,44,46,70,91,102,119,134,155,203,265,274), ]
World_emissions_CO2 <- World_emissions_CO2[ , -c(2,3,4)]
World_emissions_CO2 <- World_emissions_CO2[-c(1:258), ]
World_emissions_CO2 <- World_emissions_CO2[-c(2:7), ]
World_emissions_CO2 <- t(World_emissions_CO2)
World_emissions_CO2 <- as.numeric(World_emissions_CO2)
World_emissions_CO2 <- data.frame(World_emissions_CO2)
year <- seq(1959,2020,1)
data2 <- data.frame(year, World_emissions_CO2)
palet = colorRampPalette(c("green","red")) 
colors = palet(62)
options(scipen = 999)
ggplot(data = data2, aes(x = year, y = World_emissions_CO2)) + 
  geom_line(color = "green", size = 2) +
  geom_point(size = 2, shape = 15, color = colors) +
  geom_area(alpha = 0.5) +
  ggtitle("The dynamics of CO2 emissions in the world, 1960 - 2014",
          subtitle = "Over the past 54 years emissions have increased significantly")+
  xlab("Year") +
  ylab("Tons of CO2") +
  annotate("rect", xmin = 2000, xmax = 2014, ymin = 25000000, ymax = 38000000,  alpha = .2, color = 'red3', size = 0.1) +
  annotate("text", x = 2007, y = 40000000, label = "Sharp increase", color = 'red3', size=5) +
  theme_bw()

