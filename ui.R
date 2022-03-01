#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#

library(shiny)

# Define UI for application
shinyUI(fluidPage(

    # Application title
    titlePanel("Movies explorer"),

    # Sidebar with sliders and selectors
    sidebarLayout(
        sidebarPanel(
            sliderInput(inputId = 'year',
                        label = 'Year',
                        min = 1920,
                        max = 2020,
                        value = c(1920, 2020),
                        step = 1
                        ),
            sliderInput(inputId = 'votes',
                        label = 'Minimum number of votes',
                        min = 25e3,
                        max = 2.4e5,
                        value = 25e3,
                        step = 1e3
            ),
            sliderInput(inputId = 'gross_mms',
                        label = 'Gross (millions)',
                        min = 0,
                        max = 950,
                        value = c(0, 950),
                        step = 10
            ),
            selectInput(inputId = 'genre',
                        label = 'Genre of the movie',
                        choices = genres,
                        selected = NULL),
            textInput(inputId = 'director',
                      label = 'Director name (contains)'),
            textInput(inputId = 'cast',
                      label = 'cast name (contains)'),
            selectInput(inputId = 'axis_x',
                        label = 'X-axis variable',
                        choices = variables_plot,
                        selected = 'released_year'),
            selectInput(inputId = 'axis_y',
                        label = 'Y-axis variable',
                        choices = variables_plot,
                        selected = 'no_of_votes')
        ),

        # Show a plot of the generated distribution
        mainPanel(
          plotlyOutput(outputId = 'plotly', width = '1100px', height = '800px')
        )
    )
))
