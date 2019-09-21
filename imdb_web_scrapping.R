#Installing required packages
install.packages("tidyverse")
install.packages("rvest")

#Loading libraries
library(tidyverse)
library(rvest)

#Specifying the url for desired website to be scraped
url <- 'https://www.imdb.com/search/title/?count=100&release_date=2018,2018&title_type=feature'

#Reading the HTML code from the website
webpage <- read_html(url)

#Using CSS selectors to scrape the rankings section
#html_nodes selects nodes from an html documnet. This helps in easily extracting pieces out of HTML documents
rank_data_html <- html_nodes(webpage,'.text-primary')

#Converting the ranking data to text
rank_data <- html_text(rank_data_html)

#Let's have a look at the rankings
str(rank_data)

#Data-Preprocessing: Converting rankings to numerical
rank_data<-as.numeric(rank_data)

#Using CSS selectors to scrape the title section
title_data_html <- html_nodes(webpage,'.lister-item-header a')

#Converting the title data to text
title_data <- html_text(title_data_html)

#Let's have a look at the title
str(title_data)

#Using CSS selectors to scrape the description section
description_data_html <- html_nodes(webpage,'p:nth-child(4)')

#Converting the description data to text
description_data <- html_text(description_data_html)

#Let's have a look at the description
str(description_data)
head(description_data)

#The first description is incorrect. Dropping the same.
description_data <- description_data[2:101]

#Let's have a look at the description
str(description_data)
head(description_data)

#The description contains leading and trailing whitespaces as well as \n. Removing these
#preprocessing description data
#Data-Preprocessing: Removing \n
#Difference between gsub and sub is that sub will replace only the first matching instance whereas gsub will replace all matching instance
description_data <- gsub("\n","",description_data)

#Data-Preprocessing: Removing leading and trailing whitespaces if any
description_data <- trimws(description_data)

#Let's have a look at the description
str(description_data)
head(description_data)