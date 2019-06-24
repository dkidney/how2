################################################################################
################################################################################

# this file should work ok if you source it

# a fairly large vector of numbers
n = 750
x = rnorm(n^2) ; length(x)

#-------------------------------------------------------------------------------
# square matrices - i.e. nrows = ncols

# test 1 - rows outer loop, cols inner loop
cat("\ninner loop = cols (same)\n")
M = matrix(x, n, n)
print(system.time( for(row in 1:nrow(M)) for(col in 1:ncol(M)) M[row,col] = M[row,col] / 2))
gc()

# test 2 - rows inner loop, cols outer loop
cat("\ninner loop = rows (same)\n")
M = matrix(x, n, n)
print(system.time( for(col in 1:ncol(M)) for(row in 1:nrow(M)) M[row,col] = M[row,col] / 2))
gc()

#-------------------------------------------------------------------------------
# rectangular matrices part 1 - nrows >> ncols

# test 1 - rows outer loop, cols inner loop
cat("\ninner loop = cols (small)\n")
M = matrix(x, n*10, n/10)
print(system.time( for(row in 1:nrow(M)) for(col in 1:ncol(M)) M[row,col] = M[row,col] / 2))
gc()

# test 2 - rows inner loop, cols outer loop
cat("\ninner loop = rows (big)\n")
M = matrix(x, n*10, n/10)
print(system.time( for(col in 1:ncol(M)) for(row in 1:nrow(M)) M[row,col] = M[row,col] / 2))
gc()

#-------------------------------------------------------------------------------
# rectangular matrices part 2 - ncols >> nrows

# test 1 - rows outer loop, cols inner loop
cat("\ninner loop = cols (big)\n")
M = matrix(x, n/10, n*10)
print(system.time( for(row in 1:nrow(M)) for(col in 1:ncol(M)) M[row,col] = M[row,col] / 2))
gc()

# test 2 - rows inner loop, cols outer loop
cat("\ninner loop = rows (small)\n")
M = matrix(x, n/10, n*10)
print(system.time( for(col in 1:ncol(M)) for(row in 1:nrow(M)) M[row,col] = M[row,col] / 2))
gc()

#-------------------------------------------------------------------------------
# Conculsions

# if matrices are square it looks like it's a bit quicker to put columns in the outer loop (as is appropriate for column-major ordering)

# if matrices are rectangular it looks like putting the largers dimension in the inner loop is potentially much faster (even if that means putting the columns as the inner loop)

# the reason? it's all about the cache...

################################################################################
################################################################################

