library(dplyr)
library(stringr)
library(tm)
library(wordcloud)
library(SnowballC)


as.character(6)


book <- readLines("Ulysses", encoding="UTF-8") %>%
  as.character()
book <- book %>%
  tolower() %>%
  removeNumbers() %>%
  removePunctuation() %>%
  removeWords(stopwords("english")) %>%
  stemDocument() %>%
  stripWhitespace()
book <- VectorSource(book) %>% 
  Corpus()


wordcloud(book, main="Title",scale=c(5,0.5), max.words=20, random.order=FALSE,
          rot.per=0.35, use.r.layout=FALSE, colors=brewer.pal(8, "BuPu"))


wordcloud("this is a test of test of a to a", main="Title",scale=c(5,0.5), max.words=20, random.order=FALSE,
          rot.per=0.35, use.r.layout=FALSE, colors=brewer.pal(8, "BuPu"))
