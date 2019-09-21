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

#define Super Node
super_node <- '.mode-advanced'

#Read Html Nodes under super_node
super_node_read <- html_nodes(webpage,super_node)

#Using CSS selectors to scrape the rankings section
rank_data_html <- html_node(super_node_read,'.text-primary')

#Converting the ranking data to text
rank_data <- html_text(rank_data_html)

#Let's have a look at the rankings
str(rank_data)
head(rank_data)

#Data-Preprocessing: Converting rankings to numerical
rank_data<-as.numeric(rank_data)

#Let's have another look at the rankings
head(rank_data)

#Using CSS selectors to scrape the movie title section
title_data_html <- html_node(super_node_read,'.lister-item-header a')

#Converting the movie title data to text
title_data <- html_text(title_data_html)

#Let's have a look at the rankings
str(title_data)
head(title_data)

#Using CSS selectors to scrape the movie description section
description_data_html <- html_node(super_node_read,'p:nth-child(4)')

#Converting the movie description data to text
description_data <- html_text(description_data_html)

#Let's have a look at the movie description
str(description_data)
head(description_data)

#There is \n cahracter at the start of the description text. This needs to be removed
#Data-Preprocessing: Removing \n
#Using gsub instead of sub because gsub will replace all instances of search pattern as against sub which will remove only the first match
description_data <- gsub("\n","",description_data)

#Data-Preprocessing: Removing leading and trailing whitespaces
description_data <- trimws(description_data)

#Let's have a look at the movie description
str(description_data)
head(description_data)

#Using CSS selectors to scrape the movie certificate rating section
certificate_data_html <- html_node(super_node_read,'.certificate')

#Converting the movie certificate rfating data to text
certificate_data <- html_text(certificate_data_html)

#Let's have a look at the movie certificate
str(certificate_data)
head(certificate_data)

#There are values like UA, U/A which are same but a different way of representation
#See the distinct values for certificate ratings to understand which all could be clubbed
unique(certificate_data)

#Data-Preprocessing: Modifying values of UA to U/A and NA to "Unrated"
certificate_data[certificate_data == "UA"] <- "U/A"
certificate_data[is.na(certificate_data)] <- "Unrated"

#See the distinct values for certificate ratings
unique(certificate_data)
