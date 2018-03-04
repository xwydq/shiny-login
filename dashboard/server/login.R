##############
USER <- reactiveValues(Logged = Logged, LoginPass = LoginPass)

## 登录界面
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
          logdf = data.frame(uid = USER$username,
                             p = password,
                             login_time = Sys.time())
          shinyjs::removeClass(selector = "body", class = "sidebar-collapse")
          shinyjs::addClass(selector = "header", class = "main-header")
          
          write.table(logdf, "data/user-login.txt", append = T)
          print(paste0("user:", username, "; 登录时间:", Sys.time()))
        }
        USER$LoginPass <<- -1
      }
    }
  }
})



output$sidebarpanel <- renderUI({
  if (USER$Logged == TRUE) {
    div(source("ui/sidebar.R", local = TRUE)$value)
  }
})

output$body <- renderUI({
  if (USER$Logged == TRUE) {
    mainbody
  }
  else {
    if(USER$LoginPass >= 0) {
      login
    }
    else {
      loginfail
    }
  }
})


shinyjs::addClass(selector = "body", class = "sidebar-collapse")
shinyjs::removeClass(selector = "header", class = "main-header")
# ###################