require(tidyverse)
require(plotly)

### artyfarty need to be installed with install_github

##https://github.com/Bart6114/artyfarty

## devtools::install_github('bart6114/artyfarty')

### 1. ggplot extension: theming

require(artyfarty)

ggplot(iris, aes(x = Petal.Length, y = Sepal.Length, color = Species)) + geom_point() -> p

p + theme_economist()

## 2. Take it online with ggplotly

ggplotly(p)

## 3. integrate ggplot into tidyverse

### basic of dplyr

##5 verbs

iris %>% filter(Species == "setosa")

iris %>% arrange(Sepal.Length)

iris %>% select(Sepal.Length, Species)

iris %>% summarise(meansl = mean(Sepal.Length))

iris %>% mutate(Sepal.Ratio = Sepal.Length / Sepal.Width)

### group by

iris %>% group_by(Species) %>% summarise(meansl = mean(Sepal.Length))

### compositability

iris %>% mutate(Sepal.Ratio = Sepal.Length / Sepal.Width) %>% select(Species, Sepal.Ratio) %>% group_by(Species) %>% summarise(meansr = mean(Sepal.Ratio))

iris %>% mutate(Sepal.Ratio = Sepal.Length / Sepal.Width) %>% select(Species, Sepal.Ratio) %>% group_by(Species) %>% summarise(meansr = mean(Sepal.Ratio)) %>% ggplot(aes(x = Species, y = meansr)) + geom_bar(stat = 'identity') + ylab("Mean Sepal Length / Sepal Width")


require(stringr)

bnames <- readRDS('bnames.RDS')

bnames %>% tbl_df %>% mutate(firstc = tolower(str_sub(name, 1, 1))) %>%  group_by(year, sex, firstc) %>% summarise(populariy = sum(percent)) %>% ggplot(aes(x = year, y = populariy, color = sex)) + geom_line() + facet_wrap(~ firstc, nrow = 2) -> p2

ggplotly(p2)
