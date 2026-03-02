#Week 7 Report

# Load libraries
library(tidyverse)
library(car)
library(readxl)

#Import dataset
ceramics <- read_excel("RimData.xlsx")

#Change categorical variables to factors
ceramics <- ceramics %>%
  mutate(
    Ware = as.factor(Ware),
    VesType = as.factor(VesType)
  )

#Bad graphic
ggplot(ceramics, aes(x = Ware, y = RimDiameter, fill = Ware)) +
  stat_summary(
    fun = max,
    geom = "bar",
    width = 0.75,
    alpha = 0.95,
    color = "black"
  ) +
  geom_jitter(
    aes(color = Ware),
    width = 0.18,
    size = 3,
    alpha = 0.9
  ) +
  labs(
    title = "Superior Ceramic",
    subtitle = "Because Bigger Rim = More Soup (?)",
    x = "Ware Type",
    y = "Rim Diameter (cm)"
  ) +
  
  scale_fill_manual(values = c(
    "Coarse Earthenware" = "red",
    "Stoneware" = "chartreuse3"
  )) +
  scale_color_manual(values = c(
    "Coarse Earthenware" = "red",
    "Stoneware" = "chartreuse1"
  )) +
  theme_minimal(base_size = 16) +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))

#good graphic

ggplot(ceramics, aes(x = Ware, y = RimDiameter, fill = Ware)) +
  geom_boxplot(alpha = 0.6, outlier.shape = NA) +
  geom_jitter(width = 0.15, size = 2, alpha = 0.5, color = "black") +
  scale_fill_brewer(palette = "Set2") +
  labs(
    title = "Rim Diameter by Ware Type",
    subtitle = "Distribution of Observed Rim Diameters",
    x = "Ware Type",
    y = "Rim Diameter (cm)"
  ) +
  theme_minimal(base_size = 14) +
  theme(legend.position = "none")

#rim diameter by ware type

  #check normality and homogeneity
  by(ceramics$RimDiameter, ceramics$Ware, shapiro.test)
  car::leveneTest(RimDiameter ~ Ware, data = ceramics)

  #t-test
  t.test(RimDiameter ~ Ware, data = ceramics)

  #Ware by type
  
  #create table
  tab <- table(ceramics$Ware, ceramics$VesType)
  tab
  
  #chi- saquare
  chisq.test(tab)
  
  #AI disclaimer: Ai was used to partially write code and to help me figure it out some issues that came up with my own and why it was not working. 
  




