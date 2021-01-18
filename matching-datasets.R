library(dplyr)

# upload the two datasets under separate variables
data_A11y <- read.csv("A11y.csv")
data_non_A11y <- read.csv("Non_A11y.csv")

# check for duplicates in both datasets
data_A11y[duplicated(data_A11y), ]
data_non_A11y[duplicated(data_non_A11y), ]

# there is presence of duplicates. drop the duplicates using the code below
data_A11y <- data_A11y[!duplicated(data_A11y), ]
data_non_A11y <- data_non_A11y[!duplicated(data_non_A11y),]

data_non_A11y_unique <- unique(data_non_A11y$Bug.ID)
clean_data_A11y <- data_A11y
clean_data_A11y$Match <- ""
for (i in 1:nrow(clean_data_A11y)){
  if(clean_data_A11y[i, "Bug.ID"] %in% data_non_A11y_unique){
    clean_data_A11y[i, "Match"] <- "Yes"
  }else{
    clean_data_A11y[i, "Match"] <- "No"
  }
}

data_A11y_unique <- unique(data_A11y$Bug.ID)
clean_data_non_A11y <- data_non_A11y
clean_data_non_A11y$Match <- ""
for(i in 1:nrow(clean_data_non_A11y)){
  if(clean_data_non_A11y[i, "Bug.ID"] %in% data_A11y_unique){
    clean_data_non_A11y[i, "Match"] <- "Yes"
  }else{
    clean_data_non_A11y[i, "Match"] <- "No"
  }
}

View(clean_data_A11y)
View(clean_data_non_A11y)

# create a dataframe with the yes columns
positive_matches <- rbind(filter(clean_data_A11y, Match == "Yes"), filter(clean_data_non_A11y, Match == "Yes"))
positive_matches <- positive_matches %>% unique()