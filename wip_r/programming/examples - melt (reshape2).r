################################################################################
library(reshape2)
################################################################################

origdata.wide <- data.frame(subject = 1:4, sex=rep(c("M","F"),2), control=5:8, cond1=9:12, cond2=13:16)

origdata.wide


# id vars must be integer or string

# by default assumes:
#   - sex is the id variable (since it's the only character variable)
#   - all the rest are measure variables
melt(origdata.wide)

# as above but being explicit about the id vars
melt(origdata.wide, 
     id.vars="sex")

# as above but being explicit about the measure vars
melt(origdata.wide, 
     measure.vars=c("subject", "control", "cond1", "cond2"))

# as above but being explicit about both
melt(origdata.wide, 
     id.vars="sex", 
     measure.vars=c("subject", "control", "cond1", "cond2"))

#-------------------------------------------------------------------------------

# using two id variables
melt(origdata.wide, 
     id.vars=c("subject","sex"))

# as above but being explicit about measure vars too
melt(origdata.wide,
     id.vars=c("subject","sex"),
     measure.vars=c("control", "cond1", "cond2" )
)

# as above but also giving column names
melt(origdata.wide,
     id.vars=c("subject","sex"),
     measure.vars=c("control", "cond1", "cond2" ),
     variable.name="condition",
     value.name="measurement"
)

################################################################################
################################################################################
