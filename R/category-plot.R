
## x: the x coordinate of the left side of the rectangle.
## y: the y coordinate of the left side of the rectangle.
## width: the width of the rectangle (rectangle will be plotted at y-width/2 to y+width/2)
## size: the total numnber of counts (genes) in the category
## count: the number of significant counts in the category. Can be a vector of counts, in which case rectangles for each count will be plotted next to each other (ordered by size).
## subcount: numerical vector (ideally named) of "sub counts", if e.g. genes used in count could be split into different subtypes. In contrast to the above setting,
##           in which the rectangles are plotted one next to other, these rectangles will be plotted split vertically (see examples).
## col.size: the color for the (background) rectangle.
## border.size: color for the border of the "size" rectangle.
## col.count: the color for the significant/specific rectangle(s).
## border.count: color for the border.
## col.subcount: colors to be used for the subcounts.
## border.subcount: the border color for the "subcount" rectangles.
## add: whether to add to an existing plot or plot on its own.
## xlab: the x axis label.
## ylab: the y axis label.
## legend: whether or not a legend should be plotted.
##
## Important note: size is assumed to be always bigger than the sum of counts!
plotCategoryBar <- function( x=0, y=0, width=1, size, count=NULL, subcount=NULL, col.size="lightgrey", border.size="grey", col.count=brewer.pal( 9, "Greys" )[ 7 ], border.count=col.count, col.subcount=NULL, border.subcount, add=FALSE, xlab="count", ylab="", legend=FALSE, ... ){
    if( missing( size ) )
        stop( "Parameter size has to be defined!" )
    ## count and subcount are optional.
    if( !add ){
        YLIM <- c( y-width/2, y+width/2 )
        if( legend ){
            YLIM[ 2 ] <- YLIM[ 2 ] + diff( YLIM )/10
        }
        plot( x, y, pch=NA, xlim=c( x, x+size ), ylim=YLIM, yaxt="n", bty="n", xlab=xlab, ylab=ylab, ... )
    }
    ## background.
    rect( xleft=x, ybottom=y-width/2, xright=x+size, ytop=y+width/2, col=col.size, border=border.size )
    legend.legend <- "all"
    legend.col <- col.size
    ## process count, if defined.
    if( !is.null( count ) ){
        if( class( count )!="numeric" )
            stop( "count should be numeric!" )
        ## we do require names for the counts, otherwise the legend does not have any sense...
        if( is.null( names( count ) ) ){
            if( length( count )==1 ){
                names( count ) <- "significant"
            }else{
                message( "Parameter count has no names, automatically defining some." )
                names( count ) <- 1:length( count )
            }
        }
        ## check the colors...
        ## if col.count has names and count has names subset col.count to those...
        if( !is.null( names( count ) ) & !is.null( names( col.count ) ) ){
            if( !any( names( count ) %in% names( col.count ) ) ){
                ## have some names of counts for which I don't have any color!
                col.count <- NULL
            }else{
                ## subset, otherwise I get an error in the next condition...
                col.count <- col.count[ names( count ) ]
            }
        }
        if( length( col.count )!=length( count ) ){
            message( "More count categories than colors! Will automatically define them." )
            col.count <- brewer.pal( max( c( 3, length( count ) ) ), "Set1" )[ 1:length( count ) ]
        }
        names( col.count ) <- names( count )
        ## adding the counts...sorted by size
        count <- count[ order( unlist( count ), decreasing=TRUE ) ]
        current_x <- x
        for( i in 1:length( count ) ){
            rect( xleft=current_x, ybottom=y-width/2, xright=current_x+count[[ i ]], ytop=y+width/2, col=col.count[ names( count )[ i ] ], border=border.count[ names( count )[ i ] ] )
            current_x <- current_x + count[[ i ]]
        }
        ## pre-define the legend labels and colors...
        legend.legend <- c( legend.legend, names( count ) )
        legend.col <- c( legend.col, col.count[ names( count ) ] )
    }
    ## now, if subcount was defined plot that too.
    if( !is.null( subcount ) ){
        if( is.null( names( subcount ) ) )
            names( subcount ) <- 1:length( subcount )
        if( class( subcount )!="numeric" )
            stop( "subcount should be a numeric vector!" )
        ## check if we do have subcount colors defined...
        ## if we do have named color check if the names fit and in case sub-set.
        if( !is.null( names( subcount ) ) & !is.null( names( col.subcount ) ) ){
            if( !any( names( subcount ) %in% names( col.subcount ) ) ){
                col.subcount <- NULL
            }else{
                col.subcount <- col.subcount[ names( subcount ) ]
            }
        }
        if( is.null( col.subcount ) | length( col.subcount )!=length( subcount ) ){
            ## if we do have more than one count col, we do most likely have Set1, so
            ## select a different brewer.pal set...
            Which.set <- ifelse( length( col.count ) > 1, yes="Set2", no="Set1" )
            col.subcount <- brewer.pal( max( c( length( subcount ), 3 ) ), Which.set )[ 1:length( subcount ) ]
            names( col.subcount ) <- names( subcount )
            message( "Automatically defining sub category colors." )
        }
        if( missing( border.subcount ) )
            border.subcount <- col.subcount
        ## order them.
        subcount <- subcount[ order( subcount, decreasing=FALSE ) ]
        ## depending on how many we do have, we plot horizontal rectangles...
        subcount.width <- width/length( subcount )
        current_y <- y-width/2
        for( i in 1:length( subcount ) ){
            rect( xleft=x, xright=subcount[ i ], ybottom = current_y, ytop=current_y+subcount.width, col=col.subcount[ names( subcount )[ i ] ], border=border.subcount[ names( subcount )[ i ] ] )
            current_y <- current_y + subcount.width
        }
        legend.legend <- c( legend.legend, names( subcount ) )
        legend.col <- c( legend.col, col.subcount[ names( subcount ) ] )
    }
    ## do the legend...
    if( legend ){
        legend( "top", horiz = TRUE, legend=legend.legend, col=legend.col , pch=15 )
    }
    rect( xleft=x, ybottom=y-width/2, xright=x+size, ytop=y+width/2, col=NA, border=border.size )
}

