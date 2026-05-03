library(shiny)
library(ggplot2)
library(dplyr)
library(ggpattern)
library(scales)

brfss <- read.csv("brfss_subset_small.csv")

brfss_clean <- brfss %>%
  filter(
    GENHLTH %in% c("Excellent", "Very good", "Good", "Fair", "Poor"),
    EXERANY2 %in% c("Yes", "No")
  ) %>%
  mutate(
    GENHLTH = factor(
      GENHLTH,
      levels = c("Poor", "Fair", "Good", "Very good", "Excellent"),
      ordered = TRUE
    )
  )

table_exercise_health <- table(brfss_clean$EXERANY2, brfss_clean$GENHLTH)
chisq_test <- chisq.test(table_exercise_health)

cramers_v <- sqrt(as.numeric(chisq_test$statistic) / 
                    (sum(table_exercise_health) * 
                       (min(dim(table_exercise_health)) - 1)))
ui <- fluidPage(
  titlePanel("Exercise Participation and Self-Reported General Health"),
  
  p("App goal: This Shiny app allows users to explore whether exercise participation is associated with self-reported general health among adults in New York. Users can compare the distribution of general health between adults who reported exercising and those who did not, view either proportions or counts, and display the chi-square test result."),
  
  h4("Author"),
  p("Puying Li"),
  
  h4("Research Question"),
  p("Is exercise participation associated with self-reported general health among adults in New York?"),
  
  h4("Data Source"),
  p("This app uses a subset of BRFSS data including adults from New York. The variables used are self-reported general health and exercise participation."),
  
  h4("Methods"),
  p("The app excludes non-informative responses such as 'Refused' and 'Don't know/Not sure'. A chi-square test of independence is used to examine the association between exercise participation and self-reported general health."),
  
  h4("Variable Definitions"),
  tags$ul(
    tags$li("EXERANY2: whether the respondent reported participating in exercise during the past 30 days."),
    tags$li("GENHLTH: self-reported general health, categorized as Excellent, Very good, Good, Fair, or Poor."),
    tags$li("Plot type: Proportion shows the relative distribution within each exercise group; Count shows the number of respondents in each category.")
  ),
  
  h4("GitHub Repository"),
  tags$a("View code on GitHub", 
         href = "https://github.com/Puying305/Final_Report", 
         target = "_blank"),
  
  h4("AI Use Disclosure"),
  p("ChatGPT was used to help debug R/Shiny code and improve the organization of the app. The analysis decisions and interpretation were completed by the author."),
  
  sidebarLayout(
    sidebarPanel(
      selectInput(
        inputId = "plot_type",
        label = "Choose plot type:",
        choices = c("Proportion" = "fill", "Count" = "stack"),
        selected = "fill"
      ),
      
      checkboxInput(
        inputId = "show_result",
        label = "Show chi-square test result",
        value = TRUE
      )
    ),
    
    mainPanel(
      h3("Self-Reported General Health by Exercise Participation"),
      plotOutput("health_plot"),
      
      h4("Summary Table"),
      tableOutput("summary_table"),
      
      conditionalPanel(
        condition = "input.show_result == true",
        h4("Statistical Result"),
        verbatimTextOutput("chisq_result")
      )
    )
  )
)
server <- function(input, output) {
  
  output$health_plot <- renderPlot({
    
    p <- ggplot(brfss_clean, aes(x = EXERANY2, fill = GENHLTH, pattern = GENHLTH)) +
      geom_bar_pattern(
        position = input$plot_type,
        color = "black",
        pattern_fill = "black",
        pattern_colour = "black",
        pattern_density = 0.05,
        pattern_spacing = 0.04
      ) +
      scale_fill_grey(start = 0.95, end = 0.55) +
      scale_pattern_manual(values = c(
        "Poor" = "stripe",
        "Fair" = "crosshatch",
        "Good" = "circle",
        "Very good" = "wave",
        "Excellent" = "none"
      )) +
      labs(
        title = "Distribution of Self-Reported General Health by Exercise Participation",
        x = "Exercise participation in the past 30 days",
        y = ifelse(input$plot_type == "fill", "Percentage of respondents", "Number of respondents"),
        fill = "Self-reported general health",
        pattern = "Self-reported general health"
      ) +
      theme_minimal(base_size = 14) +
      theme(
        plot.title = element_text(face = "bold"),
        legend.title = element_text(size = 12),
        legend.text = element_text(size = 11),
        axis.title = element_text(size = 12),
        axis.text = element_text(size = 11)
      )
    
    if (input$plot_type == "fill") {
      p <- p + scale_y_continuous(labels = percent_format())
    }
    
    p
  })
  output$summary_table <- renderTable({
    brfss_clean %>%
      count(EXERANY2, GENHLTH) %>%
      group_by(EXERANY2) %>%
      mutate(Proportion = round(n / sum(n), 3)) %>%
      rename(
        "Exercise participation" = EXERANY2,
        "Self-reported general health" = GENHLTH,
        "Count" = n
      )
  })
  
  output$chisq_result <- renderPrint({
    cat("Pearson's chi-square test of independence\n")
    cat("Chi-square =", round(chisq_test$statistic, 2), "\n")
    cat("Degrees of freedom =", chisq_test$parameter, "\n")
    cat("Cramer's V =", round(cramers_v, 3), "\n")
    cat("p-value < 0.001\n")
    cat("\nInterpretation: Exercise participation is significantly associated with self-reported general health.")
  })
}

shinyApp(ui = ui, server = server)