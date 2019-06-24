
args = function(a = 1, b = 2, ...){
    list(...)
} ; args(c = 3)

args3 = function(a = 1, b = 3, ...){
    match.call()
} ; args(c = 3)

args = function(a = 1, b = 2, ...){
    match.call(expand.dots = FALSE)
} ; args(c = 3)

args = function(a = 1, b = 2, ...){
    match.call()$...
} ; args(c = 3)

args = function(a = 1, b = 2, ...){
    match.call(expand.dots = FALSE)$...
} ; args(c = 3)

args = function(a = 1, b = 2, ...){
    sapply(match.call()$..., as.character)
} ; args(c = 3)

args = function(a = 1, b = 2, ...){
    sapply(match.call(expand.dots = FALSE)$..., as.character)
} ; args(c = 3)

args = function(a = 1, b = 2, ...){
    pryr::dots(...)
} ; args(c = 3)

args = function(a = 1, b = 2, ...){
    c(as.list(environment()), list(...))
} ; args(c = 3)
