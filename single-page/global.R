library(recharts) #https://github.com/cosname/recharts
library(dplyr)

yjl = read.csv("data/yjl.csv")
lcs = unique(yjl$name)
fields = c("交易量", "新成交客户数", "VIP数", "电话量", "拜访量")
source("tools/login_auth.R")


#######################
Logged <- FALSE
LoginPass <- 0
#0: not attempted, -1: failed, 1: passed

login <- div(id = "logintab1",
             fluidPage(
               includeCSS(
                 "http://maxcdn.bootstrapcdn.com/bootstrap/3.3.4/css/bootstrap.min.css"
               ),
               includeCSS("www/login.css"),
               includeHTML("www/login-part.html")
             ))

loginfail <- div(id = "logintab2",
                 fluidPage(
                   includeCSS(
                     "http://maxcdn.bootstrapcdn.com/bootstrap/3.3.4/css/bootstrap.min.css"
                   ),
                   includeCSS("www/login.css"),
                   includeHTML("www/loginfail-part.html")
                 ))

dMdlLogin <- modalDialog(
  div(id = "logintt", login),
  footer = NULL,
  size = "l",
  easyClose = F
)

dMdlLoginFail <- modalDialog(
  div(id = "logintt", loginfail),
  footer = NULL,
  size = "l",
  easyClose = F
)