library(tidytuesdayR)
library(tidyverse)

# Athletes -----------------------------------------------------------------

athletes <- read.csv(here::here("raw_data", "athlete_events.csv"))
region <- read.csv(here::here("raw_data", "noc_regions.csv"))

athletes_region <- merge(athletes, region) %>%
  rename("Region" = region) %>%
  select(-notes)


# ## Introduce some NAs
# na_rows <- c(2, 5, 8, 100, 54)

# winners_raw[na_rows, "Hours"] <- NA


# winners <- winners_raw %>%
#   select(-c("Time"))

saveRDS(as.data.frame(athletes_region), file = here::here("raw_data", "athletes.rds"))



# Coordinates -------------------------------------------------------------

world_coordinates <- ggplot2::map_data("world")

saveRDS(as.data.frame(world_coordinates), file = here::here("raw_data", "world_coordinates.rds"))


# Babynames ---------------------------------------------------------------

babynames <- read_csv("https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2022/2022-03-22/babynames.csv")

## Introduce some NAs
na_rows <- c(4, 800)
babynames[na_rows, "year"] <- NA


babynames$ID <- 1:nrow(babynames)

babynames_n <- babynames[, c("ID", "n", "prop")]
babynames <- babynames[, -c(4, 5)]

babynames <- as.data.frame(babynames)
babynames_n <- as.data.frame(babynames_n)


write.table(babynames,
  row.names = FALSE,
  file = here::here("raw_data", "babynames.csv"),
  sep = ","
)
write.table(babynames_n,
  row.names = FALSE,
  file = here::here("raw_data", "babynames_n.csv"),
  sep = ","
)


# Characters --------------------------------------------------------------

tuesdata <- tidytuesdayR::tt_load("2022-08-16")

characters <- as.data.frame(tuesdata$characters)

## It seems like the personalty column assigns the pole of the question. For example, we have someone pretentious with a high score, but also someone unassuming with a similarily high score (even though it is the same question). Ranks can be found two times, one for the one pole, and one for the other.

psych_stats <- tuesdata$psych_stats %>%
  ## Recode
  mutate(question2 = str_extract(question, "^.*(?=(/))")) %>%
  mutate(mean_rating = ifelse(personality == question2,
    yes = 100 - avg_rating,
    no = avg_rating
  )) %>%
  mutate(question = gsub("/", "_", question)) %>%
  select(char_id, question, mean_rating) %>%
  pivot_wider(
    id_cols = c(char_id),
    names_from = question,
    values_from = mean_rating,
    values_fn = mean
  )

saveRDS(characters,
  file = here::here("raw_data", "characters.rds")
)

write.table(psych_stats, here::here("raw_data", "psych_stats.csv"), sep = ";")
psych_stats <- read.csv(here::here("raw_data", "psych_stats.csv"), sep = ";") %>%
  select(-starts_with("X."))
write.table(psych_stats, here::here("raw_data", "psych_stats.csv"), sep = ";")

# Volleyball data ------------------------------------------------------------
vb <- tidytuesdayR::tt_load("2020-05-19")$vb_matches %>%
  mutate(id = 1:nrow(.))

vb_w <- vb %>% select(-starts_with("l_p"))
vb_l <- vb %>% select(-starts_with("w_p"))

write.table(vb_w, here::here("raw_data", "vb_w.csv"), sep = " ")
haven::write_sav(vb_l, here::here("raw_data", "vb_l.sav"))
