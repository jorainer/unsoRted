## This was first defined in 2013-06-19-Translatome-additional-analyses.
## 2014-01-29: returned vector has now names (gene_id).
## 2014-04-02: using mclapply.
getRepPS <- function( x, annot, FUN=function( z ){ mean( z ) * sd( z ) }, order.decreasing=TRUE, v=TRUE, gene.id.col="gene_id", probeset.id.col="probeset_id", transcript.biotype.col="transcript_biotype", prefer.protein.coding=TRUE, probe.count.col="probe_count", probe.count.cut=c( 9, 7, 5 ), mc.cores=getOption( "mc.cores", 2L ) ){
    if( class( x )=="ExpressionSet" ){
        x <- exprs( x )
    }
    if( class( x )!="matrxi" | class( x )!="data.frame" ){
        x <- as.matrix( x )
    }
    CN.sub <- c( gene.id.col, probeset.id.col )
    check.probe.count <- TRUE
    ## checking columns.
    if( sum( colnames( annot )==gene.id.col )!=1 ){
        stop( "Required column ", gene.id.col, " containing gene ids not found in annot. Use parameter gene.id.col to specify the column that contains the gene ids!" )
    }
    if( sum( colnames( annot )==probeset.id.col )!=1 ){
        stop( "Required column ", probeset.id.col, " containing probe set ids not found in annot. Use parameter probeset.id.col to specify the column that contains the probe set ids!" )
    }
    if( sum( colnames( annot )==transcript.biotype.col )!=1 ){
        if( prefer.protein.coding ){
            warning( "Column ", transcript.biotype.col, " not found in annot! Setting prefer.protein.coding to FALSE." )
            prefer.protein.coding <- FALSE
        }
    }
    if( sum( colnames( annot )==probe.count.col )!=1 ){
        warning( "Column ", probe.count.col, " not found in annot! Will not consider probe counts." )
            check.probe.count <- FALSE
    }
    if( prefer.protein.coding ){
        CN.sub <- c( CN.sub, transcript.biotype.col )
    }
    if( check.probe.count ){
        CN.sub <- c( CN.sub, probe.count.col )
    }
    ## generating the data.frame that we will process...
    if( v ){
        cat( "Preparing data..." )
    }
    ## to enable returning the result in the same order than the input:
    idx <- unique( annot[ , gene.id.col ] )
    BigData <- cbind( annot[ , CN.sub ], x[ annot[ , probeset.id.col ], ] )
    BigData <- split( BigData, f=BigData[ , gene.id.col ] )
    if( v ){
        cat( "done.\nRunning the code on", mc.cores, "CPUs\n" )
    }
    ## now we are mclapplying...
    best.ps <- mclapply( BigData, FUN=function( y ){
        ## now check if we can/have to reduce the elements in y
        ## break if only one row
        if( nrow( y )==1 ){
            return( y[ 1, probeset.id.col ] )
        }
        if( prefer.protein.coding ){
            idx <- grep( y[ , transcript.biotype.col ], pattern="protein" )
            if( length( idx ) > 0 ){
                y <- y[ idx, , drop=FALSE ]
            }
        }
        ## break if only one left
        if( nrow( y )==1 ){
            return( y[ 1, probeset.id.col ] )
        }
        ## probe counts...
        if( check.probe.count ){
            for( probe.cut in probe.count.cut ){
                have.some <- y[ , probe.count.col ] >= probe.cut
                if( any( have.some ) ){
                    y <- y[ have.some, , drop=FALSE ]
                }
            }
        }
        ## break if only one left
        if( nrow( y )==1 ){
            return( y[ 1, probeset.id.col ] )
        }
        Score <- apply( y[ , -( 1:length( CN.sub ) ), drop=FALSE ], MARGIN=1, FUN=FUN )
        idx <- order( Score, decreasing=order.decreasing )
        return( y[ idx, probeset.id.col ][ 1 ] )
    }, mc.cores=mc.cores )
    if( v ){
        cat( "done.\n" )
    }
    best.ps <- unlist( best.ps )
    names( best.ps ) <- names( BigData )
    return( best.ps[ idx ] )
}
