

# Winners -----------------------------------------------------------------

load(here::here("raw_data", "winners_raw.rda"))

## Introduce some NAs
na_rows <- c(2, 5, 8, 100, 54)
  
winners_raw[na_rows, "Hours"] <- NA

  
winners <- winners_raw %>%
  select(-c("Time"))

saveRDS(as.data.frame(winners), file = here::here("raw_data", "winners.rds"))








# Babynames ---------------------------------------------------------------

babynames <- read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2022/2022-03-22/babynames.csv')

## Introduce some NAs
na_rows <- c(1, 4, 800)
babynames[na_rows, "year"] <- NA


babynames$ID <- 1:nrow(babynames)

babynames_n <- babynames[, c("ID", "n")]
babynames <- babynames[, -4]

saveRDS(as.data.frame(babynames), file = here::here("raw_data", "babynames.rds"))
saveRDS(as.data.frame(babynames_n), file = here::here("raw_data", "babynames_n.rds"))

