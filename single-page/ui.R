
library(shiny)

shinyUI(fluidPage(tags$head(tags$style(
  HTML("
       .shiny-split-layout > div {
       overflow: visible;
       }
       ")
  )),
  uiOutput("UI")))
