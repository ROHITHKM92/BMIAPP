library(shiny)
library(plotly)


# Define server logic required to draw diagram
server <- function(input, output) {
  output$bmiPlotWHO <- renderPlot({
    kg_input <- input$kg
    cm_input <- input$cm
    bmi_output <- 10000 * kg_input / cm_input / cm_input
    
    cm <- seq(from = 100, to = 300)
    kg_min <- numeric(length(cm)) + 20
    kg_max <- numeric(length(cm)) + 200
    kg_udr <- cm^2 * 18.5 / 10000
    kg_udr[kg_udr > 200] <- 200
    kg_udr[kg_udr < 20] <- 20
    kg_ovr <- cm^2 * 25 / 10000
    kg_ovr[kg_ovr > 200] <- 200
    kg_ovr[kg_ovr < 20] <- 20
    kg_obe <- cm^2 * 30 / 10000
    kg_obe[kg_obe > 200] <- 200
    kg_obe[kg_obe < 20] <- 20
    
    plot(0, xlim = c(100, 300), ylim = c(10, 210), xlab = "Height in cm", ylab = "Mass in kg", cex.lab = 2)
    polygon(c(cm, rev(cm)), c(kg_min, rev(kg_udr)), col = "palegreen3", border = NA) # Underweight
    polygon(c(cm, rev(cm)), c(kg_udr, rev(kg_ovr)), col = "cornflowerblue", border = NA) # Normal
    polygon(c(cm, rev(cm)), c(kg_ovr, rev(kg_obe)), col = "yellow", border = NA) # Overweight
    polygon(c(cm, rev(cm)), c(kg_obe, rev(kg_max)), col = "red", border = NA) # Obese
    points(cm_input, kg_input, pch = 21, bg = "black", cex = 2, lwd = 3)
    text(cm_input, kg_input, paste0("BMI = ", round(bmi_output, 1)), offset = 1, cex = 1.5, lwd = 4, pos = 4)
    text(100, 190, paste0("Obese"), cex = 1.5, lwd = 4, pos = 4)
    text(300, 30, paste0("Underweight"), cex = 1.5, lwd = 4, pos = 2)
    text(275, 160, paste0("Normal"), cex = 1.5, lwd = 4)
    text(250, 170, paste0("Overweight"), cex = 1.5, lwd = 4)
  })
  
  output$bmiPlotAsian <- renderPlot({
    kg_input <- input$kg
    cm_input <- input$cm
    bmi_output <- 10000 * kg_input / cm_input / cm_input
    
    cm <- seq(from = 100, to = 300)
    kg_min <- numeric(length(cm)) + 20
    kg_max <- numeric(length(cm)) + 200
    kg_udr <- cm^2 * 18.5 / 10000
    kg_udr[kg_udr > 200] <- 200
    kg_udr[kg_udr < 20] <- 20
    kg_ovr <- cm^2 * 22.9 / 10000
    kg_ovr[kg_ovr > 200] <- 200
    kg_ovr[kg_ovr < 20] <- 20
    kg_obe <- cm^2 * 25 / 10000
    kg_obe[kg_obe > 200] <- 200
    kg_obe[kg_obe < 20] <- 20
    
    plot(0, xlim = c(100, 300), ylim = c(10, 210), xlab = "Height in cm", ylab = "Mass in kg", cex.lab = 2)
    polygon(c(cm, rev(cm)), c(kg_min, rev(kg_udr)), col = "palegreen3", border = NA) # Underweight
    polygon(c(cm, rev(cm)), c(kg_udr, rev(kg_ovr)), col = "cornflowerblue", border = NA) # Normal
    polygon(c(cm, rev(cm)), c(kg_ovr, rev(kg_obe)), col = "yellow", border = NA) # Overweight
    polygon(c(cm, rev(cm)), c(kg_obe, rev(kg_max)), col = "red", border = NA) # Obese
    points(cm_input, kg_input, pch = 21, bg = "black", cex = 2, lwd = 3)
    text(cm_input, kg_input, paste0("BMI = ", round(bmi_output, 1)), offset = 1, cex = 1.5, lwd = 4, pos = 4)
    text(100, 190, paste0("Obese"), cex = 1.5, lwd = 4, pos = 4)
    text(300, 30, paste0("Underweight"), cex = 1.5, lwd = 4, pos = 2)
    text(290, 170, paste0("Normal"), cex = 1.5, lwd = 4)
    text(255, 165, paste0("Overweight"), cex = 1.5, lwd = 4)
  })
  
  # Generate interactive scatter plot
  output$bmiScatterplot <- renderPlotly({
    cm <- seq(from = 100, to = 300)
    kg <- seq(from = 20, to = 200)
    bmi <- outer(kg, cm, function(x, y) 10000 * x / y / y)
    
    bmi_df <- expand.grid(cm = cm, kg = kg)
    bmi_df$bmi <- as.vector(bmi)
    
    bmi_plot <- plot_ly(bmi_df, x = ~cm, y = ~kg, z = ~bmi, type = "scatter3d", mode = "markers", 
                        marker = list(size = 5, color = ~bmi, colorscale = "Viridis"),
                        text = ~paste("BMI: ", round(bmi, 1)), hoverinfo = "text")
    
    bmi_plot <- bmi_plot %>% layout(scene = list(xaxis = list(title = "Height in cm"),
                                                 yaxis = list(title = "Weight in kg"),
                                                 zaxis = list(title = "BMI")))
    
    bmi_plot
    
  })
  
  output$click_info <- renderPrint({
    req(input$plot_click_who)
    req(input$plot_click_asian)
    click_who <- input$plot_click_who
    click_asian <- input$plot_click_asian
    paste("Clicked at (WHO):", click_who$x, "cm height and", click_who$y, "kg mass.",
          "\nClicked at (Asian):", click_asian$x, "cm height and", click_asian$y, "kg mass.")
  })
}



