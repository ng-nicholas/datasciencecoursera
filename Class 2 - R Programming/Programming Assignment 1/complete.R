complete <- function(directory, id = 1:332) {
    ## 'directory' is a character vector of length 1 indicating
    ## the location of the CSV files
    
    ## 'id' is an integer vector indicating the monitor ID numbers
    ## to be used
    
    ## Return a data frame of the form:
    ## id nobs
    ## 1  117
    ## 2  1041
    ## ...
    ## where 'id' is the monitor ID number and 'nobs' is the
    ## number of complete cases
    
    file_id <- NULL
    num_complete <- NULL
    
    for(i in 1:length(id)){        
        file_number <- if(id[i]<10){
            paste("00", id[i], sep="")
        } else if(id[i]<100) {
            paste("0", id[i], sep="")
        } else {
            id[i]
        }
        readbuffer <- read.csv(paste(directory, "/", file_number, ".csv", sep=""))
        
        file_id <- c(file_id, id[i])
        num_complete <- c(num_complete, sum(complete.cases(readbuffer)))
    }
    file_table <- data.frame(id=file_id, nobs=num_complete)
    file_table
}