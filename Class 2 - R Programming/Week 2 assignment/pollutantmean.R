pollutantmean <- function(directory, pollutant, id = 1:332) {
    ## 'directory' is a character vector of length 1 indicating
    ## the location of the CSV files
    
    ## 'pollutant' is a character vector of length 1 indicating
    ## the name of the pollutant for which we will calculate the
    ## mean; either "sulfate" or "nitrate".
    
    ## 'id' is an integer vector indicating the monitor ID numbers
    ## to be used
    
    ## Return the mean of the pollutant across all monitors list
    ## in the 'id' vector (ignoring NA values)
    
    datastore <- NULL
    
    for(i in 1:length(id)){
        file_number <- if(id[i]<10){
            paste("00", id[i], sep="")
        } else if(id[i]<100) {
            paste("0", id[i], sep="")
        } else {
            id[i]
        }
        readbuffer <- read.csv(paste(directory, "/", file_number, ".csv", sep=""))
        datastore <- c(datastore,readbuffer[[pollutant]])
        datastore <- datastore[!is.na(datastore)]
    }
    mean(datastore)
}