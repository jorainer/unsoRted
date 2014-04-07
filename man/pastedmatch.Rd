\name{pastedmatch}
\alias{pastedmatch}
\title{
Match pasted IDs
}
\description{
This function matches (eventually e.g. \dQuote{;} separated) entries in
x with, also eventually separated values in y. The function returns TRUE
for each element in x that is also present in y.
}
\usage{
pastedmatch( x, y, split=";" )
}
\arguments{
  \item{x}{
    A character vector of (eventually) pasted ids.
  }
  \item{y}{
    Can also be a vector or a single character of pasted ids; it will be
    split prior to any comparisons.
  }
  \item{split}{
    The character that can/will be used to split the elements.
  }
}
\value{
  A logical vector with the same length than x, TRUE if any (sub)
  element in x is also present (as a sub-element) in y.
}
\references{
  http://bioinfo.i-med.ac.at
}
\author{
  Johannes Rainer
}
\examples{

x <- c( "123;343", "1543;243", "243", "1443", "313;321" )
y <- c( "123", "1443", "243" )

pastedmatch( x, y )

y.string <- "1443;321;232"
pastedmatch( x, y.string )

}
\keyword{ data }
