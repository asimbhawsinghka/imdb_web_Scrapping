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

#Converting the movie certificate rating data to text
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

#Using CSS selectors to scrape the movie runtime section
runtime_data_html <- html_node(super_node_read,'.runtime')

#Converting the movie runtime data to text
runtime_data <- html_text(runtime_data_html)

#Let's have a look at the movie runtime
str(runtime_data)
head(runtime_data)

#Data-Preprocessing: removing mins and converting it to numerical
runtime_data<-gsub(" min","",runtime_data)
runtime_data<-as.numeric(runtime_data)

#Let's have a look at the movie runtime
str(runtime_data)
head(runtime_data)

#Using CSS selectors to scrape the movie genre section
genre_data_html <- html_node(super_node_read,'.genre')

#Converting the movie genre data to text
genre_data <- html_text(genre_data_html)

#Let's have a look at the movie genre
str(genre_data)
head(genre_data)

#Data-Preprocessing: Removing \n
#Data-Preprocessing: Removing leading and trailing whitespaces
genre_data <- gsub("\n","",genre_data)
genre_data <- trimws(genre_data)

#Let's have a look at the movie genre
str(genre_data)
head(genre_data)

#Using CSS selectors to scrape the IMDB Rating section
rating_data_html <- html_node(super_node_read,'.ratings-imdb-rating strong')

#Converting the movie IMDB Rating data to text
rating_data <- html_text(rating_data_html)

#Let's have a look at the movie IMDB Rating
str(rating_data)
head(rating_data)

#Data-Preprocessing: converting ratings to numerical
rating_data<-as.numeric(rating_data)

#Let's have a look at the movie IMDB Rating
str(rating_data)
head(rating_data)

#Using CSS selectors to scrape the Votes section
votes_data_html <- html_node(super_node_read,'.sort-num_votes-visible span:nth-child(2)')

#Converting the movie Votes data to text
votes_data <- html_text(votes_data_html)

#Let's have a look at the movie Votes
str(votes_data)
head(votes_data)

#Data-Preprocessing: removing commas
#Removal of "," is required because without this, coercion to numeric values result in NAs
votes_data<-gsub(",","",votes_data)

#Data-Preprocessing: converting votes to numerical
votes_data<-as.numeric(votes_data)

#Let's have a look at the Votes
str(votes_data)
head(votes_data)

#Using CSS selectors to scrape the Directors section
directors_data_html <- html_node(super_node_read,'p a:nth-child(1)')

#Converting the movie Directors data to text
directors_data <- html_text(directors_data_html)

#Let's have a look at the movie Directors
str(directors_data)
head(directors_data)

#Using CSS selectors to scrape the Actors section
actors_data_html <- html_node(super_node_read,'.lister-item-content .ghost+ a')

#Converting the movie Actors data to text
actors_data <- html_text(actors_data_html)

#Let's have a look at the movie Actors
str(actors_data)
head(actors_data)

#Using CSS selectors to scrape the Metascore section
metascore_data_html <- html_node(super_node_read,'.metascore')

#Converting the movie Metascore data to text
metascore_data <- html_text(metascore_data_html)

#Let's have a look at the movie Metascore
str(metascore_data)
head(metascore_data)

#Data-Preprocessing: Removing leading and trailing whitespaces
#Data-Preprocessing: Converting to number
metascore_data <- trimws(metascore_data)
metascore_data <- as.numeric(metascore_data)

#Let's have a look at the movie Metascore
str(metascore_data)
head(metascore_data)

#Check how many NA exists
sum(is.na(metascore_data))

#Using CSS selectors to scrape the Gorss section
gross_data_html <- html_node(super_node_read,'.sort-num_votes-visible span:nth-child(5)')

#Converting the movie Gross data to text
gross_data <- html_text(gross_data_html)

#Let's have a look at the movie Gross
str(gross_data)
head(gross_data)

#Data-Preprocessing: Removing $
#Data-Preprocessing: Removing M
#Data-Preprocessing: Converting to number
gross_data <- gsub("\\$","",gross_data)
gross_data <- gsub("M","",gross_data)
gross_data <- as.numeric(gross_data)

#Let's have a look at the movie Gross
str(gross_data)
head(gross_data)

#Check how many NA exists
sum(is.na(metascore_data))

#Summarise Gross
summary(gross_data)

#combining all data in a dataframe
movies_df <- data.frame(
  rank = rank_data,
  title = title_data,
  description = description_data,
  runtime = runtime_data,
  genre = genre_data,
  rating = rating_data,
  votes = votes_data,
  metascore = metascore_data,
  directors = directors_data,
  actors = actors_data,
  gross_earning_in_mil_doll = gross_data,
  certificate_rating = certificate_data
)

#Structure of Data Frame
str(movies_df)

#Correcting data frame variables from factor to character
movies_df <- movies_df %>% mutate(
  title = as.character(title),
  description = as.character(description),
  genre = as.character(genre)
)

#Structure of Data Frame
str(movies_df)

#Let's see the summary of the dataset
summary(movies_df)
#Following are the observations:
# 1. Minimum runtime is 85 mins (1 hour 25 mins) and maximum is 159 (~2 hours 40 mins). The mean runtime is 117 mins (~ 2 hours).
# 2. Even the worst movie got a rating of 3.8. The highest rating is 8.5. Majority movies were above average at mean ratings score of 6.7
# 3. Number of votes recived varies wildly in the range of 131 - 7 Lakhs.
# 4. The minimum gross earning is just 50,000 and the highest grossing movie garnered 70 Crore USD.
# 5. Majority of the movies were R rated. However, certificate_rating data also has Unrated movies.

