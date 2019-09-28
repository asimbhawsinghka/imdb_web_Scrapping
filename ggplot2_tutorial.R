# Setup
# Turn off Scientific notations
options(scipen = 999)

# Load libraries
library(tidyverse)

# Load data
dat <- data("mpg", package = "ggplot2")

# Explore midwest dataset
str(midwest)

# Initialise ggplot with variables of interest
ggplot(midwest, aes(x = area, y = poptotal))
# A blank ggplot is drawn because we have not specified if we would like to draw a line chart or a scatter plot.

# Plot data: Scatter Plot
ggplot(midwest, aes(x = area, y = poptotal)) +
  geom_point()

# add a smoothing layer using geom_smooth(method='lm')
g <- ggplot(midwest, aes(x = area, y = poptotal)) +
  geom_point() +
  geom_smooth(method = "lm")

# Plot g
g

# Adjusting x and y axis limits by deleting points outside range
g + 
  xlim(c(0,0.1)) + 
  ylim(c(0,1000000))

# Adjusting x and y axis limits by Zooming In without deleting the points outside the limits
g1 <- g + 
  coord_cartesian(xlim = c(0, 0.1), 
                  ylim = c(0, 1000000))

g1

# using labs function to change plot title as well as labels
g1 + 
  labs(title="Area Vs Population", 
       subtitle="From midwest dataset", 
       y="Population", 
       x="Area", 
       caption="Midwest Demographics")

# Let’s change the color of the points and the line to a static value
ggplot(midwest, aes(x=area, y=poptotal)) + 
  geom_point(col="steelblue", size=3) +   # Set static color and size for points
  geom_smooth(method="lm", col="firebrick") +  # change the color of line
  coord_cartesian(xlim=c(0, 0.1), ylim=c(0, 1000000)) + 
  labs(title="Area Vs Population", subtitle="From midwest dataset", y="Population", x="Area", caption="Midwest Demographics")

#  if we want the color to change based on another column in the source dataset (midwest), it must be specified inside the aes() function
gg <- ggplot(midwest, aes(x=area, y=poptotal)) + 
  geom_point(aes(col=state), size=3) +  # Set color to vary based on state categories.
  geom_smooth(method="lm", col="firebrick", size=2) + 
  coord_cartesian(xlim=c(0, 0.1), ylim=c(0, 1000000)) + 
  labs(title="Area Vs Population", subtitle="From midwest dataset", y="Population", x="Area", caption="Midwest Demographics")

gg

# Change colour palette
gg +
  scale_color_brewer(palette = "GnBu")

# Changing breaks in x axis variables
gg + 
  scale_x_continuous(breaks = seq(0, 0.1, 0.01))

# Changing labels in ticks
gg +
  scale_x_continuous(breaks = seq(0, 0.1, 0.01),
                     labels = letters[1:11])
# Reverse X Axis scale
gg +
  scale_x_reverse()
