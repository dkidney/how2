


n = 100
data = data.frame(a = rnorm(n), b = rnorm(n))

model = lm(a ~ b, data)


colnames(data) = c("s(a)","s(b)") ; head(data)

model = lm(s(a) ~ s(b), data)

model = lm("s(a)" ~ "s(b)", data)

model = lm(as.name("s(a)") ~ as.name("s(b)"), data)

model = lm(bquote(s(a)) ~ bquote(s(b)), data)

model = lm(`s(a)` ~ `s(b)`, data)

names(coef(model))

gsub("`", "", names(coef(model)))

?backquote

