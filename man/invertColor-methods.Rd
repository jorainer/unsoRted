\name{invertColor-methods}
\docType{methods}
\alias{invertColor-methods}
\alias{invertColor}
\alias{invertColor,HSV-method}
\alias{invertColor,RGB-method}
\title{Inverts a color}
\description{
  This function inverts the submitted color, or, alternatively inverts
  the channels specified with the parameter \code{what}.
}
\section{Methods}{
  \describe{

    \item{\code{invertColor( object, what=c( "H", "S", "V", ... )
    )}}{
  For HSV colors. By default all channels are inverted. Parameter
    \code{what} allows to specify single channels that should be inverted.
    }
    \item{\code{invertColor( object, what=c( "R", "G", "B", ... ) )}}{
  For RGB colors. By default all channels are inverted. Parameter
    \code{what} allows to specify single channels that should be inverted.
    }


}}
\author{Johannes Rainer}
\seealso{
  \code{\link{shiftColor}} and \code{\link{modColor}} for examples.
}
\keyword{methods}
\keyword{ graphics}
