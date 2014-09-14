rankall <- function(outcome, num = "best") {
    ## Read outcome data
    data <- read.csv("outcome-of-care-measures.csv", colClasses = "character")
    
    # Setting column numbers to match the respective columns in the data
    state.col <- 7
    outcome.cols <- c(11, 17, 23)
    name.col <- 2
    
    # Setting the parameters for acceptable inputs to the function
    valid.states <- unique(data[, state.col])
    valid.outcomes <- c("heart attack", "heart failure", "pneumonia")
    
    # Setting the order of the states for correct ordering of results
    valid.states <- valid.states[order(valid.states)]
    
    ## Check that outcome is valid
    # Convert the supplied arguments to the respective character case for 
    # comparison
    outcome <- tolower(outcome)
    
    # If loops to check if input is valid
    if(outcome %in% valid.outcomes == F) {
        stop("invalid outcome")
    }
    
    ## For each state, find the hospital of the given rank
    ## Return a data frame with the hospital names and the
    ## (abbreviated) state name
    # Determine the column to use for sorting observations
    target.col <- outcome.cols[match(outcome, valid.outcomes)]
    
    # Creating vectors to store hospital names and states
    hospital.vector <- NULL
    state.vector <- NULL
    
    # Looping through the list of states
    for(i in 1:length(valid.states)) {
        # Get a subset of the data frame using each state
        data.sub <- subset(data, data[, state.col] == valid.states[i])
        
        # Using different sorting methods depending on value of num argument
        if(num == "worst") {
            data.sub <- data.sub[order(-as.numeric(data.sub[, target.col]), 
                                       data.sub[, name.col], na.last = NA), ]
        } else {
            data.sub <- data.sub[order(as.numeric(data.sub[, target.col]), 
                                       data.sub[, name.col], na.last = NA), ]
        }
        
        # Returning different output depending on value of num argument
        if(is.numeric(num)) {
            if(num <= nrow(data.sub)) {
                target.name <- data.sub[num, name.col]
            } else {
                target.name <- NA
            }
        } else {
            target.name <- data.sub[1, name.col]
        }
        
        # Appending values to vectors
        hospital.vector <- c(hospital.vector, target.name)
        state.vector <- c(state.vector, valid.states[i])
    }
    
    # Creating the data frame to be returned
    return(data.frame(hospital = hospital.vector, state = state.vector))
}