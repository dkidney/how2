

data = data.frame(sex = rep(c("M","F"), each = 5), length=runif(10, 1,2)) ; data

model.matrix(~ sex, data)
model.matrix(~ -1 + sex, data)

model.matrix(~ sex + length, data)
model.matrix(~ -1 + sex + length, data)

model.matrix(~ sex * length, data)
model.matrix(~ -1 + sex * length, data)
model.matrix(~ -1 + sex + sex:length, data)



