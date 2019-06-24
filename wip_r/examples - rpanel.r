################################################################################

require(rpanel)

################################################################################

# rp.block / rp.button

# This function will be called on pressing the button "Simulate".
boxp.sim <- function(panel) {
    boxplot(rnorm(50))
    panel
}
# Create an rpanel and add the button "Simulate" to it.
panel <- rp.control(panelname="panel")
rp.button(panel, action = boxp.sim, title = "Simulate")
rp.block(panel)

################################################################################

rp.cartoons()

################################################################################

# rp.checkbox

plot.hist <- function(panel) {
    with(panel, {
        xlim <- range(c(x, mean(x) + c(-3, 3) * sd(x)))
        if (panel$cbox[3])
            clr <- "lightblue" else clr <- NULL
        hist(x, freq = FALSE, col = clr, xlim = xlim)
        if (panel$cbox[1]) {
            xgrid <- seq(xlim[1], xlim[2], length = 50)
            dgrid <- dnorm(xgrid, mean(x), sd(x))
            lines(xgrid, dgrid, col = "red", lwd = 3)
        }
        if (panel$cbox[2])
            box()
    })
    panel
}
x <- rnorm(50)
panel <- rp.control(x = x)
rp.checkbox(panel, cbox, plot.hist, 
            labels = c("normal density", "box", "shading"), title = "Options")
rp.do(panel, plot.hist)

################################################################################

# rp.combo

callback <- function(panel) {
    print(panel$option)
    panel
}
panel <- rp.control()
rp.combo(panel, option, "Pick an option:", 
         c("Option1","Option2","Other options"), action=callback)

################################################################################

# rp.control

hist.or.boxp <- function(panel) {
    if (panel$plot.type == "histogram")
        hist(panel$x)
    else
        boxplot(panel$x)
    panel
}
panel <- rp.control(x=rnorm(50), panelname="panel")
rp.radiogroup(panel, plot.type, c("histogram", "boxplot"),
              title="Plot type", action = hist.or.boxp)  

################################################################################

# rp.control.put

action1 <- function(panel) {
    panel$x <- rnorm(1)
    rp.control.put(panel$panelname, panel)
    rp.do(panel, action2)
    panel
}
action2 <- function(panel) {
    print(panel$x)
    panel
}
panel <- rp.control(x = 0)
rp.button(panel, action1, "new x")

################################################################################

# rp.do

data.plotfn <- function(panel) {
    if (panel$plot.type == "histogram")
        hist(panel$x)
    else
        if (panel$plot.type == "boxplot")
            boxplot(panel$x)
    else
        plot(density(panel$x))
    panel
}
panel <- rp.control(x = rnorm(50))
rp.radiogroup(panel, plot.type,
              c("histogram", "boxplot", "density estimate"),
              action = data.plotfn, title = "Plot type", initval="histogram")
rp.do(panel, data.plotfn)

################################################################################

# rp.doublebutton

density.draw <- function(panel) {
    plot(density(panel$x, bw = panel$h), xlim=c(0,10))
    panel
}
panel <- rp.control(x = rnorm(50))
rp.doublebutton(panel, var = h, step = 0.05, 
                title = "Density estimate", action = density.draw,
                range = c(0.1, 5), initval=1)

################################################################################

# rp.grid

panel <- rp.control()
rp.grid(panel, pos=list(row=0, column=0, sticky="news"), background="red", name="g0")
rp.grid(panel, pos=list(row=1, column=1, sticky="news", width=100, height=100), background="navy", name="g1")
rp.grid(panel, pos=list(row=2, column=2, sticky="news", width=150, height=200), background="green", name="g2")
rp.button(panel, function(panel) { panel }, "press A", pos=list(row=1, column=1, sticky=""), parentname="g1")
rp.button(panel, function(panel) { panel }, "press B", pos=list(row=2, column=2, sticky="news"), parentname="g1")
rp.button(panel, function(panel) { panel }, "press C", pos=list("left",width=50, height=150), parentname="g2")
rp.grid(panel, pos=list(row=0, column=0, sticky="", width=10, height=10), background="yellow", parentname="g0")

################################################################################

# rp.image

