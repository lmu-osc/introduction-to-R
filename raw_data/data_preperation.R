load(here::here("raw_data", "winners_raw.rda"))

## Introduce some NAs
set.seed(65)
na_rows <- sample(1:nrow(winners_raw), 5)
  
winners_raw[na_rows, "Hours"] <- NA

  
winners <- winners_raw %>%
  select(-c("Time"))

saveRDS(as.data.frame(winners), file = here::here("raw_data", "winners.rds"))