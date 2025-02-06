# shiny

* function reference: https://shiny.posit.co/r/reference/shiny/latest/
* mastering shiny: https://mastering-shiny.org/

## functions

### `eventReactive`

```r
```

### `isolate`

Execute a reactive expression within a reactive scope without causing the reactive scope to be re-executed. Can also be used in non-reactive scopes - e.g. to evaluate the reactive expressions in the console for debugging.

```r
```

### `reactive`

```r
```

### `reactiveVal`

```r
x <- reactiveVal(0) # create a reactive value object with an initial value 
x() # get the object value 
r(10) # set the object value 
```

### `reactiveValues`

```r
x <- reactiveValues(a = 1, b = 2)
x$a # get the value of 'a' 
x[['a']] # get the value of 'a' 
isolate(x$a) # get the value of 'a' outside a reactive context
x$a <- 3 # set the value of 'a' 
x[['b']] <- 4 # set the value of 'b' 
```

### `req`

```r
```

