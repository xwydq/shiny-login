
tabItem(tabName = "tab_sum",
        tabsetPanel(
          tabPanel("关系阶段", br(),br(),
                   plotOutput("sum11", width = "50%")),
          tabPanel("性别", br(),br(),
                   plotOutput("sum12", width = "50%")),
          tabPanel("年龄", br(),br(),
                   plotOutput("sum13", width = "50%"))
        ))
