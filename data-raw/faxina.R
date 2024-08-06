library(tidyverse)
# library(ggsci)
# source("R/my-function.R")

# download do arquivo zip - climate trace ---------------------------------
# my_url <- "https://downloads.climatetrace.org/v02/country_packages/PER.zip"
# download.file(my_url, destfile = "data-raw/PER.zip", mode = "wb")
# unzip("data-raw/PER.zip", exdir = "data-raw/PER")

# arquivo emissions-sources -----------------------------------------------
# buscando o caminho dos setores
tbl_directorys <- as_tibble(
  list.files("data-raw/PER/",
             full.names = TRUE,
             recursive = TRUE)) %>%
  filter(str_detect(value, "emissions_sources.csv"))

# Extraindo os caminhos dos arquvios
value <- tbl_directorys %>% pull(value)

# Mapeando Transportation -------------------------------------------------
trans_values <- tbl_directorys %>%
  filter(str_detect(value,"transportation")) %>%
  pull(value)

# Atualizando o banco todo ------------------------------------------------
# Empilhando todos os arquivos no objeto dados
my_file_read <- function(sector_name){
  read.csv(sector_name) %>%
    select(!starts_with("other")) %>%
    mutate(directory = sector_name)
}
my_data <- map_dfr(value, my_file_read)
glimpse(my_data)

# Numéro de posições no caminho divididas por "/"
n_position <- ncol(str_split(tbl_directorys[1,1],"/",simplify = TRUE))


# Tratanto as colunas de data, nome de setores e sub setores
my_data <- my_data %>%
  mutate(
    start_time = as_date(start_time),
    end_time = as_date(end_time),
    created_date = as_date(created_date),
    modified_date = as_date(modified_date),
    year = lubridate::year(end_time)
  ) %>%
  mutate(
    sector_name = str_split(directory,
                            "/",
                            simplify = TRUE)[,n_position -1],
    sub_sector = str_split(directory,
                           "/",
                           simplify = TRUE)[,n_position],
    sub_sector = str_remove(sub_sector,"_emissions_sources.csv|_country_emissions.csv")
  )
glimpse(my_data)
write_rds(my_data, "data/emissions_sources.rds")

# country data -----------------------------------------------------------------
# # buscando o caminho dos setores
# tbl_directorys <- as_tibble(
#   list.files("data-raw/PER/", full.names = TRUE, recursive = TRUE)) %>%
#   filter(str_detect(value, "country_emissions.csv"))
#
# # Extraindo os caminhos dos arquvios
# value <- tbl_directorys %>% pull(value)
#
# # Empilhando todos os arquivos no objeto dados
# my_file_read(value[1])
# dados_country <- map_dfr(value, my_file_read) %>%
#   as_tibble()
# glimpse(dados_country)
#
# dados_country <- dados_country %>%
#   # filter(gas == "co2e_100yr") %>%
#   mutate(
#     start_time = as_date(start_time),
#     end_time = as_date(end_time),
#     created_date = as_date(created_date),
#     modified_date = as_date(modified_date),
#     year = lubridate::year(end_time)
#   ) %>%
#   mutate(
#     sector_name = str_split(directory,
#                             "/",
#                             simplify = TRUE)[,3],
#     sector_name = str_remove(sector_name,"_country_emissions.csv")
#   )
#
# dados_country$directory[1]
#
# dados_country %>%
#   select( sector_name ) %>%
#   distinct()
# write_rds(dados_country, "data/country_emissions.rds")
