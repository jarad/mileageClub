#' Find a student's name or ID
#' 
#' Launch a shiny app to help find a student's name or ID
#' 
#' @param ids A \code{data.frame} containing the student
#' @import shiny DT
#' @export
#' @examples
#' \dontrun{
#' find_name()
#' }
find_name = function(ids, school='Fellows') {
  shinyApp(
    ui = shinyUI(navbarPage(
      title = paste('MGMC Mileage Club -',school),
      tabPanel('Find student',     dataTableOutput('find_name'))
    )),
    server = function(input, output) {
      output$find_name = renderDataTable(
        datatable(ids, options = list(pageLength = 25))
      )
    }
  )
}
