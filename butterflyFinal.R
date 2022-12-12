library(readxl)
library(tidyverse)
library(hrbrthemes)
library(viridis)
library(tidytext)
library(dplyr)
library(lubridate)
library(ggplot2)
library(ggpubr)
library(zoo)
#setting up our working directory and reading our files
setwd("~/Desktop/Data 331/Final Project/cabbage_butterfly-main/data")
df2<-read_excel('Cleaned Data LWA .xlsx', .name_repair = "universal")
colnames(df2)[1]<-"Core ID"
colnames(df2)[2]<-"sex"
colnames(df2)[3]<-"leftWingLength"
colnames(df2)[6]<-"rightWingLength"
colnames(df2)[4]<-"leftWingWidth"
colnames(df2)[7]<-"rightWingWidth"
colnames(df2)[5]<-"leftWingApexArea"
colnames(df2)[8]<-"rightWingApexArea"

df <- read_excel('CompletePierisData_2022-03-09.xlsx', .name_repair = "universal")
#deleting and renaming different columns  
df[10:11] <- list(NULL)
df[25] <- NULL
df[26:27]<- list(NULL)
df[29] <- NULL
df[31:32] <- list(NULL)
df[33] <- NULL
df[35:36]<- list(NULL)
df[42:50]<- list(NULL)
df[47:49]<- list(NULL)
df[49:50]<- list(NULL)
colnames(df)[1] <-"Core ID"
colnames(df)[10]<-"sextype"
colnames(df)[25]<-"Date"
colnames(df)[26]<-"Day"
colnames(df)[27]<-"Month"
colnames(df)[28]<-"Year"
colnames(df)[15]<-"leftapexarea"
colnames(df)[21]<-"rightapexarea"
colnames(df)[33]<-"Country"
colnames(df)[36]<-"Latitude"
colnames(df)[37]<-"Longitude"
df$Date = paste(df$Year,df$Month,df$Day, sep= '-')

#final cleaning of the data
df3 <- df%>%
  dplyr::mutate(Country = ifelse((Country == "United States")|(Country == "U.S.A."),"USA",Country))%>%
  
  left_join(df2, by = c("Core ID"))%>%
  dplyr::select("Core ID", "Month","Year","LAnteriorSpotM3","RAnteriorSpotM3","Latitude","Longitude","Country")



#joining tables for statistics and graphing
leng_th <- df2%>%
  left_join(df3,by = c("Core ID"))

leng_th$sumWingLength<-as.numeric(leng_th$leftWingLength)+as.numeric(leng_th$rightWingLength)
leng_th$averageWingLength<-leng_th$sumWingLength/2
leng_th$sumApexArea<-as.numeric(leng_th$leftWingApexArea)+as.numeric(leng_th$rightWingApexArea)
leng_th$AverageApexArea<-leng_th$sumApexArea/2
leng_th$sumWingWidth<-as.numeric(leng_th$leftWingWidth)+as.numeric(leng_th$rightWingWidth)
leng_th$averageWingWidth<-leng_th$sumWingWidth/2
leng_th$sumAnteriorSpot<-as.numeric(leng_th$LAnteriorSpotM3)+as.numeric(leng_th$RAnteriorSpotM3)
leng_th$AverageAnteriorSpot<-leng_th$sumAnteriorSpot/2

#doing a t-test
apex_area_t_test = t.test(leng_th$AverageApexArea ~ leng_th$sex,data = leng_th, var.equal = TRUE)
apex_area_t_test
wing_length_t_test = t.test 

#graph for Effect of sex
ggplot(leng_th,aes(averageWingWidth,averageWingLength))+
  geom_line(aes(colour = factor(sex)))+
  labs( title = "Effect of Sex on Wing Length and Width",x="Average Wing Width", y="Average Wing Length")+
scale_colour_manual(values = c("pink","blue"))


ggplot(leng_th,aes(AverageAnteriorSpot,AverageApexArea))+
  geom_point(aes(colour = factor(sex)))+
  labs( title = "Effect of Sex on Average apex Area and Anterior Spot Area ",x="Average Anterior spot", y="Average apex area")+
scale_colour_manual(values = c("green","red"))

ggplot(leng_th,aes(averageWingWidth,averageWingLength))+
  geom_point(aes(colour = factor(sex)))+
  labs( title = "average wing Length and Width comparison",x="Average Wing Width", y="Average Wing Length")+
  scale_colour_manual(values = c("yellow","blue"))


