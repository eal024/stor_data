
# https://s3.amazonaws.com/assets.datacamp.com/blog_assets/datatable_Cheat_Sheet_R.pdf

library(data.table);library(tidyverse)

# create data.table and and call it DT
DT <- data.table( V1=c(1L,2L), 
                 V2=LETTERS[1:3],
                 V3=round(rnorm(4),4),
                 V4=1:12)


dt1 <- data.table( name = c("Trey", "Matthew", "Angela", "Michelle"), gender = c(NA, "M", "F", "F"), age = c(54,43,39, 63))
dt2 <- data.table( name = c("Trey", "Matthew", "Angela", "Abdulla"), address = c("12 High street", "7 Mill road", "33 Pacific boulevard", "3aUnon street") )


# Joing data --------------------------------------------------------------

dt1 %>% 
    left_join( dt2, by = "name")

# merge-verb
# Table key: link inof across two table -> ex. name

tables()
str( DT)

# merge-function -> base

# inner, full, left, right

# inner: only keep obs. that have info in both
# inner: the defult
merge( x = dt1, y = dt2, by.x = "name", by.y = "name") # inner_join(dt1, dt2, by = "name")

merge( x = dt1, y = dt2, by = "name")

# Full: Keep all
merge( x = dt1, y = dt2, by = "name", all = T); 

full_join( dt1, dt2, by = "name")

# Left
merge( dt1, dt2, by = "name", all.x = T)

left_join(dt1, dt2, by = "name")


# right
merge( dt1, dt2, by = "name", all.y = T)



# Merge with data.table syntax --------------------------------------------


# syntax: DT[i = row?, j = do  , by - group by]

DT[ V1 == 1, .(V1, V2, V4)][, ':=' (V400 = mean(V4), V4Max = max(V4)), by =V2][]


# Join
# DT[i:join to which, on = on key ]

# Right join
dt1[ dt2, on = .(name)]
# On two variables (. or list)
#dt1[ dt2, on = .(name, var_two)]

# left join
dt2[ dt1, on = .(name)]

# inner join
dt1[ dt2, on = .(name), nomatch = 0]

# Full join can not do. ise
# use base
merge( dt1, dt2, by = "name", all= T)

# Anti join
dt1[ !dt2, on = .(name)]


#  right join framingham to heart_2, taking the first probe for each gene in heart_2.
heart_2[framingham, on = .(gene), mult = "first"]

# Anti-join
reproducible[!framingham, on = .(gene)]

# Anti-join
reproducible[!framingham, on = .(gene)]

# Set and view the keys ---------------------------------------------------

setkey(DT, ...)
#
setkeyv() # programmatic key checking and setting
haskey( )
key()

setkey(dt1, name) 
haskey(dt1)
key(dt1)


setkey(dt2, name)

# The equal result as
dt1[dt2] == dt1[dt2, on = .(name)]


# inner join
dt1[dt2, nomatch = 0]




# more data.table joins ---------------------------------------------------

# Chaining data.table
#DT1[DT2, on][i,j,by]

customers <-
    data.table(
        name   = c("Mark", "Matt", "Angela", "Michelle"),
        gender = c("M", "M", "F", "F"),
        age    = c(54, 43, 39, 63)
    )

purchases <-
    data.table(
        name  = c("Mark", "Matt", "Angela", "Michelle"),
        sales = c(1, 5, 4, 3),
        spent = c(41.70, 41.78, 50.77, 60.01))

# Example
customers[purchases, on = .(name)][
    sales > 1, j = .(avg_spent = sum(spent)/sum(sales) ),
    by = .(gender) ]


# Example 2
# Mutate sales to T or F
customers[purchases, on = .(name), return_customer := sales > 1][]


# Example 3
customers[purchases, on = .(name), j = .N, by = gender ][]
customers[purchases, on = .(name), j = .(  avg_age = mean(age)), by = gender ][]

# Example:
students[guardians, on = c("guardian" = "name"), nomatch = 0]









