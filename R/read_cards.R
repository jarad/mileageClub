#' Read all cards and merge with days information
#' 
#' Read all card files. The filenames should be YYYYMMDD.csv and 
#' should have a single column labeled 'id'.
#' 
#' @param cards_path A directory contain the card files.
#' @param days_file A directory contain the day information.
#' @return A \code{data.frame} of all cards merged with day information.
#' @import dplyr
#' @export
#' @examples 
#' \dontrun{
#' read_cards()
#' }
read_cards = function(cards_path='data/cards/', days_file='data/days.csv') {
  days = readr::read_csv(days_file) %>%
    mutate(date = as.Date(date, format='%m/%d/%Y'))
  
  list.files(path = cards_path, full.names = TRUE) %>% 
    lapply(my_read_csv) %>% 
    bind_rows %>%
    merge(days, by="date")
}
