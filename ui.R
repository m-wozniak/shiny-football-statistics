library(plotly)

players<-read.csv('bundesliga.csv')

minage<-min(players$age)
maxage<- max(players$age)
mintime <- min(players$minutesPlayed)
maxtime <- max(players$minutesPlayed)

fluidPage(
  
  
  headerPanel("Bundesliga 2016/17 stats explorer"),
  sidebarPanel(

    
    sliderInput('age', 'Age', min =  minage, max = maxage,
                value = c(minage,maxage), step = 1, round = 0),  
    sliderInput('minutes', 'Minutes played', min =  mintime, max = maxtime,
                value = c((mintime+maxtime)*0.20,maxtime), step = 1, round = 0),  
    
    
    selectInput('x', 'X', choices = axis_vars, selected = "goals"),
    selectInput('y', 'Y', choices = axis_vars, selected = "rating"),
    selectInput('color', 'Color', choices = axis_vars, selected = "position"),
    
    selectInput('facet_row', 'Facet Row', c(None = '.', facet_vars)),
    selectInput('facet_col', 'Facet Column', c(None = '.', facet_vars)),
    
    selectInput('accumulation', 'Accumulation', choices = c('Total','Per 90 minutes'), selected = "Per 90 minutes"),
    
    checkboxInput("jitter", "Add jitter", FALSE)
    
  ),
  
  mainPanel(
    plotlyOutput('trendPlot', height = "600px")
  )
)


