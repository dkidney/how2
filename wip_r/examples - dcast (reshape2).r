################################################################################
library(reshape2)
################################################################################

origdata.long <- read.table(header=T, text='
 subject sex condition measurement
       1   M   control         7.9
       1   M     cond1        12.3
       1   M     cond2        10.7
       2   F   control         6.3
       2   F     cond1        10.6
       2   F     cond2        11.1
       3   F   control         9.5
       3   F     cond1        13.1
       3   F     cond2        13.8
       4   M   control        11.5
       4   M     cond1        13.4
       4   M     cond2        12.9
 ')

# Make sure the subject column is a factor
origdata.long$subject <- factor(origdata.long$subject)

origdata.long

dcast(origdata.long, subject + sex ~ condition, value.var="measurement")

dcast(origdata.long, subject + sex ~ condition, value.var="measurement")


