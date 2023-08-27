
library(tidytuesdayR)
library(tidyverse)

# Athletes -----------------------------------------------------------------

athletes <- read.csv(here::here("raw_data", "athlete_events.csv"))

# ## Introduce some NAs
# na_rows <- c(2, 5, 8, 100, 54)
  
# winners_raw[na_rows, "Hours"] <- NA

  
# winners <- winners_raw %>%
#   select(-c("Time"))

saveRDS(as.data.frame(athletes), file = here::here("raw_data", "athletes.rds"))



# World coordinates -------------------------------------------------------
world_coordinates <- map_data("world")

write.table(world_coordinates, here::here("raw_data", "world_coordinates.csv"), sep = ";")



# Babynames ---------------------------------------------------------------

babynames <- read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2022/2022-03-22/babynames.csv')

## Introduce some NAs
na_rows <- c(4, 800)
babynames[na_rows, "year"] <- NA


babynames$ID <- 1:nrow(babynames)

babynames_n <- babynames[, c("ID", "n", "prop")]
babynames <- babynames[, -c(4, 5)]

saveRDS(as.data.frame(babynames), file = here::here("raw_data", "babynames.rds"))
saveRDS(as.data.frame(babynames_n), file = here::here("raw_data", "babynames_n.rds"))


# Characters --------------------------------------------------------------

tuesdata <- tidytuesdayR::tt_load("2022-08-16")

characters <- as.data.frame(tuesdata$characters)

## It seems like the personalty column assigns the pole of the question. For example, we have someone pretentious with a high score, but also someone unassuming with a similarily high score (even though it is the same question). Ranks can be found two times, one for the one pole, and one for the other. 

psych_stats <- tuesdata$psych_stats %>%
  ## Recode
  mutate(question2 = str_extract(question, "^.*(?=(/))")) %>%
  mutate(mean_rating = ifelse(personality == question2, 
                              yes = 100 - avg_rating, 
                              no = avg_rating)) %>%
  select(char_id, question, mean_rating, rating_sd, number_ratings)

saveRDS(characters, 
        file = here::here("raw_data", "characters.rds")
        )
write.table(psych_stats, here::here("raw_data", "psych_stats.csv"), sep = ";")
