\name{hyperGGeneric}
\alias{hyperGGeneric}
\title{
Perform a hypergeometric test as in a Gene Ontology analysis on any
categories provided
}
\description{
This function performs a hypergeometric test, as performed by the
\dQuote{Category} package for a Gene Ontology analysis, on any
user-defined and provided categories.
}
\usage{
hyperGGeneric( fg.gns=character(), bg.gns=character(), x, proc="BH" )
}
\arguments{
  \item{fg.gns}{
    A character vector of e.g. gene ids that should be tested for
    significant over-representation in the categories provided by the
    argument \dQuote{x}.
  }
  \item{bg.gns}{
    A character vector defining the background genes (or gene universe
    as called in the \dQuote{Category} package). Should be e.g. all
    genes detected on the microarray and used in the test to define the \dQuote{fg.gns}.
  }
  \item{x}{
    A list defining the categories. This should be a list of character
    vectors, the names of the list specifying the category names and the
    values the genes associated with the category.
  }
  \item{method}{
    The method to be used for multiple hypothesis testing. Allowed are
    all values of \code{p.adjust.methods}.
  }
}
\value{
  A data.frame with columns:
  \item{\dQuote{Term}}{The category name}
  \item{\dQuote{Pvalue}}{The (raw) p-value from the hypergeometric test.}
  \item{\dQuote{padj}}{The adjusted p-value, according to the specified
    method.
  }
  \item{\dQuote{Count}}{The number of \dQuote{fg.gns} associated with
    the category.}
  \item{\dQuote{Size}}{The total number of \dQuote{bg.gns} associated
    with the category.}
  \item{\dQuote{perc}}{The percentage of \dQuote{fg.gns} associated with
    the category (related to the number of \dQuote{bg.gns} in the
    category).}
  \item{\dQuote{Fold.Enr}}{
    The ratio between the proportion of genes in the category being
    significantly regulated (i.e. Count/Size) against the proportion of regulated
    genes relative to the total amount of detected and tested genes
    (i.e. the ratio between the fg.gns/bg.gns).
  }
  \item{\dQuote{fg.gns}}{The list of all \dQuote{fg.gns} associated to
    the category (as a string, with elements separated by a \dQuote{;}).}
  \item{\dQuote{bg.gns}}{The list of all \dQuote{bg.gns} associated to
    the category (as a string, with elements separated by a \dQuote{;}).}
}
\references{
  http://bioinfo.i-med.ac.at
}
\author{
  Daniel Bindreither, Johannes Rainer
}
\keyword{ data }
\keyword{ analysis }
