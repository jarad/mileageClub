#' Calculate cumulative miles
#'
#' Calculates the cumulative miles by week.
#' 
#' @param d A \code{data.frame} contain all the cards with day information.
#' @param miles_per_card An integer specifying how many miles a card is worth.
#' @return A \code{data.frame} containing the number of miles run each week and 
#' the cumulative miles per week.
#' @import dplyr
#' @export
#' @examples 
#' \dontrun{
#' read_cards() %>% cumulative_miles
#' }
cumulative_miles = function(d, miles_per_card=5) {
  d %>%
    group_by_("week") %>%
    summarize_(miles = miles_per_card*n()) %>%
    arrange_("week") %>%
    mutate_(cumulative_miles = cumsum("miles"))
}