gulls.click <- function(panel, x, y) {
    print(c(x, y))
    panel
}
panel <- rp.control()
image.file <- file.path(system.file(package = "rpanel"), "images", "gulllmks.gif")
rp.image(panel, image.file, gulls.image, action = gulls.click)

################################################################################

# rp.listbox

data.plotfn <- function(panel) {
    if (panel$plot.type == "histogram")
        hist(panel$x)
    else
        if (panel$plot.type == "boxplot")
            boxplot(panel$x)
    else
        plot(density(panel$x))
    panel
}
panel <- rp.control(x = rnorm(50))
rp.listbox(panel, plot.type,
           c("histogram", "boxplot", "density estimate"),
           action = data.plotfn, title = "Plot type") 

################################################################################

# rp.menu

a <- rp.control()
# The action function has to come first so that it already exists for rp.menu, 
# as it creates the callback functions on the fly it requires action to already 
# be defined.
domenu <- function(panel) {
    rp.messagebox(panel$menuchoice, title = "You chose")
    panel
}
rp.menu(a, menuchoice, labels=list(list("File","Quit"),
                                   list("Edit","Copy","Cut","Paste")), action=domenu)

################################################################################

# rp.panel

# create a panel -will be created in .rpenv as "newpanel"
rp.control(panelname = "newpanel")
# creates the panel, but does not return a handle to it - created as ".rpanel2"
rp.control()
# pick up the first panel
panel2 <- rp.panel("newpanel")

################################################################################

# rp.plot3d

x <- rnorm(50)
y <- rnorm(50)
z <- rnorm(50)
scaling <- rp.plot3d(x, y, z, xlim = c(-3, 3))
# In addition you may add a line to the plot with these two lines;
# a <- scaling(c(-3,3), c(0,0), c(0,0))
# lines3d(a$x, a$y, a$z, col = "green", size = 2)

################################################################################

# rp.plot4d

# The quakes data
with(quakes, {
    rp.plot4d(cbind(long, lat), depth)
    rp.plot4d(cbind(long, lat), depth, mag)
})

# SO2 over Europe
with(SO2, {
    location <- cbind(longitude, latitude)
    if (require(mgcv) & require(maps)) {
        location1 <- location[,1]
        location2 <- location[,2]
        model <- gam(logSO2 ~ s(location1, location2, year))
        loc1 <- seq(min(location1), max(location1), length = 30)
        loc2 <- seq(min(location2), max(location2), length = 30)
        yr <- seq(min(year), max(year), length = 30)
        newdata <- expand.grid(loc1, loc2, yr)
        names(newdata) <- c("location1", "location2", "year")
        model <- predict(model, newdata)
        model <- list(x = cbind(loc1, loc2), z = yr,
                      y = array(model, dim = rep(30, 3)))
        mapxy <- map('world', plot = FALSE,
                     xlim = range(longitude), ylim = range(latitude))
        rp.plot4d(location, year, logSO2, model,
                  col.palette = rev(heat.colors(20)),
                  foreground.plot = function() map(mapxy, add = TRUE))
    }
    else
        rp.plot4d(location, year, logSO2, col.palette = rev(heat.colors(20)))
})

# Dissolved Oxygen in the River Clyde
with(Clyde, {
    # Highlight the data before and after a sewage treatment plant update in 1985
    ind <- Year >= 80 & Year <= 89 & !(Year == 85)
    year <- Year[ind] + Doy[ind] / 365
    station <- Station[ind]
    doy <- Doy[ind]
    do <- DO[ind]
    group <- factor(c("before 1985", "after 1985")[1 +
                                                       as.numeric(year < 85)])
    rp.plot4d(cbind(doy, do), station, group,
              col.palette = c("red", "green"), location.plot = FALSE)
})    
    
################################################################################

# rp.radiogroup

data.plotfn <- function(panel) {
    if (panel$plot.type == "histogram") 
        hist(panel$x)
    else 
        if (panel$plot.type == "boxplot")
            boxplot(panel$x)
    else 
        plot(density(panel$x))
    panel
}
panel <- rp.control(x = rnorm(50))
rp.radiogroup(panel, plot.type, 
              c("histogram", "boxplot", "density estimate"), 
              action = data.plotfn, title = "Plot type")    

################################################################################

# rp.slider

