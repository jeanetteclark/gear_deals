# fill jagged dataframe
cbind.fill<-function(...){
  nm <- list(...) 
  nm<-lapply(nm, as.matrix)
  n <- max(sapply(nm, nrow)) 
  do.call(cbind, lapply(nm, function (x) 
    rbind(x, matrix(, n-nrow(x), ncol(x))))) 
}

#Read the steep and cheap content and return as a dataframe
steep_and_cheap <- function(url){
  webpage <- read_html(url)
  
  page <- webpage %>%
    html_nodes("span")
  
  
  page_attrs <- page %>% 
    html_attrs()
  
  
  t_price <- page[which(page_attrs == "ui-pl-pricing-low-price price-sale js-item-price-low qa-item-price-low")] %>% 
    html_text()
  
  t_pcnt <- page[which(page_attrs == "ui-pl-percentage-off discount-sale js-pl-discount qa-item-discount")] %>% 
    html_text()
  
  t_name <- page[which(page_attrs == "ui-pl-name-wrap" )] %>% 
    html_text()
  
  pro <- list(t_name, t_price, t_pcnt)
  
  
  protection <- data.frame(cbind.fill(t_name, t_price, t_pcnt))
  names(protection) <- c("shoe", "price", "percent")
  return(protection)
}