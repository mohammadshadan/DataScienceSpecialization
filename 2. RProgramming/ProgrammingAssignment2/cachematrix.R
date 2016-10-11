# Date		: 03-AUG-2016
# Version	: V 1.0
# Create functions makeCacheMatrix and cacheSolve for ProgramAssignment2

# makeCacheMatrix: This function creates a special "matrix" object 
# that can cache its inverse.
# It creates a list containing a function which
# Set the value of the matrix
# Get the value of the matrix
# Set the value of inverse of the matrix
# Get the value of inverse of the matrix

makeCacheMatrix <- function(x = matrix()) {
    invm <- NULL                #initializes x above and invm
    
    
    #defines setter for the matrix
    set <- function(y) {              
        x <<- y                 #assigns value of y to x in parent env
        invm <<- NULL           #assigns value NULL to invm in parent env
    }
    
    #defines the getter for the matrix x
    get <- function() {              
      x                         #R retrieves x from the parent env 
    }
    
    #defines the setter for inverse matrix
    setinverse <- function(inverse) { 
      invm <<- inverse          #assigns value of to invm in parent env
    }
    
    #defines the getter for the inverse matrix
    getinverse <- function() {       
      invm                      #R retrieves invm from the parent env
    }
    
    #assigns each of above functions as an element within a list()
    list(set=set, 
	       get=get, 
	       setinverse=setinverse, 
	       getinverse=getinverse)
}


## Point to Note :Naming the list elements is what allows us to
## use the $ form of the extract operator to access the functions 
## by name rather than using the [[ operator

## cacheSolve: This function computes the inverse of the special "matrix" 
## returned by makeCacheMatrix above. If the inverse has already been 
## calculated (and the matrix has not changed), then the cachesolve 
## retrieves the inverse from the cache.

cacheSolve <- function(x, ...) {
        invm <- x$getinverse()
        #return matrix if inverse already exists
        if(!is.null(invm)) {
                message("getting cached matrix data")
                return(invm)
        }
        #Since inverse is not calculated, below steps executes
        data <- x$get()
        invm <- solve(data)    #Calculate the inverse matrix
        x$setinverse(invm)     #inverse matrix is cached
        invm                   #Matrix is Returned
}

#Testing for the above functions
# x <- matrix(rnorm(16), nrow = 4)          
# s <- makeCacheMatrix(x)                 
# s$get()       
# cacheSolve(s) 
#[,1]       [,2]        [,3]        [,4]
#[1,]  0.1299961  0.4226305 -0.05425011  0.44142246
#[2,] -0.7565361 -0.1020694  0.39506682  0.50629596
#[3,]  0.6394913  0.5657235 -1.25206938 -0.05220292
#[4,]  0.5118897  0.1460629 -0.46323346  0.44674890
# cacheSolve(s)  #Returns Cached Matrix 
#getting cached matrix data
#[,1]       [,2]        [,3]        [,4]
#[1,]  0.1299961  0.4226305 -0.05425011  0.44142246
#[2,] -0.7565361 -0.1020694  0.39506682  0.50629596
#[3,]  0.6394913  0.5657235 -1.25206938 -0.05220292
#[4,]  0.5118897  0.1460629 -0.46323346  0.44674890