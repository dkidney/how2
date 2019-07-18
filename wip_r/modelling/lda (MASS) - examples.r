
require(MASS)

# e.g. the iris data set
rownames(iris) = NULL
colnames(iris) = abbreviate(colnames(iris), 2)
iris$Sp = factor(abbreviate(iris$Sp, 3))
head(iris) ; dim(iris)

# use a random set of the data as a training set
tr = sample(1:150, 70)
table(iris$Sp[tr])
n = length(unique(iris$Sp[tr])) ; n

# perform lda
results = lda(Sp ~ ., iris, subset = tr) ; results

# plot results
par(mar = c(4,4,0.5,0.5))
plot(results)
# - colours = true class
plot(results, col = (1:n)[iris$Sp[tr]])

# look at the predictions for test data set
preds = predict(results, iris[-tr, ])
preds$class

# plot predictions
# - colours = predicted class
# - labels = true class
plot(preds$x, type = "n")
text(preds$x, cex = 0.75,
    label = iris$Sp[-tr],
    col = (1:length(unique((preds$class))))[preds$class])

