# Import Library
library(shiny)
library(shinydashboard)
library(dplyr)
library(plotly) 
library(glue) 
library(scales) 
library(tidyr)
library(lubridate)
library(wordcloud2)
library(tidyverse)
library(DT)
library(readr)
library(ggplot2)

# Import Dataset
movie <- read.csv("imdb.csv")
movie <- movie %>% 
  mutate(genre = as.factor(genre),
         status = as.factor(status),
         orig_lang = as.factor(orig_lang),
         country = as.factor(country),
         date_x = ymd(date_x)) %>% 
  arrange(desc(year)) %>% 
  distinct(names, .keep_all = TRUE)
colnames(movie)[10] <- "budget"
colnames(movie)[2] <- "date"

# Import Theme
my_theme <- theme(legend.position = "right",
                  legend.direction = "vertical",
                  legend.key = element_rect(fill="black"),
                  legend.background = element_rect(fill="transparent"),
                  legend.title = element_text(size=6, color="black", family = "Montserrat"),
                  plot.subtitle = element_text(size=6, color="black", family = "Montserrat"),
                  panel.background = element_rect(fill="transparent"),
                  panel.border = element_rect(fill=NA),
                  panel.grid = element_line(alpha(colour = "#C3C3C3",alpha = 0.4), linetype=2),
                  plot.background = element_rect(fill="transparent"),
                  text = element_text(color="black", family = "Montserrat"),
                  axis.text = element_text(color="black", family = "Montserrat")
)