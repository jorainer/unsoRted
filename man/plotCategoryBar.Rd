\name{plotCategoryBar}
\alias{plotCategoryBar}
\alias{plotCategoryBars}
\title{
Plot horizontal bars for category enrichment analysis results
}
\description{
  These functions draw horizontal bars that allow to visualize category
  enrichment results.
}
\usage{
plotCategoryBar( x=0, y=0, width=1, size, count=NULL,
subcount=NULL, col.size="lightgrey", border.size="grey",
col.count=brewer.pal( 9, "Greys" )[ 7 ], border.count=col.count,
col.subcount=NULL, border.subcount, add=FALSE, xlab="count", ylab="",
legend=FALSE, xlim, cex=par( "cex" ), ... )

plotCategoryBars( x=0, y=0, width=1, size, count=NULL,
subcount=NULL, col.size="lightgrey", border.size="grey",
col.count=brewer.pal( 9 , "Greys" )[ 7 ], border.count=col.count,
col.subcount=NULL, border.subcount, add=FALSE, xlab="count", ylab="",
legend=FALSE, asc=TRUE, spacer=width/10, xlim, cex.legend=par( "cex" ), cex=par( "cex" ), ... )

}
\arguments{
  \item{x}{
    The x-coordinate of the rectangle's left side. For
    \code{plotCategoryBars}, x and y specify the position of the bottom
    rectangle.
  }
  \item{y}{
    The y-coordinate of the rectangle's left side (middle position).
  }
  \item{width}{
    The width of the rectangle (rectangle will be plotted at \code{y-width/2}
    to \code{y+width/2} on the y-axis).
  }
  \item{size}{
    the total number of counts (genes) in the category. For
    \code{plotCategoryBar} a single value, for \code{plotCategoryBars} a
    numeric vector.
  }
  \item{count}{
    the count of significant genes in the category. This can also be a
    (ideally named) vector of
    counts, in which case separate rectangles, one next to the other on
    the x-axis, will be plotted for each count. For
    \code{plotCategoryBars}, to achieve the same (latter) behavious, a
    list of (named) numerical vectors has to be submitted.
  }
  \item{subcount}{
    for \code{plotCategoryBar}: a numerical vector (ideally named) if
    sub-counts.
    For \code{plotCategoryBars}: a list of named numerical vectors.
    In contrast to the above parameter, these counts will be
    represented by vertically splitted rectangles instead of rectangles
    one next to the other along the x-axis. See below for examples.
  }
  \item{col.size}{
    the color for the (background) rectangle.
  }
  \item{border.size}{
    the border color for the (background) rectangle.
  }
  \item{col.count}{
    the color(s) for the significant count rectangle(s).
  }
  \item{border.count}{
    the border color for the significant count rectangle.
  }
  \item{col.subcount}{
    the colors for the subcount rectangles. The colors have to be named,
    and the names have to match the names of the subcounts.
  }
  \item{border.subcount}{
    the border color.
  }
  \item{add}{
    whether the plot should be added to an existing plot.
  }
  \item{xlab}{
    the label for the x-axis.
  }
  \item{ylab}{
    the label for the y-axis.
  }
  \item{legend}{
    whether a legend should be drawn.
  }
  \item{asc}{
    if the bars should be plotted in ascending order, i.e. the first
    element at the top of the plot.
  }
  \item{spacer}{
    the spacing between the rectangles on the y-axis.
  }
  \item{xlim}{
    the xlim for the plot region. Rectangles will be cropped if size is
    larger than \code{xlim[2]} with the actual count of the size being
    plotted into the rectangle.
  }
  \item{cex}{
    graphical parameter for the plot.
  }
  \item{cex.legend}{
    allows to adjust in addition the size of the legend.
  }
  \item{...}{
    additional parameters to be passed to the \code{plot} function.
  }
}
\value{
  A plot.
}
\details{
  The names of the submitted numerical values are required to match the
  counts to the colors used for the rectangles.
  For \code{plotCategoryBars} the names of the \code{size} parameter
  will be used for the y-axis.
}
\references{
  http://bioinfo.i-med.ac.at
}
\author{
  Johannes Rainer
}
\examples{

## Classical view of a Category enrichment: plot size and count.
plotCategoryBar( 0, 0, size=10, count=2, legend=TRUE )
## If count can be further subdivided, plot a rectangle for each count.
plotCategoryBar( 0, 0, size=10, count=c( first=2, second=5 ), legend=TRUE)
## multiple bars: example would be the results of a category enrichment analysis for target
## genes of a set of microRNAs. In such a case, a gene could be target of more then one
## miRNA, thus, separate bars, placed horizontally next to each other would not be correct,
## since the total count of target genes would exceed the unique number of target genes.
## defining the number of target genes for 3 miRNAs in the category.
mirna.counts <- c( mir2=1, mir5=4, mir6=5)
plotCategoryBar( 0, 0, size=10, count=7, subcount=mirna.counts, legend=TRUE )
plotCategoryBar( 0, 0, size=10, count=c(a=7, b=2), subcount=mirna.counts, legend=TRUE )

## multiple stuff...
Sizes <- c( small=10, large=123, medium_category=69 )
## simple bars
plotCategoryBars( size=Sizes )
Counts <- c( 9, 25, 30 )
plotCategoryBars( size=Sizes, count=Counts, legend=TRUE )
## multiple counts per category.
Counts2 <- list( c( a=1, b=4 ), c( c=4, a=9 ), c( a=12, e=4, f=2 ) )
plotCategoryBars( size=Sizes, count=Counts2, legend=TRUE )
## that's now the full thing. Again on an example of miRNA target genes...
mirna.counts <- list( c( mir2=1, mir5=4, mir6=5 ),
                     c( mir3=12, mir6=3, mir7=23, mir9=3 ),
                     c( mir2=8, mir9=14 ) )
plotCategoryBars( size=Sizes, count=Counts, subcount=mirna.counts, legend=TRUE )

}
\keyword{ data }
\keyword{ analysis }
