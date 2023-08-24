load(here::here("raw_data", "winners_raw.rda"))

## Introduce some NAs
na_rows <- c(2, 5, 8, 100, 54)
  
winners_raw[na_rows, "Hours"] <- NA

  
winners <- winners_raw %>%
  select(-c("Time"))

saveRDS(as.data.frame(winners), file = here::here("raw_data", "winners.rds"))