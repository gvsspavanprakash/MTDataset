library(ggplot2)
library(shinyjs)
library(rsconnect)
server <- function(input, output, session){

  output$summary <- renderPrint({
    summary(mpg)
  })
  
  observe({
    shinyjs::hide("reset")
    
    if(input$man != "All" | input$cyl != "All" | input$trans != "All" )
      shinyjs::show("reset")
  })
  
  observeEvent(input$reset,{
    updateSelectInput(session, "man",
                      "Manufacturer:",
                      c("All",
                        unique(as.character(mpg$manufacturer))))
    
    updateSelectInput(session, "trans",
                      "Transmission:",
                      c("All",
                        unique(as.character(mpg$trans))))
    
    updateSelectInput(session, "cyl",
                      "Cylinders:",
                      c("All",
                        unique(as.character(mpg$cyl))))
    
    })
  
  output$mytable <- DT::renderDataTable({
    
    data <- mpg
    if (input$man != "All") {
      data <- data[data$manufacturer == input$man,]
    }
    if (input$cyl != "All") {
      data <- data[data$cyl == input$cyl,]
    }
    if (input$trans != "All") {
      data <- data[data$trans == input$trans,]
    }
    
    DT::datatable(data, options=list(orderClasses = TRUE))

  })
  
  output$Milageplot <- renderPlot({
    ggplot(mtcars, aes(mpg)) +
      geom_histogram(binwidth = 4) + xlab('Miles per Gallon') + ylab('Number of Cars') + 
      ggtitle('Distribution of Cars by Mileage')
  })
  
  output$Cylinderplot <- renderPlot({
    ggplot(mtcars, aes(cyl)) +
      geom_histogram(binwidth=1) + xlab('Cylinders') + ylab('Number of Cars') +
      ggtitle('Distribution of Cars by Cylinders')
  })
  
  output$Horseplot <- renderPlot({
    ggplot(mtcars, aes(hp)) +
      geom_histogram(binwidth=20) + xlab('horsepower') + ylab('Number of Cars') +
      ggtitle('Distribution of Cars by Horsepower')
  })
  
  
  
}