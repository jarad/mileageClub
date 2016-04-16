#' Calculate cumulative miles
#'
#' Calculates the cumulative miles by week.
#' 
#' @param d A \code{data.frame} contain all the cards with day information.
#' @param miles_per_card An integer specifying how many miles a card is worth.
#' @return A \code{data.frame} containing the number of miles run each week and 
#' the cumulative miles per week.
#' @export
cumulative_miles <-
function(d, miles_per_card=5) {
  d %>%
    group_by(week) %>%
    summarize(miles = miles_per_card*n()) %>%
    arrange(week) %>%
    mutate(cumulative_miles = cumsum(miles))
}
