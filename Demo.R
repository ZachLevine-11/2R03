library(shiny)
library(datasets)

df <- mtcars

#Tell the interpreter how to build the Shiny application.
server <- function(input, output){
  #Reactive so that the summary updates along with the user's choices
  summaryVarChoice <- reactive({
    #Use reactive input 'slots' to access the variables we'll store people's choice in. Then, to access the value we'll call a loading function that returns its current value.
    return(data.frame(df[input$choice]))
  })
  
  plotVarChoice <- reactive({
    #Use reactive input 'slots' to access the variables we'll store people's choice in. Then, to access the value we'll call a loading function that returns its current value.
    return(c(input$plotVarOne, input$plotVarTwo, input$plotTypeVar))
  })
  
  
  #Reactive, so it's all interactive.
  get_titleSize <- reactive({
    return(input$titleSize)
  })
  #To access the XtextSize value we'll call a loading function that returns its current value.
  get_Xsize <- reactive({
    return(input$XtextSize)
  })
  #To access the YtextSize value we'll call a loading function that returns its current value.
  get_Ysize <- reactive({
    return(input$YtextSize)
  })
  
  #Use a reactive variable loading function so that we can update the summary to reflect the user's choice in real time.
  output$view <- renderTable({
    theSummary <- base::summary(summaryVarChoice())[c(1, 3, 6, 7)]
    #Remove the name from the top of the summary table
    colnames(theSummary) <- NULL
    return(theSummary)
  })
  
  xy_range_str <- function(e) {
    if(is.null(e)) return("NULL\n")
    paste0("xmin=", round(e$xmin, 1), " xmax=", round(e$xmax, 1),
           " ymin=", round(e$ymin, 1), " ymax=", round(e$ymax, 1))
  }
  output$distPlot <- renderPlot({
    library("ggplot2")
    library("RColorBrewer")
    userSelection <- plotVarChoice()
    yesHist <- userSelection[[3]] == 1
    if (yesHist){
      #Grab the height of each bar to use as a label, and store them in a dataframe to use for plotting.
      vals <- unique(df[,userSelection[[1]]])
      counts <- c()
      for (i in 1:length(vals)){
        val <- vals[[i]]
        valCount <- sum(df[, userSelection[[1]]] == val, na.rm = TRUE)
        counts <- c(valCount, counts)
      }
      plotData <- data.frame(vals, counts)
      ggplot2::ggplot(data = plotData, aes(x = vals, y = counts)) + ggplot2::geom_col() + ggplot2::labs(title = paste("Histogram of", userSelection[[1]]), x = userSelection[[1]], y = "Number of Responses") +
        ggplot2::theme(
          plot.title = element_text(color = "black", size = get_titleSize(), face = "bold"),
          axis.title.x = element_text(color = "black", size = get_Xsize(), face = "bold"),
          axis.title.y = element_text(color = "black", size = get_Ysize(), face = "bold")
        ) +
        ggplot2::geom_text(data = plotData, mapping = aes(label = counts, x = vals, y = counts), vjust = -0.5)
    }
    else{
      ggplot2::ggplot(data = df, aes(x = df[,userSelection[[1]]] , y = df[,userSelection[[2]]], size = df[,userSelection[[2]]])) + ggplot2::geom_point(stat= "identity") +
        ggplot2::labs(title = paste(userSelection[[1]], " and ", userSelection[[2]]), x = userSelection[[1]], y = userSelection[[2]], size = "Number of responses") +
        ggplot2::theme(
          plot.title = element_text(color = "black", size = get_titleSize(), face = "bold"),
          axis.title.x = element_text(color = "black", size = get_Xsize(), face = "bold"),
          axis.title.y = element_text(color = "black", size = get_Ysize(), face = "bold")
        )
    }
  })
}

#Tell the interpreter exactly how we want the Shiny application to look.
ui <- fluidPage(
  titlePanel("ArtSci 2R03 Tutorial 1 Demonstration"),
  fluidRow(
    column(2,
           selectInput("plotVarOne", label = "x-axis variable",
                       choices = colnames(df))),
    column(2,
           radioButtons("plotTypeVar", label = h3("Plot type"),
                        choices = list("Histogram" = 1, "Scatter Plot" = 2),
                        selected = 1)),
    column(2, selectInput("choice", label = "Summary variable",
                          choices = colnames(df))),
    column(2,
           tableOutput("view"))
  ),
  fluidRow(
    #Only show the selector for the y axis variable if we're dealing with a scatter plot.
    conditionalPanel(
      condition = "input.plotTypeVar == 2",
      column(2,
             selectInput("plotVarTwo", label = "y-axis variable",
                         choices = colnames(df)))
    )
  ),
  fluidRow(
    column(10,
           plotOutput("distPlot"))
  ),
  fluidRow(
    #Space the UI properly with empty columns.
    column(2,
           sliderInput("titleSize", "Title size:",
                       min = 0, max = 25,
                       value = 20)),
    column(2,
           sliderInput("XtextSize", "X axis title size:",
                       min = 0, max = 25,
                       value = 10)),
    column(2,
           sliderInput("YtextSize", "Y axis title size:",
                       min = 0, max = 25,
                       value = 10))
  )
)

run <- function(){
  shinyApp(ui = ui, server = server)
}
