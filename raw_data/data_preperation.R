load(here::here("raw_data", "winners_raw.rda"))

winners <- winners_raw %>%
  select(-c("Time", "Hours", "Minutes", "Seconds"))

saveRDS(winners, file = here::here("raw_data", "winners.rds"))


times <- winners_raw %>%
  select(-c("Category", "Year", "Nationality"))

saveRDS(times, file = here::here("raw_data", "times.rds"))
