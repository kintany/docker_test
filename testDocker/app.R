library(shiny)
library(shinyFiles)

ui <- fluidPage( # Application title
  mainPanel(
    shinyDirButton("dir", label="Input directory", title="Upload"),
    verbatimTextOutput("dir", placeholder = TRUE)  
  ))

server <- function(input, output) {
  shinyDirChoose(
    input,
    'dir',
    roots = c(home = '~'),
    filetypes = c('', 'txt', 'bigWig', "tsv", "csv", "bw")
  )
  
  global <- reactiveValues(datapath = getwd())
  
  dir <- reactive(input$dir)
  
  output$dir <- renderText({
    global$datapath
  })
  
  observeEvent(ignoreNULL = TRUE,
               eventExpr = {
                 input$dir
               },
               handlerExpr = {
                 home <- normalizePath("~")
                 req(is.list(input$dir))
                 global$datapath <-
                   file.path(home, paste(unlist(dir()$path[-1]), collapse = .Platform$file.sep))
               })
}

# Run the application
shinyApp(ui = ui, server = server)