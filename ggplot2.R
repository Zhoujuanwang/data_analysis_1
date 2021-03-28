library(ggplot2)

# aes_group_order
p <- ggplot(mtcars, aes(wt, mpg))
# scatter plot
p + geom_point(size = 4)
p + geom_point(aes(colour = factor(cyl)), size = 4)
p + geom_point(aes(shape = factor(cyl)), size = 4)

# Using fill:
p <- ggplot(mtcars, aes(factor(cyl)))
p + geom_bar()
p + geom_bar(aes(fill = factor(cyl)))
p + geom_bar(aes(fill = factor(vs)))

ggplot(economics_long, aes(date, value01)) + geom_line(aes(linetype = variable))

# Multiple groups with one aesthetic:
p <- ggplot(nlme::Oxboys, aes(age, height))
p + geom_line()
p + geom_line(aes(group = Subject))

df <- data.frame(x = 1:10 , y = 1:10)
p <- ggplot(df, aes(x, y))
p + geom_line(linetype = 2)
p + geom_line(linetype = "dotdash")

p + geom_line(linetype = "3313")
p + geom_line(linetype = "33")

# Mapping line type from a grouping variable
p + geom_point(aes(shape = factor(cyl)))
ggplot(economics_long, aes(date, value01)) +
  geom_line(aes(linetype = variable))

# Size examples
p <- ggplot(mtcars, aes(wt, mpg))
p + geom_point(size = 4)
p + geom_point(aes(size = qsec))
p + geom_point(size = 2.5) +
  geom_hline(yintercept = 25, size = 3.5)

# Shape examples
p + geom_point()
p + geom_point(shape = 5)
p + geom_point(shape = "k", size = 3)
p + geom_point(shape = ".")
p + geom_point(shape = NA)

# A look at all 25 symbols
df2 <- data.frame(x = 1:5 , y = 1:25, z = 1:25)
p <- ggplot(df2, aes(x, y))
p + geom_point(aes(shape = z), size = 4) +
  scale_shape_identity()

# While all symbols have a foreground colour, symbols 19-25 also take a
# background colour (fill)
p + geom_point(aes(shape = z), size = 4, colour = "Red") +
  scale_shape_identity()
p + geom_point(aes(shape = z), size = 4, colour = "Red", fill = "Black") +
  scale_shape_identity()

# aes_position:
# Generate data: means and standard errors of means for prices
# for each type of cut
dmod <- lm(price ~ cut, data = diamonds)
cut <- unique(diamonds$cut)
cuts_df <- data.frame(
  cut,
  predict(dmod, data.frame(cut), se = TRUE)[c("fit", "se.fit")]
)
ggplot(cuts_df) +
  aes(
    x = cut,
    y = fit,
    ymin = fit - se.fit,
    ymax = fit + se.fit,
    colour = cut
  ) +
  geom_errorbar()

# Using annotate
p <- ggplot(mtcars, aes(x = wt, y = mpg)) + geom_point()
p
p + annotate(
  "rect", xmin = 2, xmax = 3.5, ymin = 2, ymax = 25,
  fill = "dark grey", alpha = .5
)

# Geom_segment examples
p + geom_segment(
  aes(x = 2, y = 15, xend = 2, yend = 25),
  arrow = arrow(length = unit(0.5, "cm"))
)
p + geom_segment(
  aes(x = 2, y = 15, xend = 3, yend = 15),
  arrow = arrow(length = unit(0.5, "cm"))
)
p + geom_segment(
  aes(x = 5, y = 30, xend = 3.5, yend = 25),
  arrow = arrow(length = unit(0.5, "cm"))
)

# You can also use geom_segment() to recreate plot(type = "h")
# from base R:
counts <- as.data.frame(table(x = rpois(100, 5)))
counts$x <- as.numeric(as.character(counts$x))
with(counts, plot(x, Freq, type = "h", lwd = 10))
ggplot(counts, aes(x = x, y = Freq)) +
  geom_segment(aes(yend = 0, xend = x), size = 10)

# annotate()
p <- ggplot(mtcars, aes(x = wt, y = mpg)) + geom_point()
p + annotate("text", x = 4, y = 25, label = "Some text")
p + annotate("text", x = 2:5, y = 25, label = "Some text")
p + annotate("text", x = mtcars$wt, y = mtcars$mpg, label = "2")
p + annotate("rect", xmin = 3, xmax = 4.2, ymin = 12, ymax = 21,
             alpha = .2)
p + annotate("segment", x = 2.5, xend = 4, y = 15, yend = 25,
             colour = "blue")
p + annotate("pointrange", x = 3.5, y = 20, ymin = 12, ymax = 28,
             colour = "red", size = 1.5)
p + annotate("text", x = 2:3, y = 20:21, label = c("my label", "label 2"))
p + annotate("text", x = 4, y = 25, label = "italic(R) ^ 2 == 0.75",
             parse = TRUE)
p + annotate("text", x = 4, y = 25,
             label = "paste(italic(R) ^ 2, \" = .75\")", parse = TRUE)

# annotation_custom
# Dummy plot
df <- data.frame(x = 1:10, y = 1:10)
base <- ggplot(df, aes(x, y)) +
  geom_blank() +
  theme_bw()
