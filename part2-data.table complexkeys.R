
library(data.table);library(tidyverse)

customers <-
    data.table(
        name   = c("Mark K", "Matt A", "Angela V", "Michelle V"),
        gender = c("M", "M", "F", "F"),
        address = map2_chr("street", seq(1:4), function(x,y) {str_c(x," ", y)}),
        age    = c(54, 43, 39, 63)
    )

purchases <-
    data.table(
        name  = c("Mark K", "Matt A", "Angela V", "Michelle V"),
        sales = c(1, 5, 4, 3),
        spent = c(41.70, 41.78, 50.77, 60.01))

web_visits <- data.table( 
    name = c("Maddy D", "Maddy A", "Tom S", "Mark K", "Matt A"),
    date = lubridate::ymd(c("2010-01-01","2010-01-01","2010-01-01","2010-01-01","2010-01-01")),
    duration = c(1:5)) 



# discov. missmatch and errors-----------------------------------------------------

# diffenrt types of number.
customers[ web_visits , on = .(age = name) ]

# Join by diff columns lead to a full join is stacked:
merge( customers, web_visits, by.x = "address", by.y = "name", all = T)


# left or right will give: all NA
customers[ web_visits, on = .(age = duration)]
# inner: gives an empty frame
customers[ web_visits, on = .(age = duration), nomatch = 0]


customers <- customers[, ':=' (first = str_split(name, pattern = " ")[[1]][[1]], last = str_split(name, pattern = " ")[[1]][[2]] ) , by = name ][]




# Tricky columns ----------------------------------------------------------

library(data.table)

parents <- data.table( name = c("Sarah", "Max", "Qin"), gender = c("F", "M", "F"), age = c(41,43,36))
children <- data.table( parent = c("Sarah", "Max", "Qin"), name = c("Oliver", "Seb", "Kai"), gender = c("M", "M", "F"), age = c(5,8,7))

# i is added
parents[ children, on = .(name = parent)]

merge( children, parents, by.x = "parent", by.y = "name", suffixes = c(".child", ".parent"))

# Rename
setnames( parents , old = c("gender", "age"), new = c("parent.gender", "parent.age"))

c("")




# Duplicate matches -------------------------------------------------------

dt_1 <- data.table( navn = c("A","A"), metode= c("lm", "glm"), res = c(1,2))
dt_2 <- data.table( navn = c("A","A", "A"), metode= c("lm", "glm","mean"), res = c(1,2, 3), present = c(T,T,F))

dt_1[dt_2, on = .(navn)][]
# Tillat doplicater
dt_1[dt_2, on = .(navn) , allow.cartesian = T][]

se <- dt_1[dt_2, on = .(navn) , allow.cartesian = T][]
# keep only the first match
dt_1[dt_2, on = .(navn) , mult = "first"][]
dt_1[dt_2, on = .(navn) , mult = "last"][]


# Look at the duplicats: row that is duplicated 
duplicated(data.table( navn = c("A", "A")))

# get unique
unique(data.table( navn = c("A", "A")))

dplyr::distinct(data.table( navn = c("A", "A")))

# From last and by = arg 
heart_3 <- unique(heart_2, by = "gene", fromLast = TRUE)
# or the duplicated function:
heart <- heart[!duplicated(heart, by="gene", fromLast = TRUE)]