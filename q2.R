setwd("C:/R_Practics/EDA")

library(dplyr)
library(rvest)
library(XML)
library(stringr)
library(readxl)
library(writexl)
library(readr)
library(httr)
library(lmtest)
library(RSelenium)
library(jsonlite)
library(KeyboardSimulator)


# Q. 2-1

rD <- rsDriver(port=4710L, chromever="99.0.4844.51")
remDr <- rD$client

URL <- "https://book.naver.com/search/search.naver?sm=sta_hty.book&sug=&where=nexearch&query=불평등"

remDr$navigate(URL)

Sys.sleep(1)

txt <- remDr$getPageSource()[[1]]
res <- read_html(txt)

pattern <- "#searchBiblioList > li > dl > dt > a"
title <- res %>% html_nodes(pattern) %>% html_text()
num <- (1:20)

TABLE_2.1 <- cbind(num, title) %>% as.data.frame()

write_xlsx(TABLE_2.1, "q2_1.xlsx")


# Q. 2-2

rD <- rsDriver(port=4715L, chromever="99.0.4844.51")
remDr <- rD$client

URL <- "https://book.naver.com/search/search.naver?sm=sta_hty.book&sug=&where=nexearch&query=불평등"

remDr$navigate(URL)

Sys.sleep(1)

# mouse.get_cursor() 342, 387

mouse.move(342, 387)
mouse.click()
Sys.sleep(1)

txt <- remDr$getPageSource()[[1]]
res <- read_html(txt)


pattern <- "#searchBiblioList > li > dl > dt > a"
title <- res %>% html_nodes(pattern) %>% html_text()

num <- (1:20)

pattern <- "#searchBiblioList > li > dl > dd.txt_block"
pub.date <- res %>% html_nodes(pattern) %>% html_text()

pattern <- "#searchBiblioList > li > dl > dt > a"
id <- res %>% html_nodes(pattern) %>% html_attr("href") %>% str_extract("[0-9]+$") 

TABLE_2.2 <- cbind(num, title, pub.date, id) %>% as.data.frame()

write_xlsx(TABLE_2.2, "q2_2.xlsx")


# Q. 2-3

rD <- rsDriver(port=4714L, chromever="99.0.4844.51")
remDr <- rD$client

URL <- "https://book.naver.com/search/search.naver?sm=sta_hty.book&sug=&where=nexearch&query=불평등"

remDr$navigate(URL)

Sys.sleep(1)

# mouse.get_cursor() 342, 387

mouse.move(342, 387)
mouse.click()
Sys.sleep(1)

txt <- remDr$getPageSource()[[1]]
res <- read_html(txt)


pattern <- "#searchBiblioList > li > dl > dt > a"
title <- res %>% html_nodes(pattern) %>% html_text()

num <- (1:20)

pattern <- "#searchBiblioList > li > dl > dd.txt_block"
pub.date <- res %>% html_nodes(pattern) %>% html_text()

pattern <- "#searchBiblioList > li > dl > dt > a"
id <- res %>% html_nodes(pattern) %>% html_attr("href") %>% str_extract("[0-9]+$")

stack <- NULL

selected.book <- TABLE_2.2 %>% slice(1:10)
id.list <- selected.book$id

for(i in 1:length(id.list)) { 
  cat("\n",paste0(i, "번째 작업 중"))
  print(1)
  URL <- str_c("https://book.naver.com/bookdb/book_detail.naver?bid=", id.list[i])
  res <- read_html(URL)
  
  pattern <- "#bookIntroContent p"
  content <- res %>% html_nodes(pattern) %>% html_text()
  
  stack <- rbind(stack, content) %>% as.data.frame() }
  
  TABLE_2.3 <- cbind(selected.book, stack) %>% as.data.frame()

write_xlsx(TABLE_2.3, "q2_3.xlsx")


