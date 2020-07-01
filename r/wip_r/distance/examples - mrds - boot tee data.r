
require(mrds)

data(book.tee.data)

region <- book.tee.data$book.tee.region ; region

egdata <- book.tee.data$book.tee.dataframe ; head(egdata) ; str(egdata)

samples <- book.tee.data$book.tee.samples ; samples

obs <- book.tee.data$book.tee.obs ; head(obs)

obs <- merge(obs, egdata[egdata$observer == 2,]) ; head(obs)

str(region)
str(samples)
str(obs)

model <- ddf(dsmodel = ~mcds(key = "hn", formula = ~1), data = obs, method = "ds",
           meta.data = list(width = 4))

model

dht.fit <- dht(model, region, samples, obs)

dht.fit$individuals$N
dht.fit$clusters$N

head(dht.fit$individuals$Nhat.by.sample) ; dim(dht.fit$individuals$Nhat.by.sample)

dht.fit$individuals$summary
