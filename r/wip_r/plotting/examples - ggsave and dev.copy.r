################################################################################
################################################################################

# plotting functions

################################################################################
################################################################################

run.ggsave <- function(height = 6, width = 6){
    
    ggsave(filename = file.path(figures.folder, paste(prefix, plot.name, ".", device, sep="")),
           plot = myplot, height = height, width = width, units = "in", dpi = 300)
    
}

run.dev.copy <- function(height = 6, width = 6){
    
    if(device == "jpeg" | device == "jpg"){
        height = height * multiplier    
        width = width * multiplier            
    }
    
    dev.copy(device = eval(parse(text=device)), 
             file.path(figures.folder, paste(prefix, plot.name, ".", device, sep="")), 
             height = height, width = width)
    
    dev.off() 
       
}

################################################################################
################################################################################
