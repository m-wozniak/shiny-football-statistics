library(dplyr)
library(plotly)


players<-read.csv('bundesliga2.csv')

function(input, output) {
  
  dataset <- reactive({

    p<- players  %>% filter (
      age>=input$age[1], 
      age<=input$age[2],
      minutesPlayed>=input$minutes[1],
      minutesPlayed<=input$minutes[2]
    )
    
    if (input$accumulation == 'Per 90 minutes') p <- p %>% mutate_each(funs( ./minutesPlayed*90),goals:goalsConceded)
    
    p
  })
  
  output$trendPlot <- renderPlotly({

    p <- ggplot(dataset(), aes_string(x = input$x, y = input$y, color = input$color, text = 'name'))
    ifelse (input$jitter == TRUE, p<- p+ geom_jitter(), p<- p + geom_point() )
  
    
    facets <- paste(input$facet_row, '~', input$facet_col)
    if (facets != '. ~ .') p <- p + facet_grid(facets)
    
    ggplotly(p) %>% 
      layout(height = 500)
    
  })
  
}
