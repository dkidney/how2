
require(MFDA)

data("testdata")

head(testdata) ; dim(testdata)

windows()

matplot(t(testdata), type = "l")

my.clust = MFclust(testdata, minG=3, maxG=5, nchain=1, iter.max=1)

my.clust

matplot(t(testdata), type = "l", col = my.clust$clust)


