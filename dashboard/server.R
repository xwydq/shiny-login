library(shiny)
library(shinydashboard)

shinyServer(function(input, output, session) {
  ############
  shinyjs::addClass(selector = "body", class = "sidebar-collapse")
  shinyjs::removeClass(selector = "header", class = "main-header")
  
  source("server/login.R", local = TRUE)$value
  
  source("server/tab_sum.R", local = TRUE)$value
  
  source("server/tab_cross.R", local = TRUE)$value
 
})


