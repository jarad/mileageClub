#' Calculate milestones
#' 
#' This will calculate, by week, the number of students hitting a particular
#' milestone (every 5 miles) and the cumulative number of students who have hit
#' that milestone as of that week. 
#' 
#' @param d A \code{data.frame} containing all card and day information.
#' @return A \code{data_frame} with the number of students hitting a particular milestone. 
#' @import dplyr
#' @export 
#' @examples 
#' \dontrun{
#' read_cards() %>% milestones
#' }
milestones = function(d) {
  d %>% 
    cumulative_miles_by_id %>%
    group_by_("cumulative_miles", "week") %>%
    summarize_(n = dplyr::n()) %>%
    mutate_(milestone = "cumulative_miles") %>%
    ungroup() %>%
    select_(-"cumulative_miles") %>%
    tidyr::spread_("week", "n", fill=0)
}
