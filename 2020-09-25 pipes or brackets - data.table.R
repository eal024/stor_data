

library( data.table);library(tidyverse)

dt_cars <- as.data.table(mtcars)

DT = data.table(
    ID = c("b","b","b","a","a","c"),
    a = 1:6,
    b = 7:12,
    c = 13:18
)

head(dt_cars) 

#
dt_cars[ cyl %in% c(6:8), .N, by = .(am,cyl) ][]

# Ordered
setorder(dt_cars, -am)[ cyl %in% c(6,8), list(antall = .N, 
                             mean_disp = mean(disp),
                             mean_hp = mean(hp) ), by = .(am, cyl)][]



# Example
dt_cars[ #filter
    mpg > 20,
     # summarise
    list( antall = .N, avg_qsec = mean(qsec), max = max(drat)),
    by = list(carb,gear)][order(gear, decreasing = T)]


# joining
DT2 <- data.table(
    ID = c("b","b","b","a","a","c"),
    ny_var_d = 100:105
)

DT2 <- DT2[, .(ny_var_d = sum(ny_var_d)), by = ID]

DT %>% left_join(DT2, by = "ID")

DT[DT2, on = .(ID = ID) ]

# or
setkey(DT, ID) 
setkey(DT2, ID)

DT[DT2, ]
DT2[DT,]

# Creating new variables
DT[, ':=' ( a_b = a*b , max = max(a), a_lag = lag(a), b_lead = lead(b) ), by = ID][]
    


# pivoting: ---------------------------------------------------------------

table1 %>% pivot_longer( names_to = "var", values_to = "value", cases:population)

DT_1 <- as.data.table(table1)

melt(DT_1, measure.vars =  c("cases", "population"), variable.name = c( "var"), value.name = "value_var")






# Last example:





