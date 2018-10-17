#' Count species
#' Counts number of individuals of species per family
#' @param x data frame. In forestplots format.
#' @param family_name family name
#'
#' @return Frequency table. First column has family name.
#' @export
#'
#' @examples
count_species <- function(x, family_name)
{
  
  out_table <- x %>% 
    mutate(binomial = as.character(Species)) %>% 
    filter(Family == family_name) %>% 
    select(binomial) %>% 
    table() %>% 
    tidy() 
  
  names(out_table) <- c(as.character(family_name), "Frequency")
  return(out_table)
}

#' Count species
#' Counts number of individuals of species per family for the latest census
#' @param x data frame. In forestplots format.
#' @param family_name family name
#'
#' @return Frequency table for the latest census. First column has family name.
#' @export
#'
#' @examples

count_speciesLC <- function(x, family_name, census)
{
  
out_table <- x %>% 
  dplyr::mutate(binomial = as.character(Species)) %>%
  filter(complete.cases("DBH2.2")) %>% 
  filter(Family == family_name) %>% 
  select(binomial) %>% 
  table() %>% 
  tidy() 

out_table
}




# VEN01 %>% dplyr::filter_(complete.cases(interp(~ var, var = as.name("DBH2.2"))))

