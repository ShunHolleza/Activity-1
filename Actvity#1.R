library(polite)
library(dplyr)
library(rvest)
library(httr)
polite::use_manners(save_as = 'polite_scrape.R')

brand_des <- character(0)
url_link <- 'https://www.amazon.com/s?k=laptops&ref=nb_sb_noss'
price <- character(0)
num_of_rev <- character(0)

scraped_page <- scrape(bow(url_link, user_agent = "Educational"))

brand_des <- scraped_page %>%
  html_nodes('a-size-medium a-color-base a-text-normal') %>%
  html_text()

brand_desc <- data.frame(Brand_Description = brand_des)
brand_desc <- slice(brand_desc, 1:3)
print(brand_desc)

price <- scraped_page %>%
  html_nodes('span.a-offscreen') %>%
  html_text()

num_of_rev <- scraped_page %>%
  html_nodes('span.a-size-base') %>%
  html_text()

review_stars <- scraped_page %>%
  html_nodes('span.a-icon-alt') %>%
  html_text()

min_length <- min(length(brand_des), length(price), length(num_of_rev), length(review_stars))

laptop_data <- data.frame(
  Brand_Description = brand_des[1:min_length],
  Price = price[1:min_length],
  Number_of_Reviews = num_of_rev[1:min_length],
  Review_Stars = review_stars[1:min_length]
)

print(laptop_data)
install.packages("usethis")
usethis::use_git_config(user.name="ShunHolleza", user.email="shun.holleza@students.isatu.edu.ph")
