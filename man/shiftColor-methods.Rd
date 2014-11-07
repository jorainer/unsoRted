\name{shiftColor-methods}
\docType{methods}
\alias{shiftColor-methods}
\alias{shiftColor}
\alias{shiftColor,HSV-method}
\alias{shiftColor,RGB-method}
\title{Shift the values in the color channels}
\description{
  This function shifts the color values in the individual channels
  (eihter R, G and B, or H, S, V) by a user defined value. If a value is
  shifted outside the value range it will be re-based (i.e. if a R value
  of 0.7 is shifted by 0.5 to 1.2 while the value range is [0,1],
  it will be changed to 1.2 - 1 = 0.2).
}
\section{Methods}{
  \describe{

    \item{\code{shiftColor( object, by=0.5, what=c( "H", "S", "V", ... )
    )}}{
  For HSV colors. By default all channels are shifted by the proportion
    of the color space range defined by \code{by}. Parameter
    \code{what} allows to specify single channels that should be inverted.
    }
    \item{\code{shiftColor( object, by=0.5, what=c( "R", "G", "B", ... ) )}}{
  For RGB colors. By default all channels are shifted by the proportion
    of the color space range defined by \code{by}. Parameter
    \code{what} allows to specify single channels that should be inverted.
    }

}}
\seealso{
  \code{\link{invertColor}} and \code{\link{modColor}} for examples.
}
\keyword{methods}
\keyword{graphics}
