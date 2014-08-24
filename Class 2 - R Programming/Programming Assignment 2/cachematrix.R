## The functions listed below will initialise a storage variable to cache 
## computed inverse matrices for any given square matrix and subsequently enable
## the retrieval of cached matrices, cutting down on processing time and power.
## The "makeCacheMatrix" function creates a list of interactions with the two
## matrix variables, while the "cacheSolve" function determines whether to 
## retrieve a stored value or compute and store the inverse matrix.


# The "makeCacheMatrix" function initialises a storage variable "invmatrix"
# to store the inverse of a matrix that is supplied to it. Additionally, it
# creates a list of interactions with both "invmatrix" as well as "origmatrix",
# storing information about both.

makeCacheMatrix <- function(origmatrix = matrix()) {
    
    # "invmatrix" is a internally and externally used variable that will store 
    # the inverted matrices.
    invmatrix <- NULL
    
    # "set" is a function that takes the argument "y". This function will change 
    # the matrix being evaluated and reinitialise the "invmatrix" variable.
    set <- function(y) {
        origmatrix <<- y
        invmatrix <<- NULL
    }
    
    # "get" is a function that returns the original matrix being evaluated.
    get <- function() {origmatrix}
    
    # "setinv" is a function that superassigns the computed inverse matrix to
    # the inverse matrix storage variable.
    setinv <- function(inverse) {invmatrix <<- inverse}
    
    # "getinv" is a function that retrieves the cached inverse matrix.
    getinv <- function() {invmatrix}
    
    # Before the "makeCacheMatrix" function is completed, a list of accessible
    # interactions is created and stored.
    list(set = set, get = get,
         setinv = setinv,
         getinv = getinv)
}


# The "cacheSolve" function attempts to retrieve the cached inverse matrix for
# a given matrix. If it cannot be found, the function then proceeds to compute 
# the inverse of the given matrix and caches it for future reference.

cacheSolve <- function(origmatrix, ...) {
    
    # Using the "getinv" function defined in the previous "makeCacheMatrix"
    # function, the first step is to attempt to retrieve any previously stored
    # inverse matrix, for a given matrix.
    invmatrix <- origmatrix$getinv()
    
    # Subsequently, an if condition needs to be specified to break the function
    # out of the process if there has been a previously computed inverse matrix.
    # This is determined by evaluating if the "invmatrix" variable is empty or
    # otherwise.
    if(!is.null(invmatrix)) {
        message("Getting cached data...")
        
        # The "return" function causes an immediate code break by printing 
        # whatever is defined in the parantheses.
        return(invmatrix)
    } else {
        # This step is purely optional, but it helps to inform users of what is
        # taking place in the background. Since this part of the loop does not
        # contain a "return" statement, the remainder of the "cacheSolve" 
        # function continues to process.
        message("Computing and caching inverse matrix...")
    }
    
    # The "data" variable is temporarily defined variable used to store the 
    # original matrix being evaluated.
    data <- origmatrix$get()
    
    # The following statement will locally assign the value of the "solve"
    # function to "invmatrix". The "solve" function takes a number of arguments,
    # which the first two are matrices to be evaluated. If the second argument
    # is omitted, the function will return the inverse of the given matrix. In
    # this case, the first matrix pass to it is the one stored in "data".
    invmatrix <- solve(data, ...)
    
    # This statement will call upon the "setinv" function defined in 
    # "makeCacheMatrix", and will superassign the local value of "invmatrix" as 
    # the global value.
    origmatrix$setinv(invmatrix)
    
    # Lastly, the function will return the locally assigned value of "invmatrix"
    # to show the results of the function.
    invmatrix
}