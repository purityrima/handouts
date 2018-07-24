## Getting started

library(dplyr)
animals <- read.csv('data/animals.csv',
    na.strings = '') %>%
  select(year, species_id, sex, weight) %>%
  na.omit()

View(animals)
## Layered graphics

library(ggplot2)
ggplot(animals,
       aes(x = species_id, y = weight))+
  geom_point() +
labs(x ="spp", y="wgt")

ggplot(animals,
       aes(x = species_id, y = weight)) +
  geom_boxplot()

ggplot(animals,
       aes(x = species_id, y = weight)) +
  geom_boxplot() + geom_point(colour = "red")
  

ggplot(animals,
       aes(x = species_id, y = weight)) +
  geom_boxplot() +
  geom_point(...)

ggplot(animals,
       aes(x = species_id, y = weight)) +
  geom_boxplot() +
  geom_point(
    color = 'red',
   stat = "summary",
   fun.y = "mean")

ggplot(animals,
       aes(x = species_id, y = weight,
              colour = species_id)) +
  geom_boxplot() +
  geom_point(stat = 'summary',
             fun.y = 'mean')

## Smooth lines

levels(animals$sex) <- c('Female', 'Male')
animals_dm <- filter(animals,
  species_id == 'DM')

ggplot(animals_dm,
  aes(x = year, y = weight, shape = sex)) +
  geom_point(size = 3,
    stat = 'summary', fun.y = 'mean') +
  geom_smooth(method = "lm")

ggplot(animals_dm,
  aes(x = year, y = weight,
    shape = sex, color = sex)) +
  geom_point(size = 3,
    stat = 'summary', fun.y = 'mean') +
  geom_smooth(method = "lm")

# Storing and re-plotting
 year_wgt <- ggplot(animals_dm,
  aes(x = year, y = weight,
    color = sex, shape = sex)) +
  geom_point(size = 3,
    stat = 'summary',
    fun.y = 'mean') +
  geom_smooth(method = 'lm')

year_wgt <- year_wgt +
  scale_color_manual(
   values = c("black", "red"))

ggsave(filename = 'year_wgt.pdf',
   plot = year_wgt,
    width = 4, height = 3)

## Axes, labels and themes

histo <- ggplot(animals_dm,
  aes(x = weight, fill = sex)) +
  geom_histogram(binwidth = 3, color = "white")

histo <- histo + labs(title =
  'Size of Dipodomys merriami',
 x = "Weight(g)"
  y = 'Count')

histo <- histo + scale_x_continuous(
  limits =c(20,60),
 breaks = c(20, 30, 40, 50, 60))

histo <- ggplot(animals_dm,
  aes(x = weight,
      y = stat(density),
      fill = sex)) +
  geom_histogram(binwidth = 3,
    color = 'white') +
  labs(title = 
    'Size of Dipodomys merriami',
    x = 'Weight (g)',
    y="density")

histo <- histo + theme_bw() + theme(
  legend.position = c(0.2, 0.5),
  plot.title = element_text(
    face = "bold"),
  axis.title.y = element_text(
    ...),
  ... = element_text(
    size = 13, vjust = 0))

## Facets

animals_common <- filter(animals,
  species_id %in% c('DM', 'PP', 'DO'))
faceted <- ggplot(animals_common,
 aes(x = weight)) +
  geom_histogram() +
 facet_wrap(vars(species_id))
  labs(title = 
       "Weight of most common species",
       x = "Count",
       y = "Weight (g)")

faceted_all <- faceted +
  geom_histogram(data =
    select(animals_common, -species_id),
 alpha = 0.2)

## Exercise 1: Filtering DM from species_id
animals_dm <- filter(animals,
                         species_id %in% 'DM')
 ggplot(animals_dm,
                  aes(x = year, y = weight, color = sex)) +
  geom_point(size = 3,  
              stat = "summary",
              fun.y = 'mean') + scale_color_manual(values=c(Male = "black", Female = "green"))
#Exercise 2:Histogram
 animals_dm <- filter(animals,
                      species_id %in% 'DM')
 ggplot(animals_dm,
        aes(x = weight, fill = sex)) +
   geom_histogram(binwidth =4)
 
