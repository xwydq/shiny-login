# ## example for auth api method
# login_auth <- function(user_name, pwd){
#   library(jsonlite)
#   library(httr)
#
#   auth_user = c("lijie", "linying", "yangxk", "xuwy01", "liugj", "xuxa")
#   if(!(user_name %in% auth_user)){
#     return(FALSE)
#   }else{
#     body_format = sprintf('{"username":"%s","password":"%s"}',
#                           user_name, pwd)
#     req = POST("http://IP:8088/api/user/auth_user", #auth addr
#                body = body_format)
#
#     json = content(req, "text", encoding = "UTF-8")
#
#     res = tryCatch({
#       object = jsonlite::fromJSON(json)
#       res = object$result == 200
#       },
#       error = function(e) {
#         res = FALSE
#       },
#       finally = function(){return(res)})
#     return(res)
#   }
# }


## test example auth
login_auth <- function(user_name, pwd) {
  if (user_name == "user" && pwd == "pwd") {
    return(TRUE)
  } else{
    return(FALSE)
  }
}

# login_auth("user", "pwd")
