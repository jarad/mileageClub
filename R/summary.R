#' Get mileage club summary
#' 
#' Get the mileage club summary as a shiny app which reports the miles run each week,
#' the cumulative miles run, and some other information.
#' 
#' @param cards A \code{data.frame} contining all the cards with the weeks that they were completed.
#' @param ids A \code{data.frame} containing the student
#' @import shiny dplyr
#' @export
#' @examples
#' \dontrun{
#' summary()
#' }
summary = function(cards,ids) {
  total_miles = cumulative_miles(cards)
  
  milestones = milestones(cards)
#   %>%
#     mutate_(Total = ~rowSums(select(-milestone)))
#   
  shinyApp(
    ui = shinyUI(navbarPage(
      title = 'MGMC Mileage Club - Fellows',
      tabPanel('Find student',     DT::dataTableOutput('ex1')),
      tabPanel('Total Miles',      DT::dataTableOutput('total_miles')),
      tabPanel('Milestones',       DT::dataTableOutput('milestones'))
    )),
    server = function(input, output) {
      
      output$ex1 = DT::renderDataTable(
        DT::datatable(ids, options = list(pageLength = 25))
      )
      
      output$total_miles = DT::renderDataTable(
        DT::datatable(total_miles)
      )
      
      output$milestones = DT::renderDataTable(
        DT::datatable(milestones)
      )
    }
  )
}
