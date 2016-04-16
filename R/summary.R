#' Get mileage club summary
#' 
#' Get the mileage club summary as a shiny app which reports the miles run each week,
#' the cumulative miles run, and some other information.
#' 
#' @param cards A \code{data.frame} containing all the cards with the weeks that they were completed.
#' @param school A string containing the name of the school
#' @import shiny dplyr DT
#' @export
#' @examples
#' \dontrun{
#' summary()
#' }
summary = function(cards,school) {
  total_miles = cumulative_miles(cards)
  
  milestones = milestones(cards)
#   %>%
#     mutate_(Total = ~rowSums(select(-milestone)))
#   
  shinyApp(
    ui = shinyUI(navbarPage(
      title = paste('MGMC Mileage Club -',school),
      tabPanel('Total Miles',      dataTableOutput('total_miles')),
      tabPanel('Milestones',       dataTableOutput('milestones'))
    )),
    server = function(input, output) {
      output$total_miles = renderDataTable(
        datatable(total_miles)
      )
      
      output$milestones = renderDataTable(
        datatable(milestones)
      )
    }
  )
}
