shinyServer(function(input, output) {
  
  # ----- OUTPUT PAGE 1 -----
  
  # PLOT 1
  output$plot1 <- renderPlotly({
    year_count <- movie %>% 
      group_by(year) %>% 
      summarise(value = n()) %>% 
      arrange(desc(year))
    
    plot_year <- ggplot(year_count, aes(x = year, y = value)) + 
      geom_line(color = "#DA1212")  +
      labs(x = "Year", y = "Value") +
      my_theme
    
    ggplotly(p = plot_year)
  })
  
  
  # ----- OUTPUT PAGE 2 -----
  
  # PLOT 2
  output$plot2 <- renderPlotly({
    popular <- movie %>% 
      filter(year == input$year1) %>% 
      arrange(desc(score)) %>% 
      mutate(text = glue("Film: {names}
                          IMDB Rating: {score}
                          Genre: {genre}
                          Original Language: {orig_lang}")) %>% 
      head(10)

    plot_popular <- ggplot(popular, 
                             aes(x = score, y = reorder(names, score), 
                                 text = text)) +
        geom_col(aes(fill = score)) +
        scale_y_discrete(labels = wrap_format(30)) + 
        scale_x_continuous(limits = c(0, 100), breaks = seq(0, 100, 10)) +
        scale_fill_gradient(low = "#FA9884", high = "#DA1212") + 
        labs(x = "IMDB Rating (0-100)", y = NULL, 
             title = glue("Top 10 Most Rating Movie {input$year1}"),
             legend) +
        my_theme

    ggplotly(plot_popular, tooltip = "text")
  })

  output$best_movie <- renderValueBox({

    best <- movie %>%
      filter(year == input$year1) %>%
      arrange(desc(score)) %>%
      head(1)

    valueBox(value = "Movie of the Year",
             subtitle = glue("{best$names}"),
             color = "red",
             icon = icon("trophy"))
  })

  output$best_rating <- renderValueBox({

    rating <- movie %>%
      filter(year == input$year1) %>%
      arrange(desc(score)) %>%
      head(1)

    valueBox(value = "Rating",
             subtitle = glue("{rating$score} / 100"),
             color = "red",
             icon = icon("star"))
  })


  #PLOT 3
  output$plot3 <- renderPlotly({
    if (input$radio == "Movie") {
      revenue <- movie %>%
        filter(year >= input$year2[1] & year <= input$year2[2]) %>%
        arrange(desc(revenue)) %>% 
        mutate(text = glue("Film: {names}
                          Year: {year}
                          Revenue: {revenue}
                          Genre: {genre}
                          Original Language: {orig_lang}")) %>% 
        head(10)
      
      plot_revenue <- ggplot(revenue, 
                             aes(x = revenue, y = reorder(names, revenue), 
                                 text = text)) +
        geom_col(aes(fill = revenue)) + 
        labs(x = "Revenue", y = NULL, 
             title = glue("Top 10 Most Revenue Based on Movie"),
             color = "Revenue")
      
    } else if (input$radio == "Country") {
      revenue <- movie %>% 
        filter(year >= input$year2[1] & year <= input$year2[2]) %>%
        group_by(country) %>% 
        summarise(revenue = sum(revenue)) %>% 
        arrange(desc(revenue)) %>% 
        mutate(text = glue("Revenue: {revenue}")) %>% 
        head(10)
      
      plot_revenue <- ggplot(revenue, 
                             aes(x = revenue, y = reorder(country, revenue), 
                                 text = text)) +
        geom_col(aes(fill = revenue)) + 
        labs(x = "Revenue", y = NULL, 
             title = glue("Top 10 Most Revenue Based on Country"),
             color = "Revenue")
      
    } else if (input$radio == "Genre") {
      revenue <- movie %>% 
        filter(year >= input$year2[1] & year <= input$year2[2]) %>%
        group_by(genre) %>% 
        summarise(revenue = sum(revenue)) %>% 
        arrange(desc(revenue)) %>% 
        mutate(text = glue("Revenue: {revenue}")) %>% 
        head(10)
      
      plot_revenue <- ggplot(revenue, 
                             aes(x = revenue, y = reorder(genre, revenue), 
                                 text = text)) +
        geom_col(aes(fill = revenue)) + 
        labs(x = "Revenue", y = NULL, 
             title = glue("Top 10 Most Revenue Based on Genre"),
             color = "Revenue")
      
    } else if (input$radio == "Language") {
      revenue <- movie %>%
        filter(year >= input$year2[1] & year <= input$year2[2]) %>%
        group_by(orig_lang) %>% 
        summarise(revenue = sum(revenue)) %>% 
        arrange(desc(revenue)) %>% 
        mutate(text = glue("Revenue: {revenue}")) %>% 
        head(10)
      
      plot_revenue <- ggplot(revenue, 
                             aes(x = revenue, y = reorder(orig_lang, revenue), 
                                 text = text)) +
        geom_col(aes(fill = revenue)) +
        labs(x = "Revenue", y = NULL, 
             title = glue("Top 10 Most Revenue Based on Language"),
             color = "Revenue")
    }
    
    plot_revenue <- plot_revenue +
      scale_y_discrete(labels = wrap_format(30)) +
      scale_fill_gradient(low = "#FA9884", high = "#DA1212") +
      my_theme
    
    ggplotly(plot_revenue, tooltip = "text")
  })
  
  # PLOT 4
  output$plot4 <- renderPlotly({
    if (input$radio == "Movie") {
      budget <- movie %>%
        filter(year >= input$year2[1] & year <= input$year2[2]) %>%
        arrange(desc(budget)) %>% 
        mutate(text = glue("Film: {names}
                          Year: {year}
                          Budget: {budget}
                          Genre: {genre}
                          Original Language: {orig_lang}")) %>% 
        head(10)
      
      plot_budget <- ggplot(budget, 
                             aes(x = budget, y = reorder(names, budget), 
                                 text = text)) +
        geom_col(aes(fill = budget)) +
        labs(x = "Budget", y = NULL, 
             title = glue("Top 10 Most Budget Based on Movie"),
             color = "Budget") 
      
    } else if (input$radio == "Country") {
      budget <- movie %>% 
        filter(year >= input$year2[1] & year <= input$year2[2]) %>%
        group_by(country) %>% 
        summarise(budget = sum(budget)) %>% 
        arrange(desc(budget)) %>% 
        mutate(text = glue("Budget: {budget}")) %>% 
        head(10)
      
      plot_budget <- ggplot(budget, 
                             aes(x = budget, y = reorder(country, budget), 
                                 text = text)) +
        geom_col(aes(fill = budget)) + 
        labs(x = "Budget", y = NULL, 
             title = glue("Top 10 Most Budget Based on Country"),
             color = "Budget")
      
    } else if (input$radio == "Genre") {
      budget <- movie %>% 
        filter(year >= input$year2[1] & year <= input$year2[2]) %>%
        group_by(genre) %>% 
        summarise(budget = sum(budget)) %>% 
        arrange(desc(budget)) %>% 
        mutate(text = glue("Budget: {budget}")) %>% 
        head(10)
      
      plot_budget <- ggplot(budget, 
                             aes(x = budget, y = reorder(genre, budget), 
                                 text = text)) +
        geom_col(aes(fill = budget)) + 
        labs(x = "Budget", y = NULL, 
             title = glue("Top 10 Most Budget Based on Genre"),
             color = "Budget")
      
    } else if (input$radio == "Language") {
      budget <- movie %>%
        filter(year >= input$year2[1] & year <= input$year2[2]) %>%
        group_by(orig_lang) %>% 
        summarise(budget = sum(budget)) %>% 
        arrange(desc(budget)) %>% 
        mutate(text = glue("Budget: {budget}")) %>% 
        head(10)
      
      plot_budget <- ggplot(budget, 
                             aes(x = budget, y = reorder(orig_lang, budget), 
                                 text = text)) +
        geom_col(aes(fill = budget)) +
        labs(x = "Budget", y = NULL, 
             title = glue("Top 10 Most Budget Based on Language"),
             color = "Budget")
    }
    
    plot_budget <- plot_budget +
      scale_y_discrete(labels = wrap_format(30)) +
      scale_fill_gradient(low = "#FA9884", high = "#DA1212") +
      my_theme
    
    ggplotly(plot_budget, tooltip = "text")
  })
  
  # PLOT 5
  output$plot5 <- renderPlotly({
    corr <- movie %>%  
      arrange(desc(score))
    colnames(corr)[10] <- "Budget"
    colnames(corr)[11] <- "Revenue"
    colnames(corr)[3] <- "Rating"
    corr <- subset(corr, corr$Budget > 100 & corr$Revenue > 100 & corr$Rating > 0)
    
    plot_corr <- ggplot(corr, 
                        aes_string(x = input$xlabel, y = input$ylabel)) +
        geom_point(alpha = 0.3, color = "#DA1212", aes(text = glue("Film: {names}
                                                     Year: {year}
                                                     Budget: {Budget}
                                                     Revenue: {Revenue}
                                                     Rating: {Rating}
                                                     Genre: {genre}"))) +
        labs(x = input$xlabel, y = input$ylabel, 
             title = glue("Relationship between {input$xlabel} and {input$ylabel}")) +
        my_theme
    
    if (input$trend == TRUE) {
      plot_corr <- plot_corr + geom_smooth(method = lm, formula = y ~ x)
    }
    
    ggplotly(plot_corr, tooltip = "text")
  })
  
  
  # ---- OUTPUT PAGE 3 -----
  output$data <- renderDataTable({
    DT::datatable(data = movie, options = list(scrollX=T))
  })
  
  
})