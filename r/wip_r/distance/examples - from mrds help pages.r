################################################################################
################################################################################

data(book.tee.data)

region <- book.tee.data$book.tee.region ; head(region)

egdata <- book.tee.data$book.tee.dataframe ; head(egdata)

samples <- book.tee.data$book.tee.samples ; head(samples)

obs <- book.tee.data$book.tee.obs ; head(obs)

model1 = ddf(dsmodel = ~mcds(key = "hn", formula = ~1), data = egdata, method = "ds",
             meta.data = list(width = 4)) ; model1

plot(model1, which = 1, main = "Single observer - half normal")
plot(model1, which = 2, main = "Single observer - half normal")

model2 = ddf(mrmodel = ~glm(~distance), data = egdata, method = "io.fi",
             meta.data = list(width = 4)) ; model2

plot(model2, which = 1, main = "Double observer (io.fi) - half normal")
plot(model2, which = 2, main = "Double observer (io.fi) - half normal")
plot(model2, which = 3, main = "Double observer (io.fi) - half normal")
plot(model2, which = 4, main = "Double observer (io.fi) - half normal")
plot(model2, which = 5, main = "Double observer (io.fi) - half normal")
plot(model2, which = 6, main = "Double observer (io.fi) - half normal")

model3 = ddf(dsmodel = ~cds(key = "hn"), mrmodel = ~glm(~distance), data = egdata,
             method = "io", meta.data = list(width = 4)) ; model3

plot(model3, which = 1, main = "Double observer (io) - half normal")
plot(model3, which = 2, main = "Double observer (io) - half normal")
plot(model3, which = 3, main = "Double observer (io) - half normal")
plot(model3, which = 4, main = "Double observer (io) - half normal")
plot(model3, which = 5, main = "Double observer (io) - half normal")
plot(model3, which = 6, main = "Double observer (io) - half normal")

summary(model1)$aic
summary(model2)$aic
summary(model3)$ ds.summary$aic

################################################################################
################################################################################

data(ptdata.single)

ptdata.single$distbegin = (as.numeric(cut(ptdata.single$distance,10*(0:10)))-1)*10

ptdata.single$distend = (as.numeric(cut(ptdata.single$distance,10*(0:10))))*10

head(ptdata.single)

model4 = ddf(data = ptdata.single,dsmodel = ~cds(key = "hn"),meta.data = list(point = TRUE,
                                                                             binned = TRUE,breaks = 10*(0:10)))
summary(model4)

plot(model4, main = "Single observer binned point data - half normal")

model5 = ddf(data = ptdata.single,dsmodel = ~cds(key = "hr"),
            meta.data = list(point = TRUE,binned = TRUE,breaks = 10*(0:10)))

summary(model5)

plot(model5, main = "Single observer binned point data - hazard rate")

################################################################################
################################################################################

data(ptdata.dual)

ptdata.dual$distbegin = (as.numeric(cut(ptdata.dual$distance,10*(0:10)))-1)*10

ptdata.dual$distend = (as.numeric(cut(ptdata.dual$distance,10*(0:10))))*10

head(ptdata.dual)

table(ptdata.dual$object)

model = ddf(method = "io",data = ptdata.dual,dsmodel = ~cds(key = "hn"),
            mrmodel = ~glm(formula = ~distance*observer),
            meta.data = list(point = TRUE,binned = TRUE,breaks = 10*(0:10)))

summary(model)

par(mfrow = c(2,3))

plot(model,main = "Dual observer binned point data",new = FALSE)

model = ddf(method = "io",data = ptdata.dual,dsmodel = ~cds(key = "unif",
                                                            adj.series = "cos", adj.order = 1),mrmodel = ~glm(formula = ~distance*observer),
            meta.data = list(point = TRUE,binned = TRUE,breaks = 10*(0:10)))

summary(model)

par(mfrow = c(2,3))

plot(model,main = "Dual observer binned point data",new = FALSE)

################################################################################
################################################################################
