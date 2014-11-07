## invert color;
## do that like this:
## options are shift or flip, can be done in either color space.
## shift or flip, in color
## x: a color defined as a character string (e.g. "red", or "#FF00FF")
modColor <- function( x, method="shift", colspace="HSV", shift.by=0.5, ... ){
    method <- match.arg( method, c( "shift", "invert" ) )
    colspace <- match.arg( colspace, c( "RGB", "HSV" ) )
    if( shift.by > 1 | shift.by < 0 )
        stop( "shift by has to be in [0,1]" )
    max.val <- 1
    Inv.col <- col2rgb( x )  ## transform to rgb...
    Inv.col <- RGB( t( Inv.col/255 ) )
    if( colspace=="HSV" )
        Inv.col <- as( Inv.col, "HSV" )
    if( method=="invert" ){
        return( hex( invertColor( Inv.col, ... ) ) )
    }
    if( method=="shift" ){
        return( hex( shiftColor( Inv.col, by=shift.by, ... ) ) )
    }
}

if( !isGeneric( "shiftColor" ) )
    setGeneric( "shiftColor", function( object, by=0.5,... )
        standardGeneric( "shiftColor" ))
## method for RGB
setMethod( "shiftColor", "RGB", function( object, by=0.5, what=c( "R", "G", "B" ), ... ){
    tmp <- coords( object )
    tmp[ , colnames( tmp ) %in% what ] <- tmp[ , colnames( tmp ) %in% what ] + by
    tmp[ tmp > 1 ] <- tmp[ tmp > 1 ] - 1
    return( RGB( tmp ) )
} )
## for HSV color space
setMethod( "shiftColor", "HSV", function( object, by=0.5, what=c( "H", "S", "V" ), ... ){
    tmp <- coords( object )
    if( any( what=="H" ) ){
        tmp[ , "H" ] <- tmp[ , "H" ] + 360 * by
        tmp[ tmp[ , "H" ] > 360 , "H" ] <- tmp[ tmp[ , "H" ] > 360, "H" ] - 360
        what <- what[ what!="H" ]
    }
    ## and for s and v
    tmp[ , colnames( tmp ) %in% what ] <- tmp[ , colnames( tmp ) %in% what ] + by
    tmp[ tmp > 1 ] <- tmp[ tmp > 1 ] - 1
    return( HSV( tmp ) )
} )
## invert color
if( !isGeneric( "invertColor" ) )
    setGeneric( "invertColor", function( object, by=0.5,... )
        standardGeneric( "invertColor" ))
## method for RGB
setMethod( "invertColor", "RGB", function( object, what=c( "R", "G", "B" ), ... ){
    tmp <- coords( object )
    tmp[ , colnames( tmp ) %in% what ] <- 1 - tmp[ , colnames( tmp ) %in% what ]
    return( RGB( tmp ) )
} )
## for HSV color space
setMethod( "invertColor", "HSV", function( object, what=c( "H", "S", "V" ), ... ){
    tmp <- coords( object )
    if( any( what=="H" ) ){
        tmp[ , "H" ] <- 360 - tmp[ , "H" ]
        what <- what[ what!="H" ]
    }
    ## and for s and v
    tmp[ , colnames( tmp ) %in% what ] <- 1 - tmp[ , colnames( tmp ) %in% what ]
    return( HSV( tmp ) )
} )



