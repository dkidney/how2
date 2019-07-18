
## layout ##

library(fields)

op = par(no.readonly = TRUE) # save default, for resetting...


# first argument is a matrix which indicates which plots go where

mat = rbind(c(1,1),
            c(2,3)) ; mat

layout(mat)

layout.show(1)
layout.show(2)
layout.show(3)


# you can make the layout cells square if you want
# and you can save the layout output

mylayout = layout(mat, respect = TRUE)

layout.show(mylayout)

par(mar = c(0,0,0,0))

for(i in 1:3) image(volcano, axes = FALSE)


# can also use different par settings for each window

layout(matrix(1:4,2, byrow = TRUE), respect = TRUE)

for(i in 1:4){
    par(mar = rep(i,4))
    image(volcano, axes = FALSE)  
} 


# still annoying to use plot functions which use their own par settings 

mylayout = layout(matrix(1:4,2, byrow = TRUE), respect = TRUE)

layout.show(mylayout)

for(i in 1:4) image.plot(volcano, axes = FALSE)

layout.show(mylayout)


# can't use it with filled.contour though since this function uses layout internally


#  ------------------------------------------------------------------------

par(op)  #- reset to default


