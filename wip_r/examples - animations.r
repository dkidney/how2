
setwd("~\\Resources\\R\\Examples")

require(animation)

ani.options(interval = 0.5,
            outdir = getwd(),
            imgdir = "")

par(mfrow = c(1,1), mar = c(4, 4, 2, 2))

for (i in 1:10) {
    plot(rnorm(50), ylim = c(-3, 3), main = i)
    ani.pause()
}


saveGIF({
    for (i in 1:10) {
        plot(rnorm(50), ylim = c(-3, 3), main = i)
        ani.pause()
    }
}, img.name = "anim_norm", imgdir = "anim_dir", movie.name = "anim_norm.gif", autobrowse = FALSE)



saveHTML({
    for (i in 1:10) {
        plot(rnorm(50), ylim = c(-3, 3), main = i)
        ani.pause()
    }
}, img.name = "anim_norm", imgdir = "anim_dir", htmlfile = "anim_norm.html", autobrowse = TRUE, 
         title = "Tab name", description = "A random example")
