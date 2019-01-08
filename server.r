library(ggplot2)
library(shinyjs)

server <- function(input, output, session){

  ##This observe function is to show and hide reset button based on the dropdown values
  observe({
    shinyjs::hide("reset")
    
    if(input$man != "All" | input$cyl != "All" | input$trans != "All" )
      shinyjs::show("reset")
  })
  
  ##This observeevent is to reset all the dropdown values to 'All' on click
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
  
  ### This render function is to display the data of mtcars as per the dropdown selection
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
  
  ##This render function is to display the Distribution of Cars by Mileage graph
  output$Milageplot <- renderPlot({
    ggplot(mtcars, aes(mpg)) +
      geom_histogram(binwidth = 4) + xlab('Miles per Gallon') + ylab('Number of Cars') + 
      ggtitle('Distribution of Cars by Mileage')
  })
  
  ##This render function is to display the Distribution of Cars by Cylinders
  output$Cylinderplot <- renderPlot({
    ggplot(mtcars, aes(cyl)) +
      geom_histogram(binwidth=1) + xlab('Cylinders') + ylab('Number of Cars') +
      ggtitle('Distribution of Cars by Cylinders')
  })
  
  ##This render function is to display the Distribution of Cars by Horsepower
  output$Horseplot <- renderPlot({
    ggplot(mtcars, aes(hp)) +
      geom_histogram(binwidth=20) + xlab('horsepower') + ylab('Number of Cars') +
      ggtitle('Distribution of Cars by Horsepower')
  })
  
  
  
}