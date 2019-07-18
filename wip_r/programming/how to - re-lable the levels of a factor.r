


n <- 10

A <- factor(sample(letters[1:4], n, TRUE)) ; A

levels(A)

levels(A) <- rev(letters[1:4])

A
