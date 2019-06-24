################################################################################
################################################################################
##                                                                            ##
##                           shiny - examples                                 ##
##                                                                            ##
################################################################################
################################################################################


# install.packages("shiny")
require(shiny)


################################################################################
##                          bulit-in examples                                 ##
################################################################################

system.file("examples", package="shiny")

runExample("01_hello") # a histogram
runExample("02_text") # tables and data frames
runExample("03_reactivity") # a reactive expression
runExample("04_mpg") # global variables
runExample("05_sliders") # slider bars
runExample("06_tabsets") # tabbed panels
runExample("07_widgets") # help text and submit buttons
runExample("08_html") # shiny app built from HTML
runExample("09_upload") # file upload wizard
runExample("10_download") # file download wizard
runExample("11_timer") # an automated timer



################################################################################
##                             make your own                                  ##
################################################################################

#-------------------------------------------------------------------------------
# make a folder to store the files 

setwd("~/Resources/R/Examples/shiny")
dir.create("shiny_test", FALSE)

#-------------------------------------------------------------------------------
# make a user interface file

cat('
library(shiny)

# Define UI for application that draws a histogram
shinyUI(fluidPage(
    
    # Application title
    titlePanel("Hello Shiny!"),
    
    # Sidebar with a slider input for the number of bins
    sidebarLayout(
        sidebarPanel(
            sliderInput("bins",
                        "Number of bins:",
                        min = 1,
                        max = 50,
                        value = 30)
        ),
        
        # Show a plot of the generated distribution
        mainPanel(
            plotOutput("distPlot")
        )
    )
))
', file = "shiny_test/ui.R")

#-------------------------------------------------------------------------------
# make a server file

cat('
library(shiny)

# Define server logic required to draw a histogram
shinyServer(function(input, output) {

  # Expression that generates a histogram. The expression is
  # wrapped in a call to renderPlot to indicate that:
  #
  #  1) It is "reactive" and therefore should be automatically
  #     re-executed when inputs change
  #  2) Its output type is a plot

  output$distPlot <- renderPlot({
    x    <- faithful[, 2]  # Old Faithful Geyser data
    bins <- seq(min(x), max(x), length.out = input$bins + 1)

    # draw the histogram with the specified number of bins
    hist(x, breaks = bins, col = "skyblue", border = "white")
  })
})
', file = "shiny_test/server.R")

#-------------------------------------------------------------------------------
# run the app

runApp("shiny_test")

# can also include code on webpage
runApp("shiny_test", display.mode = "showcase")


################################################################################
##                                   END                                      ##
################################################################################
