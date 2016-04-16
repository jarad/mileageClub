library(shiny)

cards_per_mile = 5

source("read_cards.R")
source("cumulative_miles.R")
source("milestones.R")

cards = read_cards()

total_miles = cumulative_miles(cards)

milestones = milestones(cards) %>%
  mutate(Total = rowSums(.) - milestone)


shinyServer(function(input, output) {
  
  # display 10 rows initially
  output$ex1 = DT::renderDataTable(
    DT::datatable(read.csv("data/id.csv"), options = list(pageLength = 25))
  )
  
  output$total_miles = DT::renderDataTable(
    DT::datatable(total_miles)
  )
  
  output$milestones = DT::renderDataTable(
    DT::datatable(milestones)
  )  
})
