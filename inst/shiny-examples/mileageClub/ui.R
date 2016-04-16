library(shiny)

shinyUI(navbarPage(
  title = 'MGMC Mileage Club - Fellows',
  tabPanel('Find student',     DT::dataTableOutput('ex1')),
  tabPanel('Total Miles',      DT::dataTableOutput('total_miles')),
  tabPanel('Milestones',       DT::dataTableOutput('milestones'))
))
