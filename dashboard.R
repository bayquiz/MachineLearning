#UI. R
library(shiny)
library(shinydashboard)
library(shinyMatrix)

sidebar <- dashboardSidebar(
  sidebarMenu(
    menuItem("Dashboard", tabName = "dashboard", icon = icon("dasboard")),
    menuItem("Input", tabName = "data input", icon = icon("th"), badgeColor = "green", badgeLabel = "new")
  )
)

body<- dashboardBody(
  tabItems(
    
    #first tab
    tabItem(tabName = "dashboard", 
      h2("Dashboard tab content")
    ),
  
  #second tab
    tabItem(tabName = "data input",
      h2("Data input conent"),
      page2 <- dashboardPage(header = "DATA"),
      box(fileInput("file1", "Choose CSV File",
                    accept = c(
                      "text/csv",
                      "text/comma-separated-values,text/plain",
                      ".csv")
       ),
     )
    )
  ),
)


ui <- dashboardPage(
  dashboardHeader(title = "PCA DASHBOARD"),
  sidebar,
  body
)

server <- function(input, output) {
  output$contents <- renderTable({
    
    inFile <- input$file1
    
    if(is.null(inFile))
      return(NULL)
    
    read.csv(inFile$datapath, header = input$header )
  })
}

shinyApp(ui, server)
