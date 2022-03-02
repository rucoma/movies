#
# This is the server logic of a Shiny web application. You can run the
# application by clicking 'Run App' above.
#


library(shiny)

# Define server logic required 

shinyServer(function(input, output) {

  output$plotly <- renderPlotly({
    plot_ly(
      movies_small %>%
        filter(released_year >= input$year[1] &
                 released_year <= input$year[2] &
                 no_of_votes >= input$votes[1] &
                 gross_mm >= input$gross_mms[1] &
                 gross_mm <= input$gross_mms[2] &
                 grepl(pattern = input$genre, x = genre) &
                 grepl(pattern = input$director, x = director) &
                 grepl(pattern = input$cast, x = cast)
        ),
      x = ~get(input$axis_x), y = ~get(input$axis_y),
      # Hover text:
      text = ~paste('Title: ', series_title, '<br>Director: ', director, '<br>Rating:', imdb_rating),
      color = ~ imdb_rating
    ) %>%
      layout(title = 'Movie explorer',
             plot_bgcolor = "#F3F7FE",
             xaxis = list(title = variables_titles$title[variables_titles$var == input$axis_x]), 
             yaxis = list(title = variables_titles$title[variables_titles$var == input$axis_y]))
  })
})
