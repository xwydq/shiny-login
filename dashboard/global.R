options(stringsAsFactors=FALSE, scipen=10, digits=4)
## 修改上传文件大小限制--200M
options(shiny.maxRequestSize=200*1024^2)
# Cairo包的PNG设备似乎无法显示中文字符，强制使用R自身的png()设备
options(shiny.usecairo = FALSE)

library(shiny)
library(shinydashboard)
library(shinyjs)

source("tools/login_auth.R")


#######################
source("ui/login.R", local = TRUE)$value

mainbody <- div(
  tabItems(
    source("ui/tab_sum.R", local = TRUE)$value,

    source("ui/tab_cross.R", local = TRUE)$value
  )
)

header <- dashboardHeader(title = "login DEMO",
                          titleWidth = 180)

sidebar <- dashboardSidebar(width = 180, uiOutput("sidebarpanel"))
body <- dashboardBody(
  shinyjs::useShinyjs(),
  includeCSS("www/style.css"),
  uiOutput("body"))
#######################