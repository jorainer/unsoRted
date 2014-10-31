## x is supposed to be a vector of (eventually) pasted ids (e.g. 123;334),
## y can also be a vector of pasted ids, it will be split first.
## the function returns TRUE for each element in x that is also in y.
pastedmatch <- function( x, y, split=";", fixed=TRUE ){
    y <- unique( unlist( strsplit( y, split=split ) ) )
    res <- mclapply( x, FUN=function( z ){
        return( any( unlist( strsplit( as.character( z ), split=split ) ) %in% y ) )
    } )
    return( unlist( res ) )
}


## pastedmatch <- function( x, y, split=";", fixed=TRUE ){
##     y <- unique( unlist( strsplit( y, split=split ) ) )
##     sapply( x, FUN=function( z ){
##         return( any( unlist( strsplit( as.character( z ), split=split ) ) %in% y ) )
##     } )
## }


## X <- sample( letters, 1000000, replace=TRUE )
## X <- paste( X, X, sep=";" )
## Y <- c( "c", "d", "g", "b;a" )

## system.time(
##     Test <- pastedmatch( x=X, y=Y )
## )
## system.time(
##     Test2 <- mpastedmatch( x=X, y=Y )
## )

