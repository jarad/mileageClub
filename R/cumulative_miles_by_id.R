#' Calculate cumulative miles for each individual by week
#' 
#' For each individual, calculate the miles run that week and the 
#' cumulative miles run up to and including that week.
#' 
#' @param d A \code{data.frame} containing all the card and day information.
#' @param miles_per_card An integer specifying how many miles a card is worth.
#' @return A \code{data.frame} with the cumulative miles for each individual by week.
#' @export
cumulative_miles_by_id <-
function(d, miles_per_card=5) {
  d %>% 
    group_by(id) %>%
    arrange(id, week) %>%
    mutate(one = 1, cumulative_miles = miles_per_card*cumsum(one)) %>%
    select(-one)
}
