athletes <- read.csv("C:/Users/hafiznij/Downloads/archive/athlete_events.csv")
regions <- read.csv("C:/Users/hafiznij/Downloads/archive/noc_regions.csv")

athletes_region <- merge(athletes, regions)


# Intro -------------------------------------------------------------------
# Medals per country:
athletes_region %>%
  filter(!is.na(Medal))


## Something like country per sport

best_by_sport <- athletes_region %>%
  filter(Medal == "Gold") %>%
  group_by(Sport, region) %>%
  count(Medal) %>%
  group_by(Sport) %>%
  slice(which.max(n)) 


p <- ggplot(
  data = best_by_sport,
  aes(
    x = Sport,
    y = n,
    fill = region,
    colour = region
  )
) + 
  geom_point()
  
  geom_col()
  