## the same function but for more data...
## asc: whether the bars should be plotted in ascending order, i.e. the first element at the top.
## x and y define the middle of the lowest bar.
## spacer: the space in between the bars on the y axis.
## subcount: if defined, it has to be a list of (named!) numerical vectors. The names are required to match the numbers in the numerical vectors to the colors.
## col.subcount: a vector of (named!) colors. The names have to match the names of the numbers in the subcount list.
plotCategoryBars <- function( x=0, y=0, width=1, size, count=NULL, subcount=NULL, col.size="lightgrey", border.size="grey", col.count=brewer.pal( 9 , "Greys" )[ 7 ], border.count=col.count, col.subcount=NULL, border.subcount, add=FALSE, xlab="count", ylab="", legend=FALSE, asc=TRUE, spacer=width/10, ... ){
    if( missing( size ) )
        stop( "Parameter size has to be defined!" )
    if( class( size )!="numeric" )
        stop( "Parameter size has to be a numeric vector!" )
    ## count and subcount are optional
    ## let's go. Do it with a simple and poor for loop.
    if( !add ){
        max.size <- max( size )
        XLIM <- c( x, x+max.size )
        YLIM <- c( y-width/2, y + width/2 + ( ( length( size ) -1 ) * ( width + spacer ) ) )
        if( legend ){
            YLIM[ 2 ] <- YLIM[ 2 ] + diff( YLIM )/10
        }
        plot( 3, 3, pch=NA, xlim=XLIM, ylim=YLIM, yaxt="n", bty="n", xlab=xlab, ylab="", ... )
        if( !is.null( names( size ) ) ){
            ## will use the names of the size as axis labels...
            Maxw <- max( strwidth( names( size ), cex=par( "cex.axis" ), units="in" ) )
            Mai <- par( "mai" )
            Mai[ 2 ] <- Maxw  ## overwriting the left margin of the plot
            par( mai=Mai )  ## finally set the left plot margin to fit the max label length (in inches)
            plot( 3, 3, pch=NA, xlim=XLIM, ylim=YLIM, yaxt="n", bty="n", xlab=xlab, ylab="", ... )
            Labels <- names( size )
            if( asc )
                Labels <- rev( Labels )
            mtext( side=2, at=seq( y, by=width+spacer, length.out=length( Labels ) ), text=Labels, las=2, cex=par( "cex.axis" ) )
        }
    }
    Legend.legend <- "all"
    Legend.col <- col.size
    ## what do I require: size should be numeric, count should be numeric or a list,
    ## subcount should always be a list.
    if( !is.null( count ) ){
        if( class( count )=="numeric" ){
            count <- as.list( count )
        }
        if( class( count )!="list" )
            stop( "Parameter count has to be either a list of integers, or a numeric vector!" )
        ## check if we do have all the same lenghts...
        if( length( size )!=length( count ) )
            stop( "Parameters size and count have to have the same number of elements!" )
        ## ok, that's done... now it get's tricky to define the colors...
        ## define the count colors if not set...
        ## if the elements have names define a unique vector of names and define colors for them...
        if( !is.null( unique( unlist( lapply( count, names ) ) ) ) ){
            count.names <- unique( unlist( lapply( count, names ) ) )
            if( length( count.names )!=length( col.count ) | !any( count.names %in% names( col.count ) )){
                message( "Automatically defining colors for counts." )
                col.count <- brewer.pal( max( c( 3, length( count.names ) ) ), "Set1" )[ 1:length( count.names ) ]
                names( col.count ) <- count.names
            }
        }else{
            ## check if the length is > 1 for any of them. If yes, stop sice we can't define
            ## colors without names!
            if( any( unlist( lapply( count, FUN=length ) ) > 1 ) )
                stop( "No names for counts provided but I have in some cases more than one count per category. Parameter count should be a list of (named!) numeric vectors!" )
        }
        if( is.null( names( col.count ) ) )
            names( col.count ) <- "significant"
        Legend.legend <- c( Legend.legend, names( col.count ) )
        Legend.col <- c( Legend.col, col.count )
    }
    ## subcount:
    if( !is.null( subcount ) ){
        if( class( subcount )!="list" )
            stop( "Parameter subcount has to be a list!" )
        if( length( subcount )!=length( size ) )
            stop( "Parameters subcount and size have to have the same number of elements!" )
        ## colors for subcount: subcount always has to be a list of named vectors, and the colors always
        ## have to be named colors matching the names of the elements!
        subcount.names <- unique( unlist( lapply( subcount, names ) ) )
        if( is.null( subcount.names ) )
            stop( "The numerical vectors in parameter subcount have to have names!" )
        ## check if names match names of colors.
        if( !is.null( col.subcount ) ){
            if( !any( subcount.names %in% names( col.subcount ) ) ){
                col.subcount <- NULL
                warning( "Names provided for the subcount colors do not match the names of subcounts! Automatically defining colors." )
            }
        }
        if( is.null( col.subcount ) ){
            col.subcount <- brewer.pal( max( c( 3, length( subcount.names ) ) ), "Set1" )[ 1:length( subcount.names ) ]
            names( col.subcount ) <- subcount.names
        }
        Legend.legend <- c( Legend.legend, names( col.subcount ) )
        Legend.col <- c( Legend.col, col.subcount )
    }
    ## ok, and now plot the stuff... using an ugly for loop...
    ## order the stuff. since we are plotting from bottom up, ascending order means that we
    ## have to re-order.
    if( asc ){
        size <- rev( size )
        if( !is.null( count ) )
            count <- rev( count )
        if( !is.null( subcount ) )
            subcount <- rev( subcount )
    }
    current_y <- y
    current_subcount <- NULL
    current_count <- NULL
    for( i in 1:length( size ) ){
        if( !is.null( count ) ){
            current_count <- count[[ i ]]
        }
        if( !is.null( subcount ) ){
            current_subcount <- subcount[[ i ]]
        }
        plotCategoryBar( x=x, y=current_y, add=TRUE, width=width, size=size[ i ], count=current_count, subcount=current_subcount, col.size=col.size, border.size=border.size, col.count=col.count, border.count=border.count, col.subcount=col.subcount, border.subcount=border.subcount )
        current_y <- current_y + width + spacer
    }
    if( legend ){
        legend( "top", horiz = TRUE, legend=Legend.legend, col=Legend.col , pch=15 )
    }
}


## Examples...


