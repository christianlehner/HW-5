library(shiny)
library(dplyr)
library(wordcloud)
library(tm)

# Define UI for application that draws a histogram
ui <- shinyUI(fluidPage(
   
   # Application title
   titlePanel("Wordcloud"),
   
   # Sidebar with a slider input for number of bins 
    sidebarLayout(
      sidebarPanel(
        radioButtons("value",
                    "Book:",
                    choices=c("Tale_of_Two_Cities","Ulysses","The_Adventures_of_Sherlock_Holmes"),
                    selected="The_Adventures_of_Sherlock_Holmes")
      ),
      
      mainPanel(
         plotOutput("Plot")
      )
   )
))

# Define server logic required to draw a histogram
server <- shinyServer(function(input, output) {
   
   output$Plot <- renderPlot({
      value <- input$value
      book <-
        readLines(con = value, encoding="UTF-8") %>%
        as.character()
      book <- book %>%
        tolower() %>%
        removeNumbers() %>%
        removePunctuation() %>%
        removeWords(stopwords("english")) %>%
        stemDocument() %>%
        stripWhitespace()
      book <- VectorSource(book) %>%
        Corpus()
      wordcloud(book, scale=c(5,0.5), max.words=25, random.order=FALSE,
                 rot.per=0.35, use.r.layout=FALSE, colors=brewer.pal(8, "BuPu"))
      # wordcloud
   })
})


# Run the application 
shinyApp(ui = ui, server = server)

