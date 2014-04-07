####
## Applied Bioinformatics Group,
## Division of Molecular Pathophysiology, Biocenter,
## Medical University of Innsbruck,
## Innrain 80-82, 6020 Innsbruck, Austria
## http://bioinfo.i-med.ac.at
## Developer: Daniel Bindreither, Johannes Rainer
####
#cat( "This is generic-category.R version 1.01.\n" )

## Just a generic function to do a category analysis on a list of entrezgene ids (or whathever).


## This function is supposed to check for the correct assignment
## of bg and fg gene lists
checkFgAndBgGeneSets <- function( fg.gns, bg.gns ) {
    consist <- all(fg.gns %in% bg.gns)
    fg <- length(fg.gns) != 0 & all(is.character(fg.gns))
    bg <- length(bg.gns) != 0 & all(is.character(bg.gns))
    consist & fg & bg
}


hyperGGeneric <- function( fg.gns=character(), bg.gns=character(), x, proc="BH" ){
    if( missing( x ) ){
        stop( "Argument x is mandatory" )
    }
    if( class( x )!="list" ){
        stop( "x has to be a list with names corresponding to the category names and entries being (entrezgene) IDs." )
    }
    if(! checkFgAndBgGeneSets(fg.gns, bg.gns) )
        stop("Not all genes in the fg.gns are contained in the bg.gns")

    fg.gns <- as.character( unique( fg.gns ) )
    bg.gns <- as.character( unique( bg.gns ) )

    ## check that the numbers correspond to genes that are really part of any category,
    ## otherwise the test would not be correct.
    no.fg.genes <- length( fg.gns )
    no.bg.genes <- length( bg.gns )
    AllGenes <- as.character( unique( unlist( x ) ) )
    fg.gns <- fg.gns[ fg.gns %in% AllGenes ]
    bg.gns <- bg.gns[ bg.gns %in% AllGenes ]
    rm( AllGenes )
    cat( "Of the ", no.fg.genes, " input genes ", length( fg.gns ), " can be annotated to one or more categories.\n" )
    cat( "Of the ", no.bg.genes, " background genes ", length( bg.gns ), " can be annotated to one or more categories.\n" )
    ##

    ##	             | drawn	not drawn	| total
    ## ------------------------------------------------
    ## white marbles |	k	K − k	        |   K
    ## black marbles |	n − k	N + k − n − K	| N − K
    ## ------------------------------------------------
    ## total	     |   n	N − n	        |  N

    ## number of genes from fg list associated with term
    k <- unlist( lapply( x, function( CatGenes ){
        length( intersect( as.character(CatGenes ), as.character( fg.gns ) ) )
    } ) )
    ## total bg genes  in Category
    K <- unlist( lapply( x, function( CatGenes ){
        length( intersect( as.character(CatGenes ), as.character( bg.gns ) ) )
    } ) )
    ## number of interesting genes.
    n <- length( fg.gns )
    ## total number of genes tested
    N <- length( bg.gns )
    numW <- K
    numDrawn <- n
    numB <- N - K
    numWdrawn <- k

#    ## get sig gene Ids
#    sig.genes <- unlist(lapply(pathway.list, function(reactomePath) {
#        intersect(reactomePath, as.character(fg.gns))
#    }))

    entrezids <- unlist( lapply( x, function( CatGenes ){
        paste( intersect( as.character( CatGenes ), as.character( fg.gns ) ), collapse=";" )
    } ) )
    entrezids.universe <- unlist( lapply( x, function( CatGenes ){
        paste( intersect( as.character( CatGenes ), as.character( bg.gns ) ), collapse=";" )
    } ) )
    n21 <- numW - numWdrawn
    n12 <- numDrawn - numWdrawn
    n22 <- numB - n12
    odds_ratio <- (numWdrawn * n22)/(n12 * n21)
    expected <- (numWdrawn + n12) * (numWdrawn + n21)
    expected <- expected/(numWdrawn + n12 + n21 + n22)
    pvals <- phyper(numWdrawn - 1L, numW, numB, numDrawn,
                    lower.tail = FALSE)
    AdjP2 <- mt.rawp2adjp( pvals, proc=proc )
    AdjP2 <- AdjP2$adj[ order( AdjP2$index ), ]
    rownames( AdjP2 ) <- names(pvals)
    DF <- data.frame( Term=names( x ), AdjP2,
                     Count=numWdrawn, Size=numW, perc=numWdrawn*100/numW,
                     fg.gns=entrezids,
                     bg.gns=entrezids.universe )
    DF <- DF[ order(DF$rawp), ]
    return( DF )
}

