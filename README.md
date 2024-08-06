
<!-- README.md is generated from README.Rmd. Please edit that file -->

# Climate TRACE - PERU

## Carregando pacotes necessários

``` r
library(sf)
library(tidyverse)
library(ggsci)
# source("R/gafico.R")
# source("R/my-function.R")
```

## Carregando a base de dados

``` r
# country_emissions <- read_rds("data/country_emissions.rds")
# emissions_sources <- read_rds("data/emissions_sources.rds") %>% 
#   mutate(source_name_1 = str_to_title(source_name)) %>% 
#   filter(year >=2015, year<=2023)

# emissions_sources$year %>% unique()
# emissions_sources$source_name %>% unique()
# emissions_sources$sector_name %>% unique()
```

## Espacialização dos pontos amostrais

``` r
# emissions_sources %>%
#   filter(year == 2022) %>%
#   ggplot(aes(x=lon,y=lat))+
#   geom_point()
```

``` r
# shapefile_path <- "data/Departamental INEI 2023 geogpsperu SuyoPomalia/"
# shapefile_data <- st_read(shapefile_path)
# shapefile_data %>%  
#   ggplot() +
#   geom_sf() +
#   theme_minimal() +
#   labs(title = "Visualização do Shapefile",
#        caption = "Fonte: Departamental INEI 2023 geogpsperu")
```

``` r
# shapefile_data %>% 
#   ggplot() +
#   geom_sf(fill="white", color="black",
#           size=.15, show.legend = FALSE) +
#   geom_point(
#     data = emissions_sources %>%
#       filter(year == 2022),
#     aes(lon,lat)) +
#   theme_minimal()
```

``` r
# nomes_departamentos <- shapefile_data$DEPARTAMEN %>% str_to_title()
# nomes_departamentos[17] <- "Madre de Dios"
```

``` r
# emissions_sources %>% 
#   filter(
#     year == 2022,
#     gas == "co2e_100yr",
#     !source_name %in% nomes_departamentos,
#     !sub_sector %in% c("forest-land-clearing",
#                             "forest-land-degradation",
#                             "shrubgrass-fires",
#                             "forest-land-fires",
#                             "wetland-fires",
#                             "removals"),
#     sector_name != "forestry_and_land_use"
#     # source_name == "Manu"
#     ) %>% 
#   group_by(sector_name) %>% 
#   summarise(
#    emission = sum(emissions_quantity, na.rm=TRUE)
#    ) %>% 
#   arrange(desc(emission)) %>% 
#   ungroup() %>% 
#   mutate(
#     Acumulada = cumsum(emission)
#   )
```
