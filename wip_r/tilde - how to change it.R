# ON A MAC
# add the line below to the .Rprofile file
Sys.setenv("HOME"="/Users/darrenkidney/Dropbox/")
# to find the .Rprofile, click on 'HOME' in the Rstudio files tab

# ON WINDOWS
# add a new environment variable 
# control panel > System > Advanced System Properties > Environment Variables... > System variables > New... 
# then set the variable name as "R_USER"
# and set the variable value e.g. as "C:/Users/Darren/Dropbox"

# check the tilde definition using
path.expand("~")
