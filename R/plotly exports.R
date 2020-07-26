library(plotly)

fig <- plot_ly(data = iris, x = ~Sepal.Length, y = ~Petal.Length, type = "scatter", mode = "markers")

fig

library(ggplot2)

scatter <- ggplot(data=iris, aes(x = Sepal.Length, y = Sepal.Width)) 
scatter = scatter + geom_point(aes(color=Species, shape=Species)) +
  xlab("Sepal Length") +  ylab("Sepal Width") +
  ggtitle("Sepal Length-Width")
scatter
p = ggplotly(scatter)
library(htmlwidgets)
htmlwidgets::saveWidget(p, "test.html")
j = plotly_json(p)
write(j$x$data, "essai.json")
saveWidget(p, "p1.html", selfcontained = F, libdir = "lib")
htmltools::tags$iframe(
  src = "p1.html", 
  frameBorder = "0"
)  
scrolling = "no", 
seamless = "seamless",