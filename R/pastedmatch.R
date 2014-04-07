## x is supposed to be a vector of (eventually) pasted ids (e.g. 123;334),
## y can also be a vector of pasted ids, it will be split first.
## the function returns TRUE for each element in x that is also in y.
pastedmatch <- function( x, y, split=";" ){
    y <- unique( unlist( strsplit( y, split=split ) ) )
    sapply( x, FUN=function( z ){
        return( any( unlist( strsplit( z, split=split ) ) %in% y ) )
    } )
}
