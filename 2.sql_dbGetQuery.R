




library(DBI)

con <- dbConnect( RMySQL::MySQL(),
                  dbname = "company",
                  host = "courses.csrrinzqubik.us-east-1.rds.amazonaws.com",
                  port = 3306,
                  user = "student",
                  password = "datacamp")


dbListTables(con)

dbReadTable(con, "employees")

dbGetQuery(con, "SELECT name FROM employees
           WHERE started_at > \"2012-09-01\"")

# ALternativ way
library(dtplyr)
tbl(con, "employees") %>% select( name )
tbl(con, "products") %>% filter( contract == 1 )

#* keep all columns
# = single equals sing
dbGetQuery( con, "SELECT * FROM products 
            WHERE contract = 1")


## To get the data:

res <- dbSendQuery( con, "SELECT * FROM products 
            WHERE contract = 1")

dbFetch(res)
# End with
dbClearResult(res)

# one by one:
res <- dbSendQuery( con, "SELECT * FROM products 
            WHERE contract = 1")


while( ! dbHasCompleted(res)) { 
    chunk <- dbFetch(res,n = 1);print(chunk)}


dbClearResult(res)
dbDisconnect(con)



























