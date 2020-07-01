## ------------------------------------------------------------------------- ## 
## ------------------------------------------------------------------------- ## 

## dplyr - examples
 
## ------------------------------------------------------------------------- ## 
## ------------------------------------------------------------------------- ## 

require(dplyr)

# Note: if your data frame has row names then these will be ignored by most of the dplyr functions - if you want to keep the rownames then save the row names in a separate column before you start.


# group_by ----------------------------------------------------------------

# using the mtcars dataset as an example
head(mtcars)
class(mtcars)

# create a grouped tbl object
by_cyl = group_by(mtcars, cyl)
by_cyl
class(by_cyl)
groups(by_cyl)

# use ungroup to undo grouped_df class (keeps tbl class)
class(ungroup(by_cyl))

# more than one grouping level
by_vs_am <- group_by(mtcars, vs, am)
groups(by_vs_am)

# group by expressions
group_by(mtcars, vsam = vs + am)
group_by(mtcars, vs2 = vs)

# add groups
groups(group_by(by_cyl, vs, am, add = TRUE))


# summarise ---------------------------------------------------------------

# use with tbl objects
# works with normal dataframes too, but not very useful
summarise(mtcars, mean(disp))
summarise(group_by(mtcars, cyl), mean(disp))
summarise(group_by(mtcars, cyl), m = mean(disp), sd = sd(disp))

# compare with the verboseness of using tapply
tapply(mtcars$disp, mtcars$cyl, mean)
tapply(mtcars$disp, mtcars$cyl, sd)

# use the n() function to count the number of observations in each group
summarise(by_cyl, n = n())


# mutate ------------------------------------------------------------------

# add new variables
head(mutate(mtcars, displ_l = disp / 61.0237))

# or delete variables
head(mutate(mtcars, cyl = NULL))

# compare with within
head(within(mtcars, displ_l <- disp / 61.0237))
head(within(mtcars, cyl <- NULL))


# mutate_each -------------------------------------------------------------





# transmute ---------------------------------------------------------------

# drop existing variables
head(transmute(mtcars, displ_l = disp / 61.0237))


# filter ------------------------------------------------------------------

# subset a data.frame
head(filter(mtcars, cyl == 8))

# subset a grouped data object - harder to do with conventional subsetting
head(filter(by_cyl, disp == max(disp)))


# select ------------------------------------------------------------------

select(by_cyl, starts_with("d"))
select(by_cyl, ends_with("p"))
select(by_cyl, contains("a"))
select(by_cyl, matches(".r."))
select(by_cyl, gear, carb)
select(by_cyl, -gear, -carb)
select(by_cyl, one_of(c("gear", "carb")))


# arrange -----------------------------------------------------------------

head(arrange(mtcars, disp))
head(arrange(mtcars, desc(disp)))

head(arrange(mtcars, gear, disp))
head(arrange(mtcars, gear, desc(disp)))

arrange(by_cyl, disp)
arrange(by_cyl, gear, desc(disp))


## ------------------------------------------------------------------------- ## 
## ------------------------------------------------------------------------- ## 