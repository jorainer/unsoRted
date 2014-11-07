\name{modColor}
\alias{modColor}
\title{
Modify colors
}
\description{
This function modifies, i.e. inverts or shifts colors.
}
\usage{
modColor( x, method="shift", colspace="HSV", shift.by=0.5, ... )
}
\arguments{
  \item{x}{a character vector of color(s) that should be modified. Can
    be any color definition that can be handled by the \code{col2rgb} function.}
  \item{method}{how the color should be modified; either \dQuote{shift}
    or \dQuote{invert}.}
  \item{colspace}{the color space in which the modification should be
    performed; either \dQuote{RGB} or \dQuote{HSV}.}
  \item{shift.by}{the proportion by which the individual color channels
    should be shifted.}
  \item{...}{additional parameters to be submitted to the
    \code{shiftColor} and \code{invertColor} functions.}
}
\value{
  A character vector of color(s) (in HTML notion).
}
\details{
By default the submitted color modifies the complete color, by passing
the \code{what} parameter to the function it is also possible to change
individual channels (coordinates). See help for the functions
\code{\link{invertColor}} or \code{\link{shiftColor}} for details.
}
\seealso{
  \code{\link{invertColor}}, \code{\link{shiftColor}}, \code{\link{col2rgb}}.
}
\examples{

Colors <- c( "black", "red", "blue", "grey", brewer.pal( 3, "Pastel1" ) )
par( mar=c( 0, 8, 0, 0 ) )
plot( 3, 3, pch=NA, axes = FALSE, xlab="", ylab="", xlim=c( 0.5, length( Colors ) + 0.5 ), ylim=c( 0.5, 8.5 ) )

## invert the colors in HSV color space
points( x=1:length( Colors ), y=rep( 1, length( Colors ) ), pch=16, cex=6, col=Colors)
points( x=1:length( Colors ), y=rep( 1, length( Colors ) ), pch=16, cex=3, col=modColor( Colors, colspace="HSV", method="invert" ) )
mtext( side=2, at=1, text="invert HSV", las=2 )

## invert the colors in RGB color space
points( x=1:length( Colors ), y=rep( 2, length( Colors ) ), pch=16, cex=6, col=Colors)
points( x=1:length( Colors ), y=rep( 2, length( Colors ) ), pch=16, cex=3, col=modColor( Colors, colspace="RGB", method="invert" ) )
mtext( side=2, at=2, text="invert RGB", las=2 )

## invert H in HSV color space
points( x=1:length( Colors ), y=rep( 3, length( Colors ) ), pch=16, cex=6, col=Colors)
points( x=1:length( Colors ), y=rep( 3, length( Colors ) ), pch=16, cex=3, col=modColor( Colors, colspace="HSV", method="invert", what="H" ) )
mtext( side=2, at=3, text="invert H in HSV", las=2 )

## invert G in RGB color space
points( x=1:length( Colors ), y=rep( 4, length( Colors ) ), pch=16, cex=6, col=Colors)
points( x=1:length( Colors ), y=rep( 4, length( Colors ) ), pch=16, cex=3, col=modColor( Colors, colspace="RGB", method="invert", what="G" ) )
mtext( side=2, at=4, text="invert G in RGB", las=2 )

## next we are shifting the values...
## shift HSV by 0.5
points( x=1:length( Colors ), y=rep( 5, length( Colors ) ), pch=16, cex=6, col=Colors)
points( x=1:length( Colors ), y=rep( 5, length( Colors ) ), pch=16, cex=3, col=modColor( Colors, colspace="HSV", method="shift", shift.by=0.5 ) )
mtext( side=2, at=5, text="shift HSV by 0.5", las=2 )

## shift HSV by 0.7
points( x=1:length( Colors ), y=rep( 6, length( Colors ) ), pch=16, cex=6, col=Colors)
points( x=1:length( Colors ), y=rep( 6, length( Colors ) ), pch=16, cex=3, col=modColor( Colors, colspace="HSV", method="shift", shift.by=0.7 ) )
mtext( side=2, at=6, text="shift HSV by 0.7", las=2 )

## shift RGB by 0.5
points( x=1:length( Colors ), y=rep( 7, length( Colors ) ), pch=16, cex=6, col=Colors)
points( x=1:length( Colors ), y=rep( 7, length( Colors ) ), pch=16, cex=3, col=modColor( Colors, colspace="RGB", method="shift", shift.by=0.5 ) )
mtext( side=2, at=7, text="shift RGB by 0.5", las=2 )

## shift RGB by 0.7
points( x=1:length( Colors ), y=rep( 8, length( Colors ) ), pch=16, cex=6, col=Colors)
points( x=1:length( Colors ), y=rep( 8, length( Colors ) ), pch=16, cex=3, col=modColor( Colors, colspace="RGB", method="shift", shift.by=0.7 ) )
mtext( side=2, at=8, text="shift RGB by 0.7", las=2 )

}
\keyword{graphics}
