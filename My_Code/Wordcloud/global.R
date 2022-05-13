# http://www.baoruidata.com/examples/082-word-cloud/
## Author: Fereshteh Karimeddini <fereshteh@rstudio.com>

library(shiny)
library(tm)
library(wordcloud)
library(memoise)

# The list of texts
books <<- list(
              "Thoreau: Walden, and On The Duty Of Civil Disobedience" = "walden",
              "Replace newtext" = "newtext",
              "Moodie: Roughing it in the Bush" = "bush"
              )

# Using "memoise" to automatically cache the results
getTermMatrix <- memoise(function(book) {
  if (!(book %in% books))
    stop("Unknown book")

  text <- readLines(sprintf("./%s.txt", book),
                    encoding="UTF-8")

  myCorpus = Corpus(VectorSource(text))
  myCorpus = tm_map(myCorpus, content_transformer(tolower))
  myCorpus = tm_map(myCorpus, removePunctuation)
  myCorpus = tm_map(myCorpus, removeNumbers)
  # Remove words
  myCorpus = tm_map(myCorpus, removeWords,
                    c(stopwords("SMART"), "thy", "thou", "thee", "the", "and", "but"))

  myDTM = TermDocumentMatrix(myCorpus,
                             control = list(minWordLength = 1))

  m = as.matrix(myDTM)

  sort(rowSums(m), decreasing = TRUE)
})
