################################################################################
################################################################################

# Examples - merge

################################################################################
################################################################################

# example 0

nsurveys = 2
npoints = 3
nreplcates = 3

surveys = data.frame(surveyID = 1:nsurveys, season = c("summar", "winter")) ; surveys

points = data.frame(pointID = 1:npoints, habitat = c("forest", "grassland", "coast")) ; points

replicates = expand.grid(surveyID = 1:nsurveys, pointID = 1:npoints) ; replicates

replicates$couldy = sample(c("Y","N")) ; replicates

merge(replicates, surveys)

merge(replicates, npoints)

merge(merge(replicates, surveys), points)

################################################################################

# example 1

x <- data.frame(var1 = 1:5, var2 = 5:1) ; x
y <- data.frame(var1 = 5:1, var3 = 6:10) ; y

merge(x, y)

merge(x, y, by="var1")
merge(x, y, by="var2")
merge(x, y, by="var3")

merge(x, y, by.x="var1")
merge(x, y, by.x="var2")
merge(x, y, by.x="var2", sort=FALSE)

merge(x, y, by.y="var1")
merge(x, y, by.y="var3")

################################################################################

# example 2

x <- data.frame(var1 = 3:1, var2 = 3:1, var3 = 5:7) ; x
y <- data.frame(var1 = 2:4, var2 = 2:4, var4 = 7:5) ; y

merge(x, y, by.x="var1", by.y="var1", sort = FALSE)
merge(x, y, sort = FALSE)

merge(x, y, all.x = TRUE)
merge(x, y, by.x="var1", by.y="var1", all.x = TRUE, sort = FALSE)

merge(x, y, all.y = TRUE)
merge(x, y, by.x="var1", by.y="var1", all.y = TRUE, sort = FALSE)

merge(x, y, all = TRUE)
merge(x, y, by.x="var1", by.y="var1", all = TRUE, sort = FALSE)

################################################################################
################################################################################
