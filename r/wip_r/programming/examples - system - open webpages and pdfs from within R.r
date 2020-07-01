################################################################################
# system
################################################################################

# open a webpage
system("open http://www.google.com")

# open a search
search <- "Introduction to R"
system(paste("open http://www.google.com/#q=", gsub(" ","+",search), sep = ""))

################################################################################

# open a pdf

plot(0,0)
dev.copy(pdf, 'my_plot.pdf')
dev.off()
system("open my_plot.pdf")
file.remove('my_plot.pdf')

# open a file stored in an installed package
system(paste("open", system.file("doc/secr-overview.pdf", package = "secr")))

################################################################################

# Using temporary files

tempdir()
plotPath <- tempfile("plot_", fileext=".pdf") ; plotPath
pdf(plotPath)
plot(0,0)
dev.off()
system(paste("open", plotPath))

################################################################################

# get computer host name

system("hostname")
system("hostname", intern = TRUE)

################################################################################
################################################################################



