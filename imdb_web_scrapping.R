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
# 4. The minimum gross earning is just 50,000 and the highest grossing movie garnered 70 Crore USD.Earnings data is not available for 20 movies.
# 5. Majority of the movies were R rated. However, certificate_rating data also has Unrated movies.

# ============ EDA on Runtime ==========

#Let's visualise runtime through boxplot
boxplot(movies_df$runtime)
# The following are the observations from the boxplot
# 1. Mean and Median values for runtime are same. This indicates that the distribution is not skewed. The same iscorroborated from the box plot where the 50th percentile or the median is exactly at the centre of the box.
# 2. There are no outlier values in the runtime data.
# 3. Atleast 50% of the movies have runtime between 105.8 mins (~1 hour 45 mins) and 129.2 mins (~2 hours 10 mins). Again this is evident from the summary stats above.

# Let's plot a histogram of runtime
hist(movies_df$runtime)
# The following are the observations from the histogram
# 1. This is a uniform distribution and corroborates the box plot and summary statistics
# 2. Runtime is normally distributed around it's mean of 117 mins.
# 2. Majority of the movies have a runtime between 110 mins (~1 hour 50 mins) and 120 mins (~2 hours)

# Let's calculate the standard deviation of run time
sd(movies_df$runtime)
# The standard deviation of the runtime is 16.66 mins

#Let's see which movie had the highest and the lowest runtime
movies_df[which.min(movies_df$runtime),]
# The horror movie, Hex had the lowest runtime of 85 mins (just under 1 hour 30 mins)

movies_df[which.max(movies_df$runtime),]
#The crime drama Mel Gibson movie, Dragged Across Concrete ahd the highest runtime of 159 mins (~2 hours 20 mins)

# ========== EDA on ratings ==========
# Lets see the box plot for ratings
boxplot(movies_df$rating)
# Observations:
# 1. The distribution is negatively skewed since the median line is closer to the 3rd Quartile hinge.
# 2. There are 2 outlier values. These movies have ratings below 5. 
# 3. Outlier values below 5 indicates that user ratings have a bias. Users tend to rate movies higher than 5.
# 4. Further investigation needs to be done on why the 2 ratings were below 5. Were they really abysmally bad? How do their votes stack up? Is it possible that the a very small number of people voted for these movies and they were quite biased in their review?

# Let's investigate point 4. above
# Let's see whcich movies received ratings lower than 5
#Description is not needed hence selecting other columns only
movies_df[order(movies_df$rating)[1:2],-3]
# The 2 movies were:
# 1. Holmes & Watson with a rating of 3.8, votes = 21,698
# 2. Fifty Shades Freed with a rating 4.5, votes = 45,861

# While the number of votes are relatively high, let's validate it through the data we have
# Let's see the rank of votes for these 2 movies in our dataset
# Let's add a column to the dataset to indicate the rank of the votes
# Notice the - sign before votes. This is done to rank the values in descending order, i.e., the movie having highest votes will be ranked 1.
movies_df <- movies_df %>% mutate(votes_rank =rank(-votes))

# Now let's see the votes rank for the two movies
movies_df[order(movies_df$rating)[1:2],-3]
# 78 and 56 respectively. Nope, the votes are not low. Conclusion, I am not going to watch both the movies at all.
# The third installment of Fifty Shades film trilogy is not that great!

# Let's explore the histogram and distribution of the ratings
hist(movies_df$rating)
# Histogram confirms information that we already know above.

# Are the movies that are highly rated by viewers also highly rated my critics?
# This requires ranking according to metacritic as well as ratings
movies_df <- movies_df %>% mutate(meta_rank =rank(-metascore_data))
movies_df <- movies_df %>% mutate(ratings_rank =rank(-rating))
movies_df
# Surprise, Surprise. meta_rank and ratings_rank have decimal values! This is because meta_rank as well as ratings_rank have same values for few movies
# The argument ties.method determines the result of the rankings in case ties are encountered.
# The following values can be input for the argument - "average","first", "last", "max", "min"
# In our case we will be using first
movies_df <- movies_df %>% mutate(meta_rank =rank(-metascore_data, ties.method = "first"))
movies_df <- movies_df %>% mutate(ratings_rank =rank(-rating, ties.method = "first"))
movies_df


# Let's investigate top 10 movies with highest Ratings
movies_df[order(movies_df$ratings_rank)[1:10],-3]
# There seems a lot of disparity between viewer's ratings and critic's ratings. Further relationship will be explored later when we perform a bivariate EDA.

# Let's calculate the standard deviation of run time
sd(movies_df$rating)
# The standard deviation of the rating is 0.83
# The mean rating was 6.705. Consequently, about 68% of the data has ratings between 5.87 and 7.54 (Chebychev's Theorem applied to a normal distribution)

# ========== EDA on Votes ==========
# Votes indicates how many people rated a particular movie.
# Let's get a box plot for votes
boxplot(movies_df$votes)
# Votes are higly positively skewed. This indicates that there are few movies which are rated by many many people, however, majority of the movies are not reviewed as much. Most likely, the movies that receive a large number of votes are the ones that have quite a good recall with the viewers.
# Another reason for higher number of votes could be that the movie was released to a bigger audience than the others. We need to study the release patterns of these movies to confirm the same.
# Any votes above 3 Lakhs is an outlier

# Let's explore the histogram and distribution of the votes
hist(movies_df$votes)
# 60+ movies have received votes less than 1 Lakhs

# Which movies received votes greater than 3 Lakhs?
movies_df[movies_df$votes >300000,-3]
# Not surprisingly, these are Bohemian Rhapsody, Avengers: Infinity War, Deadpool 2, A Quiet Place, Black Panther, Venom, Ready Player One.

# Are these movies the highest gross_earning_movies as well?
movies_df <- movies_df %>% mutate(gross_rank = rank(-gross_earning_in_mil_doll))
movies_df[movies_df$votes >300000,-3]
# And the answer is no. Steven Speilberg's Ready Player One is ranked 22 according to Gross Earnings. 
# However, 4 of the 7 movies listed above does feature in the top 10 in Gross Earnings list.
# They are (in ascending order of their gross_rank):
# 1. Black Panther - ranked 1
# 2. Avengers: Infinity War - ranked 2
# 3. Deadpool 2 - ranked 6
# 4. Bohemian Rhapsody - ranked 9

# Are these movies the critically acclaimed?
movies_df[movies_df$votes >300000,-3]
# No. The public does not seem to agree with the critics yet again. Commercial success of the film does not seem to be influenced by critic's ratings.