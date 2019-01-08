library(shiny)
library(ggplot2)
library(shinyjs)


"""The layout of the application is a navbar with two tabs - Data Snapshot & visualization
    Data Snapshot tab contains three select dropdown with a actionButton and a datatable
    Visualization tab contains a tabsetPanel with three tabs for plots
"""

navbarPage('MT Cars Dashboard',theme="custom-navbar.css",
           tabPanel('Data Snapshot',
                    
                    column(3,
                           selectInput("man",
                                       "Manufacturer:",
                                       c("All",
                                         unique(as.character(mpg$manufacturer))))
                    ),
                    column(3,
                           selectInput("trans",
                                       "Transmission:",
                                       c("All",
                                         unique(as.character(mpg$trans))))
                    ),
                    column(3,
                           selectInput("cyl",
                                       "Cylinders:",
                                       c("All",
                                         unique(as.character(mpg$cyl))))
                    ),
                    column(3,useShinyjs(),
                          actionButton("reset", "reset to defaults",
                                       style="color: #fff;background:#2073d4;margin-top: 24px;")
                    ),
   
                  DT::dataTableOutput("mytable")
                   
           ),
           tabPanel('Visualization',
                    h4('Distribution Graphs'),
                    tabsetPanel(type = "tabs",
                      tabPanel("Milage", plotOutput("Milageplot")),
                      tabPanel("Cylinders", plotOutput("Cylinderplot")),
                      tabPanel("Horsepower", plotOutput("Horseplot"))
                    )
                    
                )
           
           )
