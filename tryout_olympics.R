athletes <- read.csv("C:/Users/hafiznij/Downloads/archive/athlete_events.csv")
regions <- read.csv("C:/Users/hafiznij/Downloads/archive/noc_regions.csv")

athletes_region <- merge(athletes, regions)



# Medals per country on map -----------------------------------------------
# Medals per country:
best_country <- athletes_region %>%
  filter(!is.na(Medal)) %>%
  filter(Medal == "Gold") %>%
  mutate(medal_bi = 1) %>%
  group_by(region) %>%
  count(medal_bi) 


world_coordinates <- map_data("world") %>%
  left_join(best_country) %>%
  arrange(order)


ggplot(data = world_coordinates, 
       mapping = aes(x = long, y = lat, group = group)) + 
  coord_fixed(1.3) +
  geom_polygon(aes(fill = n)) +
  scale_fill_distiller(palette ="RdBu", direction = -1) + # or direction=1
  ggtitle("Olympic medalists by country") +
  theme_void()



# Intro -------------------------------------------------------------------

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