# Full panel annotation
base + annotation_custom(
  grob = grid::roundrectGrob(),
  xmin = -Inf, xmax = Inf, ymin = -Inf, ymax = Inf
)
# Inset plot
df2 <- data.frame(x = 1 , y = 1)
g <- ggplotGrob(ggplot(df2, aes(x, y)) +
                  geom_point() +
                  theme(plot.background = element_rect(colour = "black")))
base +
  annotation_custom(grob = g, xmin = 1, xmax = 10, ymin = 8, ymax = 10)


# annotation_logticks()
# Make a log-log plot (without log ticks)
a <- ggplot(msleep, aes(bodywt, brainwt)) +
  geom_point(na.rm = TRUE) +
  scale_x_log10(
    breaks = scales::trans_breaks("log10", function(x) 10^x),
    labels = scales::trans_format("log10", scales::math_format(10^.x))
  ) +
  scale_y_log10(
    breaks = scales::trans_breaks("log10", function(x) 10^x),
    labels = scales::trans_format("log10", scales::math_format(10^.x))
  ) +
  theme_bw()
a + annotation_logticks() # Default: log ticks on bottom and left
a + annotation_logticks(sides = "lr") # Log ticks for y, on left and right
a + annotation_logticks(sides = "trbl") # All four sides
a + annotation_logticks(sides = "lr", outside = TRUE) +
  coord_cartesian(clip = "off") # Ticks outside plot
# Hide the minor grid lines because they don't align with the ticks
a + annotation_logticks(sides = "trbl") + theme(panel.grid.minor = element_blank())
# Another way to get the same results as 'a' above: log-transform the data before
# plotting it. Also hide the minor grid lines.
b <- ggplot(msleep, aes(log10(bodywt), log10(brainwt))) +
  geom_point(na.rm = TRUE) +
  scale_x_continuous(name = "body", labels = scales::math_format(10^.x)) +
  scale_y_continuous(name = "brain", labels = scales::math_format(10^.x)) +
  theme_bw() + theme(panel.grid.minor = element_blank())
b + annotation_logticks()
# Using a coordinate transform requires scaled = FALSE
t <- ggplot(msleep, aes(bodywt, brainwt)) +
  geom_point() +
  coord_trans(x = "log10", y = "log10") +
  theme_bw()
t + annotation_logticks(scaled = FALSE)
# Change the length of the ticks
a + annotation_logticks(
  short = unit(.5,"mm"),
  mid = unit(3,"mm"),
  long = unit(4,"mm")
)

# annotation_map()
if (require("maps")) {
  usamap <- map_data("state")
  seal.sub <- subset(seals, long > -130 & lat < 45 & lat > 40)
  ggplot(seal.sub, aes(x = long, y = lat)) +
    annotation_map(usamap, fill = NA, colour = "grey50") +
    geom_segment(aes(xend = long + delta_long, yend = lat + delta_lat))
}
if (require("maps")) {
  seal2 <- transform(seal.sub,
                     latr = cut(lat, 2),
                     longr = cut(long, 2))
  ggplot(seal2, aes(x = long, y = lat)) +
    annotation_map(usamap, fill = NA, colour = "grey50") +
    geom_segment(aes(xend = long + delta_long, yend = lat + delta_lat)) +
    facet_grid(latr ~ longr, scales = "free", space = "free")
}

# annotation_raster()
# Generate data
rainbow <- matrix(hcl(seq(0, 360, length.out = 50 * 50), 80, 70), nrow = 50)
ggplot(mtcars, aes(mpg, wt)) +
  geom_point() +
  annotation_raster(rainbow, 15, 20, 3, 4, interpolate = FALSE)
# To fill up whole plot
ggplot(mtcars, aes(mpg, wt)) +
  annotation_raster(rainbow, -Inf, Inf, -Inf, Inf) +
  geom_point()
rainbow2 <- matrix(hcl(seq(0, 360, length.out = 10), 80, 70), nrow = 1)
ggplot(mtcars, aes(mpg, wt)) +
  annotation_raster(rainbow2, -Inf, Inf, -Inf, Inf) +
  geom_point()
rainbow2 <- matrix(hcl(seq(0, 360, length.out = 10), 80, 70), nrow = 1)
ggplot(mtcars, aes(mpg, wt)) +
  annotation_raster(rainbow2, -Inf, Inf, -Inf, Inf, interpolate = TRUE) +
  geom_point()

if (require("maps")) {
  ia <- map_data("county", "iowa")
  mid_range <- function(x) mean(range(x))
  seats <- do.call(rbind, lapply(split(ia, ia$subregion), function(d) {
    data.frame(lat = mid_range(d$lat), long = mid_range(d$long), subregion = unique(d$subregion))
  }))
  ggplot(ia, aes(long, lat)) +
    geom_polygon(aes(group = group), fill = NA, colour = "grey60") +
    geom_text(aes(label = subregion), data = seats, size = 2, angle = 45)
}
if (require("maps")) {
  data(us.cities)
  capitals <- subset(us.cities, capital == 2)
  ggplot(capitals, aes(long, lat)) +
    borders("state") +
    geom_point(aes(size = pop)) +
    scale_size_area() +
    coord_quickmap()
}
if (require("maps")) {
  # Same map, with some world context
  ggplot(capitals, aes(long, lat)) +
    borders("world", fill = "red", colour = "blue", xlim = c(-130, -60), ylim = c(20, 50)) +
    geom_point(aes(size = pop)) +
    scale_size_area() +
    coord_quickmap()
}