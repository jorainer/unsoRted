## second approach... download as a temp file and read from there...
read.table.from.http <- function( x, ... ){
    TP <- tempfile()
    download.file( url=x, destfile=TP )
    return( read.table( TP, ... ) )
}

load.from.http <- function( x, ... ){
    TP <- tempfile()
    download.file( url=x, destfile=TP )
    load( TP, envir=globalenv(), ... )
}