#doing a correlation
corelation=cor.test(leng_th$AverageAnteriorSpot,leng_th$AverageApexArea)  
corelation
correlation=cor.test
# adding month name
leng_th$monthName<-month.abb[leng_th$Month]


#graph for effect of month on wing Width and Apex Area
ggplot(data=leng_th,aes(monthName,averageWingWidth))+
  geom_histogram(stat="identity",aes(color=monthName))+
  labs( title = "Effect of Month on Wing Width",x="Month", y="Average Wing Width")+
  scale_color_manual(values=c('Red','Orange','Green','Yellow', 'Violet','Dark Orange','Blue','Dark Blue','Dark Green','Grey','Brown','Purple','Pink','Black','Light Yellow','Light Pink'))

leng_th %>%
  ggplot(aes(x= monthName, y=AverageApexArea, fill = monthName)) +
  geom_col()+
  scale_x_reordered() +
  coord_flip() +
  labs(title= "Effect of month on Anterior spot", x="monthName", y="AverageApexArea")

leng_th %>%
  ggplot(aes(x= monthName, y=AverageAnteriorSpot, fill = monthName)) +
  geom_col()+
  scale_x_reordered() +
  coord_flip() +
  labs(title= "Effect of month on apex area", x="monthName", y="AverageAnteriorSpot")

#graph for geospatial distribution in the world
world <- map_data("world")
world_plot = ggplot() +
  geom_map(
    data = world, map = world,
    aes(long, lat, map_id = region),
    color = "black", fill = "lightyellow", size = 0.1) +
  geom_point(
    data = leng_th,
    aes(x = Longitude, y = Latitude,
        color = sex),
    alpha = 6) +
  labs(x = NULL, y = NULL, color = NULL)+
  theme_void() +
  theme(legend.position = "none")+
  labs(title="Insect Locations")
ggarrange(world_plot)

#graph for geospatial distribution in the USA
df_usa = leng_th %>%
  dplyr::filter(Country == "USA")

usa = map_data("state")
usa_plot = ggplot() +
  geom_map(
    data = usa, map = usa,
    aes(long, lat, map_id = region),
    color = "black", fill = "lightyellow", size = 0.1)+
  geom_point(
    data = df_usa,
    aes(x = Longitude, y = Latitude,
        color = sex),
    alpha = 5, size = 4) +
  labs(x = NULL, y = NULL, color = NULL)+
  theme_void() +
  theme(legend.position = "none")+
  labs(title="Insect Locations In the United States")
ggarrange(usa_plot)

#graph for how apexArea, wingWidth, and Anteriorspot is affected by location

Measurments = c(leng_th$averageWingLength, leng_th$averageWingWidth, leng_th$AverageApexArea, leng_th$AverageAnteriorSpot)
Countries = leng_th%>%
  gather(Measurments, Length, 19:22)%>%
  group_by(Country, Measurments)%>%
  summarise(mnl = round(mean(Length), digits=3), sdl = round(sd(Length), digits=3))%>%
  ggplot(aes(reorder(Country, mnl),mnl, fill = reorder(Measurments,mnl))) +
  geom_bar(stat = "identity", position = "dodge")+
  geom_text(mapping = aes(label=mnl),position = position_dodge(width = 0.9),
            cex = 2.5, vjust = -4)+
  labs(title = "Insect Wing Measurments in different Countries",
       subtitle = "Wing Length, Width, and Area grouped by Countries",
       x = "Country", y = "Length in mm",
       caption = "cabbage-butterfly dataset", fill = "Description: ")+
  geom_errorbar(mapping = aes(ymin = round(mnl-sdl, digits = 3), ymax = mnl+sdl),
                width = 0.2, position = position_dodge(width = 0.9))+
  theme_bw()
Countries

#effect of decade on average wing width
floor_decade=function(value){return(as.numeric(leng_th$Year)-1900 %% 10)}
round_to_decade = function(value){ return(round( as.numeric(leng_th$Year)/ 10) * 10) }
floor_decade(as.numeric(leng_th$decade))
leng_th$decade=round_to_decade(leng_th$decade)
ggplot(leng_th,aes(x=decade,y=averageWingWidth,group=decade))+
  geom_point(aes(colour = factor(decade)))+
  labs( title = "Width by Decade",x="Decade", y="Average Wing Width")+
  scale_color_manual(values=c('Red','Orange','Green','Yellow', 'Violet','Dark Orange','Blue','Dark Blue','Dark Green','Grey','Brown','Purple','Pink','Black','Light Yellow','Light Pink'))


  

