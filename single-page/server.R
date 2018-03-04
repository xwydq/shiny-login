

# This is the server logic for a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#

library(shiny)
library(dplyr)
library(lubridate)


shinyServer(function(session, input, output) {
  vt = reactiveValues(pltDat = NULL)
  
  ##############
  USER <- reactiveValues(Logged = Logged, LoginPass = LoginPass)
  
  ## global ui is dynamic
  output$UI = renderUI({
    if (USER$Logged == FALSE) {
      return()
    } else{
      removeModal()
      tagList(
        # Application title
        titlePanel("业绩示例画图之影响因素"),
        
        splitLayout(
          selectInput(
            inputId = "id_lcs",
            label = "人员姓名",
            choices = lcs
          ),
          selectInput(
            inputId = "id_fields",
            label = "业绩影响变量",
            choices = fields
          )
        ),
        
        eChartOutput("exmplot", width = "100%", height = "600px")
      )
    }
  })
  
  ## login interface
  showModal(dMdlLogin)
  
  observe({
    if (USER$Logged == FALSE) {
      if (!is.null(input$Login)) {
        if (input$Login > 0) {
          username <- isolate(input$userName)
          password <- isolate(input$passwd)
          
          user_yn = TRUE
          power_yn = login_auth(username, password)
          
          if (user_yn & power_yn) {
            USER$Logged <<- TRUE
            USER$LoginPass <<- 1
            USER$username <<- username
            
            # log for user login
            logdf = data.frame(uid = USER$username,
                               login_time = Sys.time())
            write.table(logdf, "data/login-log.txt", append = T)
            print(paste0("user:", username, "; 登录时间:", Sys.time()))
          }
          USER$LoginPass <<- -1
        }
      }
    }
  })
  
  
  observeEvent({
    input$Login
  },
  {
    if (USER$Logged == FALSE) {
      showModal(dMdlLoginFail)
    }
  })
  
  
  
  observeEvent({
    input$id_lcs
    input$id_fields
  },
  {
    vt$pltDat = yjl %>%
      filter(name == input$id_lcs) %>%
      select_("年", "月", "交易额", input$id_fields)
  })
  
  ## interactive plot with echart
  output$exmplot = renderEChart({
    if (USER$Logged == FALSE) {
      return()
    } else{
      removeModal()
      
      series2 = list(
        list(
          name = '业绩量',
          type = 'bar',
          data = vt$pltDat$交易额
        ),
        list(
          name = input$id_fields,
          type = 'line',
          yAxisIndex = 1,
          data = vt$pltDat[, 4]
          
        )
      )
      
      ext = list(xAxis = list(list(
        type = "category",
        data = paste(vt$pltDat[, 1], vt$pltDat[, 2], sep = "/")
      )),
      yAxis = list(
        list(
          type =  'value',
          name =  '业绩量',
          min =  0,
          max =  max(vt$pltDat$交易额),
          # interval =  50,
          axisLabel =  list(formatter =  '{value} 万')
        ),
        list(
          type =  'value',
          name =  input$id_fields,
          min =  0,
          max =  max(vt$pltDat[, 4]),
          # interval =  5,
          axisLabel = list(formatter = '{value}')
        )
      ))
      ePlot(series2, ext)
    }
  })
})
