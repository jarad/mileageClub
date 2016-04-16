#' Find a student's name or ID
#' 
#' Launch a shiny app to help find a student's name or ID
#' 
#' @param ids A \code{data.frame} containing the student
#' @param school A string containing the name of the school
#' @import shiny
#' @export
#' @examples
#' \dontrun{
#' find_name()
#' }
find_name = function(ids, school="Fellows") {
  shinyApp(
    ui = shinyUI(navbarPage(
      title = paste('MGMC Mileage Club -',school),
      tabPanel('Find student',     DT::dataTableOutput('find_name'))
    )),
    server = function(input, output) {
      output$find_name = DT::renderDataTable(
        DT::datatable(ids, options = list(pageLength = 25))
      )
    }
  )
}
