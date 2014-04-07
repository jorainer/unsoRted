\name{getAnnotation}
\alias{getAnnotation}
\alias{getAnnotationForIDs}
\title{
Retrieves annotations for an \dQuote{ExpressionSet}
}
\description{
  Function to retrieve annotations for probe sets of a given
  \dQuote{ExpressionSet} object from anntation package provided by Bioconductor.
}
\usage{
getAnnotation( x, ann.source="bioconductor", what=c( "accnum", "symbol",
"entrezid", "chr", "ensembl" ) )
getAnnotationForIDs( x, chip, ann.source="bioconductor", what=c( "accnum", "symbol",
"entrezid", "chr", "ensembl" ) )
}
\arguments{
  \item{x}{
    An \dQuote{ExpressionSet} object for which the annotations should be
    returned (for function \code{getAnntotation}), or character vector
    of probe set ids (for function \code{getAnnotationForIDs}).
  }
  \item{chip}{
    The type of microarray for which the annotation should be returned.
  }
  \item{ann.source}{
    Currently not used; should enable to switch from annotations
    provided form Bioconductor to e.g. Biomart based annotations.
  }
  \item{what}{
    The character that can/will be used to split the elements.
  }
}
\value{
  A data.frame (same ordering as the probe set ids in \code{featureNames}
  of the \code{ExpressionSet} with annotations retrieved for the probe
set ids.)
}
\details{
  The function might get improved in future as, at present, it is pretty
  slow.
}
\references{
  http://bioinfo.i-med.ac.at
}
\author{
  Johannes Rainer
}
\keyword{ data }
\keyword{ annotation }
