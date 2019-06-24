

# environment -------------------------------------------------------------

# returns the current environment

environment()

f = function() environment()

# a new environment is associated with f every time it is called
f() 
f() 




# parent.frame ------------------------------------------------------------

# this accesses the chain of environments within which a function was called (the call stack?)

# parent.frame(1) gives the environment where the function was called
# parent.frame(2) gives parent environment of the environment where the function was called
# parent.frame(3) gives parent environment of the environment of the parent environment of the environment... etc.

f = function() parent.frame(1)

# f is called in the global env
f()

# f is called in function g
g = function() f()
g()

# e.g. evaluate an expression in the parent environment
x = 1
h = function(){
    x = 10
    evalq(2*x, envir = parent.frame())
}
h()

x = 1
h = function(){
    x = 10
    k = function(){
        x = 100
        evalq(2*x, envir = parent.frame())
    }
    k()
}
h()

x = 1
h = function(){
    x = 10
    k = function(){
        x = 100
        m = function(){
            x = 1000
            evalq(2*x, envir = parent.frame())
        }
        m()
    }
    k()
}
h()




# sys.parent --------------------------------------------------------------

# this tells you how many parent frames a function had when it was called

f = function() sys.parent()
g = function() f()
h = function() g()

f() # 0 parents
g() # 1 parent (g)
h() # 2 parents (g and h)

# here's a general way of evaluating an expression in the environment of the outermost frame
x = 1
h = function(){
    x = 10
    k = function(){
        x = 100
        evalq(2*x, envir = parent.frame(sys.parent())) 
    }
    k()
}
h()

# be careful with the apply functions since they use additional layers of parenting

# for example, lapply produces an additional parent as you migth expect (for lapply itself)
f = function() lapply(1, sys.parent)
f() # 1 parent (lapply)

# however if you define FUN as being another function, then FUN also becomes a parent
f = function() lapply(1, function(i) sys.parent())
f() # 2 parents (lapply, FUN)

# and if you use sapply you get another one (because sapply is just a wrapper for lapply)
f = function() sapply(1, function(i) sys.parent(), simplify = FALSE)
f() # 3 parents (sapply, lapply, FUN)




# sys.call ----------------------------------------------------------------

# this gives the identity of the parent frame

f = function(n) sys.call(n)
g = function(n) f(n)
h = function(n) g(n)

f(1)

g(1)
g(2)

h(1)
h(2)
h(3)




# sys.calls ---------------------------------------------------------------

# this gives the identities of the frames used in the call stack
# includes that of the function which called sys.calls() itself

f = function() sys.calls()
g = function() f()
h = function() g()

f() # 1 frame  (0 parents)
g() # 2 frames (1 parent)
h() # 3 frames (2 parents)

# more helpful when trying to work out what's going on with sapply

f = function() lapply(1, function(i) sys.calls())
f() # 3 frames (2 parents)

f = function() sapply(1, function(i) sys.calls(), simplify = FALSE)
f() # 4 frames (3 parents)




# sys.nframe --------------------------------------------------------------

# this tells you the total number of frames there are in the call stack
# I think it's just equal to sys.parent() + 1

f = function() sys.nframe()
g = function() f()
h = function() g()

f() # 1 frame  (0 parents)
g() # 2 frames (1 parent)
h() # 3 frames (2 parents)




# sys.frames --------------------------------------------------------------

# gives you a list of calling environments (length equal to sys.nframe)

f = function() sys.frames()
g = function() f()
h = function() g()

f() 
g() 
h() 




# sys.status --------------------------------------------------------------

# this gives lots of sys information about the call stack

f = function() sys.status()
g = function() f()
h = function() g()

f() 
g() 
h() 




# sys.function -------------------------------------------------------------

# this goes backwards down the call stack (I think) 
# it's a little bit like sys.calls but seems harder to use

f = function(n) sys.function(n)
f(1) 

g = function(n) f(n)
g(1) 
g(2) 

h = function(n) g(n)
h(1) 
h(2) 
h(3) 




# parent.env --------------------------------------------------------------

# confusingly this is the environment that was bound to a function when it was defined
# it is NOT the environment in which it was called (unless the function happens to be called in the same enviroment in which it was made)

# f made in global env
f = function() parent.env(environment())
f()

# parent.env stays the same even if it is called from inside another function
g = function() f() 
g()

# here it is actually re-defined inside another function
h = function(){
    f = function() parent.env(environment())
    f()
}
h()




# sys.frame ---------------------------------------------------------------

# seems to just give you the environment in which the function was called 

f = function() sys.frame()
g = function() f()
h = function() g()

f() 
g() 
h() 

x = 1
h = function(){
    x = 10
    k = function(){
        x = 100
        evalq(2*x, envir = sys.frame()) 
    }
    k()
}
h()




