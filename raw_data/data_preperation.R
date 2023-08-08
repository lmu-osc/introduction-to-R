load(here::here("raw_data", "winners_raw.rda"))

winners_raw <- winners_raw %>%
  mutate("ID" = 1:nrow(.)) 

## Introduce some NAs

set.seed(65)
na_rows <- sample(1:nrow(winners_raw), 5)
  
winners_raw[na_rows, "ID"] <- NA

  
winners <- winners_raw %>%
  select(-c("Time", "Hours", "Minutes", "Seconds"))

saveRDS(winners, file = here::here("raw_data", "winners.rds"))


times <- winners_raw %>%
  select(-c("Category", "Year", "Nationality", "Athlete"))

saveRDS(times, file = here::here("raw_data", "times.rds"))
