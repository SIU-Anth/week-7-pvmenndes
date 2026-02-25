library(dplyr); library(tidyr) # I don't think I need these, it's just habit
library(readr)

cbind1 <- read_csv("cbind1.csv")
cbind2 <- read_csv("cbind2.csv")
rbind1 <- read_csv("rbind1.csv")
rbind2 <- read_csv("rbind2.csv")
merge2 <- read_csv("merge2.csv")
merge1 <- read_csv("merge1.csv")
merge3 <- read_csv("merge3.csv")
columns_bound <- cbind(cbind1, cbind2) #reminder, this really trusts your observations are aligned perfectly. Use caution

rows_bound <- rbind(rbind1, rbind2) # little smaller than original dataset because I cut a few, it's fine

# let's use merge to put together two sets of observations

total <- merge(merge2, cbind1,by = "Vessel") # this is like cbind, but confirms it's the same observation by id 'Vessel'

# NOTE: What do merge1 and merge3 look like? This uses dplyr package
left_join(merge1, merge3) #don't have to tell it what by, if the name matches
left_join(merge3, merge1) #don't have to tell it what by, if the name matches

# what if the column names don't match for ID?
merge1 <- merge1 %>% rename(newName = Vessel)
left_join(merge1, merge3, join_by("newName" == "Vessel")) # will pick the left name scheme

# of course, you can make the tibble a new data frame
newdf <- left_join(merge1, merge3, join_by("newName" == "Vessel"))
