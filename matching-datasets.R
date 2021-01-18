library(dplyr)

# upload the two datasets under separate variables
data_A11y <- read.csv("~/Fiverr/R/wadji/A11y.csv")
data_non_A11y <- read.csv("~/Fiverr/R/wadji/Non_A11y.csv")

# check for duplicates in both datasets
data_A11y[duplicated(data_A11y), ]
data_non_A11y[duplicated(data_non_A11y), ]

# there is presence of duplicates. drop the duplicates using the code below
data_A11y <- data_A11y[!duplicated(data_A11y), ]
data_non_A11y <- data_non_A11y[!duplicated(data_non_A11y),]

for (value in unique(data_non_A11y$Bug.ID)){
  clean_data_A11y <- data_A11y %>%
    mutate(Match = ifelse(grepl(value, Bug.ID, fixed = TRUE), "Yes", "No"))
  
}

for (value in unique(data_non_A11y$Bug.ID)){
  clean_data_non_A11y <- data_non_A11y %>%
    mutate(Match = ifelse(grepl(value, Bug.ID, fixed = TRUE), "Yes", "No"))
  
}

View(clean_data_A11y)
View(clean_data_non_A11y)

# create a dataframe with the yes columns
positive_matches <- rbind(filter(clean_data_A11y, Match == "Yes"), filter(clean_data_non_A11y, Match == "Yes"))
