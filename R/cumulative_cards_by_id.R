cumulative_cards_by_id <-
function(d) {
  d %>% 
    group_by(id) %>%
    arrange(id, week) %>%
    mutate(one = 1, cumulative_cards = cumsum(one))
}