density.draw <- function(panel) {
    plot(density(panel$x, bw = panel$h))
    panel
}
panel <- rp.control(x = rnorm(50))
rp.slider(panel, h, 0.5, 5, log = TRUE, action = density.draw)

printer <- function(panel) {
    print(panel$h)
    panel
}
panel <- rp.control(x = rnorm(50), h=c(1,2,3))
rp.slider(panel, h, c(0.5,0.5,0.5), c(5,5,5),
          log = c(TRUE,TRUE,TRUE), action = printer,
          title=c('h','h1','h2'), initval=c(1,2,3))

# An example which changes the slider position through another widget

draw <- function(panel) {
    hist(panel$x)
    abline(v=panel$v, col="red", lty=2)
    panel
}

redraw <- function(panel) {
    rp.tkrreplot(panel, plot)
    panel
}

redraw1 <- function(panel) {
    rp.tkrreplot(panel, plot)
    rp.slider.change(panel, "slider", panel$v)
    panel
}

x <- rnorm(25)
panel <- rp.control(v = 0, x = x)
rp.tkrplot(panel, plot, draw, pos="right")
rp.slider(panel, v, min(x), max(x), redraw, name = "slider")
rp.doublebutton(panel, v, diff(range(x))/100, action=redraw1)

################################################################################

# rp.surface

if (require(sm)) {
    provide.data(trawl, options = list(describe = FALSE))
    location <- cbind(Longitude, Latitude)
    model <- sm.regression(location, Score1, ngrid = 15, display = "none")
    longitude <- model$eval.points[ , 1]
    latitude <- model$eval.points[ , 2]
    xgrid <- as.matrix(expand.grid(longitude, latitude))
    S <- sm.weight2(location, xgrid, model$h)
    covar <- tcrossprod(S) * model$sigma^2
    rp.surface(model$estimate, covar, longitude, latitude, location, Score1)
}

################################################################################

# rp.text

panel <- rp.control(x=1)
callback <- function(panel)
{
    rp.text.change(panel, "t2", panel$x)
    panel$x = panel$x+1
    panel
}
rp.text(panel, "This is a test", name="t1")
rp.text(panel ,"And so is this", font="Arial", foreground="white", background="navy", action=callback, name="t2")
rp.text(panel,"Here is some more text, this time across several lines.\nHere is some more text, this time across several lines.\nHere is some more text, this time across several lines.", name="t3")

################################################################################

# rp.textentry

plotf <- function(panel) {
    with(panel, {
        pars   <- as.numeric(pars)
        xgrid <- seq(0.1, max(c(pars[3], 5), na.rm = TRUE), length = 50)
        dgrid <- df(xgrid, pars[1], pars[2])
        plot(xgrid, dgrid, type = "l", col = "blue", lwd = 3)
        if (!is.na(pars[3])) {
            lines(rep(pars[3], 2), c(0, 0.95 * max(dgrid)), lty = 2, col = "red")
            text(pars[3], max(dgrid), as.character(pars[3]), col = "red")
        }
    })
    panel
}

panel <- rp.control(pars = c(5, 10, NA))
rp.textentry(panel, pars, plotf, labels = c("df1", "df2", "observed"),
             initval = c(10, 5, 3))
rp.do(panel, plotf)

################################################################################

# rp.timer

stopme <- function(panel) panel$count<=20
callme <- function(panel) {
    print(panel$count)
    panel$count = panel$count+1
    panel
}
panel <- rp.control(count=1)
rp.timer(panel, 500, callme, stopme)

################################################################################

# rp.tkrplot

draw <- function(panel) {
    plot(1:20, (1:20)^panel$h, type="l")
    panel
}

redraw <- function(panel) {
    rp.tkrreplot(panel, tkrp)
    panel
}

rpplot <- rp.control(title = "Demonstration of rp.tkrplot", h = 1)
rp.tkrplot(rpplot, tkrp, draw)
rp.slider(rpplot, h, action = redraw, from = 0.05, to = 2.00, resolution = 0.05)

################################################################################

# rp.widget.dispose

p1 <- rp.control()
rp.button(p1, I, "press me", name="b1")
rp.widget.dispose(p1, b1 )

################################################################################
################################################################################


################################################################################