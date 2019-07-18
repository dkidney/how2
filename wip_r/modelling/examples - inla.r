################################################################################
################################################################################

# INLA

################################################################################
################################################################################

# main version
source("http://www.math.ntnu.no/inla/givemeINLA.R") 

# testing version
source("http://www.math.ntnu.no/inla/givemeINLA-testing.R") 

# upgrade main version 
inla.upgrade()  

# uograde testing version
inla.upgrade(testing=TRUE)

install.packages("INLA.tgz", repos=NULL, type="source")