convertTxt2Xls <- function( file, sep="\t", as.is=TRUE, header=TRUE, xls="xlsx", ... ){
    if( missing( file ) ){
        stop( "The file name of the txt file has to be submitted!" )
    }
    for( i in 1:length( file ) ){
        tmp <- unlist( strsplit( file[ i ], split="/", fixed=TRUE ) )
        filename <- tmp[ length( tmp ) ]
        path <- "."
        if( length( tmp ) > 1 ){
            path <- paste( tmp[ 1:( length( tmp )-1 ) ], collapse="/" )
        }
        tmp <- unlist( strsplit( filename, split=".", fixed=TRUE ) )
        filename.noending <- paste( tmp[ 1:( length( tmp )-1 ) ], collapse="." )
        ## sanityzing sheet name
        sheetname <- gsub( filename.noending, pattern="[", fixed=TRUE, replacement="-" )
        sheetname <- gsub( sheetname, pattern="]", fixed=TRUE, replacement="-" )
        sheetname <- gsub( sheetname, pattern="*", fixed=TRUE, replacement="-" )
        sheetname <- gsub( sheetname, pattern="?", fixed=TRUE, replacement="-" )
        sheetname <- gsub( sheetname, pattern="/", fixed=TRUE, replacement="-" )
        sheetname <- gsub( sheetname, pattern="\\", fixed=TRUE, replacement="-" )
        sheetname <- unlist( strsplit( sheetname, "" ) )
        sheetname <- paste( sheetname[ 1:(min( c( length( sheetname ), 31 ) ) ) ], collapse="" )
        cat( "Processing file: ", filename, "..." )
        ## read file
        tmp <- read.table( filename, sep=sep, as.is=as.is, header=header, ... )
        WriteXLS( "tmp", ExcelFileName=paste0( path, "/", filename.noending, ".", xls ), SheetNames=sheetname )
        rm( tmp )
        cat( "done.\n" )
    }
}

