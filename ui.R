library(shiny)
library(plotly)

ui <- fluidPage(
  titlePanel(HTML("<h1 style='color: blue;'>BMI Tracker: WHO & Asia-Pacific</h1>")),
  sidebarLayout(
    sidebarPanel(
      HTML("Welcome to the BMI Calculator designed to meet WHO and Asia-Pacific standards. 
    This tool utilizes inputs of weight in kilograms and height in centimeters.
    According to the WHO guidelines, a healthy BMI falls within the range of 18.5 to 25,
    while the Asia-Pacific standard suggests a range of 18.5 to 22.9.
    Adjust the sliders below to input your weight and height,
    and observe how changes in kilograms and centimeters influence your BMI.<br>"),
      HTML("<br><h5 style='color: darkblue;'><i>Adjust the sliders for Height</i></h5>"),
      sliderInput("cm",
                  "Height in centimeters:",
                  min = 100,
                  max = 300,
                  value = 172
      ),
      HTML("<br><h5 style='color: darkbluedarkblue;'><i>Adjust the sliders for Mass</i></h5>"),
      sliderInput("kg",
                  "Mass in kilograms:",
                  min = 20,
                  max = 200,
                  value = 68
      ),
      "You can find the source code on my",
      a(href="https://github.com/ROHITHKM92/Coursera/tree/main/Developing_Data_Products/Week_3", "GitHub:ROHITHKM92"
        
      ),
      
    ),
    mainPanel(
      tabsetPanel(
        tabPanel("WHO (BMI)", plotOutput("bmiPlotWHO", click = "plot_click_who")),
        tabPanel("Asia-Pacific (BMI)", plotOutput("bmiPlotAsian", click = "plot_click_asian")),
        tabPanel("BMI Scatterplot", plotlyOutput("bmiScatterplot")),
        tabPanel("Documentation", includeHTML("documentation.html")),
        verbatimTextOutput("click_info")
      )
    )
  )
)