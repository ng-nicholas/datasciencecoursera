rankhospital <- function(state, outcome, num = "best") {
    ## Read outcome data
    data <- read.csv("outcome-of-care-measures.csv", colClasses = "character")
    
    # Setting column numbers to match the respective columns in the data
    state.col <- 7
    outcome.cols <- c(11, 17, 23)
    name.col <- 2
    
    # Setting the parameters for acceptable inputs to the function
    valid.states <- unique(data[, state.col])
    valid.outcomes <- c("heart attack", "heart failure", "pneumonia")
    
    ## Check that state and outcome are valid
    # Convert the supplied arguments to the respective character case for 
    # comparison
    state <- toupper(state)
    outcome <- tolower(outcome)
    
    # If loops to check if input is valid
    if(state %in% valid.states == F) {
        stop("invalid state")
    }
    if(outcome %in% valid.outcomes == F) {
        stop("invalid outcome")
    }
    
    ## Return hospital name in that state with the given rank    
    ## 30-day death rate
    # Get a subset of the data frame using the supplied state argument
    data.sub <- subset(data, data[, state.col] == state)
    
    # Determine the column to use for sorting observations
    target.col <- outcome.cols[match(outcome, valid.outcomes)]
    
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
            return(data.sub[num, name.col])
        } else {
            return(NA)
        }
    } else {
        return(data.sub[1, name.col])
    }
    
}