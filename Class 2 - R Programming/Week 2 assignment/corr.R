corr <- function(directory, threshold = 0) {
    ## 'directory' is a character vector of length 1 indicating
    ## the location of the CSV files
    
    ## 'threshold' is a numeric vector of length 1 indicating the
    ## number of completely observed observations (on all
    ## variables) required to compute the correlation between
    ## nitrate and sulfate; the default is 0
    
    ## Return a numeric vector of correlations
    
    file_list <- complete(directory)
    
    res_vect <- NULL
    
    for(i in 1:nrow(file_list)){        
        if(file_list[i,2]>=threshold) {
            file_number <- if(file_list[i,1]<10){
                paste("00", file_list[i,1], sep="")
            } else if(file_list[i,1]<100) {
                paste("0", file_list[i,1], sep="")
            } else {
                file_list[i,1]
            }
            readbuffer <- read.csv(paste(directory, "/", file_number, ".csv", sep=""))
            sulfate_vect <- readbuffer$sulfate[complete.cases(readbuffer)]
            nitrate_vect <- readbuffer$nitrate[complete.cases(readbuffer)]
            res_vect <- c(res_vect, cor(sulfate_vect,nitrate_vect))
        }
    }
    res_vect
}