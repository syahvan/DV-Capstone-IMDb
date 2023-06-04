
# Header
header <- dashboardHeader(title = span("Movie Analysis", style = 'font-family: "Montserrat";
  font-style: bold;
  font-weight: 550;
  '))

# Sidebar
sidebar <- dashboardSidebar(
  sidebarMenu(
    menuItem("Overview", tabName = "overview", icon = icon("film")),
    menuItem(text = "Statistics", tabName = "stats", icon = icon("chart-line")),
    menuItem("Data", tabName = "tab_data", icon = icon("database")),
    menuItem("Profile", tabName = "User_Profile", icon = icon("address-card")),
    menuItem("Source Code", href = "https://github.com/syahvan/DV-Capstone-IMDb", icon = icon("code"))
  )
)

# Body
body <- dashboardBody(
  
  # using custom CSS 
  
  tags$head(tags$style(HTML('* { 
                            font-family: "Montserrat"; 
                            }
                            '))),
  
  tabItems(
    
    # PAGE 1 #
    
    tabItem(tabName = "overview",
            fluidPage(
              h2(tags$b("IMDb: Internet Movie Database")),
              div(style = "text-align:justify",
                  p('IMDb is an online repository that houses a vast collection of information related to movies, TV shows, podcasts, home 
                      videos, video games, and streaming content. It provides details such as cast and crew information, personal biographies, 
                      plot summaries, trivia, ratings, as well as fan and critical reviews. Initially established by fans on the Usenet group 
                      "rec.arts.movies" in 1990, IMDb transitioned to the internet in 1993. Since 1998, it has been under the ownership and 
                      operation of IMDb.com, Inc., a subsidiary of Amazon.'),
                  br()
              )
            ),
            
            
            
            fluidRow(
              valueBox("14 Million+", "Titles", icon = icon("film"), color = "red"),
              valueBox("7 Million+", "User Review", icon = icon("user"), color = "navy"),
              valueBox("495 Million+" , "Total Visits (April 2023)", icon = icon("globe"), color = "red"),
              valueBox("19", "Genre", icon = icon("play-circle"), color = "navy"),
              valueBox("58", "Country", icon = icon("earth-asia"), color = "red"),
              valueBox("53", "Language", icon = icon("language"), color = "navy")
            ),
            
            fluidPage(
              box(width = 16,
                  solidHeader = T,
                  title = tags$b("Movies Produced per Year Since 1903-2023"),
                  plotlyOutput("plot1")),
            )
    ),
    
    
      # PAGE 2 #

      tabItem(tabName = "stats",

              fluidPage(

                box(width = 8,
                    solidHeader = T,
                    title = tags$b("Best Movie in a Year Based on Rating"),
                    plotlyOutput("plot2")),
                box(width = 4,
                    solidHeader = T,
                    height = 110,
                    background = "navy",
                    selectInput(inputId = "year1",
                                label = "Select Year",
                                choices = unique(movie$year),)
                ),

                valueBoxOutput("best_movie", width = 4),
                valueBoxOutput("best_rating",width = 4),
                br()
              ),


              fluidPage(
                tabBox(width = 9,
                       title = tags$b("Top 10 Most Budget and Revenue"),
                       side = "right",
                       tabPanel(tags$b("Top Revenue"),
                                plotlyOutput("plot3", height=480)
                       ),
                       tabPanel(tags$b("Top Budget"),
                                plotlyOutput("plot4", height=480)
                       )
                ),
                box(width = 3,
                    solidHeader = T,
                    background = "navy",
                    sliderInput("year2", "Year Range:", min = 1903, max = 2023, value = c(1903, 2023))
                ),
                box(width = 3,
                    solidHeader = T,
                    background = "red",
                    radioButtons(inputId = "radio",
                                label = "Select Plot",
                                choices = c("Movie", "Country", "Genre", "Language")),
                ),
              ),
              
              
              fluidPage(
                box(width = 9,
                    solidHeader = T,
                    title = tags$b("Relationship between Budget, Revenue, and Rating"),
                    plotlyOutput("plot5")
                ),
                
                box(width = 3,
                    solidHeader = T,
                    background = "navy",
                    selectInput(inputId = "xlabel", 
                                label = "Select X Axis",
                                choices = c('Budget', 'Revenue', 'Rating')),
                    selectInput(inputId = "ylabel", 
                                label = "Select Y Axis",
                                choices = c('Revenue', 'Rating', 'Budget')) 
                ),
                
                box(tags$b("Choose whether to display trend"),
                    width = 3,
                    solidHeader = T,
                    background = "red",
                    checkboxInput("trend", "Display trend", FALSE)
                )
              ),
      ),

    # PAGE 3
    
    tabItem(tabName = "tab_data",
            fluidPage(
              h2(tags$b("About Dataset")),
              br(),
              div(style = "text-align:justify",
                  p("This dashboard uses a IMDb movie dataset from ", tags$a(href="https://www.kaggle.com/datasets/ashpalsingh1525/imdb-movies-dataset", "kaggle"), " which is cleaned. 
                    The IMDB dataset contains information about movies, including their names, release dates, user ratings, genres, overviews, 
                    cast and crew members, original titles, production status, original languages, budgets, revenues, and countries of origin. 
                    This data can be used for various analyses, such as identifying trends in movie genres, exploring the relationship between 
                    budget and revenue, and predicting the success of future movies.")),
                  
                  br(),
              
              dataTableOutput(outputId = "data"),
              br(),
            )
    ),
    
    # PAGE 4
    
    tabItem(tabName = "User_Profile",
            fluidPage(
              h2(tags$b("Profile")),
              br(),
              br(),
              div(style = "text-align:justify",
                  p("This project is made by Syahvan Alviansyah Diva Ritonga as a Capstone Project for completing Data Visualization Specialist in Algoritma Data Science School. You can connect me through ",
                    tags$a(href="https://www.linkedin.com/in/syahvanalviansyah/", "linkedin"),
                    " and please feel free to hit me up!"))))
    
  )
)

#Assembly

ui <- 
  dashboardPage(
    skin = "red",
    header = header,
    body = body,
    sidebar = sidebar
  )