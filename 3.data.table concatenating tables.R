

library(data.table);library(tidyverse)


sales_2015 <- data.table( year = rep(1,12),  quarter = rep(1:4, times = 3, each = 3), sales = 100*rnorm(12, 100, 10))
sales_2016 <- data.table( year = rep(2,12),  quarter = rep(1:4, times = 3, each = 3), sales = 100*rnorm(12, 100, 10))
sales_2017 <- data.table( year = rep(3,12),  quarter = rep(1:4, times = 3, each = 3), sales = 100*rnorm(12, 100, 10), store = "A")
# rbind()
rbind( sales_2015, sales_2016, idcol = T) %>% head()
rbind( sales_2015, sales_2016, idcol = "navn" ) %>% head()

# Gives error
rbind(sales_2016, sales_2017, idcol = "year")

# FIxe the problem:
rbind(sales_2016, sales_2017, idcol = "year", fill = T)

rbind(sales_2015, sales_2016, idcol= "year", use.name = T)

# read multiple files:
tables_files <- c("sales_2015.csv", "sales_2016.csv")
list_of_tables <- lapply( tables_files, fread)

# The rbindlist -> concat. data.frames from lists
rbindlist(list_of_tables)


gdp_all_2 <- rbindlist(gdp, idcol = "continent")
str(gdp_all_2)
gdp_all_2[95:105]


gdp_all_3 <- rbindlist(gdp, idcol = "continent", use.names = T)



# the set operations ------------------------------------------------------

library(data.table);library(tidyverse)

dt1 <- data.table( a = letters[seq(1:4)], tall = c(1:4) )
dt2 <- data.table( a = letters[ seq(from = 3, to = 6)], tall = c(3:4) )
dt3 <-  data.table( a = letters[rep(1:2, 2)], tall = rep(1:2) )
# fintersect(): what row two DT share. -> innter_joint
fintersect(dt1, dt2)
dt1[dt2, on = .(a,tall), nomatch = 0]

# funion(): unqie set of rows 
funion(dt1, dt2) # 
unique( rbind(dt1, dt2) )

# fsetdiff(): what row that are unique -> return only rows/obs from dt1 that is not in dt2
fsetdiff(dt1, dt2)


# Example: data gdp in dir. data:
#gdp <- 

# Obtain countries in both Asia and Europe
fintersect( gdp$europe, gdp$asia)

# Concatenate all data tables
gdp_all <- rbindlist(gdp)

# Find all countries that span multiple continents
(gdp_all)[duplicated(gdp_all)]


# Get all countries in either Asia or Europe
funion( gdp$asia, gdp$europe)

# Concatenate all data tables
gdp_all <- rbindlist(gdp)

# Print all unique countries
unique(gdp_all)

# Which countries are in Africa but not considered part of the middle east?
fsetdiff(gdp$africa, middle_east)

fsetdiff(gdp$europe , middle_east)

# ..
# ..
lapply(gdp, fsetdiff, middle_east)
map2(gdp,middle_east, fsetdiff )


# Melt vs pivot_ ----------------------------------------------------------



















