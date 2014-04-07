## just a simple function to generate a data.frame containing probe set annotations

# x is the ExpressionSet
# ann.source: which annotation source should be used...
# what: what annotations should be included in the data frame?
getAnnotation <- function( x, ann.source="bioconductor", what=c( "accnum", "symbol", "entrezid", "chr", "ensembl" ) ){
  if( !( class( x )=="ExpressionSet" | class( x )=="MadbSet" ) ){
    stop( "x has to be an ExpressionSet" )
  }
  return( getAnnotationForIDs( featureNames( x ), chip=x@annotation, ann.source=ann.source, what=what ) )
}

### return a data.frame
# x: the probe set ids
# chip: the type of chip
# ann.source: which annotation source should be used...
# what: what annotations should be included in the data frame?
getAnnotationForIDs <- function( x, chip, ann.source="bioconductor", what=c( "accnum", "symbol", "entrezid", "chr", "ensembl" ) ){
  ann.source <- tolower( ann.source )
  ann.source=match.arg( ann.source, c( "bioconductor", "biomart" ) )
  if( missing( chip ) ){
    stop("argument chip is required!")
  }
  if( missing( x ) ){
    stop( "argument x (i.e. the probe set IDs) is required!" )
  }
  if( ann.source=="bioconductor" ){
    return( .getAnnotationForIDsBioconductor( x, chip, what ) )
  }
}


.getAnnotationForIDsBioconductor <- function( x, chip, what ){
  if( any( c( "mogene10stv1mmensg", "hugene10stv1hsensg", "ragene10stv1rnensg" ) == chip ) ){
    return( .getAnnotationForAffyWTGeneChip( x, chip, what ) )
  }
  if( !require( paste( chip, ".db", sep="" ), character.only=TRUE ) ){
    source( "http://www.bioconductor.org/biocLite.R" )
    biocLite( paste( chip, ".db", sep="" ) )
    if( !require( paste( chip, ".db", sep="" ), character.only=TRUE ) ){
      warning( paste( "Annotation package ", chip, ".db is not available!", sep="" ) )
      Ann <- data.frame( matrix( ncol=1, nrow=length( x ) ), stringsAsFactors=FALSE)
      colnames( Ann ) <- "probeset_id"
      Ann[ , "probeset_id" ] <- x
      rownames( Ann ) <- x
      return( Ann )
    }
  }
  pkgSyms <- ls(paste("package:", chip, ".db", sep=""))

  wanted <- paste( chip, toupper( what ), sep="" )
  available <- wanted %in% pkgSyms
  if( any( !available ) ){
    warning( paste( "Annotation", what[ !available ], "not available" ) )
    what <- what[ available ]
    wanted <- wanted[ available ]
  }
  Ann <- data.frame( matrix( nrow=length( x ), ncol=length( what )+1 ), stringsAsFactors=FALSE )
  colnames( Ann ) <- c( "probeset_id", what )
  rownames( Ann ) <- x
  Ann[ , "probeset_id" ] <- x
  ## getting the annotations...
  for( i in 1:length( what ) ){
    ResList <- do.call( mget, list( x, env=as.name( wanted[ i ] ), ifnotfound=NA ) )
    ResList <- unlist( lapply( ResList, function( z ){ paste( z, collapse=";", sep="" ) } ) )
    Ann[ , what[ i ] ] <- ResList
  }
  return( Ann )
}

.getAnnotationForAffyWTGeneChip <- function( x, chip, what ){
  Annpackage <- "org.Hs.eg"
  if( chip=="mogene10stv1mmensg" ){
    Annpackage <- "org.Mm.eg"
  }
  if( chip=="ragene10stv1rnensg" ){
    Annpackage <- "org.Rn.eg"
  }
  Ensids <- sub( x, pattern="_at", replacement="" )
  require( paste( Annpackage, ".db", sep="" ), character.only=TRUE )
  pkgSyms <- ls( paste( "package:", Annpackage, ".db", sep="" ) )
  Ann <- data.frame( matrix( nrow=length( Ensids ), ncol=length( what )+1 ), stringsAsFactors=FALSE )
  colnames( Ann ) <- c( "probeset_id", what )
  Ann[ , "probeset_id" ] <- x
  rownames( Ann ) <- x
  ## map the Ensembl gene ids to Entrezgene ids...
  EG <- do.call( mget, list( Ensids, env=as.name( paste( Annpackage, "ENSEMBL2EG",sep="" ) ), ifnotfound=NA ) )
  if( any( what=="entrezid" ) ){
    Ann[ , "entrezid" ] <- unlist( lapply( EG, paste, collapse=";" ) )
  }
  ## doing it manually...
  if( any( what=="accnum" ) ){
    Accs <- lapply( EG, function( z ){
      if( any( is.na( z ) ) ){
        return( NA )
      }
      else{
        # am not using ACCNUM, because we would get all genbank ids associated with the entrezgene id...
        unlist( do.call( mget, list( z, env=as.name( paste( Annpackage, "REFSEQ", sep="" ) ), ifnotfound=NA ) ) )
      }
    } )
    Ann[ , "accnum" ] <- unlist( lapply( Accs, paste, collapse=";" ) )
  }
  if( any( what=="symbol" ) ){
    Accs <- lapply( EG, function( z ){
      if( any( is.na( z ) ) ){
        return( NA )
      }
      else{
        # am not using ACCNUM, because we would get all genbank ids associated with the entrezgene id...
        unlist( do.call( mget, list( z, env=as.name( paste( Annpackage, "SYMBOL", sep="" ) ), ifnotfound=NA ) ) )
      }
    } )
    Ann[ , "symbol" ] <- unlist( lapply( Accs, paste, collapse=";" ) )
  }
  if( any( what=="pfam" ) ){
    Accs <- lapply( EG, function( z ){
      if( any( is.na( z ) ) ){
        return( NA )
      }
      else{
        # am not using ACCNUM, because we would get all genbank ids associated with the entrezgene id...
        unlist( do.call( mget, list( z, env=as.name( paste( Annpackage, "PFAM", sep="" ) ), ifnotfound=NA ) ) )
      }
    } )
    Ann[ , "pfam" ] <- unlist( lapply( Accs, paste, collapse=";" ) )
  }
  if( any( what=="chr" ) ){
    Accs <- lapply( EG, function( z ){
      if( any( is.na( z ) ) ){
        return( NA )
      }
      else{
        # am not using ACCNUM, because we would get all genbank ids associated with the entrezgene id...
        unlist( do.call( mget, list( z, env=as.name( paste( Annpackage, "CHR", sep="" ) ), ifnotfound=NA ) ) )
      }
    } )
    Ann[ , "chr" ] <- unlist( lapply( Accs, paste, collapse=";" ) )
  }
  return( Ann )
}
