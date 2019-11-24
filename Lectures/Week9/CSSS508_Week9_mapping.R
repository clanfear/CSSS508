library(tidyverse)
spd_raw <- read_csv("https://clanfear.github.io/CSSS508/Seattle_Police_Department_911_Incident_Response.csv")

glimpse(spd_raw)

## ggplot(spd_raw,
##        aes(Longitude, Latitude)) +
##   geom_point() +
##   coord_fixed() +
##   ggtitle("Seattle Police Incidents",
##           subtitle="March 25, 2016") +
##   theme_classic()



## if(!requireNamespace("devtools")) install.packages("devtools")
## devtools::install_github("dkahle/ggmap", ref = "tidyup")





qmplot(data = spd_raw, x = Longitude, y = Latitude, color = I("#342c5c"), alpha = I(0.5))



qmplot(data = spd_raw, 
  geom = "blank", 
  x = Longitude,
  y = Latitude, 
  maptype = "toner-lite", 
  darken = 0.5) + 
  stat_density_2d(
    aes(fill = stat(level)), 
      geom = "polygon", 
      alpha = .2,
      color = NA) + 
  scale_fill_gradient2(
      "Incident\nConcentration", 
      low = "white", 
      mid = "yellow", 
      high = "red") + 
  theme(legend.position = "bottom")

downtown <- spd_raw %>%
  filter(Latitude > 47.58, Latitude < 47.64,
         Longitude > -122.36, Longitude < -122.31)

assaults <- downtown %>% 
  mutate(assault_label = 
           ifelse(`Event Clearance Group` %in%
                  c("ASSAULTS", "ROBBERY"), 
                  `Event Clearance Description`, "")) %>% 
  filter(assault_label != "")



qmplot(data = downtown,
       x = Longitude,
       y = Latitude,
       maptype = "toner-lite",
       color = I("firebrick"),
       alpha = I(0.5)) + 
  geom_label(data = assaults,
       aes(label = assault_label),
       size=2.5)



library(ggrepel)
qmplot(data = 
    downtown,
    x = Longitude,
    y = Latitude,
    maptype = "toner-lite", 
    color = I("firebrick"), 
    alpha = I(0.5)) + 
  geom_label_repel(
    data = assaults,
    aes(label = assault_label), 
    fill = "black", 
    color = "white", 
    segment.color = "black",
    size=2.5)



library(sf)

precinct_shape <- st_read("./data/district/votdst.shp",
                          stringsAsFactors = F) %>% 
  select(Precinct=NAME, geometry)

precincts_votes_sf <- 
  read_csv("./data/king_county_elections_2016.txt") %>%
  filter(Race=="US President & Vice President",
         str_detect(Precinct, "SEA ")) %>% 
  select(Precinct, CounterType, SumOfCount) %>%
  group_by(Precinct) %>%
  filter(CounterType %in% 
           c("Donald J. Trump & Michael R. Pence",
             "Hillary Clinton & Tim Kaine",
             "Registered Voters",
             "Times Counted")) %>%
  mutate(CounterType =
           recode(CounterType, 
                  `Donald J. Trump & Michael R. Pence` = "Trump",
                  `Hillary Clinton & Tim Kaine` = "Clinton",
                  `Registered Voters`="RegisteredVoters",
                  `Times Counted` = "TotalVotes")) %>%
  spread(CounterType, SumOfCount) %>%
  mutate(P_Dem = Clinton / TotalVotes, 
         P_Rep = Trump / TotalVotes, 
         Turnout = TotalVotes / RegisteredVoters) %>%
  select(Precinct, P_Dem, P_Rep, Turnout) %>% 
  filter(!is.na(P_Dem)) %>%
  left_join(precinct_shape) %>%
  st_as_sf() #<<

glimpse(precincts_votes_sf)



ggplot(precincts_votes_sf, 
       aes(fill=P_Dem)) + #<<
  geom_sf(color="white", #<<
          size=0.1) +
  theme_void() +
  theme(legend.position = 
          "bottom")

library(tidycensus)

library(tidycensus)
# census_api_key("PUT YOUR KEY HERE", install=TRUE)
acs_2015_vars <- load_variables(2015, "acs5")
acs_2015_vars[10:18,] %>% print() 

king_county <- get_acs(geography="tract", state="WA", 
                       county="King", geometry = TRUE,
                       variables=c("B02001_001E", 
                                   "B02009_001E"))



glimpse(king_county)

king_county <-  king_county %>% 
  select(-moe) %>% #<<
  group_by(GEOID) %>% 
  spread(variable, estimate) %>% 
  rename(`Total Population`=B02001_001,
         `Any Black`=B02009_001) %>%
  mutate(`Any Black` = `Any Black` / `Total Population`)


head(king_county, 10)



king_county %>% 
  ggplot(aes(fill=`Any Black`)) + 
  geom_sf(size=0.1, color="white") + 
  coord_sf(crs = "+proj=longlat +datum=WGS84", datum=NA) + 
  scale_fill_continuous(name="Any Black\n", 
                        low="#d4d5f9",
                        high="#00025b") + 
  theme_minimal() + ggtitle("Proportion Any Black")

st_erase <- function(x, y) {
  st_difference(x, lwgeom::st_make_valid(st_union(st_combine(y))))
}
kc_water <- tigris::area_water("WA", "King", class = "sf")
kc_nowater <- king_county %>% 
  st_erase(kc_water)



  ggplot(kc_nowater, 
         aes(fill=`Any Black`)) + 
  geom_sf(size=0, color="white") + 
  coord_sf(crs = "+proj=longlat +datum=WGS84", datum=NA) + 
  scale_fill_continuous(name="Any Black\n", 
                        low="#d4d5f9",
                        high="#00025b") + 
  theme_minimal() + ggtitle("Proportion Any Black")

pb_state <- 
  get_acs(geography = "tract", state = "IL",
          geometry  = TRUE,
          variables = c("B02001_001E", 
                        "B02009_001E")) %>%
  select(-moe) %>%
  group_by(GEOID) %>% 
  spread(variable, estimate) %>% 
  rename(`Total Population` = B02001_001,
         `Any Black` = B02009_001) %>%
  mutate(`Any Black` = `Any Black` / `Total Population`)





pb_state %>% 
  ggplot(aes(fill=`Any Black`)) + 
  geom_sf(lwd=0) + 
  coord_sf(crs = "+proj=longlat +datum=WGS84", datum=NA) + 
  scale_fill_continuous(name="Any Black\n", 
                        low="#d4d5f9",
                        high="#00025b") + 
  theme_minimal()
