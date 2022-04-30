setwd("C:/R_Practics/EDA")

library(dplyr)
library(rvest)
library(XML)
library(XML2)
library(stringr)
library(readxl)
library(writexl)
library(readr)
library(httr)
library(lmtest)
library(RSelenium)
library(jsonlite)

# Q. 1-1

URL <- "https://www.demographic-research.org/volumes/vol45"
res <- read_html(URL)

volume <- "45"

pattern <- ".articles_header , .articles_header_noborder"
pubdate <- res %>% html_nodes(pattern) %>% html_text() # 텍스트 나누기 확인

length(link)


pattern <- ".articles_header , .articles_header_noborder"
type <- res %>% html_nodes(pattern) %>% html_text()  # 텍스트 나누기 확인

pattern <- ".articles_title a"
title <- res %>% html_nodes(pattern) %>% html_text()

pattern <- ".articles_authors"
authors <- res %>% html_nodes(pattern) %>% html_text()

pattern <- "span+ span"
pages <- res %>% html_nodes(pattern) %>% html_text()

pattern <- ".articles_title a"
link <- res %>% html_nodes(pattern) %>% html_attr("href") %>% str_c("https://www.demographic-research.org/", .)

TABLE <- cbind(volume, pubdate, type, title, authors, pages, link) %>% as.data.frame()

write_xlsx(TABLE, "q1_1.xlsx")



#Q. 1-2

stack <- NULL

start.n <- 42
end.n <- 45


for(i in start.n:end.n) {

  cat("\n\n", i, "번째 볼륨 작업 중")

  URL <- str_c("https://www.demographic-research.org/volumes/vol", i)
  res <- read_html(URL)
  
  volume <- i
  
  pattern <- ".articles_header , .articles_header_noborder"
  pubdate <- res %>% html_nodes(pattern) %>% html_text() # 텍스트 나누기 확인
  
  length(link)
  
  
  pattern <- ".articles_header , .articles_header_noborder"
  type <- res %>% html_nodes(pattern) %>% html_text()  # 텍스트 나누기 확인
  
  pattern <- ".articles_title a"
  title <- res %>% html_nodes(pattern) %>% html_text()
  
  pattern <- ".articles_authors"
  authors <- res %>% html_nodes(pattern) %>% html_text()
  
  pattern <- "span+ span"
  pages <- res %>% html_nodes(pattern) %>% html_text()
  
  pattern <- ".articles_title a"
  link <- res %>% html_nodes(pattern) %>% html_attr("href") %>% str_c("https://www.demographic-research.org/", .)
  
  TABLE_sub <- cbind(volume, pubdate, type, title, authors, pages, link) %>% as.data.frame()

  stack <- rbind(stack, TABLE_sub)
  
}    

write_xlsx(stack, "q1_2.xlsx")








