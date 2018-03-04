#######################
Logged <- FALSE;
LoginPass <- 0; #0: not attempted, -1: failed, 1: passed

login <- tabBox(id = "logintab1", 
  tabPanel("登陆", 
           textInput("userName", "用户名"),
           passwordInput("passwd", "密码"),
           br(),actionButton("Login", "登陆"))
)


login <- div(id = "logintab1", 
             fluidPage(
               includeCSS("http://maxcdn.bootstrapcdn.com/bootstrap/3.3.4/css/bootstrap.min.css"),
               includeCSS("www/login.css"),
               includeHTML("www/login-part.html")
             )
)

loginfail <- tabBox(id = "logintab2", 
  tabPanel("登陆", 
           textInput("userName", "用户名"),
           passwordInput("passwd", "密码"),
           p("用户名或密码不正确", style = "color:red"),
           br(),actionButton("Login", "登陆"))
)

loginfail <- div(id = "logintab2", 
             fluidPage(
               includeCSS("http://maxcdn.bootstrapcdn.com/bootstrap/3.3.4/css/bootstrap.min.css"),
               includeCSS("www/login.css"),
               includeHTML("www/loginfail-part.html")
             )
)