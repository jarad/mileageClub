#' Get mileage club summary
#' 
#' Get the mileage club summary as a shiny app which reports the cumulative miles, milestones, and students
#' reaching milestones.
#' 
#' @param cards A \code{data.frame} containing all the cards with the weeks that they were completed.
#' @param school A string containing the name of the school
#' @param ids A \code{data.frame} containing the student
#' @import shiny dplyr
#' @export
#' @examples
#' \dontrun{
#' cards = read_cards()
#' ids = read_csv('data/id.csv')
#' summary(cards,ids)
#' }
summary = function(cards,ids,school="Fellows") {
  total_miles = cumulative_miles(cards)
  
  milestones_df = milestones(cards) 
  
  milestone_summary = milestones_df %>%
    ungroup() %>%
    tidyr::spread_("week", "n", fill=0)
#   %>%
#     mutate_(Total = ~rowSums(select(-milestone)))
#   
  
  certificates = cards %>%
    cumulative_miles_by_id %>% 
    mutate_(milestone = ~cumulative_miles) %>%
    merge(ids, by='id') %>%
    select_(~first, ~last, ~grade, ~teacher, ~week, ~milestone) %>%
    arrange_(~grade,~teacher)
  
  weeks = unique(certificates$week)
  milestones = unique(certificates$milestone)
  
  

  shinyApp(
    ui = shinyUI(navbarPage(
      title = paste('MGMC Mileage Club -',school),
      tabPanel('Total Miles',  DT::dataTableOutput('total_miles' )),
      tabPanel('Milestones',   DT::dataTableOutput('milestones'  )),
      tabPanel('Certificates', 
               
               selectInput(inputId  = 'weeks', 
                           label    = 'Week:', 
                           choices  = weeks,
                           selected = max(weeks),
                           multiple = TRUE),
               
               selectInput(inputId  = 'milestones', 
                           label    = 'Milestones:', 
                           choices  = milestones,
                           selected = milestones,
                           multiple = TRUE),
               downloadButton('downloadData', 'Download'),
               
               DT::dataTableOutput('certificates'))
    )),
    server = function(input, output) {
      output$total_miles = DT::renderDataTable(
        DT::datatable(total_miles)
      )
      
      output$milestones = DT::renderDataTable(
        DT::datatable(milestone_summary)
      )
      
      filtered_certificates = reactive({
        certificates%>% 
          filter_(~week %in% input$weeks, ~milestone %in% input$milestones)
      })
      
      output$certificates = DT::renderDataTable(
        DT::datatable(filtered_certificates())
      )
      
      output$downloadData <- downloadHandler(
        filename = function() {
          foo = paste("certificates","weeks",input$weeks,"milestones",input$milestones,sep="_")
          paste(foo, "csv", sep = ".")
        },
        content = function(file) {
          readr::write_csv(filtered_certificates(), file)
        }
      )
    }
  )
}
